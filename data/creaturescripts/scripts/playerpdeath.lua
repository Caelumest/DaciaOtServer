local pokein, pokeout = 2222,2223

function getSummonLifes(cid)
    for _,x in pairs(getCreatureSummons(cid)) do
        return getCreatureHealth(x), getCreatureMaxHealth(x)
    end
end

function onDeath(cid)
local health,maxhealth = getSummonLifes(cid)
    if #getCreatureSummons(cid) >= 1 then
        setPlayerStorageValue(cid, 61205, health)
        setPlayerStorageValue(cid, 61206, maxhealth)
        setPlayerStorageValue(cid, 61204, 0)
        setPlayerStorageValue(cid, 61207, 1)
    end
return TRUE
end
