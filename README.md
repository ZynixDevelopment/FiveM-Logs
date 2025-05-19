# Zynix Logs - Script de Logs Complet pour FiveM

Ce script permet de monitorer l'ensemble des actions importantes sur votre serveur FiveM et d'envoyer les logs dans un salon Discord via un webhook. Il prend en charge les frameworks ESX (et peut être adapté à QBCore ou autre), et couvre les connexions, déconnexions, chat, commandes, transactions d'argent, inventaire, véhicules, jobs, sanctions, démarrage/arrêt de ressources, et détection de triggers suspects.

## Fonctionnalités principales

- Logs de connexion/déconnexion des joueurs
- Logs du chat et des commandes
- Logs des changements de jobs (ESX)
- Logs des transactions d'argent (ESX)
- Logs d'ajout/retrait d'items dans l'inventaire (ESX)
- Logs d'achat de véhicules (ESX)
- Logs de bannissements et kicks
- Logs de démarrage/arrêt de ressources
- Logs des tentatives de triche ou triggers suspects
- Envoi de tous les logs dans un salon Discord via webhook

## Installation

1. **Téléchargez ou clonez** ce dépôt dans le dossier `resources` de votre serveur FiveM (par exemple : `resources/[monitoring]/zynix-logs`).
2. **Configurez le webhook Discord** :
   - Créez un webhook dans le salon Discord où vous souhaitez recevoir les logs.
   - Copiez l’URL du webhook et remplacez la variable `webhook` dans le fichier `server.lua` :
     ```lua
     local webhook = "TON_WEBHOOK_DISCORD_ICI"
     ```
3. **Ajoutez la ressource à votre `server.cfg`** :
   ```bash
   ensure zynix-logs
   ```
4. **(Re)démarrez** votre serveur FiveM.

## Personnalisation

- **Framework** : Par défaut le script utilise ESX. Pour QBCore ou un autre framework, adaptez les événements (noms, exports, etc.).
- **Logs supplémentaires** : Ajoutez vos propres événements ou logs personnalisés selon vos besoins.
- **Filtres** : Si vous souhaitez ne pas tout logger, commentez/supprimez les parties concernées dans `server.lua`.

## Aide & Support

- Pour toute demande de logs spécifiques, intégration avec un autre framework, ou aide à la personnalisation, n’hésitez pas à ouvrir une issue ou à me contacter.

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

## Remerciements

Script développé par ZynixDevelopment.

---
