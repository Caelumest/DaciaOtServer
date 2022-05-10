-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onUse(cid, item, fromPosition, itemEx, toPosition)
	if not (isCreature(getPlayerPet(cid))) then
		returnMessage(cid, "[PET-SYSTEM] Your pet should be online.")
		return true
	end	
	local holes = {468, 481, 483, 7932, 8579}
	if(isInArray(holes, itemEx.itemid)) then
		doCreatureSay(cid, getCreatureName(getPlayerPet(cid)) .. ', Dig!', TALKTYPE_SAY)
		local pos = getClosestFreeTile(getPlayerPet(cid), toPosition)
		doTeleportThing(getPlayerPet(cid), pos)
		for i = 2, 3 do
			addEvent(doSendMagicEffect, i * 200, toPosition, i)
		end
		local newId = itemEx.itemid + 1
		if(itemEx.itemid == 8579) then
			newId = 8585
		end
		doTransformItem(itemEx.uid, newId)
		doDecayItem(itemEx.uid)
	elseif(isInArray(1285, itemEx.itemid)) then
		doCreatureSay(cid, getCreatureName(getPlayerPet(cid)) .. ', Rock Smash!', TALKTYPE_SAY)
		local pos = getClosestFreeTile(getPlayerPet(cid), toPosition)
		doTeleportThing(getPlayerPet(cid), pos)
		for i = 2, 3 do
			addEvent(doSendMagicEffect, i * 200, toPosition, i)
		end
		doRemoveItem(itemEx.uid)
		addEvent(doCreateItem, 5 * 1000, 1285, 1, toPosition)
	elseif(isInArray(2767, itemEx.itemid)) then
		doCreatureSay(cid, getCreatureName(getPlayerPet(cid)) .. ', Cut!', TALKTYPE_SAY)
		doSendDistanceShoot(getCreaturePosition(getPlayerPet(cid)), toPosition, 4)
		for i = 2, 3 do
			addEvent(doSendMagicEffect, i * 100, toPosition, i)
		end
		doRemoveItem(itemEx.uid)
		addEvent(doCreateItem, 5 * 1000, 2767, 1, toPosition)		
	else
		returnMessage(cid, "[PET-SYSTEM] This is impossible.")
	end
	return true
end	