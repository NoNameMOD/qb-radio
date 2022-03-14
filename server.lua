local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("radio", function(source, item)
    TriggerClientEvent('qb-radio:use', source)
end)

QBCore.Functions.CreateCallback('qb-radio:server:GetItem', function(source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        local RadioItem = Player.Functions.GetItemByName(item)
        if RadioItem ~= nil and not Player.PlayerData.metadata["isdead"] and
            not Player.PlayerData.metadata["inlaststand"] then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)


--for channel, config in pairs(Config.RestrictedChannels) do
--    exports['pma-voice']:addChannelCheck(channel, function(source)
-- Saltychat
--        exports.saltychat:SetRadioChannel(channel, true)
-- Saltychat
--        local Player = QBCore.Functions.GetPlayer(source)
--        return config[Player.PlayerData.job.name] and Player.PlayerData.job.onduty
--    end)
--end

RegisterNUICallback('joinRadio', function(data, cb)
  local _source = source
  local PlayerData = QBCore.Functions.GetPlayer(_source)
  local playerName = GetPlayerName(PlayerId())
  local getPlayerRadioChannel = exports.saltychat:GetRadioChannel(true)

  if data.channel ~= getPlayerRadioChannel then
    if tonumber(data.channel) <= Config.RestrictedChannels then
      if(PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'fire') then
        exports.saltychat:SetRadioChannel(data.channel, true)

--        exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
          QBCore.Functions.Notify(Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>, 'error')
      elseif not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'fire') then
--        exports['mythic_notify']:DoHudText('error', Config.messages['restricted_channel_error'])
          QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
      end
    end
    if tonumber(data.channel) > Config.RestrictedChannels then
      exports.saltychat:SetRadioChannel(data.channel, true)

--      exports['mythic_notify']:DoHudText('inform', Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>')
        QBCore.Functions.Notify(Config.messages['joined_to_radio'] .. data.channel .. '.00 MHz </b>, 'error')
    end
  else
--    exports['mythic_notify']:DoHudText('error', Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>')
      QBCore.Functions.Notify(Config.messages['you_on_radio'] .. data.channel .. '.00 MHz </b>, 'error')
  end

  -- Debug output
  --[[ ]]

  PrintChatMessage("radio: " .. data.channel)
  print('radiook')

  cb('ok')
end)
