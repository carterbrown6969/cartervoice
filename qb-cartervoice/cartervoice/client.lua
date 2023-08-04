local voiceEnabled = false
local currentRadioChannel = 0

RegisterKeyMapping('toggleVoice', 'Toggle Voice Chat', 'keyboard', 'v')

RegisterCommand('toggleVoice', function()
    voiceEnabled = not voiceEnabled
    if voiceEnabled then
        QBCore.Functions.Notify('Voice chat enabled.', 'success')
    else
        QBCore.Functions.Notify('Voice chat disabled.', 'error')
    end
end)

RegisterNetEvent('qb-radio:setRadioChannel')
AddEventHandler('qb-radio:setRadioChannel', function(channel)
    currentRadioChannel = channel
    QBCore.Functions.Notify('Switched to radio channel: ' .. Config.RadioChannels[channel], 'success')

    if voiceEnabled then
        TriggerEvent('toggleVoice')  -- Disable voice temporarily to apply radio changes
    end
end)

-- Phone compatibility check
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if phoneOpen then
            -- Adjust voice properties when the phone is open
            -- Implement logic to temporarily reduce voice volume or proximity, etc.
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if voiceEnabled then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local volume = 1.0  -- Adjust this based on voice intensity

            -- Adjust radio properties if radio is enabled
            if currentRadioChannel > 0 then
                -- Implement your logic to adjust voice properties for radio here
            end
            
            exports['qb-voice']:SetRadioChannel(currentRadioChannel)  -- Change this to QBcore's appropriate voice function
            exports['qb-voice']:SetMumbleProperty('radioEnabled', currentRadioChannel > 0)
            NetworkSetTalkerProximity(volume)
            NetworkClearVoiceChannel()
            NetworkSetVoiceChannel(-1)
            NetworkSetVoiceActive(voiceEnabled)

            Citizen.Wait(500)  -- Adjust the interval based on your needs
        end
    end
end)
RegisterNetEvent('qb-voice:playVoice')
AddEventHandler('qb-voice:playVoice', function(playerId, message, voiceType)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(playerId))
    local targetCoords = GetEntityCoords(targetPed)
    local distance = #(GetEntityCoords(playerPed) - targetCoords)

    local volume = 1.0 - (distance / Config.VoiceRanges[voiceType])
    if volume < 0.2 then
        volume = 0.2
    end

    -- Use appropriate voice playback methods based on QBcore's features
end)