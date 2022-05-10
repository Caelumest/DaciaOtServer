-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onSay(cid, words, param, channel)
	if not (aps_tools.commands.enablePetWar) then
		returnMessage(cid, "[PET-SYSTEM] Server as disabled that option.")	
		return true
	end
	if not (doPlayerHavePet(cid)) then
		returnMessage(cid, "[PET-SYSTEM] You dont have a pet, Go talk to the Pet Trainer " .. aps_tools.location )
		return true
	end
	if words == "/pet-war-challenge" then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)
			local enemy = getPlayerByNameWildcard(param)	
			if(param == '') then
				doPlayerSendCancel(cid, "Command param required.")
				return true
			end	
			if not (isPlayer(enemy)) then
				returnMessage(cid, "[PeT-WaR] Player '" .. param .. "' not found.")
				return true
			end
			if(isInvitedToWar(cid, enemy) == true) then
				returnMessage(cid, "[PeT-WaR] there's already an invite between you and " .. param .. ".")
				return true
			end
			if(getPlayerGUID(getPlayerByNameWildcard(param)) == getPlayerGUID(cid)) then
				returnMessage(cid, "[PeT-WaR] You may not use your own name.")
				return true			
			end
			if(isCreature(getPlayerPet(cid)) == false) or (isCreature(getPlayerPet(enemy)) == false) then
				returnMessage(cid, "[PeT-WaR] Both pets should be online.")
				return true
			end
			local pos_one, pos_two = getCreaturePosition(cid), getCreaturePosition(enemy)
			if(getDistanceBetween(pos_one, pos_two) > 5) then	
				returnMessage(cid, "[PeT-WaR] You're too far away from the enemy.")			
				return true
			end				
			if(isPetInWar(enemy) == false) and (isPetInWar(cid) == false) then
				-- do the war
				doSendAnimatedText(getCreaturePosition(getPlayerPet(cid)), 'CHALLENGE', math.random(1, 250))
				returnMessage(cid, "[PeT-WaR] Your request has send to '" .. param .. "'.")
				returnMessage(enemy, "[PeT-WaR] Player '" .. getPlayerName(cid) .. "' is challenging you to join in a PeT-WaR.")	
				returnMessage(enemy, "[PeT-WaR] To accept, type /pet-war-accept " .. getPlayerName(cid))	
				doInviteToWar(cid, enemy)
			else
				returnMessage(cid, "[PeT-WaR] You or '" .. param .. "' is already in a PeT-WaR.")
			end
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end			
	elseif words == "/pet-war-accept" then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)	
			local enemy = getPlayerByNameWildcard(param)	
			if(param == '') then
				doPlayerSendCancel(cid, "Command param required.")
				return true
			end			
			if not (isPlayer(enemy)) then
				returnMessage(cid, "[PeT-WaR] Player '" .. param .. "' not found.")
				return true
			end	
			if(getPlayerGUID(enemy) == getPlayerGUID(cid)) then
				returnMessage(cid, "[PeT-WaR] You may not use your own name.")
				return true			
			end			
			if(isCreature(getPlayerPet(cid)) == false) or (isCreature(getPlayerPet(enemy))) == false then
				returnMessage(cid, "[PeT-WaR] Both pets should be online.")
				return true
			end
			local pos_one, pos_two = getCreaturePosition(cid), getCreaturePosition(enemy)
			if(getDistanceBetween(pos_one, pos_two) > 5) then	
				returnMessage(cid, "[PeT-WaR] You're too far away from the enemy.")			
				return true
			end				
			if(isPetInWar(enemy) == true) or (isPetInWar(cid) == true) then
				returnMessage(cid, "[PeT-WaR] You or '" .. param .. "' is already in a PeT-WaR, to reset your possible last PeT-WaR, type /pet-war-leave.")
				return true
			end	
			if not (isInvitedToWar(cid, enemy)) then
				returnMessage(cid, "[PeT-WaR] Theres no invite between you and '" .. param .. "'.")
				return true
			end	
			-- start the war
			doSendAnimatedText(getCreaturePosition(getPlayerPet(cid)), 'ACCEPT', math.random(1, 250))
			for i = 1, 5 do
				addEvent(doSendAnimatedText, i * 1000, getCreaturePosition(getPlayerPet(cid)), i .. ' ...', math.random(1, 250))
			end
			addEvent(returnMessage, 5 * 1100, cid, "[PeT-WaR] Your pet and '" .. getPlayerName(enemy) .. "' pet's may start the PeT-WaR now!")
			addEvent(returnMessage, 5 * 1100, enemy, "[PeT-WaR] Your pet and '" .. getPlayerName(cid) .. "' pet's may start the PeT-WaR now!")
			addEvent(doSendAnimatedText, 5 * 1100, getCreaturePosition(getPlayerPet(cid)), 'FIGHT!', math.random(1, 250))
			addEvent(doSendAnimatedText, 5 * 1100, getCreaturePosition(getPlayerPet(enemy)), 'FIGHT!', math.random(1, 250))
			addEvent(doStartWar, 5 * 1100, cid, enemy)
			-- start the war			
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end	
	elseif words == "/pet-war-cancel" then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)	
			if(param == '') then
				doPlayerSendCancel(cid, "Command param required.")
				return true
			end				
			local enemy = getPlayerByNameWildcard(param)	
			if not (isPlayer(enemy)) then
				returnMessage(cid, "[PeT-WaR] Player '" .. param .. "' not found.")				
				return true
			end
			if(getPlayerGUID(enemy) == getPlayerGUID(cid)) then
				returnMessage(cid, "[PeT-WaR] You may not use your own name.")
				return true			
			end			
			if(isPetInWar(enemy) == true) or (isPetInWar(cid) == true) then
				returnMessage(cid, "[PeT-WaR] You or '" .. param .. "' is already in a PeT-WaR.")
				return true
			end
			if(isInvitedToWar(cid, enemy) == true) then
				local table = {
					cid,
					enemy
				}
				for i = 1, #table do
					resetWar(table[i])
				end
				returnMessage(cid, "[PeT-WaR] Invitation for " .. param .. " has been revoked.")
			else
				returnMessage(cid, "[PeT-WaR] Player " .. param .. " inst invited to a PeT-WaR.")
			end
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end				
	elseif words == "/pet-war-leave" then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)				
			if not (isPetInWar(cid)) then
				returnMessage(cid, "[PeT-WaR] You are not in a PeT-WaR.")
				return true
			end	
			if not (isPlayer(getPetEnemy(cid))) then
				returnMessage(cid, "[PeT-WaR] Your enemy should be online.")
				return true
			end	
			returnMessage(cid, "[PeT-WaR] Your pet have left the PeT-WaR and lost.")
			returnMessage(getPetEnemy(cid), "[PeT-WaR] " .. getCreatureName(getPetEnemy(cid)) .. " pet's has left the PeT-WaR and your pet win!")
			setPlayerStorageValue(cid, aps_storages.war.win, getPlayerStorageValue(cid, aps_storages.war.win) +1)
			setPlayerStorageValue(getPetEnemy(cid), aps_storages.war.lost, getPlayerStorageValue(getPetEnemy(cid), aps_storages.war.lost) +1)
			leaveWar(cid)
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end					
	elseif words == "/pet-war-stats" then
		if not (isExhausted(cid)) then
			addExhausted(cid, 3)		
			if(param == '') then
				local bestEnemy = "Nobody."
				if(getPlayerStorageValue(cid, aps_storages.war.bestEnemy) ~= 0) then
					local explode = string.explode(getPlayerStorageValue(cid, aps_storages.war.bestEnemy), "-")	
					bestEnemy = "\n - Owner: " .. explode[1] .. "[lv:" .. explode[2] .. "]\n - Pet: " .. explode[3] .. "[lv:" .. explode[4] .. "]\n - Race: " .. string.upper(getRaceNameById(explode[5])) .. ""		
				end
				local str = "##ADVANCED PET SYSTEM BY RACES##\n\n" ..
				"Duels:" ..
				"\n - Win: " .. getPlayerStorageValue(cid, aps_storages.war.win) ..
				"\n - Lost: " .. getPlayerStorageValue(cid, aps_storages.war.lost) ..
				"\n\nBest Enemy: " .. bestEnemy .. ""
				doShowTextDialog(cid, aps_tools.show_item, str .. "\n\n                 made by " .. s(aps_tools.s)) -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
			else
				local pid = getPlayerByName(param)
				if not (isPlayer(pid)) then
					returnMessage(cid, "[PET-SYSTEM] Player " .. param .. " should be online.")
					return true
				end	
				local bestEnemy = "Nobody."
				if(getPlayerStorageValue(pid, aps_storages.war.bestEnemy) ~= 0) then
					local explode = string.explode(getPlayerStorageValue(pid, aps_storages.war.bestEnemy), "-")	
					bestEnemy = "\n - Owner: " .. explode[1] .. "[lv:" .. explode[2] .. "]\n - Pet: " .. explode[3] .. "[lv:" .. explode[4] .. "]\n - Race: " .. string.upper(getRaceNameById(explode[5])) .. ""	
				end
				local str = "##ADVANCED PET SYSTEM BY RACES##\n\n" ..
				"Stats of '" .. param .. "' Pet's\n" ..
				"\n - Win: " .. getPlayerStorageValue(pid, aps_storages.war.win) ..
				"\n - Lost: " .. getPlayerStorageValue(pid, aps_storages.war.lost) ..
				"\n\n - Best Enemy: " .. bestEnemy .. ""
				doShowTextDialog(cid, aps_tools.show_item, str .. "\n\n                 made by " .. s(aps_tools.s)) -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
			end
		else	
			doPlayerSendCancel(cid, "You are exhausted.")
		end	
	elseif words == "/pet-war-commands" then
		local str = "##ADVANCED PET SYSTEM BY RACES##\n               Scripted by " .. s(aps_tools.s) .. "\n\n/pet-war-challenge PLAYER\n to challenge PLAYER pet.\n\n/pet-war-accept PLAYER\n to accept PLAYER invite.\n\n/pet-war-cancel PLAYER\n to cancel an invite to PLAYER.\n\n/pet-war-leave\n to leave from PeT-WaR.\n\n/pet-war-stats\n show stats about your PeT-WaR stats\n like win/lose/enemy also\n you can use /pet-war-stats PLAYER.\n" -- YOU HAVE NO RIGHTS TO CHANGE THIS LINE.
		doShowTextDialog(cid, aps_tools.show_item, str)		
	end
	return true
end	