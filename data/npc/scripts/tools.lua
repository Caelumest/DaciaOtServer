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

shopModule:addBuyableItem({'brown bag'}, 1987, 20, 1, 'brown backpack')
shopModule:addBuyableItem({'brown backpack'}, 1988, 20, 1, 'brown backpack')
shopModule:addBuyableItem({'basket'}, 1989, 6, 1, 'brown backpack')
shopModule:addBuyableItem({'present box'}, 1990, 20, 1, 'present box')
shopModule:addBuyableItem({'green bag'}, 1991, 5, 1, 'green bag')
shopModule:addBuyableItem({'yellow bag'}, 1992, 5, 1, 'yellow bag')
shopModule:addBuyableItem({'red bag'}, 1993, 5, 1, 'red bag')
shopModule:addBuyableItem({'purple bag'}, 1994, 5, 1, 'purple bag')
shopModule:addBuyableItem({'blue bag'}, 1995, 5, 1, 'blue bag')
shopModule:addBuyableItem({'grey bag'}, 1996, 5, 1, 'grey bag')
shopModule:addBuyableItem({'golden bag'}, 1997, 5, 1, 'golden bag')
shopModule:addBuyableItem({'green backpack'}, 1998, 20, 1, 'green backpack')
shopModule:addBuyableItem({'yellow backpack'}, 1999, 20, 1, 'yellow backpack')
shopModule:addBuyableItem({'red backpack'}, 2000, 20, 1, 'red backpack')
shopModule:addBuyableItem({'purple backpack'}, 2001, 20, 1, 'purple backpack')
shopModule:addBuyableItem({'blue backpack'}, 2002, 20, 1, 'blue backpack')
shopModule:addBuyableItem({'grey backpack'}, 2003, 20, 1, 'grey backpack')
shopModule:addBuyableItem({'golden backpack'}, 2004, 20, 1, 'golden backpack')
shopModule:addBuyableItem({'beach backpack'}, 5949, 20, 1, 'beach backpack')
shopModule:addBuyableItem({'beach bag'}, 5950, 20, 1, 'beach bag')
shopModule:addBuyableItem({'camouflage bag'}, 3939, 20, 1, 'camouflage bag')
shopModule:addBuyableItem({'camouflage backpack'}, 3940, 20, 1, 'camouflage backpack')
shopModule:addBuyableItem({'pirate backpack'}, 5926, 20, 1, 'pirate backpack')
shopModule:addBuyableItem({'pirate bag'}, 5927, 5, 1, 'pirate bag')
shopModule:addBuyableItem({'fur backpack'}, 7342, 20, 1, 'fur backpack')
shopModule:addBuyableItem({'fur bag'}, 7343, 20, 1, 'fur bag')

shopModule:addBuyableItem({'rope'}, 2120, 50, 1, 'rope')
shopModule:addBuyableItem({'scythe'}, 2550, 50, 1, 'scythe')
shopModule:addBuyableItem({'pick'}, 2553, 50, 1, 'pick')
shopModule:addBuyableItem({'shovel'}, 2554, 50, 1, 'shovel')
shopModule:addBuyableItem({'fishing rod'}, 2580, 150, 1, 'fishing rod')
shopModule:addBuyableItem({'worms'}, 3976, 1, 1, 'worms')
shopModule:addBuyableItem({'torch'}, 2050, 2, 1, 'torch')
shopModule:addBuyableItem({'football'}, 2109, 111, 1, 'football')
shopModule:addBuyableItem({'watch'}, 2036, 20, 1, 'watch')

shopModule:addSellableItem({'rope'}, 2120, 8, 1, 'rope')
shopModule:addSellableItem({'shovel'}, 2554, 8, 1, 'shovel')
shopModule:addSellableItem({'scythe'}, 2550, 10, 1, 'scythe')
shopModule:addSellableItem({'pick'}, 2553, 15, 1, 'pick')
shopModule:addSellableItem({'fishing rod'}, 2580, 40, 1, 'fishing rod')
shopModule:addSellableItem({'watch'}, 2036, 6, 1, 'watch')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())