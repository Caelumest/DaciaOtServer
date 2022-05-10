local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)            npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                    npcHandler:onThink()                    end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
        if msgcontains(msg, 'help') then
        selfSay('You can here change some items for "spider silk yarn", "chunk of crude iron", "draconian steel", "warrior sweat", "magic sulpher", "enchanted chicken wing", "royal steel", "hell steel", "engraved crossbow", "fighting spirit", "infernal bolt", "blue piece of cloth", "green piece of cloth", "red piece of cloth", "lottery ticket".')

            elseif msgcontains(msg, 'spider silk yarn') then
            if getPlayerItemCount(cid,5879) >= 10 then
                selfSay('Did you bring me the 10 Giant Silks ?')
                talk_state = 1
            else
                selfSay('I need a 10 Giant Spider Silks, to give you the spider silk yarn. Come back when you have them.')
                talk_state = 0
            end

            elseif msgcontains(msg, 'yes') and talk_state == 1 then
            talk_state = 0
            if getPlayerItemCount(cid,5879) >= 10 then
            if doPlayerRemoveItem(cid,5879, 10) == TRUE then
            doPlayerAddItem(cid, 5886, 1)
                        selfSay('Here u are.')
            end
            else
                selfSay(havent_item)
            end

elseif msgcontains(msg, 'chunk of crude iron') then
if getPlayerItemCount(cid,2393) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 then
selfSay('Did you bring me the 3 Bast Skirts and Giant Sword ?')
talk_state = 2
else
selfSay('I need a 3 Bast Skirts and Giant Sword, to give you the chunk of crude iron. Come back when you have them.')
talk_state = 0
end
elseif msgcontains(msg, 'yes') and talk_state == 2 then
talk_state = 0
if getPlayerItemCount(cid,2393) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 then
if doPlayerRemoveItem(cid,2393,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 then
selfSay(addon_give)
doPlayerAddItem(cid,5892,1)
end
else
selfSay(havent_item)
end
elseif msgcontains(msg, 'ticket') or msgcontains(msg, 'lottery') or msgcontains(msg, 'lottery ticket') or msgcontains(msg, 'lotery ticket') then
if getPlayerItemCount(cid,2160) >= 5 then
selfSay('Did you bring me the 5cc?')
talk_state = 9
else
selfSay('I need a 5cc, to give you a lottery ticket. Come back when you have them.')
talk_state = 0
end
elseif msgcontains(msg, 'yes') and talk_state == 9 then
talk_state = 0
if getPlayerItemCount(cid,2160) >= 5 then
if doPlayerRemoveItem(cid,2160,5) == 1 then
selfSay(addon_give)
doPlayerAddItem(cid,5957,1)
end

else
selfSay(havent_item)
end


elseif msgcontains(msg, 'draconian steel') then
if getPlayerItemCount(cid,2516) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 then
selfSay('Did you bring me 3 Bast Skirts and Dragon Shield ?')
talk_state = 3
else
selfSay('I need 3 Bast Skirts and Dragon Shield, to give you the draconian steel. Come back when you have them.')
talk_state = 0
end
elseif msgcontains(msg, 'yes') and talk_state == 3 then
talk_state = 0
if getPlayerItemCount(cid,2516) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 then
if doPlayerRemoveItem(cid,2516,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 then
doPlayerAddItem(cid,5889,1)
selfSay('Here u are.')
end
else
selfSay(havent_item)
end

        elseif msgcontains(msg, 'warrior sweat') then
                if getPlayerItemCount(cid,2475) >= 1 and getPlayerItemCount(cid,2475) >= 1 and getPlayerItemCount(cid,2475) >= 1 and getPlayerItemCount(cid,2475) >= 1 then
                    selfSay('Did you bring me 4 warrior helmets?')
                    talk_state = 4
                else
                    selfSay('I need 4 warrior helmets, to give you the warrior sweat. Come back when you have them.')
                    talk_state = 0
                end
        elseif msgcontains(msg, 'yes') and talk_state == 4 then
            talk_state = 0
            if getPlayerItemCount(cid,2475) >= 1 and getPlayerItemCount(cid,2475) >= 1 and getPlayerItemCount(cid,2475) >= 1 and getPlayerItemCount(cid,2475) >= 1 then
                    if doPlayerRemoveItem(cid,2475,1) == 1 and doPlayerRemoveItem(cid,2475,1) == 1 and doPlayerRemoveItem(cid,2475,1) == 1 and doPlayerRemoveItem(cid,2475,1) == 1 then
                        doPlayerAddItem(cid,5885,1)
                        selfSay(addon_give)
                    end
                else
                selfSay(havent_item)
                end

elseif msgcontains(msg, 'magic sulpher') then
if getPlayerItemCount(cid,2392) >= 1 and getPlayerItemCount(cid,2392) >= 1 and getPlayerItemCount(cid,2392) >= 1 then
selfSay('Did you bring me 3 fire swords?')
talk_state = 5
else
selfSay('I need 3 fire swords, to give you the magic sulpher. Come back when you have them.')
talk_state = 0
end

        elseif msgcontains(msg, 'yes') and talk_state == 5 then
            talk_state = 0
            if getPlayerItemCount(cid,2392) >= 1 and getPlayerItemCount(cid,2392) >= 1 and getPlayerItemCount(cid,2392) >= 1 then
                    if doPlayerRemoveItem(cid,2392,1) == 1 and doPlayerRemoveItem(cid,2392,1) == 1 and doPlayerRemoveItem(cid,2392,1) == 1 then
                        doPlayerAddItem(cid,5904,1)
                        selfSay(addon_give)
                end
            else
                selfSay(havent_item)
            end

        elseif msgcontains(msg, 'enchanted chicken wing') then
            if getPlayerItemCount(cid,2195) >= 1 then
                selfSay('Did you bring me boots of haste?')
                talk_state = 6
            else
                selfSay('I need boots of haste, to give you the enchanted chicken wing. Come back when you have them.')
                talk_state = 0
            end

        elseif msgcontains(msg, 'yes') and talk_state == 6 then
            talk_state = 0
            if getPlayerItemCount(cid,2195) >= 1 then
                    if doPlayerRemoveItem(cid,2195,1) == 1 then
                        doPlayerAddItem(cid,5891,1)
                        selfSay(addon_give)
                    end
            else
                selfSay(havent_item)
            end



        elseif msgcontains(msg, 'royal steel') then
            if getPlayerItemCount(cid,2487) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 then
                selfSay('Did you bring me the 3 Bast Skirts and Crown Armor ?')
                talk_state = 7
            else
                selfSay('I need 3 Bast Skirts and Crown Armor, to give you the royal steel. Come back when you have them.')
                talk_state = 0
            end
        elseif msgcontains(msg, 'yes') and talk_state == 7 then
            talk_state = 0
            if getPlayerItemCount(cid,2487) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 then
                    if doPlayerRemoveItem(cid,2487,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,5887,1)
                    end
            else
                selfSay(havent_item)
            end


        elseif msgcontains(msg, 'hell steel') then
            if getPlayerItemCount(cid,2462) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 then
                selfSay('Did you bring me the 3 Bast Skirts and Devil Helmet ?')
                talk_state = 8
            else
                selfSay('I need a 3 Bast Skirts and Devil Helmet, to give you the hell steel. Come back when you have them.')
                talk_state = 0
            end

        elseif msgcontains(msg, 'yes') and talk_state == 8 then
            talk_state = 0
            if getPlayerItemCount(cid,2462) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 and getPlayerItemCount(cid,3983) >= 1 then

                    if doPlayerRemoveItem(cid,2462,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 and doPlayerRemoveItem(cid,3983,1) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,5888,1)
                    end
            else
                selfSay(havent_item)
            end

        elseif msgcontains(msg, 'engraved crossbow') then
            if getPlayerItemCount(cid,5954) >= 15 then
                selfSay('Did you bring me the 15 demon horns?')
                talk_state = 9
            else
                selfSay('I need a 15 demon horns, to give you the engraved crossbow. Come back when you have them.')
                talk_state = 0
            end
        elseif msgcontains(msg, 'yes') and talk_state == 9 then
            talk_state = 0
            if getPlayerItemCount(cid,5954) >= 15 then
                    if doPlayerRemoveItem(cid,5954,15) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,5947,1)
                    end

            else
                selfSay(havent_item)
            end

        elseif msgcontains(msg, 'fighting spirit') then
            if getPlayerItemCount(cid,2498) >= 1 and getPlayerItemCount(cid,2498) >= 1 then
                selfSay('Did you bring me the 2 Royal Helmets?')
                talk_state = 10
            else
                selfSay('I need a 2 Royal Helmets, to give you the Fighting Spirit. Come back when you have them.')
                talk_state = 0
            end
        elseif msgcontains(msg, 'yes') and talk_state == 10 then
            talk_state = 0
            if getPlayerItemCount(cid,2498) >= 1 and getPlayerItemCount(cid,2498) >= 1 then
                    if doPlayerRemoveItem(cid,2498,1) == 1 and doPlayerRemoveItem(cid,2498,1) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,5884,1)
                    end

            else
                selfSay(havent_item)
            end


        elseif msgcontains(msg, 'infernal bolt') then
            if getPlayerItemCount(cid,5944) >= 1 then
                selfSay('Did you bring me the Soul Orb?')
                talk_state = 11
            else
                selfSay('I need a Soul Orb, to give you the 2 Infernal Bolts. Come back when you have them.')
                talk_state = 0
            end
        elseif msgcontains(msg, 'yes') and talk_state == 11 then
            talk_state = 0
            if getPlayerItemCount(cid,5944) >= 1 then
                    if doPlayerRemoveItem(cid,5944,1) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,6529,2)
                    end

            else
                selfSay(havent_item)
            end

        elseif msgcontains(msg, 'blue piece of cloth') then
            if getPlayerItemCount(cid,2663) >= 1 then
                selfSay('Did you bring me the Mystic Turban ?')
                talk_state = 12
            else
                selfSay('I need a Mystic Turban, to give you the Blue Piece of Cloth. Come back when you have them.')
                talk_state = 0
            end
        elseif msgcontains(msg, 'yes') and talk_state == 12 then
            talk_state = 0
            if getPlayerItemCount(cid,2663) >= 1 then
                    if doPlayerRemoveItem(cid,2663,1) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,5912,1)
                    end

            else
                selfSay(havent_item)
            end

        elseif msgcontains(msg, 'green piece of cloth') then
            if getPlayerItemCount(cid,2652) >= 1 then
                selfSay('Did you bring me the Green Tunic ?')
                talk_state = 13
            else
                selfSay('I need a Green Tunic, to give you the Green Piece of Cloth. Come back when you have them.')
                talk_state = 0
            end
        elseif msgcontains(msg, 'yes') and talk_state == 13 then
            talk_state = 0
            if getPlayerItemCount(cid,2652) >= 1 then
                    if doPlayerRemoveItem(cid,2652,1) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,5910,1)
                    end

            else
                selfSay(havent_item)
            end

        elseif msgcontains(msg, 'red piece of cloth') then
            if getPlayerItemCount(cid,2655) >= 1 then
                selfSay('Did you bring me the Red Robe ?')
                talk_state = 14
            else
                selfSay('I need a Red Robe, to give you the Red Piece of Cloth. Come back when you have them.')
                talk_state = 0
            end
        elseif msgcontains(msg, 'yes') and talk_state == 14 then
            talk_state = 0
            if getPlayerItemCount(cid,2655) >= 1 then
                    if doPlayerRemoveItem(cid,2655,1) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,5911,1)
                    end

            else
                selfSay(havent_item)
            end


        elseif msgcontains(msg, 'obsidian knife') then
            if getPlayerItemCount(cid,3983) >= 3 and getPlayerItemCount(cid,2516) >= 1 and getPlayerItemCount(cid,2425) >= 1 then
                selfSay('Did you bring me the 3 bast skirts, a dragon shield and a obsidian lance?')
                talk_state = 15
            else
                selfSay('I need 3 bast skirts, a dragon shield and a obsidian lance to give you the obsidian knife. Come back when you have them.')
                talk_state = 0
            end
        elseif msgcontains(msg, 'yes') and talk_state == 15 then
            talk_state = 0
            if getPlayerItemCount(cid,3983) >= 3 and getPlayerItemCount(cid,2516) >= 1 and getPlayerItemCount(cid,2425) >= 1  then
                    if doPlayerRemoveItem(cid,3983,1) == 3 and doPlayerRemoveItem(cid,2516,1) == 1 and doPlayerRemoveItem(cid,2425,1) == 1 then
                        selfSay(addon_give)
                        doPlayerAddItem(cid,5908,1)
                    end

            else
                selfSay(havent_item)
            end


        elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 5) then
            selfSay('Ok than.')
            talk_state = 0
        end
    -- Place all your code in here. Remember that hi, bye and all that stuff is already handled by the npcsystem, so you do not have to take care of that yourself.
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())