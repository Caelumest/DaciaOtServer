  local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)                       npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)                  npcHandler:onCreatureSay(cid, type, msg)                end
function onThink()                                      npcHandler:onThink()                                    end
function creatureSayCallback(cid, type, msg)
        if(not npcHandler:isFocused(cid)) then
                return false
        end
        local tokenid = 7290
        local storage = 7290
        local getstorage = getPlayerStorageValue(cid, storage)
        local sorrymessage = "Sorry, you don't have enough tokens to progress in rank..."
        local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
        if msgcontains(msg, 'mission') then
                if getstorage == 6 then
                        npcHandler:say("You have finished all missions.", cid)
                elseif getstorage < 6 then
                        npcHandler:say("Would ye' like to give me shards?", cid)
                        talkState[talkUser] = 1
                end
        elseif msgcontains(msg, 'rank') then
                if getstorage < 1 then
                        npcHandler:say("You don't have any rank yet.", cid)
                elseif getstorage == 1 then
                        npcHandler:say("You are {fluke} rank now.", cid)
                elseif getstorage == 2 then
                        npcHandler:say("You are {lucky} rank now.", cid)
                elseif getstorage == 3 then
                        npcHandler:say("You are {determined} rank now.", cid)
                elseif getstorage == 4 then
                        npcHandler:say("You are {painstaking} rank now.", cid)
                elseif getstorage == 5 then
                        npcHandler:say("You are {obliterative} rank now.", cid)
                elseif getstorage == 6 then
                        npcHandler:say("You are {razing} rank now.", cid)
                end
        elseif msgcontains(msg, 'yes') then
                if talkState[talkUser] == 1 then
                        if getstorage < 0 then
                                if doPlayerRemoveItem(cid, tokenid, 1) == TRUE then
                                        npcHandler:say("Ye' brought the shard needed to advance to the first rank. I consider that a fluke, but still, congrats! Let me share some of my experience with ye'.", cid)
                                        setPlayerStorageValue(cid, storage, 1)
                                        doPlayerAddExp(cid, 1000)
                                        talkState[talkUser] = 0
                                elseif doPlayerRemoveItem(cid, tokenid, 1) == FALSE then
                                        npcHandler:say(sorrymessage, cid)
                                        talkState[talkUser] = 0
                                end
                        elseif getstorage == 1 then
                                if doPlayerRemoveItem(cid, tokenid, 3) == TRUE then
                                        npcHandler:say("Ye' brought three shard needed to advance to the second rank. I consider that a fluke, but still, congrats! Let me share some of my experience with ye'.", cid)
                                        setPlayerStorageValue(cid, storage, 2)
                                        doPlayerAddExp(cid, 5000)
                                        talkState[talkUser] = 0
                                elseif doPlayerRemoveItem(cid, tokenid, 3) == FALSE then
                                        npcHandler:say(sorrymessage, cid)
                                        talkState[talkUser] = 0
                                end
                        elseif getstorage == 2 then
                                if doPlayerRemoveItem(cid, tokenid, 5) == TRUE then
                                        npcHandler:say("Ye' brought five shards needed to advance to the third rank. I consider that a fluke, but still, congrats! Let me share some of my experience with ye'.", cid)
                                        setPlayerStorageValue(cid, storage, 3)
                                        doPlayerAddExp(cid, 10000)
                                        talkState[talkUser] = 0
                                elseif doPlayerRemoveItem(cid, tokenid, 5) == FALSE then
                                        npcHandler:say(sorrymessage, cid)
                                        talkState[talkUser] = 0
                                end
                        elseif getstorage == 3 then
                                if doPlayerRemoveItem(cid, tokenid, 10) == TRUE then
                                        npcHandler:say("Ye' brought the ten shards needed to advance to the fourth rank. You're absolutely painstaking! Let me share some of my experience with ye'.", cid)
                                        setPlayerStorageValue(cid, storage, 4)
                                        doPlayerAddExp(cid, 20000)
                                        talkState[talkUser] = 0
                                elseif doPlayerRemoveItem(cid, tokenid, 10) == FALSE then
                                        npcHandler:say(sorrymessage, cid)
                                        talkState[talkUser] = 0
                                end
                        elseif getstorage == 4 then
                                if doPlayerRemoveItem(cid, tokenid, 15) == TRUE then
                                        npcHandler:say("Ye' brought the fifteen shards needed to advance to the fifth rank. You're completely obliterative, kid! Let me share some of my experience with ye'.", cid)
                                        setPlayerStorageValue(cid, storage, 5)
                                        doPlayerAddExp(cid, 50000)
                                        doPlayerAddItem(cid, 8878, 1)
                                        doPlayerAddItem(cid, 8300, 1)
                                        doPlayerAddItem(cid, 8305, 1)
                                        talkState[talkUser] = 0
                                elseif doPlayerRemoveItem(cid, tokenid, 15) == FALSE then
                                        npcHandler:say(sorrymessage, cid)
                                        talkState[talkUser] = 0
                                end
                        elseif getstorage == 5 then
                                if doPlayerRemoveItem(cid, tokenid, 20) == TRUE then
                                        npcHandler:say("Ye' brought the twenty shards needed to advance to the last rank. Now that's something. You're razing-amazing! Let me share some of my experience and a little something with ye'!", cid)
                                        setPlayerStorageValue(cid, storage, 6)
                                        doPlayerAddExp(cid, 100000)
                                        doPlayerAddItem(cid, 9778, 1)
                                        doPlayerAddItem(cid, 8905, 1)
                                        doPlayerAddItem(cid, 8982, 1)
                                        doPlayerAddItem(cid, 8305, 1)
                                        talkState[talkUser] = 0
                                elseif doPlayerRemoveItem(cid, tokenid, 20) == FALSE then
                                        npcHandler:say(sorrymessage, cid)
                                        talkState[talkUser] = 0
                                end
                        end
                end
        elseif(msgcontains(msg, 'no') and talkState[talkUser] == 1) then
                npcHandler:say("Sure, come back when ye'll have enough shards.", cid)
                talkState[talkUser] = 0
        end
return TRUE
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new()) 