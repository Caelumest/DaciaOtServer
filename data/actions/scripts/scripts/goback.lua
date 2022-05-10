local pokein, pokeout = 2222,2223

local pokes = {
["Dragon"] = {level = 150, go = "Vai Dragon", back = "Volte Dragon."},
["Demon"] = {level = 500, go = "Vai Demon", back = "Volte Demon."},
["Dragon Lord"] = {level = 300, go = "Vai Dragon Lord", back = "Volte Dragon Lord."},
}

function onUse(cid, item, frompos, item2, topos)
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
    
    local maxh = tonumber(getDescription(item.uid):match("/(.+)]"))
    local health = tonumber(getDescription(item.uid):match("%[(.-)/"))
    
    if item.itemid == pokeout then
    
        if #getCreatureSummons(cid) >= 1 then
            for _,z in pairs(getCreatureSummons(cid)) do
                if getDescription(item.uid):find(getCreatureName(z)) then
                    doTransformItem(item.uid, pokein)
                    doCreatureSay(cid, pokes[getCreatureName(z)].back, TALKTYPE_SAY)
                    doItemSetAttribute(item.uid, "description", getDescription(item.uid):sub(1, findLetter(getDescription(item.uid), ".")) .. " HP = ["..getCreatureHealth(z).."/"..getCreatureMaxHealth(z).."]")
                    setPlayerStorageValue(cid, 61204, 0)
                    doSendMagicEffect(getCreaturePosition(z), 10)
                    return doRemoveCreature(z)
                end
            end
        end

    elseif item.itemid == pokein then

        if getTilePzInfo(getCreaturePosition(cid)) then
            return doPlayerSendCancel(cid, "You can't use pokeball in Protection Zones.")
        end

        if health <= 0 then
            return doPlayerSendCancel(cid, "This pokemon is dead.")
        end
    
        for i,x in pairs(pokes) do
            if #getCreatureSummons(cid) >= 1 then
                return doPlayerSendCancel(cid, "You already summoned a pokemon.")
            end
            
            if i == getDescription(item.uid):sub(9, findLetter(getDescription(item.uid), "'")-1) then
                if getPlayerLevel(cid) >= x.level then
                    pk =  doSummonCreature(i, getThingPosition(cid))
                    doConvinceCreature(cid, pk)
                    setCreatureMaxHealth(pk, tonumber(getDescription(item.uid):match("/(.+)]")))
                    doCreatureAddHealth(pk, maxh)
                    doCreatureAddHealth(pk, health-maxh)
                    doTransformItem(item.uid, pokeout)
                    doCreatureSay(cid, x.go, TALKTYPE_SAY)
                    doItemSetAttribute(item.uid, "description", getDescription(item.uid):sub(1, findLetter(getDescription(item.uid), ".")))
                    doSendMagicEffect(getCreaturePosition(pk), 10)
                    setPlayerStorageValue(cid, 61204, 1)
                    registerCreatureEvent(pk, "DiePoke")
                    registerCreatureEvent(cid, "PlayerPokeDeath")
                    break
                else
                    doPlayerSendCancel(cid, "Only players level "..x.level.." or higher can use this pokemon.")
                end
            end
        end
    end
return TRUE
end
