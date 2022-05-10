-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onLogout(cid)
	if(isCreature(getPlayerPet(cid)) == true) then
		if(getCreatureSkullType(getPlayerPet(cid)) == SKULL_NONE) then
			if(isInPetParty(cid)) then
				doLeavePetParty(cid)	
			end
			doRemovePet(cid)
			setPetStats(cid, 0)
		else
			doPlayerSendCancel(cid, RETURNVALUE_PLAYERISPZLOCKEDLEAVEPVPZONE)
			return false
		end
	end
	if(isPetInWar(cid) == true) then
		if(isPlayer(getPetEnemy(cid)) == true) then
			doSendAnimatedText(getCreaturePosition(getPlayerPet(getPetEnemy(cid))), "WINNER!", math.random(1, 255))
			returnMessage(getPetEnemy(cid), "[PeT-WaR] Your Pet WIN the duel versus " .. getCreatureName(getPlayerPet(cid)) .. "(owner:" .. getPlayerName(cid) .. "), level " .. getPetLvl(cid) ..  " from " .. getRaceNameById(getPetRace(cid)) .. " race.")
			setPlayerStorageValue(getPetEnemy(cid), aps_storages.war.win, getPlayerStorageValue(getPetEnemy(cid), aps_storages.war.win) +1)
			setPlayerStorageValue(cid, aps_storages.war.lost, getPlayerStorageValue(cid, aps_storages.war.lost) +1)		
			leaveWar(cid)			
		else
			resetWar(cid)
		end		
	end	
	return true
end