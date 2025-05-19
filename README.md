# Zynix Logs - Script Complet de Monitoring pour FiveM

Ce script permet de monitorer et logger la plupart des activités importantes sur votre serveur FiveM, en envoyant les logs dans un salon Discord via un webhook. Il est pensé pour le framework **ESX** (adaptable à QBCore ou autre) et couvre : connexions, déconnexions, chat, commandes, transactions d'argent, inventaire, véhicules, jobs, sanctions, démarrage/arrêt de ressources, détections de triggers suspects, etc.

---

## Fonctionnalités principales

- Logs des connexions/déconnexions des joueurs
- Logs du chat et des commandes
- Logs des changements de job (ESX)
- Logs des transactions d'argent (ESX)
- Logs d'ajout/retrait d'items dans l'inventaire (ESX)
- Logs d'achat de véhicules (ESX)
- Logs des bannissements et kicks
- Logs de démarrage/arrêt des ressources
- Logs des tentatives de triche et triggers suspects
- Envoi des logs dans un salon Discord via webhook

---

## Installation

1. **Placez les fichiers**  
   Téléchargez ou clonez ce dépôt dans le dossier `resources` de votre serveur FiveM, par exemple :  
   ```
   resources/[monitoring]/zynix-logs
   ```

2. **Configurez le webhook Discord**  
   - Créez un webhook dans le salon Discord où vous souhaitez recevoir les logs.
   - Copiez l’URL du webhook et remplacez la variable `webhook` dans le fichier `server.lua` :
     ```lua
     local webhook = "TON_WEBHOOK_DISCORD_ICI"
     ```

3. **Vérifiez fxmanifest.lua**  
   Le fichier doit être présent dans le dossier et contenir :
   ```lua
   fx_version 'cerulean'
   game 'gta5'

   author 'ZynixDevelopment'
   description 'Script complet de logs pour FiveM avec envoi sur Discord'
   version '1.0.0'

   server_script 'server.lua'
   ```

4. **Ajoutez la ressource à votre `server.cfg`**  
   Ajoutez cette ligne à la fin de votre fichier `server.cfg` :
   ```
   ensure zynix-logs
   ```

5. **Ordre des ressources**  
   Si vous utilisez ESX/QBCore, assurez-vous que ces frameworks sont démarrés **avant** le script de logs :
   ```
   ensure es_extended
   ensure zynix-logs
   ```

6. **Redémarrez** le serveur.

---

## Lignes indispensables dans vos scripts

Pour que les logs fonctionnent correctement, vérifiez que :
- Le webhook Discord est bien configuré en haut de `server.lua` :
  ```lua
  local webhook = "TON_WEBHOOK_DISCORD_ICI"
  ```
- La fonction d’envoi Discord utilise bien `json.encode` ou `cjson.encode` suivant votre configuration FiveM :
  ```lua
  function sendToDiscord(msg)
      PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
          username = "FiveM LOGS",
          avatar_url = "https://i.imgur.com/4M34hi2.png",
          content = msg
      }), { ['Content-Type'] = 'application/json' })
  end
  ```
  > Si vous avez une erreur “json is nil”, remplacez par :
  ```lua
  function sendToDiscord(msg)
      PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', cjson.encode({
          username = "FiveM LOGS",
          avatar_url = "https://i.imgur.com/4M34hi2.png",
          content = msg
      }), { ['Content-Type'] = 'application/json' })
  end
  ```
- Les events du framework sont bien reliés aux fonctions de logs (voir `server.lua` fourni).

---

## Personnalisation

- **Framework** : Par défaut, le script utilise ESX. Pour QBCore ou autre, adaptez les noms des events et la récupération joueur.
- **Logs supplémentaires** : Vous pouvez ajouter vos propres events ou logs personnalisés.
- **Filtres** : Commentez/supprimez les parties inutiles dans `server.lua` si vous ne souhaitez pas tout logger.

---

## Exemples de logs envoyés

- 🟢 **Connexion:** JoueurX (source: 5)
- 🔴 **Déconnexion:** JoueurY (source: 9, raison: Quit)
- 💬 **Chat:** [JoueurZ] Salut tout le monde !
- ⚙️ **Commande:** [JoueurA] /ban JoueurB
- 💼 **Changement de job:** JoueurX (steam:xyz) : police ➔ ambulance
- 💸 **Changement d'argent (bank):** JoueurY (steam:xyz) : 15000
- 📦 **Ajout d'item inventaire :** JoueurZ (steam:xyz) : +2 pain
- 🚗 **Achat de véhicule :** JoueurX (steam:xyz) plaque: AB123CD
- ⛔ **BAN:** JoueurA (raison: Cheat)
- 🚨 **Tentative de cheat détectée** par JoueurB : {...}

---

## Support & Aide

Pour toute demande de logs spécifiques, adaptation QBCore, ou aide à la personnalisation, ouvrez une issue ou contactez ZynixDevelopment.

---

## Remerciements

Script développé par ZynixDevelopment.
