local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'lizard leather'}, 5876, 120, 'lizard leathers')
shopModule:addSellableItem({'minotaur leather'}, 5878, 120, 'minotaur leathers')
shopModule:addSellableItem({'green dragon leather'}, 5877, 200, 'green dragon leathers')
shopModule:addSellableItem({'giant spider silk'}, 5879, 200, 'giant spider silks')
shopModule:addSellableItem({'red dragon scale'}, 5882, 400, 'red dragon scale')
shopModule:addSellableItem({'green dragon scale'}, 5920, 200, 'green dragon scales')
shopModule:addSellableItem({'bear paw'}, 5896, 100, 'bear paw')
shopModule:addSellableItem({'wolf paw'}, 5897, 100, 'wolf paw')
shopModule:addSellableItem({'bat wing'}, 5894, 100, 'bat wing')
shopModule:addSellableItem({'egg of the many'}, 10523, 100, 'egg of the many')
shopModule:addSellableItem({'honeycomb'}, 5902, 150, 'honeycomb')
shopModule:addSellableItem({'ape fur'}, 5883, 100, 'ape furs')
shopModule:addSellableItem({'iron ore'}, 5880, 100, 'iron ore')
shopModule:addSellableItem({'chicken feather'}, 5890, 30, 'chicken feathers')
shopModule:addSellableItem({'beholder eye'}, 5898, 300, 'beholder eyes')
shopModule:addSellableItem({'demon dust'}, 5906, 1000, 'demon dust')
shopModule:addSellableItem({'vampire dust'}, 5905, 500, 'vampire dust')
shopModule:addSellableItem({'hydra egg'}, 4850, 800, 'hydra egg')
shopModule:addSellableItem({'behemot claw'}, 5930, 500, 'behemot claw')
shopModule:addSellableItem({'red dragon leather'}, 5948, 400, 'red dragon leathers')
shopModule:addSellableItem({'fish tail'}, 5951, 200, 'fish tail')
shopModule:addSellableItem({'winged tail'}, 11223, 900, 'winged tail')
shopModule:addSellableItem({'fish fin'}, 5895, 200, 'fish fin')
shopModule:addSellableItem({'shard'}, 7290, 300, 'shard')
shopModule:addSellableItem({'icicle'}, 4848, 500, 'icicle')
shopModule:addSellableItem({'perfect behemoth fang'}, 5893, 500, 'perfect behemoth fang')
shopModule:addSellableItem({'turtle shell'}, 5899, 100, 'turtle shell')
shopModule:addSellableItem({'white pearl'}, 2143, 120, 'white pearl')
shopModule:addSellableItem({'black pearl'}, 2144, 120, 'black pearl')
shopModule:addSellableItem({'small diamond'}, 2145, 120, 'small diamond')
shopModule:addSellableItem({'small sapphire'}, 2146, 100, 'small sapphire')
shopModule:addSellableItem({'small ruby'}, 2147, 100, 'small ruby')
shopModule:addSellableItem({'small emerald'}, 2149, 100, 'small emerald')
shopModule:addSellableItem({'small amethyst'}, 2150, 100, 'small amethyst')
shopModule:addSellableItem({'talon'}, 2151, 150, 'talon')
shopModule:addSellableItem({'scarab coin'}, 2159, 100, 'scarab coin')
shopModule:addSellableItem({'wyvern fang'}, 7408, 400, 'wyvern fang')
shopModule:addSellableItem({'heaven blossom'}, 5921, 100, 'heaven blossom')
shopModule:addSellableItem({'dragon claw'}, 5919, 800, 'dragon claw')
shopModule:addSellableItem({'hardened bone'}, 5925, 200, 'hardened bone')
shopModule:addSellableItem({'blue gem'}, 2158, 10000, 'blue gem')
shopModule:addSellableItem({'green gem'}, 2155, 10000, 'green gem')
shopModule:addSellableItem({'yellow gem'}, 2154, 10000, 'yellow gem')
shopModule:addSellableItem({'red gem'}, 2156, 10000, 'red gem')
shopModule:addSellableItem({'purple gem'}, 2153, 10000, 'purple gem')
shopModule:addSellableItem({'white piece of cloth'}, 5909, 100, 'white piece of cloth')
shopModule:addSellableItem({'green piece of cloth'}, 5910, 100, 'green piece of cloth')
shopModule:addSellableItem({'red piece of cloth'}, 5911, 100, 'red piece of cloth')
shopModule:addSellableItem({'blue piece of cloth'}, 5912, 100, 'blue piece of cloth')
shopModule:addSellableItem({'brown piece of cloth'}, 5913, 100, 'brown piece of cloth')
shopModule:addSellableItem({'yellow piece of cloth'}, 5914, 100, 'yellow piece of cloth')

shopModule:addBuyableItem({'blessed wooden stake'}, 5942, 7000, 'blessed wooden stake')
shopModule:addBuyableItem({'obsidian knife'}, 5908, 3200, 'obsidian knife')
shopModule:addBuyableItem({'shovel'}, 2554, 20, 'shovel')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())