-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function 	onAreaCombat(cid, tileItem, tilePosition, isAggressive)
	if(isAggressive == true) then
		local position = {x = tilePosition.x, y = tilePosition.y, z = tilePosition.z, stackpos = STACKPOS_TOP_MOVEABLE_ITEM_OR_CREATURE}
		local target = getThingFromPos(position).uid
		if not (isMonster(target)) then
			return true
		end	
		local pid = getCreatureMaster(target)
		if not pid then
			return true
		end	
		if(target == getPlayerPet(cid)) and not (isInPetParty(cid)) then
			return false			
		end
		if not (isPlayer(pid)) then
			return true
		end	
		if(target == getPlayerPet(pid)) then
			-- PeT-WaR
			if(aps_tools.commands.enablePetWar == true) then
				if(getPetEnemy(cid) == pid) and (getPetEnemy(pid) == cid) then
					if(isCreature(getPlayerPet(cid)) == true) then
						return true
					end
				end
			end	
			-- PeT-WaR
			if not (isCreature(getPlayerPet(cid))) then
				return false
			end
			if(getPlayerParty(pid) == getPlayerParty(cid)) then
				return true
			end		
			if(aps_tools.protectionLevel ~= 0) then
				if(getPetLvl(pid) < aps_tools.protectionLevel) or (getPetLvl(cid) < aps_tools.protectionLevel) then
					return false
				end
			end					
			if(getCreatureCondition(pid, CONDITION_INFIGHT) == false) and (getCreatureSkullType(target) == SKULL_NONE) and (getCreatureSkullType(pid) == SKULL_NONE) and not (target == getPlayerPet(cid)) and not (isInPetParty(cid)) then
				return false
			end	
		end			
	end	
	return true
end