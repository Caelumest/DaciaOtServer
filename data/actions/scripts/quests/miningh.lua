function onUse(cid, item, frompos, item2, topos)

	if item.uid == 7939 then
		if getPlayerStorageValue(cid,7939) == -1 then
			doPlayerSendTextMessage(cid,25,"You have found a mining helmet.")
			doPlayerAddItem(cid,7939,1)
			setPlayerStorageValue(cid,7939,1)
		else
			doPlayerSendTextMessage(cid,25,"The chest is empty.")
		end

	elseif item.uid == 50031 then
		if getPlayerStorageValue(cid,50031) == -1 then
			doPlayerSendTextMessage(cid,25,"You have found a Dragon Lance.")
			doPlayerAddItem(cid,2414,1)
			setPlayerStorageValue(cid,50031,1)
		else
			doPlayerSendTextMessage(cid,25,"The is empty.")
		end
	
	end
	return TRUE
end