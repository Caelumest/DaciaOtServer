function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	if (isCreature(getPlayerPet(cid))) then
		setPetStats(cid, 0)
		doRemovePet(cid)
		addEvent(doSummonPet, 2 * 1000, cid)
	end	
	return true
end
