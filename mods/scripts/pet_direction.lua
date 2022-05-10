-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onDirection(cid, old, current)
	if(aps_tools.commands.enablePetTurn == true) then
		if(doPlayerHavePet(cid) == false) then
			return true
		end	
		if(isCreature(getPlayerPet(cid)) == true) then
			doCreatureSetLookDirection(getPlayerPet(cid), current)
		end
	end		
	return true
end
