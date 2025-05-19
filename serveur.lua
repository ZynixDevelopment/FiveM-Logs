local webhook = "TON_WEBHOOK_DISCORD_ICI"

function sendToDiscord(msg)
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
        username = "FiveM LOGS",
        avatar_url = "https://i.imgur.com/4M34hi2.png",
        content = msg
    }), { ['Content-Type'] = 'application/json' })
end

-- LOG CONNEXION/DÉCONNEXION
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    sendToDiscord("🟢 **Connexion:** " .. name .. " (source: " .. tostring(source) .. ")")
end)
AddEventHandler('playerDropped', function(reason)
    local name = GetPlayerName(source)
    sendToDiscord("🔴 **Déconnexion:** " .. (name or "Inconnu") .. " (source: " .. tostring(source) .. ", raison: " .. (reason or "Aucune")) 
end)

-- LOG CHAT & COMMANDES
RegisterServerEvent('chatMessage')
AddEventHandler('chatMessage', function(source, name, msg)
    if msg:sub(1, 1) == "/" then
        sendToDiscord("⚙️ **Commande:** ["..name.."] "..msg)
    else
        sendToDiscord("💬 **Chat:** ["..name.."] "..msg)
    end
end)

-- LOG JOB (ESX)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job, lastJob)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("💼 **Changement de job:** "..xPlayer.getName().." ("..xPlayer.getIdentifier()..") : "..(lastJob and lastJob.name or "N/A").." ➔ "..job.name)
end)

-- LOG TRANSACTIONS D'ARGENT (ESX)
RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account, money)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("💸 **Changement d'argent ("..account..") :** "..xPlayer.getName().." ("..xPlayer.getIdentifier()..") : "..money)
end)

-- LOG INVENTAIRE (ESX)
RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("📦 **Ajout d'item inventaire :** "..xPlayer.getName().." ("..xPlayer.getIdentifier()..") : +"..count.." "..item)
end)
RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord("📦 **Retrait d'item inventaire :** "..xPlayer.getName().." ("..xPlayer.getIdentifier()..") : -" ..count.." "..item)
end)

-- LOG VÉHICULES (ESX)
RegisterNetEvent('esx_vehicleshop:setVehicleOwnedPlayerId')
AddEventHandler('esx_vehicleshop:setVehicleOwnedPlayerId', function(playerId, plate, props, type)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    sendToDiscord("🚗 **Achat de véhicule :** "..xPlayer.getName().." ("..xPlayer.getIdentifier()..") plaque: "..plate)
end)

-- LOG BAN/KICK (ESX ADMIN / VOTRE SYSTÈME)
RegisterServerEvent('BanSql:ICheatBan')
AddEventHandler('BanSql:ICheatBan', function(reason)
    local name = GetPlayerName(source)
    sendToDiscord("⛔ **BAN:** "..name.." (raison: "..reason..")")
end)
RegisterServerEvent('esx:playerKicked')
AddEventHandler('esx:playerKicked', function(target, reason)
    local name = GetPlayerName(target)
    sendToDiscord("⛔ **KICK:** "..name.." (raison: "..reason..")")
end)

-- LOG START/STOP RESSOURCES
AddEventHandler('onResourceStart', function(resourceName)
    sendToDiscord("🟢 **Ressource démarrée:** "..resourceName)
end)
AddEventHandler('onResourceStop', function(resourceName)
    sendToDiscord("🔴 **Ressource arrêtée:** "..resourceName)
end)

-- LOG TRIGGERS SUSPECTS (exemple)
RegisterServerEvent('exploit:detected')
AddEventHandler('exploit:detected', function(data)
    local name = GetPlayerName(source)
    sendToDiscord("🚨 **Tentative de cheat détectée** par "..name.." : "..json.encode(data))
end)

-- LOG TEST
RegisterCommand("logtest", function(source)
    sendToDiscord("✅ Test de log Discord par "..GetPlayerName(source))
end, false)
