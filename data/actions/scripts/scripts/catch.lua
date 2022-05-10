local pokein, pokeout = 2222,2223

local pokes = {
["Dragon"] = {chance = 40, health = 100, maxhealth = 100},
["Demon"] = {chance = 20, health = 1000, maxhealth = 1000},
}

function onUse(cid, item, frompos, item2, topos)
    for i,x in pairs(pokes) do
        if getItemNameById(item2.itemid):find(i:lower()) then
            doRemoveItem(item.uid, 1)
            doRemoveItem(item2.uid, 1)
            if math.random(1,100) <= x.chance then
                local s = doPlayerAddItem(cid, pokein)
                doSendMagicEffect(topos, 29)
                addEvent(doSendMagicEffect, 300, topos, 30)
                doItemSetAttribute(s, "description", "This is "..i.."'s pokeball. HP = ["..x.health.."/"..x.maxhealth.."]")
                doPlayerSendTextMessage(cid, 27, "You catch a "..i..".")
            else
                doPlayerSendTextMessage(cid, 27, "Your pokeball broke.")
                doSendMagicEffect(topos, 2)
            end
        end
    end            
return TRUE
end
