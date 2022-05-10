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

shopModule:addBuyableItem({'steel helmet'}, 2457, 580, 1, 'steel helmet')
shopModule:addBuyableItem({'chain helmet'}, 2458, 52, 1, 'chain helmet')
shopModule:addBuyableItem({'iron helmet'}, 2459, 390, 1, 'iron helmet')
shopModule:addBuyableItem({'brass helmet'}, 2460, 120, 1, 'brass helmet')
shopModule:addBuyableItem({'leather helmet'}, 2461, 12, 1, 'leather helmet')
shopModule:addBuyableItem({'viking helmet'}, 2473, 265, 1, 'viking helmet')
shopModule:addBuyableItem({'soldier helmet'}, 2481, 110, 1, 'soldier helmet')
shopModule:addBuyableItem({'studded helmet'}, 2482, 63, 1, 'studded helmet')

shopModule:addBuyableItem({'chain armor'}, 2464, 200, 1, 'chain armor')
shopModule:addBuyableItem({'brass armor'}, 2465, 450, 1, 'brass armor')
shopModule:addBuyableItem({'leather armor'}, 2467, 35, 1, 'leather armor')

shopModule:addBuyableItem({'brass legs'}, 2478, 195, 1, 'brass legs')
shopModule:addBuyableItem({'chain legs'}, 2648, 80, 1, 'chain legs')
shopModule:addBuyableItem({'leather legs'}, 2649, 10, 1, 'leather legs')

shopModule:addBuyableItem({'steel shield'}, 2509, 240, 1, 'steel shield')
shopModule:addBuyableItem({'plate shield'}, 2510, 125, 1, 'plate shield')
shopModule:addBuyableItem({'brass shield'}, 2511, 16, 1, 'brass shield')
shopModule:addBuyableItem({'wooden shield'}, 2512, 15, 1, 'wooden shield')
shopModule:addBuyableItem({'dwarven shield'}, 2525, 500, 1, 'dwarven shield')

shopModule:addBuyableItem({'sword'}, 2376, 85, 1, 'sword')
shopModule:addBuyableItem({'two handed sword'}, 2377, 950, 1, 'two handed sword')
shopModule:addBuyableItem({'dagger'}, 2379, 5, 1, 'dagger')
shopModule:addBuyableItem({'rapier'}, 2384, 15, 1, 'rapier')
shopModule:addBuyableItem({'sabre'}, 2385, 35, 1, 'sabre')
shopModule:addBuyableItem({'carlin sword'}, 2395, 473, 1, 'carlin sword')

shopModule:addBuyableItem({'club'}, 2382, 5, 1, 'club')
shopModule:addBuyableItem({'morning star'}, 2394, 430, 1, 'morning star')
shopModule:addBuyableItem({'mace'}, 2398, 90, 1, 'mace')
shopModule:addBuyableItem({'battle hammer'}, 2417, 350, 1, 'battle hammer')
shopModule:addBuyableItem({'clerical mace'}, 2423, 540, 1, 'clerical mace')

shopModule:addBuyableItem({'battle axe'}, 2378, 235, 1, 'battle axe')
shopModule:addBuyableItem({'hand axe'}, 2380, 8, 1, 'hand axe')
shopModule:addBuyableItem({'axe'}, 2386, 20, 1, 'axe')
shopModule:addBuyableItem({'barbarian axe'}, 2429, 590, 1, 'barbarian axe')

shopModule:addSellableItem({'battle axe'}, 2378, 80, 1, 'battle axe')
shopModule:addSellableItem({'hand axe'}, 2380, 4, 1, 'hand axe')
shopModule:addSellableItem({'halberd'}, 2381, 400, 1, 'halberd')
shopModule:addSellableItem({'axe'}, 2386, 8, 1, 'axe')
shopModule:addSellableItem({'double axe'}, 2387, 260, 1, 'double axe')
shopModule:addSellableItem({'barbarian axe'}, 2429, 185, 1, 'barbarian axe')

shopModule:addSellableItem({'steel helmet'}, 2457, 190, 1, 'steel helmet')
shopModule:addSellableItem({'chain helmet'}, 2458, 17, 1, 'chain helmet')
shopModule:addSellableItem({'iron helmet'}, 2459, 145, 1, 'iron helmet')
shopModule:addSellableItem({'brass helmet'}, 2460, 30, 1, 'brass helmet')
shopModule:addSellableItem({'leather helmet'}, 2461, 4, 1, 'leather helmet')
shopModule:addSellableItem({'viking helmet'}, 2473, 66, 1, 'viking helmet')
shopModule:addSellableItem({'legion helmet'}, 2480, 22, 1, 'legion helmet')
shopModule:addSellableItem({'soldier helmet'}, 2481, 16, 1, 'soldier helmet')

shopModule:addSellableItem({'plate armor'}, 2463, 400, 1, 'plate armor')
shopModule:addSellableItem({'chain armor'}, 2464, 70, 1, 'chain armor')
shopModule:addSellableItem({'brass armor'}, 2465, 150, 1, 'brass armor')
shopModule:addSellableItem({'leather armor'}, 2467, 12, 1, 'leather armor')
shopModule:addSellableItem({'scale armor'}, 2483, 75, 1, 'scale armor')shopModule:addSellableItem({'studded armor'}, 2484, 0, 1, 'studded armor')

shopModule:addSellableItem({'brass legs'}, 2478, 49, 1, 'brass legs')
shopModule:addSellableItem({'plate legs'}, 2647, 115, 1, 'plate legs')
shopModule:addSellableItem({'chain legs'}, 2648, 25, 1, 'chain legs')
shopModule:addSellableItem({'leather legs'}, 2649, 2, 1, 'leather legs')

shopModule:addSellableItem({'steel shield'}, 2509, 80, 1, 'steel shield')
shopModule:addSellableItem({'plate shield'}, 2510, 45, 1, 'plate shield')
shopModule:addSellableItem({'brass shield'}, 2511, 16, 1, 'brass shield')
shopModule:addSellableItem({'wooden shield'}, 2512, 5, 1, 'wooden shield')
shopModule:addSellableItem({'battle shield'}, 2513, 95, 1, 'battle shield')
shopModule:addSellableItem({'dwarven shield'}, 2525, 100, 1, 'dwarven shield')
shopModule:addSellableItem({'sentinel shield'}, 3974, 120, 1, 'sentinel shield')
shopModule:addSellableItem({'salamander shield'}, 3975, 280, 1, 'salamander shield')
shopModule:addSellableItem({'tusk shield'}, 3973, 850, 1, 'tusk shield')

shopModule:addSellableItem({'sword'}, 2376, 25, 1, 'sword')
shopModule:addSellableItem({'two handed sword'}, 2377, 450, 1, 'two handed sword')
shopModule:addSellableItem({'dagger'}, 2379, 2, 1, 'dagger')
shopModule:addSellableItem({'rapier'}, 2384, 5, 1, 'rapier')
shopModule:addSellableItem({'sabre'}, 2385, 12, 1, 'sabre')
shopModule:addSellableItem({'carlin sword'}, 2395, 118, 1, 'carlin sword')
shopModule:addSellableItem({'short sword'}, 2406, 10, 1, 'short sword')

shopModule:addSellableItem({'club'}, 2382, 1, 1, 'club')
shopModule:addSellableItem({'morning star'}, 2394, 90, 1, 'morning star')
shopModule:addSellableItem({'mace'}, 2398, 30, 1, 'mace')
shopModule:addSellableItem({'battle hammer'}, 2417, 120, 1, 'battle hammer')
shopModule:addSellableItem({'giant smithhammer'}, 2321, 250, 1, 'giant smithhammer')
shopModule:addSellableItem({'clerical mace'}, 2423, 170, 1, 'clerical mace')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())