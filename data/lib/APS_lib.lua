-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
-- Include aps_config.lua
dofile("aps_config.lua")
-- pet statistics/information
function addPetExp(cid, amount)
	local level = getPetLvl(cid) local need, exp, i = getExpForLvl(level + 1), getPetExp(cid), 0
	if(exp+amount  >= need) then
		doCreatureSay(getPlayerPet(cid), string.upper(getCreatureName(getPlayerPet(cid))) .. " grew to LV. " .. level+1, TALKTYPE_ORANGE_1)	
		setPlayerStorageValue(cid, aps_storages.manaMax, getPetMaxMana(cid) +aps_pets[getPetRace(cid)][1].mana)
		setPlayerStorageValue(cid, aps_storages.health, getPetMaxHp(cid) +aps_pets[getPetRace(cid)][1].hp)	
		setCreatureMaxHealth(getPlayerPet(cid), getPetMaxHp(cid) +aps_pets[getPetRace(cid)][1].hp)
		doSendMagicEffect(getPetPos(cid), math.random(28, 30))		
		setPlayerStorageValue(cid, aps_storages.level, level + 1)
		local pet = aps_pets[getPetRace(cid)][getPetId(cid)]
		i = i+1
		if(pet.lvlNext) then
			if(level +1 >= pet.lvlNext) then
				local pos, name = getPetPos(cid), getCreatureName(getPlayerPet(cid)) 
				setPetLastHealth(cid, getCreatureHealth(getPlayerPet(cid)))				
				doRemoveCreature(getPlayerPet(cid))
				setPetId(cid, getPetId(cid) +1)
				doSummonPet(cid, pos)
				returnMessage(cid, "[PET-SYSTEM] '" .. name .. "' - LV. " .. level .. " Envolved into " .. getArticle(getCreatureName(getPlayerPet(cid))) .. " '" .. getCreatureName(getPlayerPet(cid)) .. "' - LV. " .. level + i .. ".")							
			end
		end		
	end
	if(amount > 0) then
		doSendAnimatedText(getPetPos(cid), "+" .. amount, 215)
	end	
	return setPlayerStorageValue(cid, aps_storages.tries.lvl, exp +amount)
end
function getPetExp(cid)
	return getPlayerStorageValue(cid, aps_storages.tries.lvl)
end
function getPetLastHealth(cid)
	return getPlayerStorageValue(cid, aps_storages.lastHealth)
end
function setPetLastHealth(cid, health)
	return setPlayerStorageValue(cid, aps_storages.lastHealth, health)
end
function getPetMaxHp(cid)
	return getPlayerStorageValue(cid, aps_storages.health)
end
function getPetMana(cid)
	return getPlayerStorageValue(cid, aps_storages.mana)
end
function getPetMaxMana(cid)
	return getPlayerStorageValue(cid, aps_storages.manaMax)
end
function addPetMana(cid, amount)
	return setPlayerStorageValue(cid, aps_storages.mana, getPetMana(cid) +amount)
end
function doPetRemoveMana(cid, amount)
	return setPlayerStorageValue(cid, aps_storages.mana, getPetMana(cid) -amount)
end
function getPetLvl(cid)
	return getPlayerStorageValue(cid, aps_storages.level)
end
function addPetLvl(cid, amount)
	local lvl = getPetLvl(cid) local exp = getExpForLvl(lvl + amount)
	setPlayerStorageValue(cid, aps_storages.tries.lvl, exp)
	doSendMagicEffect(getPetPos(cid), math.random(28, 30))	
	for i = 1, amount do
		setPlayerStorageValue(cid, aps_storages.manaMax, getPetMaxMana(cid) +aps_pets[getPetRace(cid)][1].mana)
		setPlayerStorageValue(cid, aps_storages.health, getPetMaxHp(cid) +aps_pets[getPetRace(cid)][1].hp)
		setCreatureMaxHealth(getPlayerPet(cid), getPetMaxHp(cid) +aps_pets[getPetRace(cid)][1].hp)	
		local pet = aps_pets[getPetRace(cid)][getPetId(cid)]		
		if(pet.lvlNext) then
			if(lvl+amount >= pet.lvlNext) then
				local pos, name = getPetPos(cid), getCreatureName(getPlayerPet(cid)) 
				setPetLastHealth(cid, getCreatureHealth(getPlayerPet(cid)))				
				doRemoveCreature(getPlayerPet(cid))
				setPetId(cid, getPetId(cid) +1)
				doSummonPet(cid, pos)
				returnMessage(cid, "[PET-SYSTEM] '" .. name .. "' - LV. " .. lvl .. " Envolved into " .. getArticle(getCreatureName(getPlayerPet(cid))) .. " '" .. getCreatureName(getPlayerPet(cid)) .. "' - LV. " .. lvl + amount .. ".")	
			end
		end			
	end	
	if(amount > 0) then
		doSendAnimatedText(getPetPos(cid), "+" .. exp , 215)
		doCreatureSay(getPlayerPet(cid), string.upper(getCreatureName(getPlayerPet(cid))) .. " grew to LV. " .. lvl + amount, TALKTYPE_ORANGE_1)			
	end		
	return setPlayerStorageValue(cid, aps_storages.level, lvl + amount)
end
function addPetManaSpend(cid, amount)
	local ml = getPetMl(cid) local need, spend = getReqManaSpend(cid, ml + 1), getPetManaSpend(cid)
	if(spend+amount >= need) then
		doCreatureSay(getPlayerPet(cid), string.upper(getCreatureName(getPlayerPet(cid))) .. " grew to Magic LV. " .. ml + 1, TALKTYPE_ORANGE_1)					
		setPlayerStorageValue(cid, aps_storages.ml, ml + 1)
	end
	return setPlayerStorageValue(cid, aps_storages.tries.ml, spend +amount)	
end
function getPetManaSpend(cid)
	return getPlayerStorageValue(cid, aps_storages.tries.ml)
end
function getPetMl(cid)
	return getPlayerStorageValue(cid, aps_storages.ml)
end
function addPetMl(cid, amount)
	local ml = getPetMl(cid) local manaSpend = getReqManaSpend(cid, ml + amount) setPlayerStorageValue(cid, aps_storages.tries.ml, manaSpend) if(amount > 0) then doCreatureSay(getPlayerPet(cid), string.upper(getCreatureName(getPlayerPet(cid))) .. " grew to Magic LV. " .. ml + amount, TALKTYPE_ORANGE_1) end return setPlayerStorageValue(cid, aps_storages.ml, ml + amount)	
end
function getPetRace(cid)
	return getPlayerStorageValue(cid, aps_storages.race)
end
function getPetId(cid)
	return getPlayerStorageValue(cid, aps_storages.id)
end
function setPetId(cid, pet_id)
	return setPlayerStorageValue(cid, aps_storages.id, pet_id)
end	
function getLvlStage(lvl)
	for i = 1, #aps_tools.stages do
		if(aps_tools.stages[i].maxlevel) then
			for e = aps_tools.stages[i].minlevel, aps_tools.stages[i].maxlevel do
				if(isInArray(e, lvl) == true) then
					ret = aps_tools.stages[i].multiplier
				end
			end
		else
			if(lvl >= aps_tools.stages[i].minlevel) then
				ret = aps_tools.stages[i].multiplier
			end	
		end
	end
	return ret
end
function getExpForLvl(lv)
	lv = lv - 1 return ((50 * lv * lv * lv) - (150 * lv * lv) + (400 * lv)) * 2
end
function getReqManaSpend(cid, magLevel)
	return (20 * magLevel * magLevel * magLevel * 1.5) / aps_pets[getPetRace(cid)][1].multiplier
end
function getRaceNameById(id)
	for k, v in pairs(aps_pets_config) do if(isInArray(v.race_id, id)) then return k end end return nil
end
function getEvolutionsByRace(race)
	local get, str = aps_pets[race], "#   -   Name\n"
	for i = 1, #get do
		str = str .. i .. ".   -   " .. get[i].pet .. "\n"
	end
	return str
end	
-- pet statistics
-- call pet, remove, online and dead....
function isPetOnline(cid)
	return getPlayerStorageValue(cid, aps_storages.pet) == 1 and true or false
end
function setPetStats(cid, value) -- 1 = online, 0 = offline
	return setPlayerStorageValue(cid, aps_storages.pet, value)
end
function getPlayerPet(cid)
	return getPlayerStorageValue(cid, aps_storages.uid)
end
function doRemovePet(cid)
	return doRemoveCreature(getPlayerPet(cid))
end
function getPetPos(cid)
	return getCreaturePosition(getPlayerPet(cid))
end
function doSummonPet(cid, pos)
	if(getTilePzInfo(getCreaturePosition(cid))) then
		returnMessage(cid, "[PET-SYSTEM] the summon as failed! try again!")
		doSendMagicEffect(getCreaturePosition(cid), 2)
		setPetStats(cid, 0)	
		return true
	end	
	local peet = aps_pets[getPetRace(cid)][getPetId(cid)]
	local pet = nil
	if(pos) then 
		pet = doSummonCreature(peet.pet, pos) 
	else 
		pet = doSummonCreature(peet.pet, getCreaturePosition(cid)) 
	end 	
	doCreatureSay(pet, getRamdomThing(aps_texts.voices_call) .. ", " .. string.upper(getCreatureName(cid)) .. "!", TALKTYPE_ORANGE_1)
	setPlayerStorageValue(cid, aps_storages.uid, pet) 
	setPetStats(cid, 1) 
	setPlayerStorageValue(cid, aps_storages.alert, 0)
	setCreatureMaxHealth(pet, getPetMaxHp(cid))	
	if(isNumber(getPetLastHealth(cid))) and (getPetLastHealth(cid) == 0) then
		doCreatureAddHealth(pet, getPetMaxHp(cid)) 
	else
		doCreatureAddHealth(pet, getPetMaxHp(cid) - getCreatureHealth(pet) - getPetLastHealth(cid))
	end			
	doChangeSpeed(pet, getSpeedByLevel(getPetLvl(cid))) 
	doConvinceCreature(cid, pet) 
	doSendMagicEffect(getCreaturePosition(pet), CONST_ME_POFF)	
	if(getMonsterInfo(peet.pet).convinceable == 0) then
		print("[PET-SYSTEM] APS_lib.lua as found an issue, monster '" .. peet.pet .. "' ins't convinceable!. [PLAYER: " .. getCreatureName(cid) .. "]")
		doRemovePet(cid)
		setPetStats(cid, 0)
		returnMessage(cid, "[PET-SYSTEM] Your pet as been removed, reason: monster '" .. peet.pet .. "' ins't convinceable. please send this message to a Game Master.")
	end	
end
function isPetDead(cid)
	return isCreature(getPlayerPet(cid)) == false and isPetOnline(cid) == true or false
end
function doPlayerHavePet(cid)
	return getPlayerStorageValue(cid, aps_storages.race) ~= 0 and true or false
end
function createPet(cid, race_id, hp, mana)
	setPetLastHealth(cid, 0)	
	setPlayerStorageValue(cid, aps_storages.id, 1)
	setPlayerStorageValue(cid, aps_storages.race, race_id)
	setPlayerStorageValue(cid, aps_storages.level, 1) 
	setPlayerStorageValue(cid, aps_storages.ml, 1) 
	setPlayerStorageValue(cid, aps_storages.manaMax, mana) 
	setPlayerStorageValue(cid, aps_storages.mana, mana) 
	setPlayerStorageValue(cid, aps_storages.health, hp)	
end	
function doResetPet(cid)
	for i = aps_storages.race, aps_slots[#aps_slots] do setPlayerStorageValue(cid, i, 0) end
end
function getPriceRevive(cid)
	return aps_pets[getPetRace(cid)][getPetId(cid)].priceRevive
end
-- call pet, remove, online and dead...
-- others
function sendWindowsMessage(cid, message)
	if(aps_tools.commands.windowsType.sendInTextDialog == false) then doPlayerPopupFYI(cid, message) else doShowTextDialog(cid, aps_tools.show_item, message)  end	
end
function getItemNameFromSlot(cid, slot)
	local item, count = getPlayerStorageValue(cid, aps_slots[slot]), getPlayerStorageValue(cid, aps_slots[slot]+1) return item == 0 and "**EMPTY**" or "x" .. count .. " " .. getItemNameById(item) .. (count > 1 and "s" or "")
end
function s(s)-- credits NOT MINE!
	local str = "" for i = 1, s:len() do str = str .. string.char((string.byte(s:sub(i, i)) + i - 10 ) / 2) end return str:reverse()
end
function addNpcAutoSay(npc, time, msgs) -- npc = npcid > getNpcId() - time in seconds, msgs = {"msgs1", "msg2"}
	if(getGlobalStorageValue(npc) < os.time()) then addEvent(doCreatureSay, time * 1000, npc, getRamdomThing(msgs), TALKTYPE_YELL) setGlobalStorageValue(npc, os.time() +time) end		
end
function isExhausted(cid)
	return getPlayerStorageValue(cid, aps_storages.exhaustion.exh) > os.time() and true or false
end
function addExhausted(cid, time) -- time in seconds
	return setPlayerStorageValue(cid, aps_storages.exhaustion.exh, os.time() +time)
end
function getValueInArray (arr, v)
	return arr[v]
end
function petFormula(ml, lvl, maxb, maxa, minb, mina) -- credits opentibia
	return {maxD = ((lvl * 1 + ml * 2) * 1 * mina + minb), minD = ((lvl * 1 + ml * 2) * 1 * maxa + maxb)}
end
function setSkull(cid, type)
	local skulls = { [1] = {stg = aps_storages.skull_1}, [2] = {stg = aps_storages.skull_2, remove = 1}	}
	local thing = skulls[type]
	if thing then
		if(getPlayerStorageValue(cid, thing.stg) <= 0) then
			doCreatureSetSkullType(getPlayerPet(cid), aps_tools.skulls[type].skull)
			setPlayerStorageValue(cid, thing.stg, 1)
			addEvent(setPlayerStorageValue, aps_tools.skulls[type].time * 1000, cid, thing.stg, 0)
			addEvent(doCreatureSetSkullType, aps_tools.skulls[type].time * 1000, getPlayerPet(cid), SKULL_NONE)
			if thing.remove then
				addEvent(setPlayerStorageValue, aps_tools.skulls[type].time * 1000, cid, aps_storages.kill, 0)
			end
		end
	end	
end	
function isFood(itemid)
	if(isNumber(itemid) == true) and (itemid > 100) then local food = aps_foods[getItemNameById(itemid)] if(food) then return true end end	
	return false
end
function isPotion(itemid)
	if(isNumber(itemid) == true) and (itemid > 100) then local potion = aps_potions[getItemNameById(itemid)] if(potion) then return true end end	
	return false
end
function getRamdomThing(table)
	return table[math.random(1, #table)]
end
function doPetFeed(cid, food) -- food = item_id
	local getFood = aps_foods[getItemNameById(food):lower()]	
	function addHp(cid, hp, mana)
		if(isCreature(getPlayerPet(cid)) == true) then
			if(getPlayerStorageValue(cid, aps_storages.exhaustion.exh_eat) == 1) then	
				doCreatureAddHealth(getPlayerPet(cid), hp)
				if(getPlayerStorageValue(cid, aps_storages.mana) < getPlayerStorageValue(cid, aps_storages.manaMax)) then
					addPetMana(cid, mana)
				elseif(getPlayerStorageValue(cid, aps_storages.mana) > getPlayerStorageValue(cid, aps_storages.manaMax)) then
					setPlayerStorageValue(cid, aps_storages.mana, getPlayerStorageValue(cid, aps_storages.manaMax))
				end	
				foodEvent = addEvent(addHp, getFood.ticks * 1000, cid, hp, mana)
				addEvent(setPlayerStorageValue, getFood.time * 1000, cid, aps_storages.exhaustion.exh_eat, 0)
			end	
		end	
	end		
	setPlayerStorageValue(cid, aps_storages.exhaustion.exh_eat, 1)		
	addEvent(addHp, 2 * 1000 , cid, getFood.hpAmmount, getFood.manaAmmount)
	setPlayerStorageValue(cid, aps_storages.exhaustion.exh_food, os.time() +getFood.time)	
end
function fixTimer(v)
	local seconds, minutes, hours = v - os.time(), 0, 0
	while seconds >= 60 do minutes = minutes + 1 seconds = seconds - 60 end
	while minutes >= 60 do hours = hours + 1 minutes = minutes - 60 end
	local str1, str2, str3 = hours > 1 and hours .. " hours, " or "" .. "",  minutes > 1 and minutes .. " minutes and " or "" .. "", seconds .. " seconds." or "" .. ""
	return str1 .. str2 .. str3
end
--  .. seconds .. " seconds." \ " .. minutes > 1 and minutes .. " and, " or "" .. ""
function isSummon(uid) -- check if master is player, only player.
	return isPlayer(getCreatureMaster(uid))
end
function returnMessage(cid, message)
	return doPlayerSendTextMessage(cid, aps_tools.commands.systemMessageColour, message)
end
function getCreatureLastPosition(cid)
	local lookDiretion, creaturePos, lookDiretions = getCreatureLookDirection(cid), getCreaturePosition(cid), {[0] = {x = 0, y = 1}, [1] = {x = -1, y = 0}, [2] = {x = 0, y = -1}, [3] = {x = 1, y = 0}} return {x = creaturePos.x+lookDiretions[lookDiretion].x, y = creaturePos.y+lookDiretions[lookDiretion].y, z = creaturePos.z}
end
function getSpeedByLevel(level) -- credits tara(or tibiawikia)
    return (220 + (2 * (level - 1)))
end	
-- others
-- Pet-WAR
function isPetInWar(cid)
	return getPlayerStorageValue(cid, aps_storages.war.war) > 0 and true or false
end
function doInviteToWar(cid, enemy)
	setPlayerStorageValue(cid, aps_storages.war.invite, getPlayerName(enemy)) setPlayerStorageValue(enemy, aps_storages.war.invite, getPlayerName(cid))
end
function getPetEnemy(cid)
	return getPlayerByNameWildcard(getPlayerStorageValue(cid, aps_storages.war.enemy))
end
function isInvitedToWar(cid, enemy)
	if(getPlayerStorageValue(cid, aps_storages.war.invite) == getPlayerName(enemy)) and (getPlayerStorageValue(enemy, aps_storages.war.invite) == getPlayerName(cid)) then return true end return false
end
function doStartWar(cid, enemy)
	setPlayerStorageValue(cid, aps_storages.war.war, 1) setPlayerStorageValue(enemy, aps_storages.war.war, 1) setPlayerStorageValue(cid, aps_storages.war.enemy, getPlayerName(enemy)) setPlayerStorageValue(enemy, aps_storages.war.enemy, getPlayerName(cid)) setPlayerStorageValue(cid, aps_storages.war.invite, 0) setPlayerStorageValue(enemy, aps_storages.war.invite, 0)	
end
function leaveWar(cid)
	local enemy = getPetEnemy(cid)
	for i = aps_storages.war.war, aps_storages.war.enemy do
		setPlayerStorageValue(cid, i, 0)
		setPlayerStorageValue(enemy, i, 0)
	end
end	
function stopWar(cid, enemy)
	for i = aps_storages.war.war, aps_storages.war.enemy do setPlayerStorageValue(cid, i, 0) setPlayerStorageValue(enemy, i, 0) end
end
function resetWar(cid)
	for i = aps_storages.war.war, aps_storages.war.enemy do setPlayerStorageValue(cid, i, 0) end
end
-- Pet-WAR
-- Pet feeling
function setPetStatus(cid, it) -- its hard to understand if you're not a scripter(it == 1 or 2 )
	 -- 0 = normal, 1 = happy, 2 = sad, 3 = bad
	local stats_1 = {[0] = 1, [1] = 1, [2] = 0, [3] = 2} -- to happy
	local stats_2 = { [0] = 2, [1] = 0, [2] = 3, [3] = 3} -- to bad
	local ret = nil
	if(it == 1) then
		ret = stats_1[getPlayerStorageValue(cid, aps_storages.love)]
	elseif(it == 2) then
		ret = stats_2[getPlayerStorageValue(cid, aps_storages.love)]
	end
	return setPlayerStorageValue(cid, aps_storages.love, ret)
end
function getPetStatus(cid) -- 0 = normal, 1 = happy, 2 = sad, 3 = bad
	local stats = { [0] = aps_texts.smiles_normal, [1] = aps_texts.smiles_happy, [2] = aps_texts.smiles_sad, [3] = aps_texts.smiles_bad }
	return stats[getPlayerStorageValue(cid, aps_storages.love)]
end
function lalala(cid)
	local stats = {
		--[0] = -5,
		--[1] = -15,
		--[2] = +25,
		--[3] = +35,		
	}
	return stats[getPlayerStorageValue(cid, aps_storages.love)]
end
-- Pet feeling
-- haha now pets have guilds too? damn yeah!
-- 				next update!
-- haha now pets have guilds too? damn yeah!
-- PeT-Party
function isInPetParty(cid)
	return getPlayerStorageValue(cid, aps_storages.party) == 1 and true or false
end
function doStartPetParty(cid)
	return setPlayerStorageValue(cid, aps_storages.party, 1)
end
function doLeavePetParty(cid)
	return setPlayerStorageValue(cid, aps_storages.party, 0)
end
-- PeT-Party

