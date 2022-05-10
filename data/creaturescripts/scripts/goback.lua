local pokein, pokeout = 2222,2223

function getDescription(uid)
    for i,x in pairs(getItemDescriptions(uid)) do
        if i == "special" then
            return x
        end
    end
end
    
function findLetter(string, letter)
    for i = 1, #string do
        if string:sub(i, i) == letter then
            return i
        end
    end
end

function getSummonLifes(cid)
    for _,x in pairs(getCreatureSummons(cid)) do
        return getCreatureHealth(x), getCreatureMaxHealth(x)
    end
end

function onLogout(cid)
local health,maxhealth = getSummonLifes(cid)
    if getPlayerStorageValue(cid, 61204) >= 1 then
        setPlayerStorageValue(cid, 61205, health)
        setPlayerStorageValue(cid, 61206, maxhealth)
        setPlayerStorageValue(cid, 61204, 0)
        setPlayerStorageValue(cid, 61207, 1)
    end
return TRUE
end

function onLogin(cid)
    if getPlayerStorageValue(cid, 61207) >= 1 then
        local item = getPlayerItemById(cid, TRUE, pokeout)
        doTransformItem(item.uid, pokein)
        doItemSetAttribute(item.uid, "description", getDescription(item.uid) .. " HP = ["..getPlayerStorageValue(cid, 61205).."/"..getPlayerStorageValue(cid, 61206).."]")
        setPlayerStorageValue(cid, 61207, 0)
    end
return TRUE
end

function onDeath(cid, deathList)
    local owner = getCreatureMaster(cid)
    doPlayerSendTextMessage(owner, 22, "You pokemon died.")
    local item = getPlayerItemById(owner, TRUE, pokeout)
    doTransformItem(item.uid, pokein)
    doItemSetAttribute(item.uid, "description", getDescription(item.uid):sub(1,     findLetter(getDescription(item.uid), ".")) .. " HP = [0/"..getCreatureMaxHealth(cid).."]") 
    doRemoveCreature(cid)
    setPlayerStorageValue(owner, 61207, 0)
    setPlayerStorageValue(owner, 61204, 0)
return FALSE
end