-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
aps_tools = {
	commands = {
		enablePetWar = true, -- enable pet war ? true / false
		revivePetAfterWar = true, -- if pet get kill in war, revive him? true / false
		enableReviveCommand = true, -- able players to use /pet-revive ? true / false
		giveItemToPlayer = true, -- when use /pet-carry 1 (to get item back), give to player or drop on floor? true=give/false=drop
		playerSellPet = {sell = true, lvl = 3}, -- sell pet to pet-trainer <sell = true or false> <lvl = Pet lvl needed> price: Petprice * PetLvl 
		enablePetTeleport = {tp = true, logout = false, distance = 6}, -- info under this line...
		-- tp = teleport pet to player? true or false, logout = if player enter in a pz zone, logout pet? true/false, if false pet will walk with your in pz, but i recommend u to set true
		-- distance = if distance between player/pet more than 6, then teleport!
		petGainExpFromPlayers = true, -- Pets gain exp from others players? true / false
		petGainExpFromPets = true, -- Pets gain exp from others pets? true / false
		countKilledPlayers = true, -- When Pet kill a player, count = killedPlayers+1
		countKilledMonsters = true, -- When Pet kill a monster, count = killedMonsters+1		
		enablePetTurn = true, -- if player turn to a direction then his pet will look too? true / false
		enablePetLook = true, -- if player look to a pet, show pet name, lvl and owner? true / false	
		dropMsgOnLogin = false, -- when player login for the first time, he get a msg, how send the msg? true=drop/false=send on console
		systemMessageColour = MESSAGE_STATUS_CONSOLE_BLUE, -- all messages will send with this colour
		windowsType = {sendInTextDialog = false}, -- false to PopupFYI or true to TextDialog
		enableLoveCommand = {enable = true, wait_time = 300}, -- enable /pet-love? true / false, wait_time in seconds!
		enablePartyCommand =  true -- enable /pet-love? true / false, wait_time in seconds!		
	},
	protectionLevel = 0, -- Pet protection level, 0 to disable.
	lenght = 30, -- max letters pet can say
	show_item = 11138, -- show a nightmare doll when use /pet-status, /pet-carry slots, etc...
	sayWait = 30, -- when use /pet-say player will not be able to use again for 30 sec
	location = "at 'cityname' to the north.", -- location of pet trainer.
	skulls = {
		[1] = {
			-- White Skull Configuration (when player w/ his pet attack a player WITHOUT skull)
			enable = true, -- enable? True/False
			skull = SKULL_WHITE,
			time = 60 -- in seconds
		},	
		[2] = {
			-- Red Skull Configuration (when player w/ his pet kill a player WITHOUT skull)
			enable = false, -- enable? True/False
			skull = SKULL_RED,
			time = 900, -- (60 sec x 15 == 900 sec == 15 minutes)
			killsToRed = 3
		}
	},
	magicLevelRate = 4,	
	stages = { -- EXPERIENCE CONFIG! from minlevel to maxlevel XP will multiplier.
		{minlevel=1, maxlevel=10, multiplier=6},
		{minlevel=10, maxlevel=20, multiplier=4},		
		{minlevel=20, multiplier=2}
	},
	v = "wdk", -- dont touch here.
	s = "olëä×àíÖËæÝÒ" -- dont touch here if you want get this to work.
}
aps_storages = { -- using storages from 1337 to 1415
	race = 1337,
	id = 1338,
	uid = 1339,
	pet = 1340,
	ml = 1341,
	level = 1342,
	lastHealth = 1343, 
	health = 1344,
	mana = 1345,
	manaMax = 1346,
	skull_1 = 1347,
	skull_2 = 1348,
	counter = 1349,
	counter_2 = 1350,
	alert = 1351, 
	kill = 1352,
	love = 1353, -- not in use!
	party = 1354,
	tries = {
		lvl = 1355, -- Experience
		ml = 1356 -- manaSpend
	},
	exhaustion = {
		exh = 1357,
		exh_heal = 1358,
		exh_speed = 1359,
		exh_attack = 1360,
		exh_food = 1361,
		exh_say = 1362,
		exh_eat = 1363,
		exh_love = 1364
	},
	spells = {
		learn_heal = 1365,
		learn_speed = 1365,
		learn_fire = 1367,
		learn_ice = 1368,
		learn_berserk = 1369,
		learn_exchange = 1370,
		learn_challenge = 1371,	
		learn_poison = 1372,	
		learn_energy = 1373,	
		learn_max_heal = 1374,
		learn_groundshake = 1375,
		learn_control = 1376,
		learn_fireball = 1377,
		learn_sludge = 1378,
		learn_granmort = 1379
	--     obs if you gonna add something here, give a look to the last storage at shortkeys!	
	},
	war = {
		war = 1380,
		invite = 1381,
		enemy = 1382,
		win = 1383,
		lost = 1384,
		bestEnemy = 1385
	},
	shortkeys = {
		["a1"] = 1386,
		["a2"] = 1387,
		["a3"] = 1388,
		["a4"] = 1389,
		["a5"] = 1390,
		["a6"] = 1391,
		["a7"] = 1492,
		["a8"] = 1493,
		["a9"] = 1494,
		["a10"] = 1495
	}
}
aps_missions = {
	["dwarf hunter"] = {
		id = 1496,
		check = 1497, 
		request = {itemid = 5880, count = 10}, -- need 10 iron ores
		reward = {id = 2476, count = 1, exp = 1000}, -- reward 1 demon shield and 1000 exp points
		description = "Oohh! this is a good mission for you! easy and fast!"
	},
	["demon hunter"] = {
		id = 1498,
		check = 1499, 
		request = {itemid = 5906, count = 100}, -- need 100 demon dust
		reward = {id = false, count = 0, exp = 50000},  -- reward 50000 exp points
		description = "Oohh! for this mission you'll need to spend some time!"		
	},
	["boss hunter"] = {
		id = 1502,
		check = 1503, 
		request = {itemid = 2421, count = 1}, -- need 1 thunder hammer
		reward = {id = 2160, count = 100, exp = false}, -- reward 100 crystal coins
		description = "Oohh! You need a loot from a monster!"	
	}
}	
aps_texts = {
	smiles_normal = {":)", "(:", ":-)", "=)", "=>"},
	smiles_happy = {":D", "=D", ":P", "=D", "=P"},
	smiles_sad = {"/:", ":/", ":|", ":l", ":I"},
	smiles_bad = {":@", "=(", ":(", "=[", ":C"},
	voices_call = {"HERE I AM", "I LIVE TO SERVE YOU", "DID YOU CALL ME", "WHATS UP"},
	voices_back = {"SEE YAA!", "BYE BYE!", "CYA!", "GOOD BYE :)", "TCHAU?"},	
	no_target = {"I NEED A TARGET!!!", "I DONT HAVE A TARGET.", "NEED TARGET!"},
	no_mana = {"I NEED MANA!!!", "NO ENOUGH MANA..", "IM OUT OF MANA!", "NEED MANA!"},	
	no_food = {"FOOD? WHERE!?", "I SEE NO FOOD...", "NAHH, NO MORE FOOD ON MY SLOTS!", "YEAH...FOOD?"},
	food_voices = {"HMMM...", "HNNHN..", "CRUNCH", "CRUSH..."},
	exh_texts = {"Hey Comon I'M EXHAUSTED!!!", "CAN YOU WAIT SOME?", "OK, IN ONE SECOND!", "HAAM? DUDE WAIT!"},			
	exh_food_texts = {"HEY DUDE IM FULL..", "NAHH, I'M COOL...", "FOOD? NO MORE!", "MAYBE IN FEW SECONDS.."}
}
aps_pets = { -- how to config -> lvlNext = lvl need to evolve, hp = health gain per lvl, same to mana, multiplier = how fast gain magic level
	[1] = {
		[1] = {pet = "[PET] Minotaur", priceRevive = 1000, lvlNext = 4, hp = 20, mana = 20, multiplier = 1.0},
		[2] = {pet = "[PET] Minotaur Guard", priceRevive = 2000, lvlNext = 8},
		[3] = {pet = "[PET] Minotaur Archer", priceRevive = 3000, lvlNext = 13},	
		[3] = {pet = "[PET] Minotaur Mage", priceRevive = 5000}					
	},
	[2] = {
		[1] = {pet = "[PET] Orc", priceRevive = 1000, lvlNext = 3, hp = 20, mana = 20, multiplier = 1.0},
		[2] = {pet = "[PET] Orc Spearman", priceRevive = 2000, lvlNext = 5},			
		[3] = {pet = "[PET] Orc Warrior", priceRevive = 3000, lvlNext = 7},	
		[4] = {pet = "[PET] Orc Berserker", priceRevive = 4000, lvlNext = 9},	
		[5] = {pet = "[PET] Orc Leader", priceRevive = 5000, lvlNext = 13},	
		[6] = {pet = "[PET] Orc Warlord", priceRevive = 7000}				
	},
	[3] = {
		[1] = {pet = "[PET] Priestess", priceRevive = 1000, lvlNext = 5, hp = 15, mana = 25, multiplier = 1.0},
		[2] = {pet = "[PET] Necromancer", priceRevive = 2000, lvlNext = 13},
		[3] = {pet = "[PET] Necropharus", priceRevive = 5000}				
	},	
	[4] = {
		[1] = {pet = "[PET] Skeleton", priceRevive = 1000, lvlNext = 6, hp = 25, mana = 15, multiplier = 1.0},
		[2] = {pet = "[PET] Demon Skeleton", priceRevive = 2000, lvlNext = 13},
		[3] = {pet = "[PET] Undead Gladiator", priceRevive = 5000}				
	},
	[5] = {
		[1] = {pet = "[PET] Dragon Hatchling", priceRevive = 10000, lvlNext = 8, hp = 25, mana = 15, multiplier = 1.0},
		[2] = {pet = "[PET] Dragon", priceRevive = 20000, lvlNext = 15},
		[3] = {pet = "[PET] Dragon Lord", priceRevive = 30000}				
	},
	[6] = {
		[1] = {pet = "[PET] Dwarf", priceRevive = 1000, lvlNext = 3, hp = 15, mana = 25, multiplier = 1.0},
		[2] = {pet = "[PET] Dwarf Soldier", priceRevive = 2000, lvlNext = 7},
		[3] = {pet = "[PET] Dwarf Guard", priceRevive = 3000, lvlNext = 13},
		[4] = {pet = "[PET] Dwarf Geomancer", priceRevive = 5000},		
	},
	[7] = {
		[1] = {pet = "[PET] Cyclops", priceRevive = 1000, lvlNext = 7, hp = 25, mana = 15, multiplier = 1.0},
		[2] = {pet = "[PET] Cyclops Drone", priceRevive = 2000, lvlNext = 13},
		[3] = {pet = "[PET] Cyclops Smith", priceRevive = 3000}
	},
	[8] = {
		[1] = {pet = "[PET] Elf", priceRevive = 1000, lvlNext = 7, hp = 25, mana = 15, multiplier = 1.0},
		[2] = {pet = "[PET] Elf Scout", priceRevive = 2000, lvlNext = 13},
		[3] = {pet = "[PET] Elf Arcanist", priceRevive = 3000}
	},	
	[9] = {
		[1] = {pet = "[PET] Mercury Blob", priceRevive = 1000, lvlNext = 6, hp = 30, mana = 15, multiplier = 1.0},
		[2] = {pet = "[PET] Acid Blob", priceRevive = 2000, lvlNext = 13},
		[3] = {pet = "[PET] Death Blob", priceRevive = 3000}
	},
	[10] = {
		[1] = {pet = "[PET] Dworc Fleshhunter", priceRevive = 1000, lvlNext = 7, hp = 25, mana = 25, multiplier = 1.0},
		[2] = {pet = "[PET] Dworc Venomsniper", priceRevive = 2000, lvlNext = 13},
		[3] = {pet = "[PET] Dworc Voodoomaster", priceRevive = 3000}
	},
	[11] = {
		[1] = {pet = "[PET] Chakoya Toolshaper", priceRevive = 1000, lvlNext = 7, hp = 25, mana = 15, multiplier = 1.0},
		[2] = {pet = "[PET] Chakoya Tribewarden", priceRevive = 2000, lvlNext = 13},
		[3] = {pet = "[PET] Chakoya Windcaller", priceRevive = 3000}
	},
	[12] = {
		[1] = {pet = "[PET] Spider", priceRevive = 1000, lvlNext = 7, hp = 35, mana = 8, multiplier = 1.0},
		[2] = {pet = "[PET] Poison Spider", priceRevive = 2000, lvlNext = 13},
		[3] = {pet = "[PET] Tarantula", priceRevive = 3000}
	},	
}
aps_pets_config = { -- how to config ->  price = price to buy pet, hp = pet start health, same to mana
	["minotaurs"] = {race_id = 1, price = 2000, hp = 230, mana = 55, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["orcs"] = {race_id = 2, price = 2000, hp = 230, mana = 55, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["necromancers"] = {race_id = 3, price = 2000, hp = 230, mana = 70, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["undeads"] = {race_id = 4, price = 2000, hp = 230, mana = 50, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["dragons"] = {race_id = 5, price = 2000, hp = 230, mana = 50, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["dwarfs"] = {race_id = 6, price = 2000, hp = 230, mana = 55, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["giants"] = {race_id = 7, price = 2000, hp = 230, mana = 50, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["elfs"] = {race_id = 8, price = 2000, hp = 230, mana = 50, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["blobs"] = {race_id = 9, price = 2000, hp = 230, mana = 50, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["dworcs"] = {race_id = 10, price = 2000, hp = 230, mana = 50, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["chakoyas"] = {race_id = 11, price = 2000, hp = 230, mana = 50, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
	["aracnids"] = {race_id = 12, price = 2000, hp = 230, mana = 50, vocs = {"Sorcerer","Druid","Paladin","Knight","Master Sorcerer","Elder Druid","Royal Paladin","Elite Knight"}},
}
aps_slots = { -- how to config -> 1396 == item, 1397 == item count(you can add as much as you want, just follow the storages
	[1] = 1396,
	[2] = 1398,
	[3] = 1400,
	[4] = 1402,
	[5] = 1404,
	[6] = 1406,
	[7] = 1408,
	[8] = 1410,
	[9] = 1412,
	[10] = 1414,
}
aps_foods = { -- how to config -> time = pet will eat for X sec, hpAmmount/manaAmmount = pets gain health/mana each TICKS seconds.
	["banana"] = {time = 20, hpAmmount = 10, manaAmmount = 25, ticks = 3},
	["meat"] = {time = 20, hpAmmount = 18, manaAmmount = 7, ticks = 3},
	["ham"] = {time = 30, hpAmmount = 20, manaAmmount = 8, ticks = 3},
	["dragon ham"] = {time = 60, hpAmmount = 25, manaAmmount = 12, ticks = 3},
	["cheese"] = {time = 20, hpAmmount = 8, manaAmmount = 23, ticks = 3},	
	["apple"] = {time = 20, hpAmmount = 10, manaAmmount = 25, ticks = 3},
	["white mushroom"] = {time = 20, hpAmmount = 10, manaAmmount = 25, ticks = 3},
	["fish"] = {time = 15, hpAmmount = 15, manaAmmount = 15, ticks = 3},
	["salmon"] = {time = 20, hpAmmount = 20, manaAmmount = 20, ticks = 4},
	["coconut"] = {time = 20, hpAmmount = 10, manaAmmount = 25, ticks = 3},
	["brown mushroom"] = {time = 20, hpAmmount = 25, manaAmmount = 10, ticks = 3},
	["white mushroom"] = {time = 20, hpAmmount = 10, manaAmmount = 25, ticks = 3}	
}
aps_potions = {
	["small health potion"] = {hpAmmount = 25, text = 'Guuup!'},	
	["health potion"] = {hpAmmount = 55, text = 'Aaaah...'},	
	["mana potion"] = {manaAmmount = 55, text = 'Aaaah...'},
	["strong mana potion"] = {manaAmmount = 85, text = 'Aaaaaah...'},
	["strong health potion"] = {hpAmmount = 85, text = 'Aaaaaah...'},
	["great mana potion"] = {manaAmmount = 105, text = 'Aaaaaah...'},
	["great health potion"] = {hpAmmount = 105, text = 'Aaaaaah...'}
}
aps_attacks = {
	["heal"] = {ml = 1, lvl = 1, races = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}, info = "None", self = 1, offensive = -1, mana = 10, exh = aps_storages.exhaustion.exh_heal, exh_time = 5, price = 100, needLearn = false, learnstg = aps_storages.spells.learn_heal,
		area = 0, range = 0, combatType = COMBAT_HEALING, effectType = CONST_ME_MAGIC_BLUE, text = '+HEALING', textColor = 16,
		formula = {maxb = 0.5, maxa = 20, minb = 0.6, mina = 0},
		hasFunction = false		
	},
	["max heal"] = {ml = 15, lvl = 13, races = {3, 10, 11}, info = "None", self = 1, offensive = -1, mana = 60, exh = aps_storages.exhaustion.exh_heal, exh_time = 15, price = 100, needLearn = true, learnstg = aps_storages.spells.learn_max_heal,
		area = 6, range = 2, combatType = COMBAT_HEALING, effectType = CONST_ME_MAGIC_BLUE, text = '+MAX HEAL', textColor = 16,
		formula = {maxb = 0.4, maxa = 20, minb = 0.6, mina = 0},
		hasFunction = false		
	},	
	["speed"] = {ml = 1, lvl = 2, races = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}, info = "None", mana = 20, exh = aps_storages.exhaustion.exh_speed, exh_time = 30, price = 1100, needLearn = false, learnstg = aps_storages.spells.learn_speed,
		hasFunction = function (parameters)
			local pet, cid = getPlayerPet(parameters.cid), parameters.cid
			doChangeSpeed(pet, getCreatureSpeed(cid))
			addEvent(doChangeSpeed, 30 * 1000, pet, -getCreatureSpeed(cid))
			addEvent(doPlayerSendCancel, 30 * 1000, cid, "[buff] Speed as finished.")
			addEvent(doSendMagicEffect, 30 * 1000, getPetPos(cid), CONST_ME_POFF)
			doSendMagicEffect(getPetPos(cid), 14)
			doSendAnimatedText(getPetPos(cid), "+SPEED", math.random(150, 200))						
		end
	},
	["fire"] = {ml = 1, lvl = 3, races = {1, 2, 3, 5, 8}, info = "None", self = 0, offensive = 1, mana = 25, exh = aps_storages.exhaustion.exh_attack, exh_time = 5, price = 2100, needLearn = false, learnstg = aps_storages.spells.learn_fire,
		area = 4, range = 3, combatType = COMBAT_FIREDAMAGE, effectType = CONST_ME_FIREAREA, shotType = 3, 
		formula = {maxb = 0.2, maxa = 13, minb = 0.2, mina = 0},
		hasFunction = false
	},
	["fireball"] = {ml = 7, lvl = 15, races = {5}, info = "None", self = 0, offensive = 1, mana = 75, exh = aps_storages.exhaustion.exh_attack, exh_time = 10, price = 2100, needLearn = true, learnstg = aps_storages.spells.learn_fireball,
		area = 10, range = 1, combatType = COMBAT_FIREDAMAGE, effectType = CONST_ME_FIREAREA,
		formula = {maxb = 0.3, maxa = 14, minb = 0.3, mina = 0},
		hasFunction = false
	},	
	["ice"] = {ml = 4, lvl = 7, races = {3, 8, 11}, info = "None", self = 0, offensive = 1, mana = 35, exh = aps_storages.exhaustion.exh_attack, exh_time = 5, price = 2100, needLearn = false, learnstg = aps_storages.spells.learn_ice,
		area = 4, range = 3, combatType = COMBAT_ICEDAMAGE, effectType = CONST_ME_ICEATTACK, shotType = 36,  
		formula = {maxb = 0.3, maxa = 15, minb = 0.3, mina = 0},
		hasFunction = false
	},	
	["poison"] = {ml = 2, lvl = 5, races = {3, 9, 10, 12}, info = "None", self = 0, offensive = 1, mana = 45, exh = aps_storages.exhaustion.exh_attack, exh_time = 5, price = 2100, needLearn = false, learnstg = aps_storages.spells.learn_poison,
		area = 6, range = 3, combatType = COMBAT_POISONDAMAGE, effectType = CONST_ME_GREEN_RINGS, shotType = 38, 		
		formula = {maxb = 0.2, maxa = 17, minb = 0.2, mina = 0},
		hasFunction = false
	},	
	["energy"] = {ml = 6, lvl = 10, races = {3, 8, 10, 11}, info = "None", self = 0, offensive = 1, mana = 55, exh = aps_storages.exhaustion.exh_attack, exh_time = 5, price = 2100, needLearn = false, learnstg = aps_storages.spells.learn_energy,
		area = 4, range = 3, combatType = COMBAT_ENERGYDAMAGE, effectType = CONST_ME_ENERGYHIT, shotType = 4, 		
		formula = {maxb = 0.3, maxa = 20, minb = 0.3, mina = 0},
		hasFunction = false
	},	
	["berserk"] = {ml = 3, lvl = 5, races = {4, 5, 6, 7}, info = "None", self = 0, offensive = 1, mana = 15, exh = aps_storages.exhaustion.exh_attack, exh_time = 10, price = 2100, needLearn = false, learnstg = aps_storages.spells.learn_berserk,
		area = 2, range = 0, combatType = COMBAT_PHYSICALDAMAGE, effectType = 9, 
		formula = {maxb = 0.3, maxa = 20, minb = 0.3, mina = 0},
		hasFunction = false
	},
	["groundshake"] = {ml = 7, lvl = 3, races = {4, 7}, info = "None", self = 0, offensive = 1, mana = 15, exh = aps_storages.exhaustion.exh_attack, exh_time = 5, price = 2100, needLearn = false, learnstg = aps_storages.spells.learn_groundshake,
		area = 6, range = 0, combatType = COMBAT_PHYSICALDAMAGE, effectType = CONST_ME_GROUNDSHAKER, 
		formula = {maxb = 0.2, maxa = 15, minb = 0.2, mina = 0},
		hasFunction = false
	},	
	["sludge"] = {ml = 7, lvl = 13, races = {3, 9, 10, 12}, info = "None", self = 0, offensive = 1, mana = 25, needTarget = true, exh = aps_storages.exhaustion.exh_attack, exh_time = 7, price = 2100, needLearn = false, learnstg = aps_storages.spells.learn_sludge,
		area = 0, range = 5, combatType = COMBAT_POISONDAMAGE, effectType = 20, shotType = 10, 		
		formula = {maxb = 0.3, maxa = 18, minb = 0.3, mina = 0},
		hasFunction = false
	},	
	["gran mort"] = {ml = 20, lvl = 20, races = {9, 3, 10}, info = "None", self = 0, offensive = 1, mana = 200, exh = aps_storages.exhaustion.exh_attack, exh_time = 15, price = 3100, needLearn = true, learnstg = aps_storages.spells.learn_granmort,
		hasFunction = function (parameters)    
			function createAttack(combat, effect, dist)     
				local formula, petPos = petFormula(getPetLvl(parameters.cid), getPetMl(parameters.cid), 0.2, 20, 0.2, 0), getPetPos(parameters.cid) 
				local attackGo, attackBack = {x = petPos.x + math.random(-7, 7), y = petPos.y  + math.random(-7, 7), z = petPos.z}, {x = petPos.x + math.random(-2, 2), y = petPos.y + math.random(-2, 2), z = petPos.z}
				doSendDistanceShoot(petPos, attackGo, 10) 
				doSendMagicEffect(attackGo, effect)		
				addEvent(doAreaCombatHealth, 300, getPlayerPet(parameters.cid), combat, attackBack,  0, math.floor(formula.minD*-1*1), math.floor(formula.maxD*-1*1), effect) 
				addEvent(doSendDistanceShoot, 300, attackGo, petPos, 31) 

			end 
			createAttack(COMBAT_DEATHDAMAGE, CONST_ME_MORTAREA) 
			for i = 1, 20 do 
				addEvent(createAttack, 300 * i, COMBAT_DEATHDAMAGE, CONST_ME_MORTAREA)
			end
			createAttack(COMBAT_DEATHDAMAGE, CONST_ME_MORTAREA)
		end
	},	
	["exchange"] = {ml = 2, lvl = 5, races = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}, info = "exchange HP for MP", mana = 0, exh = aps_storages.exhaustion.exh_attack, exh_time = 4, price = 3100, needLearn = false, learnstg = aps_storages.spells.learn_exchange,
		hasFunction = function (parameters)    
			if(getCreatureHealth(getPlayerPet(parameters.cid)) > 20) then
				doCreatureAddHealth(getPlayerPet(parameters.cid), -20)
				addPetMana(parameters.cid, 20)
				doSendMagicEffect(getCreaturePosition(getPlayerPet(parameters.cid)), 14)
				doSendAnimatedText(getCreaturePosition(getPlayerPet(parameters.cid)), "+MANA", math.random(150, 200))
			end	
		end
	},
	["challenge"] = {ml = 3, lvl = 4, races = {4, 7}, info = "challenge an enemy", mana = 24, exh = aps_storages.exhaustion.exh_attack, exh_time = 5, price = 3100, needLearn = false, learnstg = aps_storages.spells.learn_challenge,
		hasFunction = function (parameters)   
			local petPos = getCreaturePosition(getPlayerPet(parameters.cid))
			local enemy = getSpectators(petPos, 1, 1)
			if(#enemy > 0) then
				for i = 1, #enemy do
					if(isMonster(enemy[i])) then
						doMonsterSetTarget(enemy[i], getPlayerPet(parameters.cid))
						doSendMagicEffect(getCreaturePosition(enemy[i]), 14)
					end	
				end
			end	
		end
	},
	["control"] = {ml = 2, lvl = 6, races = {1, 2, 6, 10, 12}, info = "control enemy mind", mana = 60, exh = aps_storages.exhaustion.exh_attack, exh_time = 5, price = 3100, needLearn = false, learnstg = aps_storages.spells.learn_control,
		hasFunction = function (parameters)   
			local petPos, pet, cid = getCreaturePosition(getPlayerPet(parameters.cid)), getPlayerPet(parameters.cid), parameters.cid
			local convinceable_1 = {"Orc", "Minotaur", "Dwarf"}
			local convinceable_2 = { "Bear", "Rat", "Bug", "Wolf", "Winter Wolf", "Cave Rat", "Spider", "Poison Spider", "Skeleton"}
			local function doConvince(uid)
				if(uid ~= pet) then
					if not(isPlayer(getCreatureMaster(uid))) then
						if(isInArray({1, 2, 6, 12}, getPetRace(cid))) then
							if(isInArray(convinceable_1, getCreatureName(uid))) then
								doSendMagicEffect(getCreaturePosition(uid), 31)
								doConvinceCreature(pet, uid)
							end
						elseif(isInArray({10, 11}, getPetRace(cid))) then
							if(isInArray(convinceable_2, getCreatureName(uid))) then
								doSendMagicEffect(getCreaturePosition(uid), 31)
								doConvinceCreature(pet, uid)
							end
						end
					end	
				end	
			end
			local spectators = getSpectators(petPos, 1, 1)
			if(#spectators > 0) then
				for i = 1, #spectators do
					if(isMonster(spectators[i])) then
						doConvince(spectators[i])
					end	
				end
			end				
		end
	}	
}