local config = {
    positions = {
        ["Baiak"] = { x = 160, y = 54, z = 7 },
        ["Welcome"] = { x = 158, y = 51, z = 4 },
        ["Vip City"] = { x = 166, y = 50, z = 7 },
        ["Teleports"] = { x = 152, y = 50, z = 7 },
        ["Ilha"] = { x = 153, y = 50, z = 7 },
        ["Treiners"] = { x = 158, y = 47, z = 7 }
    }
}

function onThink(cid, interval, lastExecution)
    for text, pos in pairs(config.positions) do
        doSendAnimatedText(pos, text, math.random(1, 255))
    end
    
    return TRUE
end  