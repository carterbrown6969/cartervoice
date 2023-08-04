    local players = QBCore.Functions.GetPlayers()

    for _, player in ipairs(players) do
        local targetPed = GetPlayerPed(player)
        local targetCoords = GetEntityCoords(targetPed)
        local distance = #(coords - targetCoords)

        if distance <= Config.VoiceRanges[voiceType] then
            TriggerClientEvent('qb-voice:playVoice', player, source, message, voiceType)
        end
    end
end,
exports('SetRadioChannel', function(channel)
    -- Implement your radio channel change logic here
end)

exports('SetMumbleProperty', function(property, value)
    -- Implement your Mumble property setting logic here
end)
