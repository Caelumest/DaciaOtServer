-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onLook(cid, thing)
	if(aps_tools.commands.enablePetLook == false) then
		return true
	end
	if(isExhausted(cid) == true) then
		return false
	end
	local pet = thing.uid
	if not (isMonster(pet)) then
		return true
	end	
	local owner = getCreatureMaster(pet)
	if(owner) then
		if not (isPlayer(owner)) then
			return true
		end	
		if(pet == getPlayerPet(owner)) then
			addExhausted(cid, 2)
			returnMessage(cid, "[PET-SYSTEM] You see " .. getArticle(getCreatureName(pet)) .. " " .. getCreatureName(pet) .. ", level " .. getPetLvl(owner)  .. ". its belongs to " .. getCreatureName(owner) .. ".")
			if(owner == cid) then
				doPlayerSendCancel(cid, "[PET-INFO] Your Pet need  " .. (getExpForLvl(getPetLvl(cid) + 1) - getPetExp(cid) > 1 and getExpForLvl(getPetLvl(cid) + 1) - getPetExp(cid) or 0)  .. " experience to level " .. getPetLvl(cid) + 1)
			end
		end	
	end	
	return true
end