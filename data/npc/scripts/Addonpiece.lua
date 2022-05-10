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

shopModule:addBuyableItem({'fire bug'}, 5468, 100, 1, 'fire bug')
shopModule:addBuyableItem({'blessed wooden stake'}, 5941, 7000, 1, 'blessed wooden stake')

shopModule:addSellableItem({'sniper gloves'}, 5875, 2000, 1, 'sniper gloves')
shopModule:addSellableItem({'lizard leather'}, 5876, 150, 1, 'lizard leather')
shopModule:addSellableItem({'green dragon leather'}, 5877, 100, 1, 'green dragon leather')
shopModule:addSellableItem({'minotaur leather'}, 5878, 80, 1, 'minotaur leather')
shopModule:addSellableItem({'giant spider silk'}, 5879, 100, 1, 'giant spider silk')
shopModule:addSellableItem({'lizard scale'}, 5881, 120, 1, 'lizard scale')
shopModule:addSellableItem({'red dragon scale'}, 5882, 200, 1, 'red dragon scale')
shopModule:addSellableItem({'ape fur'}, 5883, 120, 1, 'ape fur')
shopModule:addSellableItem({'chicken feather'}, 5890, 30, 1, 'chicken feather')
shopModule:addSellableItem({'perfect behemoth fang'}, 5893, 250, 1, 'perfect behemoth fang')
shopModule:addSellableItem({'bat wing'}, 5894, 50, 1, 'bat')
shopModule:addSellableItem({'fish fin'}, 5895, 150, 1, 'fish fin')
shopModule:addSellableItem({'bear paw'}, 5896, 100, 1, 'bear paw')
shopModule:addSellableItem({'wolf paw'}, 5897, 70, 1, 'wolf paw')
shopModule:addSellableItem({'beholder eye'}, 5898, 80, 1, 'beholder eye')
shopModule:addSellableItem({'turtle shell'}, 5899, 90, 1, 'turtle shell')
shopModule:addSellableItem({'honeycomb'}, 5902, 40, 1, 'honey comb')
shopModule:addSellableItem({'magic sulphur'}, 5904, 8000, 1, 'magic sulphur')
shopModule:addSellableItem({'vampire dust'}, 5905, 100, 1, 'vampire dust')
shopModule:addSellableItem({'demon dust'}, 5875, 300, 1, 'demon dust')
shopModule:addSellableItem({'green dragon scale'}, 5920, 100, 1, 'green dragon scale')
shopModule:addSellableItem({'heaven blossom'}, 5921, 50, 1, 'heaven blossom')
shopModule:addSellableItem({'holy orchid'}, 5875, 2000, 1, 'holy orchid')
shopModule:addSellableItem({'hardened bone'}, 5925, 70, 1, 'hardened bone')
shopModule:addSellableItem({'behemoth claw'}, 5930, 500, 1, 'behemoth claw')
shopModule:addSellableItem({'white piece of cloth'}, 5909, 100, 1, 'white piece of cloth')
shopModule:addSellableItem({'green piece of cloth'}, 5910, 200, 1, 'green piece of cloth')
shopModule:addSellableItem({'red piece of cloth'}, 5911, 300, 1, 'red piece of cloth')
shopModule:addSellableItem({'blue piece of cloth'}, 5912, 200, 1, 'blue piece of cloth')
shopModule:addSellableItem({'brown piece of cloth'}, 5913, 100, 1, 'brown piece of cloth')
shopModule:addSellableItem({'yellow piece of cloth'}, 5914, 150, 1, 'yellow piece of cloth')
shopModule:addSellableItem({'red dragon leather'}, 5948, 200, 1, 'red dragon leather')
shopModule:addSellableItem({'demon horn'}, 5954, 1000, 1, 'demon horn')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())