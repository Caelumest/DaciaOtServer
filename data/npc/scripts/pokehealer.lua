local pokein, pokeout = 2222,2223
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)        end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)        end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                npcHandler:onThink()                end

function creatureSayCallback(cid, type, msg)

    if(not npcHandler:isFocused(cid)) then
        return false
    end

function getItemsInContainerById(container, itemid) -- Function By Kydrai
    local items = {}
    if isContainer(container) and getContainerSize(container) > 0 then
        for slot=0, (getContainerSize(container)-1) do
            local item = getContainerItem(container, slot)
            if isContainer(item.uid) then
                local itemsbag = getItemsInContainerById(item.uid, itemid)
                for i=0, #itemsbag do
                    table.insert(items, itemsbag[i])
                end
            else
                if itemid == item.itemid then
                    table.insert(items, item.uid)
                end
            end
        end
    end
    return items
end

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

    
    if msgcontains(msg, 'heal') then
        if #getCreatureSummons(cid) >= 1 then
            return selfSay('Voce precisa botar seus pokemons dentro da pokebola.', cid)
        end

        local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
        local handr = getPlayerSlotItem(cid, CONST_SLOT_RIGHT)
        local handl = getPlayerSlotItem(cid, CONST_SLOT_LEFT)
        local arrow = getPlayerSlotItem(cid, CONST_SLOT_AMMO)
 
        if handr.itemid == pokein then
            local maxh = tonumber(getDescription(handr.uid):match("/(.+)]"))
            doItemSetAttribute(handr.uid, "description", getDescription(handr.uid):sub(1, findLetter(getDescription(handr.uid), "[")) .. maxh .. getDescription(handr.uid):sub(findLetter(getDescription(handr.uid), "/"))) 
        end

        if handl.itemid == pokein then
            local maxh = tonumber(getDescription(handl.uid):match("/(.+)]"))
        doItemSetAttribute(handl.uid, "description", getDescription(handl.uid):sub(1, findLetter(getDescription(handl.uid), "[")) .. maxh .. getDescription(handl.uid):sub(findLetter(getDescription(handl.uid), "/")))
        end
 
        if arrow.itemid == pokein then
            local maxh = tonumber(getDescription(arrow.uid):match("/(.+)]"))
        doItemSetAttribute(arrow.uid, "description", getDescription(arrow.uid):sub(1, findLetter(getDescription(arrow.uid), "[")) .. maxh .. getDescription(arrow.uid):sub(findLetter(getDescription(arrow.uid), "/"))) 
        end

        local items = getItemsInContainerById(bp.uid, pokein)
        doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid))
        for _, uid in pairs(items) do
            local maxh = tonumber(getDescription(uid):match("/(.+)]"))
            doItemSetAttribute(uid, "description", getDescription(uid):sub(1, findLetter(getDescription(uid), "[")) .. maxh .. getDescription(uid):sub(findLetter(getDescription(uid), "/")))     
        end
        selfSay('Pronto, voce e seus pokemons estao com a life maxima.', cid)
    end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
