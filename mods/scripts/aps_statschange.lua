function onStatsChange(cid, attacker, type, combat, value)
	if not (isPlayer(attacker)) then
		if(type == STATSCHANGE_HEALTHLOSS) then
			if(getPlayerPet(cid) == attacker) then
				return false
			end
		end	
	end
	return true
end