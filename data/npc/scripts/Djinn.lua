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

shopModule:addBuyableItem({'beholder shield'}, 2518, 7000, 1, 'beholder shield')
shopModule:addBuyableItem({'noble armor'}, 2486, 8000, 1, 'noble armor')
shopModule:addBuyableItem({'spike sword'}, 2383, 8000, 1, 'spike sword')
shopModule:addBuyableItem({'war hammer'}, 2391, 10000, 1, 'war hammer')

shopModule:addSellableItem({'beholder shield'}, 2518, 1200, 1, 'beholder shield')
shopModule:addSellableItem({'crown shield'}, 2519, 8000, 1, 'crown shield')
shopModule:addSellableItem({'dragon shield'}, 2516, 4000, 1, 'dragon shield')
shopModule:addSellableItem({'guardian shield'}, 2515, 2000, 1, 'guardian shield')
shopModule:addSellableItem({'phoenix shield'}, 2539, 16000, 1, 'phoenix shield')

shopModule:addSellableItem({'blue robe'}, 2656, 10000, 1, 'blue rope')
shopModule:addSellableItem({'crown armor'}, 2487, 12000, 1, 'crown armor')
shopModule:addSellableItem({'noble armor'}, 2486, 900, 1, 'noble armor')

shopModule:addSellableItem({'boots of haste'}, 2195, 30000, 1, 'boots of haste')

shopModule:addSellableItem({'broad sword'}, 2413, 500, 1, 'broad sword')
shopModule:addSellableItem({'dragon lance'}, 2414, 9000, 1, 'dragon lance')
shopModule:addSellableItem({'fire axe'}, 2432, 8000, 1, 'fire axe')
shopModule:addSellableItem({'fire sword'}, 2392, 4000, 1, 'fire sword')
shopModule:addSellableItem({'ice rapier'}, 2396, 1000, 1, 'ice rapier')
shopModule:addSellableItem({'obsidian lance'}, 2425, 500, 1, 'obsidian lance')
shopModule:addSellableItem({'spike sword'}, 2383, 1000, 1, 'spike sword')
shopModule:addSellableItem({'war hammer'}, 2391, 1200, 1, 'war hammer')

shopModule:addSellableItem({'crown helmet'}, 2491, 2500, 1, 'crown helmet')
shopModule:addSellableItem({'crusader helmet'}, 2497, 6000, 1, 'crusader helmet')
shopModule:addSellableItem({'royal helmet'}, 2498, 30000, 1, 'royal helmet')

shopModule:addSellableItem({'crown legs'}, 2488, 12000, 1, 'crown legs')

shopModule:addSellableItem({'earth spike sword'}, 7854, 1000, 1, 'spike sword')
shopModule:addSellableItem({'energy spike sword'}, 7869, 1000, 1, 'spike sword')
shopModule:addSellableItem({'fiery spike sword'}, 7744, 1000, 1, 'spike sword')
shopModule:addSellableItem({'icy spike sword'}, 7763, 1000, 1, 'spike sword')
shopModule:addSellableItem({'earth war hammer'}, 7868, 1200, 1, 'war hammer')
shopModule:addSellableItem({'energy war hammer'}, 7883, 1200, 1, 'war hammer')
shopModule:addSellableItem({'fiery war hammer'}, 7758, 1200, 1, 'war hammer')
shopModule:addSellableItem({'icy war hammer'}, 7777, 1200, 1, 'war hammer')

shopModule:addSellableItem({'wand of vortex'}, 2190, 100, 1, 'wand of vortex')
shopModule:addSellableItem({'wand of dragonbreath'}, 2191, 200, 1, 'wand of dragonbreath')
shopModule:addSellableItem({'wand of decay'}, 2188, 1000, 1, 'wand of decay')
shopModule:addSellableItem({'wand of draconia'}, 8921, 1500, 1, 'wand of draconia')
shopModule:addSellableItem({'wand of cosmic energy'}, 2189, 2000, 1, 'wand of casmic energy')
shopModule:addSellableItem({'wand of inferno'}, 2187, 3000, 1, 'wand of inferno')
shopModule:addSellableItem({'wand of starstorm'}, 8920, 3600, 1, 'wand of starstorm')
shopModule:addSellableItem({'wand of voodoo'}, 8922, 4400, 1, 'wand of voodoo')

shopModule:addSellableItem({'life crystal'}, 2177, 50, 1, 'life crystal')
shopModule:addSellableItem({'magic light wand'}, 2162, 35, 1, 'magic light wand')
shopModule:addSellableItem({'mind stone'}, 2178, 100, 1, 'mind stone')
shopModule:addSellableItem({'orb'}, 2176, 750, 1, 'orb')

shopModule:addBuyableItem({'magic light wand'}, 2162, 120, 1, 'magic light wand')

shopModule:addSellableItem({'dragon hammer'}, 2434, 2000, 1, 'dragon hammer')
shopModule:addSellableItem({'giant sword'}, 2393, 17000, 1, 'giant sword')
shopModule:addSellableItem({'knight axe'}, 2430, 2000, 1, 'knight axe')
shopModule:addSellableItem({'poison dagger'}, 2411, 50, 1, 'poison dagger')
shopModule:addSellableItem({'scimitar'}, 2419, 150, 1, 'scimitar')
shopModule:addSellableItem({'serpent sword'}, 2409, 900, 1, 'serpent sword')
shopModule:addSellableItem({'skull staff'}, 2436, 6000, 1, 'skull staff')

shopModule:addSellableItem({'dark armor'}, 2489, 400, 1, 'dark armor')
shopModule:addSellableItem({'knight armor'}, 2476, 5000, 1, 'knight armor')
shopModule:addSellableItem({'dark helmet'}, 2490, 250, 1, 'dark helmet')
shopModule:addSellableItem({'mystic turban'}, 2663, 150, 1, 'mystic turban')
shopModule:addSellableItem({'strange helmet'}, 2479, 500, 1, 'strange helmet')
shopModule:addSellableItem({'warrior helmet'}, 2475, 5000, 1, 'warrior helmet')

shopModule:addSellableItem({'knight legs'}, 2477, 5000, 1, 'knight legs')

shopModule:addSellableItem({'ancient shield'}, 2532, 900, 1, 'ancient shield')
shopModule:addSellableItem({'black shield'}, 2529, 800, 1, 'black shield')
shopModule:addSellableItem({'tower shield'}, 2528, 8000, 1, 'tower shield')
shopModule:addSellableItem({'vampire shield'}, 2534, 15000, 1, 'vamire shield')

shopModule:addBuyableItem({'ice rapier'}, 2396, 5000, 1, 'ice rapier')
shopModule:addBuyableItem({'serpent sword'}, 2409, 6000, 1, 'serpent sword')
shopModule:addBuyableItem({'dark armor'}, 2489, 1500, 1, 'dark armor')
shopModule:addBuyableItem({'dark helmet'}, 2490, 1000, 1, 'dark helmet')
shopModule:addBuyableItem({'ancient shield'}, 2532, 5000, 1, 'ancient shield')

shopModule:addSellableItem({'snakebite rod'}, 2182, 100, 1, 'snakebite rod')
shopModule:addSellableItem({'moonlight rod'}, 2186, 200, 1, 'moonlight rod')
shopModule:addSellableItem({'necrotic rod'}, 2185, 1000, 1, 'necrotic rod')
shopModule:addSellableItem({'northwind rod'}, 8911, 1500, 1, 'northwind rod')
shopModule:addSellableItem({'terra rod'}, 2181, 2000, 1, 'terra rod')
shopModule:addSellableItem({'hailstorm rod'}, 2183, 3000, 1, 'hailstorm rod')
shopModule:addSellableItem({'springsprout rod'}, 8912, 3600, 1, 'springsprout rod')
shopModule:addSellableItem({'underworld rod'}, 8910, 4400, 1, 'underworld rod')

shopModule:addSellableItem({'ankh'}, 2193, 100, 1, 'ankh')
shopModule:addSellableItem({'mysterious fetish'}, 2194, 50, 1, 'mysterious fetish')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())