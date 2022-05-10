function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.actionid >= 2519 and item.actionid <= 2519 and getPlayerStorageValue(cid, 2519) ~= 1 then
		local reward = 0
		if item.actionid == 2519 then
			reward = doCreateItemEx(1987,1)
			doAddContainerItem(reward, 2519, 1)
			doAddContainerItem(reward, 2488, 1)
			doAddContainerItem(reward, 9980, 1)
			doAddContainerItem(reward, 9980, 1)

		end
		if doPlayerAddItemEx(cid, reward, 0) == RETURNVALUE_NOERROR then
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,'You found ' .. getItemName(getThing(reward).uid) .. '.')
			setPlayerStorageValue(cid, 42361, 1)
		else
			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,'You do not have enought capacity or place in backpack.')
		end
	end
	return TRUE
end