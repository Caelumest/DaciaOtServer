-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onKill(cid, target, lastHit)
	if(isCreature(getPlayerPet(cid)) == false) then
		return true
	end	
	if(getDistanceBetween(getCreaturePosition(getPlayerPet(cid)), getCreaturePosition(target)) > 7) then	
		return true
	end	
	if(isMonster(target) == true) then	
		owner = getCreatureMaster(target)
		if(isPlayer(owner) == true) and (target == getPlayerPet(owner)) and (target ~= getPlayerPet(cid))  then 
			-- Pet-WAR
			if(aps_tools.commands.enablePetWar == true) then
				if(getPetEnemy(cid) == owner) and (getPetEnemy(owner) == cid) then
					stopWar(cid, owner)
					doSendAnimatedText(getCreaturePosition(getPlayerPet(cid)), "WINNER!", math.random(1, 255))
					doSendAnimatedText(getCreaturePosition(target), "LOSER!", math.random(1, 255))
					doSendMagicEffect(getCreaturePosition(getPlayerPet(cid)), 29)
					doSendMagicEffect(getCreaturePosition(target), 32)
					returnMessage(cid, "[PeT-WaR] Your Pet WIN the duel versus " .. getCreatureName(target) .. "(owner:" .. getPlayerName(owner) .. "), level " .. getPetLvl(owner) ..  " from " .. getRaceNameById(getPetRace(owner)) .. " race.")
					returnMessage(owner, "[PeT-WaR] Your Pet LOST the duel versus '" .. getCreatureName(getPlayerPet(cid)) .. "'.")
					setPlayerStorageValue(cid, aps_storages.war.win, getPlayerStorageValue(cid, aps_storages.war.win) +1)
					setPlayerStorageValue(owner, aps_storages.war.lost, getPlayerStorageValue(owner, aps_storages.war.lost) +1)
					local storage = getPlayerStorageValue(cid, aps_storages.war.bestEnemy)
					local playerName, playerLvl, petName, petLvl, raceId  = getCreatureName(owner), getPlayerLevel(owner), getCreatureName(getPlayerPet(owner)), getPetLvl(owner), getPetRace(owner)					
					if(storage ~= 0) then
						local explode = string.explode(storage, "-")		
						oldLvl = tonumber(explode[4])
					end	
					if(storage == 0) then
						setPlayerStorageValue(cid, aps_storages.war.bestEnemy, playerName .. "-" .. playerLvl .. "-" .. petName .. "-" .. petLvl .. "-" .. raceId)
						returnMessage(cid, "[PeT-WaR] New best enemy! type /pet-war-stats for more information.")							
					elseif oldLvl and (petLvl > oldLvl) then
						setPlayerStorageValue(cid, aps_storages.war.bestEnemy, playerName .. "-" .. playerLvl .. "-" .. petName .. "-" .. petLvl .. "-" .. raceId)
						returnMessage(cid, "[PeT-WaR] Your best enemy as been updated.")								
					end	
					if(aps_tools.commands.revivePetAfterWar == true) then
						setPetStats(owner, 0)
					end
				end
			end	
			-- Pet-WAR
			if(aps_tools.commands.petGainExpFromPets == true) then
				addPetExp(cid, getMonsterInfo(getCreatureName(target)).experience * getLvlStage(getPetLvl(cid)) + getPetLvl(owner))
			end	
		else
			if(isSummon(target) == false) then
				doPlayerAddExperience(cid, getMonsterInfo(getCreatureName(target)).experience / 2 * getExperienceStage(getPlayerLevel(cid)))
				addPetExp(cid, getMonsterInfo(getCreatureName(target)).experience / 2 * getLvlStage(getPetLvl(cid)))	
				if(aps_tools.commands.countKilledMonsters == true) then
					local count = getPlayerStorageValue(cid, aps_storages.counter_2)
					setPlayerStorageValue(cid, aps_storages.counter_2, count+1)
				end		
			end
		end	
	elseif(isPlayer(target) == true) then
		if(aps_tools.skulls[2].enable == true) then
			if(getCreatureSkullType(target) == SKULL_NONE) then
				if(getPlayerStorageValue(cid, aps_storages.kill)+1 >= aps_tools.skulls[2].killsToRed) then
					setSkull(cid, 2)
					returnMessage(cid, "[PET-SYSTEM] Your pet killed " .. getCreatureName(target) .. ", now your pet have " .. getPlayerStorageValue(cid, aps_storages.kill)+1 .. " unjustified frags.")					
					setPlayerStorageValue(cid, aps_storages.kill, getPlayerStorageValue(cid, aps_storages.kill) +1)
				end	
			end
		end	
		if(aps_tools.commands.countKilledPlayers == true) then
			local count = getPlayerStorageValue(cid, aps_storages.counter)
			setPlayerStorageValue(cid, aps_storages.counter, count+1)
		end
		if(aps_tools.commands.petGainExpFromPlayers == true) then		
			addPetExp(cid,  getPetLvl(cid) + getPlayerLevel(target) * getLvlStage(getPetLvl(cid)))
		end	
	end	
	return true
end	