-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onSay(cid, words, param, channel)
	if(words == "/pet") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)
			if not (doPlayerHavePet(cid)) then
				returnMessage(cid, "[PET-SYSTEM] You dont have a pet, go talk to the Pet Trainer " .. aps_tools.location )
				return true
			end	
			if(isPetDead(cid)) then
				returnMessage(cid, "[PET-SYSTEM] Your pet is dead, talk to the Pet Trainer" .. (aps_tools.commands.enableReviveCommand == true and " or type '/pet-revive' ps: this will cost " .. getPriceRevive(cid) .. " gold coins" or "") .. ".")	
				return true
			end
			if not (isCreature(getPlayerPet(cid))) then
				if (getTilePzInfo(getCreaturePosition(cid))) then
					returnMessage(cid, "[PET-SYSTEM] You may not call your pet in a protected zone.")
					return true
				end	
				local pos = getCreaturePosition(cid)
				local bad_items = {"fire field", "poison field", "energy field", "smoke", "searing fire", "poison gas"}
				local item_floor = getThingFromPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 2})
				if(item_floor.itemid ~= 0) and (isInArray(bad_items, getItemNameById(item_floor.itemid)) == true) then
					returnMessage(cid, "[PET-SYSTEM] You may not call your pet here.")
					return true
				end
				doSendMagicEffect({x = pos.x+1, y = pos.y, z = pos.z}, 67)
				addEvent(doSummonPet, 1 * 1000, cid)	
			else
				if(getCreatureSkullType(getPlayerPet(cid)) ~= SKULL_NONE) and (getCreatureSkullType(cid) ~= SKULL_NONE) then
					returnMessage(cid, "[PET-SYSTEM] You may not call back your pet in battle.")
					return true
				end	
				if(isInPetParty(cid)) then
					doLeavePetParty(cid)	
				end
				setPetStats(cid, 0)
				if(getCreatureHealth(getPlayerPet(cid)) == getPetMaxHp(cid)) then
					setPetLastHealth(cid, 0)
				else
					setPetLastHealth(cid, getPetMaxHp(cid) - getCreatureHealth(getPlayerPet(cid)))
				end	
				doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.voices_back), TALKTYPE_ORANGE_1)	
				local pos = getPetPos(cid)
				doSendMagicEffect({x = pos.x+1, y = pos.y, z = pos.z}, 67)
				doRemovePet(cid)			
			end
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end
	elseif(words == "/pet-revive") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 1)	
			if not (doPlayerHavePet(cid)) then
				return true
			end	
			if not (isPetDead(cid)) then
				returnMessage(cid, "[PET-SYSTEM] Your pet inst dead.")	
				return true
			end
			if not (aps_tools.commands.enableReviveCommand) then
				returnMessage(cid, "[PET-SYSTEM] Server as disabled that option.")	
				return true
			end	
			if not (doPlayerRemoveMoney(cid, getPriceRevive(cid))) then
				returnMessage(cid, "[PET-SYSTEM] You dont have enough money. you need " .. getPriceRevive(cid) .. " gold coins.")
				return true
			end			
			setPetStats(cid, 0)
			setPetLastHealth(cid, 0)
			setPlayerStorageValue(cid, aps_storages.mana, getPetMaxMana(cid))
			doSendMagicEffect(getCreaturePosition(cid), 65)					
			returnMessage(cid, "[PET-SYSTEM] Your pet is now alive, type /pet to call him.")	
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end				
	elseif(words == "/pet-attack") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 1)
			if not (doPlayerHavePet(cid)) then
				return true
			end			
			if not (isCreature(getPlayerPet(cid))) then
				returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")
				return true
			end	
			local k = aps_attacks[param:lower()]
			if not k then
				returnMessage(cid, "[PET-SYSTEM] type /pet-help to see all commands.")
			elseif k then
				if(getPlayerStorageValue(cid, k.exh) > os.time()) then
					doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.exh_texts), TALKTYPE_ORANGE_1)
					return true
				end	
				if not (isInArray(k.races, getPetRace(cid))) then
					returnMessage(cid, "[PET-SYSTEM] Your pet cannot use that spell.")
					return true
				end			 
				if(k.needLearn == true) and (getPlayerStorageValue(cid, k.learnstg) == 0) then
					returnMessage(cid, "[PET-SYSTEM] Your pet need to learn that spell.")	
					return true
				end
				if(k.needTarget) and (getCreatureTarget(cid) == 0) then
					if(k.needTarget == 1) or (k.needTarget == true) then
						doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.no_target), TALKTYPE_ORANGE_1)	
						return true
					end	
				end	
				if(getPetLvl(cid) < k.lvl) then
					doCreatureSay(getPlayerPet(cid), "NO ENOUGH LEVEL!", TALKTYPE_ORANGE_1)		
					return true
				end	
				if(getPetMl(cid) < k.ml) then
					doCreatureSay(getPlayerPet(cid), "NO ENOUGH MAGIC LEVEL!", TALKTYPE_ORANGE_1)			
					return true
				end	
				if not (getPetMana(cid) == k.mana) and (getPetMana(cid) < k.mana) then
					doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.no_mana), TALKTYPE_ORANGE_1)
					return true
				end	
				local attackPosition = getPetPos(cid)
				if(k.self ~= 1) and (getCreatureTarget(cid) > 0) then
					attackPosition = getCreaturePosition(getCreatureTarget(cid))
				end	
				if (k.hasFunction == false) then
					local damage = petFormula(getPetMl(cid), getPetLvl(cid), k.formula.maxb, k.formula.maxa, k.formula.minb, k.formula.mina)
					doAreaCombatHealth(getPlayerPet(cid)*((k.self - 1)*-1), k.combatType, attackPosition, k.area, math.floor(damage.minD*-1*k.offensive), math.floor(damage.maxD*-1*k.offensive), k.effectType)
					if(k.shotType) and (getCreatureTarget(cid) > 0) then
						doSendDistanceShoot(getPetPos(cid), getCreaturePosition(getCreatureTarget(cid)), k.shotType)
					end	
					if(k.text and k.textColor) then
						doSendAnimatedText(getPetPos(cid), k.text, k.textColor)
					end					
				else
					k.hasFunction({cid = cid, words = words, param = param})
				end									
				doPetRemoveMana(cid, k.mana)
				addPetManaSpend(cid, k.mana * aps_tools.magicLevelRate)
				setPlayerStorageValue(cid, k.exh, os.time() +k.exh_time)
				doCreatureSay(cid, getCreatureName(getPlayerPet(cid)) .. ', ' .. param ..  '!', TALKTYPE_SAY)
			end				
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end	
	elseif(words == "/pet-status") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)
			if not (doPlayerHavePet(cid)) then
				return true
			end				
			if(param == '') then
				if not (isCreature(getPlayerPet(cid))) then
					returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")	
					return true
				end	
				local pet = getPlayerPet(cid)
				local str = "##ADVANCED PET SYSTEM BY RACES##\n\n" ..
				"Pet: \n - " .. getCreatureName(pet) ..
				"\n - Race: " .. string.upper(getRaceNameById(getPetRace(cid))) ..
				"\n - Level: " .. getPetLvl(cid) ..	
				"\n - Experience: " .. getPetExp(cid) ..						
				"\n - You need " .. (getExpForLvl(getPetLvl(cid) + 1) - getPetExp(cid) > 1 and getExpForLvl(getPetLvl(cid) + 1) - getPetExp(cid) or 0)  .. " experience\n -> to level " .. getPetLvl(cid) + 1 .. 
				"\n\nSkills: " .. 
				"\n - Magic Level: " .. getPetMl(cid) ..						
		 		"\n - Health: " .. (getCreatureHealth(getPlayerPet(cid)) > getPetMaxHp(cid) and getPetMaxHp(cid) or getCreatureHealth(getPlayerPet(cid))) .. "/" .. getPetMaxHp(cid) ..
				"\n - Mana: " .. getPetMana(cid) .. "/" .. getPetMaxMana(cid) ..
				"\n - ManaSpend: " .. getPetManaSpend(cid) .. 
				"\n - You need to Spend " .. (getReqManaSpend(cid, getPetMl(cid) + 1) - getPetManaSpend(cid) > 1 and getReqManaSpend(cid, getPetMl(cid) + 1) - getPetManaSpend(cid) or 0) .. " mana\n -> to magic level " .. getPetMl(cid) + 1  ..  ""
				if(aps_tools.commands.countKilledPlayers == true) then
					str = str .. "\n - Killed Players: " .. getPlayerStorageValue(cid, aps_storages.counter) .. ""	
				end	
				if(aps_tools.commands.countKilledMonsters == true) then
					str = str .. "\n - Killed Monsters: " .. getPlayerStorageValue(cid, aps_storages.counter_2) .. ""	
				end						
				if(getCreatureSkullType(pet) > 0) then
					str = str .. "\n - Skull: " ..  getValueInArray ({"Yellow", "Green", "White", "Red", "Black"}, getCreatureSkullType(pet)) .. ""	
				end	
				sendWindowsMessage(cid, str .. "\n\n                 made by " .. s(aps_tools.s)) -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
			else	
				local pid = getPlayerByName(param)
				if not (isPlayer(pid)) then
					returnMessage(cid, "[PET-SYSTEM] Player " .. param .. " should be online.")
					return true
				end	
				if not (isCreature(getPlayerPet(pid))) then
					returnMessage(cid, "[PET-SYSTEM] Pet of " .. param .. " should be online.")	
					return true
				end	
				if(getPlayerStorageValue(pid, aps_storages.race) ~= 0 )then
					local ped = getPlayerPet(pid)
					local str = "##ADVANCED PET SYSTEM BY RACES##\n\n" ..
					" - Pet Owner: " .. param ..	
					"\n - Pet: " .. getCreatureName(ped) ..
					"\n - Race: " .. string.upper(getRaceNameById(getPetRace(pid))) .. 
					"\n - Level: " .. getPetLvl(pid) ..
					"\n\nSkills: " .. 						
					"\n - Magic Level: " .. getPetMl(pid) ..
					"\n - Health: " .. (getCreatureHealth(getPlayerPet(pid)) > getPetMaxHp(pid) and getPetMaxHp(pid) or getCreatureHealth(getPlayerPet(pid))) .. "/" .. getPetMaxHp(pid) ..	
					"\n - Mana: " .. getPetMana(pid) .. "/" .. getPetMaxMana(pid) ..""
					if(aps_tools.commands.countKilledPlayers == true) then
						str = str .. "\n - Killed Players: " .. getPlayerStorageValue(pid, aps_storages.counter) .. ""	
					end	
					if(aps_tools.commands.countKilledMonsters == true) then
						str = str .. "\n - Killed Monsters: " .. getPlayerStorageValue(pid, aps_storages.counter_2) .. ""	
					end							
					if(getCreatureSkullType(ped) > 0) then
						str = str .. "\n - Skull: " .. getValueInArray({"Yellow", "Green", "White", "Red", "Black"}, getCreatureSkullType(ped)) .. ""
					end							
					sendWindowsMessage(cid, str .. "\n\n                 made by " .. s(aps_tools.s))	 -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.			
				end
			end
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end			
	elseif(words == "/pet-food") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)
			if not (doPlayerHavePet(cid)) then
				return true
			end		
			if(getPlayerStorageValue(cid, aps_storages.exhaustion.exh_food) > os.time()) then	
				doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.exh_food_texts), TALKTYPE_ORANGE_1)	
				return true
			end
			if not (isCreature(getPlayerPet(cid))) then	
				returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")
				return true
			end
			local foundFood, str = 0, getRamdomThing(aps_texts.food_voices) .. "..."
			for i = 1, #aps_slots do
				local searchFood = getPlayerStorageValue(cid, aps_slots[i])
				if(isFood(searchFood)) then
					local srt = getPlayerStorageValue(cid, aps_slots[i]+1)
					if(srt > 1) then
						setPlayerStorageValue(cid, aps_slots[i]+1, srt-1)
						str = str .. " STILL HAVE x" .. srt-1 .. " " .. string.upper(getItemNameById(searchFood)) .. "S"
					else	
						setPlayerStorageValue(cid, aps_slots[i], 0)
						setPlayerStorageValue(cid, aps_slots[i]+1, 0)
						str = str .. " EATING THE LAST " .. string.upper(getItemNameById(searchFood))
					end	
					setPetStatus(cid, 1)
					doPetFeed(cid, searchFood)									
					foundFood = 1
					break
				end
			end	
			if(foundFood == 0) then
				doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.no_food), TALKTYPE_ORANGE_1)	
			elseif(foundFood == 1) then	
				doCreatureSay(getPlayerPet(cid), str, TALKTYPE_ORANGE_1)	
			end
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end			
	elseif(words == "/pet-say") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)
			if not (doPlayerHavePet(cid)) then
				return true
			end		
			if not (isCreature(getPlayerPet(cid))) then
				returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")
				return true
			end
			if(getPlayerStorageValue(cid, aps_storages.exhaustion.exh_say) > os.time()) then	
				doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.exh_texts), TALKTYPE_ORANGE_1)	
				return true
			end	
			if(param == '') then
				returnMessage(cid, "[PET-SYSTEM] type what do you want to your pet say.")
				return true
			end	
			if(string.len(param) > aps_tools.lenght) then
				returnMessage(cid, "[PET-SYSTEM] You cannot use more than " .. aps_tools.lenght .. " letters.")
				return true
			end	
			doCreatureSay(getPlayerPet(cid), param, TALKTYPE_ORANGE_1)
			setPlayerStorageValue(cid, aps_storages.exhaustion.exh_say, os.time() +aps_tools.sayWait)	
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end		
	elseif(words == "/pet-help") then	
		if(param == '') then
			local str = "##ADVANCED PET SYSTEM BY RACES##\n               Scripted by " .. s(aps_tools.s) .. "\n\n/pet-help spells\n to see all Pets spells\n\n/pet-help commands\n to see all Pets commands.\n\n/pet-war-commands\n to all PeT-WaR commands.\n\n/pet-help foods\n to see all foods that pet can eat.\n\n/pet-help experience\n show exp need from lvl 2 to lvl 100.\n" -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
			doShowTextDialog(cid, aps_tools.show_item, str)
		elseif(param == 'commands') then
			local str = "##ADVANCED PET SYSTEM BY RACES##\n               Scripted by " .. s(aps_tools.s) .. "\n\n/pet\nto call your pet\n\n" ..
			"/pet-status\nsee information about your pet.\n\n" ..
			"/pet-attack\nto cast a Pet spell.\n\n" .. 
			"/pet-say\nmake your Pet say.\n\n" .. 
			"/pet-carry\nYour pet can carry items.\n\n" ..
			"/pet-revive\nTo revive your pet.\n\n" ..
			"/pet-info\n Show Exp and Ml rate and more.\n\n" ..
			"/pet-love\n Show to your pet that you love him.\n\n" ..
			"Ps: to feed your pet, just drop food on him."
			doShowTextDialog(cid, aps_tools.show_item, str) -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.	
		elseif(param == 'spells') then
			if not (doPlayerHavePet(cid)) then
				return true
			end				
			local i, str = 0, nil
			for spell in pairs(aps_attacks) do
				if(isInArray(aps_attacks[spell].races, getPetRace(cid))) then
					i = i + 1
					if(str ~= nil) then
						str = str .. " "
					else
						str = "##ADVANCED PET SYSTEM BY RACES##\n               Scripted by " .. s(aps_tools.s) .. "\n\n  -  SPELLS LIST FOR " .. string.upper(getRaceNameById(getPetRace(cid))) .. "  -  \n" -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
					end
					str = str .. "\n" .. i .. ". - '" .. string.upper(spell) .. "'\n        [LV:" .. aps_attacks[spell].lvl .. "] - [ML:" .. aps_attacks[spell].ml .. "] - [MP:" .. aps_attacks[spell].mana .. "]\n        [INFO: " .. aps_attacks[spell].info .. "]\n"
				end
			end		
			doShowTextDialog(cid, aps_tools.show_item, str .. " \n\n  -  SPELLS LIST FOR " .. string.upper(getRaceNameById(getPetRace(cid))) .. "  -  ")
		elseif(param == 'foods') then
			if not (doPlayerHavePet(cid)) then
				return true
			end			
			local i, str = 0, nil
			for food in pairs(aps_foods) do
				i = i + 1
				if(str ~= nil) then
					str = str .. " "
				else
					str = "##ADVANCED PET SYSTEM BY RACES##\n               Scripted by " .. s(aps_tools.s) .. "\n\n             -          FOODS LIST        -          \n" -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
				end
				str = str .. "\n" .. i .. " - '" .. string.upper(food) .. "'\n        [HP:" .. aps_foods[food].hpAmmount .. "] - [MP:" .. aps_foods[food].manaAmmount .. "] - [TICKS:" .. aps_foods[food].ticks .. "]\n"
			end		
			doShowTextDialog(cid, aps_tools.show_item, str .. " \n\n             -          FOODS LIST        -          ")	
		elseif(param == "experience") then
			local str = "##ADVANCED PET SYSTEM BY RACES##\n               Scripted by " .. s(aps_tools.s) .. "\n\n             -        LEVEL TABLE         -        \n"
			local num = 2
			if(doPlayerHavePet(cid)) then
				num = getPetLvl(cid)
			end
			for i = num, 100 do
				str = str .. "             |     LV. " .. i .. " - EXP. " .. getExpForLvl(i) .. "     | \n"
			end
			doShowTextDialog(cid, aps_tools.show_item, str)						
		end
	elseif(words == "/pet-carry") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)
			if not (doPlayerHavePet(cid)) then
				return true
			end
			local max = #aps_slots	
			if(param == '') then
				returnMessage(cid, "[PET-SYSTEM] Drop an item under your pet and type /pet-carry SLOT [max " ..  max .. " slots]")	
				return true
			elseif(param == "slots") then
				local str = "##ADVANCED PET SYSTEM BY RACES##\n               \n\n-> SLOT - ITEM NAME <-\n"
				local count = 1
				while TRUE do
					for i = 1, max do
						str = str .. "\n -> [" .. count .. "] - " .. getItemNameFromSlot(cid, i) .. " <-"
						count = count+1
					end	
					if(count > max) then
						break
					end
				end
				sendWindowsMessage(cid, str .. "\n\n                 made by " .. s(aps_tools.s)) -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
			elseif(isNumber(param) == true) and (tonumber(param) > max)	then
				returnMessage(cid, "[PET-SYSTEM] You cannot use slot " .. tonumber(param) .. ".")	
				return true
			elseif(isNumber(param) == false) then
				returnMessage(cid, "[PET-SYSTEM] SLOT should be a number from 1 to " .. max .. ".")	
				return true		
			end	
		
			local p = aps_slots[tonumber(param)]
			if p then
				if not (isCreature(getPlayerPet(cid))) then
					returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")	
					return true
				end	
				local pos = getPetPos(cid)
				local item_carry, item_count  = getThingFromPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 2}), 1
				if(getPlayerStorageValue(cid, p) < 1) then	
					local bad_items = {"water", "grass", "stone", "tree", "blood", "earth", "dirt", "sand", "hole", "muchrooms", "pool", "pool of blood"}
					if(item_carry.itemid == 0) or (isInArray(bad_items, getItemNameById(item_carry.itemid)) == true) then
						doCreatureSay(getPlayerPet(cid), "I SEE NO ITEM?", TALKTYPE_ORANGE_1)
						return true
					end
					if not (isItemMovable(item_carry.itemid)) or (isContainer(item_carry.uid)) then
						doCreatureSay(getPlayerPet(cid), "I CANNOT CARRY THAT!", TALKTYPE_ORANGE_1)
						return true
					end	
					if(isItemStackable(item_carry.itemid) == true) then
						item_count = item_carry.type
						doRemoveItem(item_carry.uid, item_count)
						doCreatureSay(getPlayerPet(cid), "HMMM, SAVING YOUR " .. (item_count == 1 and "" or "x" .. item_count .. " ") .. "" .. string.upper(getItemNameById(item_carry.itemid)) .. "" .. (item_count > 1 and "S" or "") .. " ON SLOT [" .. param .. "]", TALKTYPE_ORANGE_1)
					else
						doRemoveItem(item_carry.uid, 1)
						doCreatureSay(getPlayerPet(cid), "HMM, SAVING YOUR " .. string.upper(getItemNameById(item_carry.itemid)) .. " ON SLOT [" .. param .. "]", TALKTYPE_ORANGE_1)									
					end
					setPlayerStorageValue(cid, p, item_carry.itemid)
					setPlayerStorageValue(cid, p+1, item_count)
				else	
					local count, item  = getPlayerStorageValue(cid, p+1), getPlayerStorageValue(cid, p)
					if(aps_tools.commands.giveItemToPlayer == false) then
						doCreateItem(item, count, pos)
					else
						if(getPlayerFreeCap(cid) >= getItemWeightById(item, count)) then
							doPlayerAddItem(cid, item, count)
						else
							returnMessage(cid, "[PET-SYSTEM] You dont have enough cap to carry x" .. count .. " " .. getItemNameById(item) .. ",  weighing " .. getItemWeight(p.storage, count) .. " oz.")
							return true
						end
					end	
					doCreatureSay(getPlayerPet(cid), "HERE IS YOUR " .. (count == 1 and "" or "x" .. count .. " ") .. "" .. string.upper(getItemNameById(item)) .. "" .. (count > 1 and "S" or "") .. " FROM SLOT [" .. param .. "]", TALKTYPE_ORANGE_1)				
					setPlayerStorageValue(cid, p, 0)
					setPlayerStorageValue(cid, p+1, 0)
				end
			end	
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end		
	elseif(words == "/pet-info") then	
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)	
			if not (doPlayerHavePet(cid)) then
				return true
			end	
			local i = 0
			for _, pid in ipairs(getPlayersOnline()) do
				if(isCreature(getPlayerPet(pid)) == true) then
					i = i+1
				end
			end			
			local str = "##ADVANCED PET SYSTEM BY RACES##\n\n -> Config Information\n - Magic Rate: " .. aps_tools.magicLevelRate ..
			"x\n - Exp Rate: " .. getLvlStage(getPetLvl(cid)) .. 
			"x\n - Max Slots: " .. #aps_slots .. 
			"\n - Pet's Online: " .. i ..
			"\n - White Skull: " .. aps_tools.skulls[1].time ..
			" seconds\n - Red Skull: " .. aps_tools.skulls[2].time ..
			" seconds\n\n -> Version: " .. s(aps_tools.v) .."\n -> full scripted by:\n                    -> " .. s(aps_tools.s) .. " <-" -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
			 sendWindowsMessage(cid, str)	
		else
			doPlayerSendCancel(cid, "You are exhausted.")
		end
	elseif(words == "/pet-love") then		
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)	
			if not (doPlayerHavePet(cid)) then
				return true
			end	
			if not (aps_tools.commands.enableLoveCommand.enable) then
				returnMessage(cid, "[PET-SYSTEM] Server as disabled that option.")	
				return true
			end	
			if not (isCreature(getPlayerPet(cid))) then
				returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")
				return true
			end
			if(getPlayerStorageValue(cid, aps_storages.exhaustion.exh_love) > os.time()) then
				returnMessage(cid, "[PET-SYSTEM] You need to wait " .. fixTimer(getPlayerStorageValue(cid, aps_storages.exhaustion.exh_love)))	
				return true
			end	
			setPlayerStorageValue(cid, aps_storages.exhaustion.exh_love, os.time() +aps_tools.commands.enableLoveCommand.wait_time)	
			local positions = {
				getCreaturePosition(cid),
				getPetPos(cid)
			}
			for i = 1, #positions do
				addEvent(doSendMagicEffect,  i * 1000, positions[i], 35)
			end
			setPetStatus(cid, 1)
			addEvent(doCreatureSay, 3 * 1000, getPlayerPet(cid), getRamdomThing(getPetStatus(cid)), TALKTYPE_ORANGE_1)
			addEvent(addPetExp, 3 * 1000, cid, math.random(1, getPetLvl(cid)))
			addEvent(addPetManaSpend, 3 * 1000, cid, math.random(1, getPetMl(cid)))
		else
			doPlayerSendCancel(cid, "You are exhausted.")
		end	
	elseif(words == "/pet-party") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)	
			if not (doPlayerHavePet(cid)) then
				return true
			end	
			if not (aps_tools.commands.enablePartyCommand) then
				returnMessage(cid, "[PET-SYSTEM] Server as disabled that option.")	
				return true
			end	
			if not (isCreature(getPlayerPet(cid))) then
				returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")
				return true
			end	
			if not (isInPetParty(cid)) then
				doStartPetParty(cid)
				returnMessage(cid, "[PET-SYSTEM] You and your pet is now in a party.")
			else
				if(getCreatureTarget(cid) ~= 0) then
					if(getCreatureTarget(cid) == getPlayerPet(cid)) then
						returnMessage(cid, "[PET-SYSTEM] Please stop attacking your pet.")	
						return true
					end
				end			
				doLeavePetParty(cid)
				returnMessage(cid, "[PET-SYSTEM] Your party with your pet as been disabled.")	
			end
		else
			doPlayerSendCancel(cid, "You are exhausted.")
		end		
	elseif(words == ".status") then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)	
			doCreatureSay(getPlayerPet(cid), getRamdomThing(getPetStatus(cid)), TALKTYPE_ORANGE_1)	
			doPlayerSendCancel(cid, "[PET-INFO] Your Pet need  " .. (getExpForLvl(getPetLvl(cid) + 1) - getPetExp(cid) > 1 and getExpForLvl(getPetLvl(cid) + 1) - getPetExp(cid) or 0)  .. " experience to level " .. getPetLvl(cid) + 1)
		else
			doPlayerSendCancel(cid, "You are exhausted.")
		end		
	end	
	return true
end