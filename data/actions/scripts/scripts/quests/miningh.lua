function onUse(cid, item, frompos, item2, topos)


	if item.uid == 7939 then
		if getPlayerStorageValue(cid,7939) == -1 then
			doPlayerSendTextMessage(cid,25,"You have found a mining helmet.")
			doPlayerAddItem(cid,7939,1)
			setPlayerStorageValue(cid,7939,1)
		else
			doPlayerSendTextMessage(cid,25,"This chest is empty.")
		end

	end
	return TRUE
end