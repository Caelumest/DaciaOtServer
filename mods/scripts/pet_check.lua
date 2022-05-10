-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onThink(cid, interval)
	if(aps_tools.commands.enablePetTeleport.tp == true) then
		if(getPlayerStorageValue(cid, aps_storages.race) ~= 0) then
			if(isCreature(getPlayerPet(cid)) == true) then
				if(math.random(1, 100) == math.random(1, 100)) then
					doCreatureSay(getPlayerPet(cid), getRamdomThing(getPetStatus(cid)), TALKTYPE_ORANGE_1)	
					doPlayerSendCancel(cid, "[PET-INFO] Your Pet need  " .. (getExpForLvl(getPetLvl(cid) + 1) - getPetExp(cid) > 1 and getExpForLvl(getPetLvl(cid) + 1) - getPetExp(cid) or 0)  .. " experience to level " .. getPetLvl(cid) + 1)
				end
				if(math.random(1, 500) == math.random(1, 500)) then
					setPetStatus(cid, 2)
					doCreatureSay(getPlayerPet(cid), getRamdomThing(getPetStatus(cid)), TALKTYPE_ORANGE_1)	
				end				
				local pet = getPlayerPet(cid)
				local petPos, playerPos, newPos = getPetPos(cid), getCreaturePosition(cid), getClosestFreeTile(pet, getCreaturePosition(cid), false, false)
				if(getTilePzInfo(getCreaturePosition(cid)) == true) and (aps_tools.commands.enablePetTeleport.logout == true) and (getCreatureSkullType(pet) == SKULL_NONE) then
					local pos = getPetPos(cid)
					doSendMagicEffect({x = pos.x+1, y = pos.y, z = pos.z}, 67)
					setPetStats(cid, 0)
					doRemovePet(cid)
					setPlayerStorageValue(cid, aps_storages.alert, 0)	
					returnMessage(cid, "[PET-SYSTEM] Your pet is now offline.")
				elseif(getTilePzInfo(getCreaturePosition(cid)) == true) and (aps_tools.commands.enablePetTeleport.logout == false) and (getCreatureSkullType(pet) == SKULL_NONE) then
					if not (getTilePzInfo(getPetPos(cid))) and (getDistanceBetween(getCreaturePosition(cid), getPetPos(cid)) < 3) then
						return true
					elseif(getDistanceBetween(getCreaturePosition(cid), getPetPos(cid)) > 1) then	
						local pos = getCreatureLastPosition(cid)
						doTeleportThing(pet, pos)
						doCreatureSetLookDirection(cid, getCreatureLookDirection(cid))
					end	
				elseif(getTilePzInfo(getPetPos(cid)) == true) and (aps_tools.commands.enablePetTeleport.logout == false) and (getCreatureSkullType(pet) == SKULL_NONE) then
					if(getDistanceBetween(getCreaturePosition(cid), getPetPos(cid)) >= 2) then	
						local pos = getCreatureLastPosition(cid)
						doTeleportThing(pet, pos)
						doCreatureSetLookDirection(cid, getCreatureLookDirection(cid))
					end		
				end
				if(getDistanceBetween(playerPos, petPos) > aps_tools.commands.enablePetTeleport.distance) then	
					if(getTilePzInfo(getCreaturePosition(cid)) == false) then			
						if doTeleportThing(pet, newPos) then
							doSendMagicEffect(newPos, 37)	
						else
							doSendMagicEffect(playerPos, 37)	
							doTeleportThing(pet, playerPos)
						end
						doSendMagicEffect(petPos, CONST_ME_POFF)
					else 
						returnMessage(cid, "[PET-SYSTEM] Your pet is waiting for you.")
					end	
				end	
			elseif(isPetDead(cid) == true) then
				if(getPlayerStorageValue(cid, aps_storages.alert) == 0) then
					doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Your pet is dead.")
					setPlayerStorageValue(cid, aps_storages.alert, 1)
				end
			end
		end
	end	
	--PeT-WaR
	if(aps_tools.commands.enablePetWar == true) then
		if(getPlayerStorageValue(cid, aps_storages.race) ~= 0) then
			if(isPetInWar(cid) == true) then
				if(isCreature(getPetEnemy(cid)) == false) then
					resetWar(cid)
					returnMessage(cid, "[PET-WAR] Your last PeT-WaR as been reseted, reason: Your enemy is offline.")
				end
			end	
		end
	end	
	--PeT-WaR
	return true
end