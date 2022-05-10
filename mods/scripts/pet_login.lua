-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onLogin(cid)
	local bad_names = {"Account Manager", "Account Manager", "Account Manager"}
	if(isInArray(bad_names, getPlayerName(cid)) == true) then
		return true
	end
	local sendMsg = 0
	if(getPlayerStorageValue(cid, aps_storages.race) == -1) then
		doResetPet(cid)
		sendMsg = 1
	end	
	if(sendMsg == 1) then
		local message = "Welcome to " .. getConfigValue('serverName') ..
		"\n this server is using:\n            - Advanced Pet System by Races v" .. s(aps_tools.v) ..
		". \n            - If you want to know more,\n            - Type /pet-help or talk to the [NPC] Pet Trainer.\n\n" .. 
		"                           made by " .. s(aps_tools.s) .. ""
		if(aps_tools.commands.dropMsgOnLogin == true) then
			addEvent(doPlayerPopupFYI, 15 * 1000, cid, message)
		else
			returnMessage(cid, message)
		end
	end
	setPlayerStorageValue(cid, aps_storages.uid, 0)
	resetWar(cid)	
	registerCreatureEvent(cid, "pet_kill")
	registerCreatureEvent(cid, "pet_logout")
	registerCreatureEvent(cid, "pet_look")	
	registerCreatureEvent(cid, "pet_target")	
	registerCreatureEvent(cid, "pet_cast")
	registerCreatureEvent(cid, "pet_direction")	
	registerCreatureEvent(cid, "pet_check")		
	registerCreatureEvent(cid, "pet_areacombat")		
	registerCreatureEvent(cid, "aps_statschange")			
	return true
end	