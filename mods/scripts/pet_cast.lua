-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onCast(cid, target)
	local pid = getCreatureMaster(target)
	if(isMonster(target) == true) then
		if(target == getPlayerPet(cid)) then
			if not (isInPetParty(cid)) then
				doPlayerSendCancel(cid, "You may not attack your own pet.")
				return false
			elseif(isInPetParty(cid)) then
				-- this feature will be added in next update.			
				-- returnMessage(cid, "Your pet will attack you, to stop just leave from the party.")
				return true
			end
		end
		if(isPlayer(pid) == true) then
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
					doPlayerSendCancel(cid, "You need to call your pet to attack another pet.")
					return false
				end
				if(getPlayerParty(pid) == getPlayerParty(cid)) then
					return true
				end		
				if(aps_tools.protectionLevel ~= 0) then
					if(getPetLvl(pid) < aps_tools.protectionLevel) or (getPetLvl(cid) < aps_tools.protectionLevel) then
						doPlayerSendCancel(cid, "Your Pet or target Pet's need to be level " .. aps_tools.protectionLevel .. " or higher.")
						return false
					end
				end								
				if(getCreatureCondition(pid, CONDITION_INFIGHT) == false) and (getCreatureSkullType(target) == SKULL_NONE) and (getCreatureSkullType(pid) == SKULL_NONE) and not (target == getPlayerPet(cid)) and not (isInPetParty(cid)) then
					doPlayerSendCancel(cid, "You may not attack this pet.")
					return false
				end									
			end	
		end	
	elseif(isPlayer(target) == true) then
		if(aps_tools.skulls[1].enable == true) then
			if(getCreatureSkullType(target) == SKULL_NONE) then
				if(isCreature(getPlayerPet(cid)) == true) then
					if(getCreatureSkullType(getPlayerPet(cid)) == SKULL_NONE) then
						setSkull(cid, 1)
					end	
				end
			end
		end	
	end
	return true
end