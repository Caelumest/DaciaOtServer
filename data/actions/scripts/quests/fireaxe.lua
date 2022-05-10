function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.actionid >= 2432 and item.actionid <= 2432 and getPlayerStorageValue(cid, 2432) ~= 1 then
		local reward = 0
		if item.actionid == 2432 then
			reward = doCreateItemEx(1987,1)
			doAddContainerItem(reward, 2432, 1)
			doAddContainerItem(reward, 9980, 1)
			doAddContainerItem(reward, 9980, 1)
			doAddContainerItem(reward, 9980, 1)

		end
		if doPlayerAddItemEx(cid, reward, 0) == RETURNVALUE_NOERROR then
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,'You found ' .. getItemName(getThing(reward).uid) .. '.')
			setPlayerStorageValue(cid, 2432, 1)
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,'You do not have enought capacity or place in backpack.')
		end
	end
	return TRUE
end