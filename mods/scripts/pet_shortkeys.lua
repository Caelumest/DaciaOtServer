function onSay(cid, words, param, channel)
	if not (isExhausted(cid)) then
		addExhausted(cid, 1)
		if not (doPlayerHavePet(cid)) then
			return true
		end			
		if not (isCreature(getPlayerPet(cid))) then
			returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")
			return true
		end			
		local word = aps_storages.shortkeys[words:lower()]
		if word then
			if(param == '') then
				local attack = getPlayerStorageValue(cid, aps_storages.shortkeys[words])
				if(isNumber(attack)) then
					returnMessage(cid, "[PET-SYSTEM] You need to configure that shortkey.")
					return true
				end
				local k = aps_attacks[attack:lower()]
				if not k then
					returnMessage(cid, "[PET-SYSTEM] You need to configure that shortkey.")
					return true
				elseif k then
					if(getPlayerStorageValue(cid, k.exh) > os.time()) then
						doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.exh_texts), TALKTYPE_ORANGE_1)
						returnMessage(cid, "[PET-SYSTEM] You need to wait " .. fixTimer(getPlayerStorageValue(cid, k.exh)))						
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
					if(k.hasFunction == false) then
						local damage = petFormula(getPetMl(cid), getPetLvl(cid), k.formula.maxb, k.formula.maxa, k.formula.minb, k.formula.mina)
						local minD = math.floor(damage.minD*-1*k.offensive)
						local maxD = math.floor(damage.maxD*-1*k.offensive)
						doAreaCombatHealth(getPlayerPet(cid)*((k.self - 1)*-1), k.combatType, attackPosition, k.area, minD, maxD, k.effectType)
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
					doCreatureSay(cid, getCreatureName(getPlayerPet(cid)) .. ', ' .. attack ..  '!', TALKTYPE_SAY)		
				end
			else 
				local k = aps_attacks[param:lower()]
				if not k then
					returnMessage(cid, "[PET-SYSTEM] Spell '" .. param .. "' does not exist.")
					return true
				elseif k then
					if(isInArray(k.races, getPetRace(cid)) == true) then
						setPlayerStorageValue(cid, aps_storages.shortkeys[words], param)
						returnMessage(cid, "[PET-SYSTEM] Shortkey '" .. words .. "' as set to '" .. param .. "'.")				
					else
						returnMessage(cid, "[PET-SYSTEM] You cannot use '" .. param .. "' as shortkey.")
					end
				end
			end
		elseif(words == "/sk") or (words == "/shortkeys") then	
			local function getPlayerShortKey(cid, shortkey)
				local key, text = getPlayerStorageValue(cid, aps_storages.shortkeys[shortkey]), "**NONE**"
				return isNumber(key) == true and text or key
			end
			local str = "##ADVANCED PET SYSTEM BY RACES##\n               Scripted by " .. s(aps_tools.s) .. "\n\n-> Shortkey - Spell <-\n"
			local count, max = 1, 10
			while TRUE do
				for i = 1, max do
					str = str .. "\n - [" .. "a" .. count .. "] - " .. string.upper(getPlayerShortKey(cid, "a" .. i)) .. ""
					count = count+1
				end	
				if(count > max) then
					break
				end
			end
			sendWindowsMessage(cid, str .. "\n\n                 made by " .. s(aps_tools.s)) -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
		end	
	else	
		doPlayerSendCancel(cid, "You are exhausted.")
	end			
	return true
end