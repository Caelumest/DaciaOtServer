-- pvp arena lever

function onUse(cid, item, frompos, item2, topos)

	if item.uid == 1945 and item.itemid == 1945 then
		player1pos = {x=1022, y=1020, z=8, stackpos=253}
		player1 = getThingfromPos(player1pos)

		player2pos = {x=1022, y=1022, z=8, stackpos=253}
		player2 = getThingfromPos(player2pos)

		if player1.itemid > 0 and player2.itemid > 0 then
			arenalevel = 50			player1level = getPlayerLevel(player1.uid)
			player2level = getPlayerLevel(player2.uid)

			if player1level >= arenalevel and player2level >= arenalevel then
				for arenax = 1366,1388 do
					for arenay = 1052,1074 do
						arenapos = {x=arenax, y=arenay, z=7, stackpos=253}
						arenacreature = getThingfromPos(arenapos)

						if arenacreature.itemid > 0 then
							doPlayerSendCancel(cid,"Wait for current duel to end.")							return 1
						end
					end
				end

				nplayer1pos = {x=1367, y=1062, z=7}
				nplayer2pos = {x=1386, y=1062, z=7}

				doSendMagicEffect(player1pos,2)
				doSendMagicEffect(player2pos,2)

				doTeleportThing(player1.uid,nplayer1pos)
				doTeleportThing(player2.uid,nplayer2pos)

				doSendMagicEffect(nplayer1pos,10)
				doSendMagicEffect(nplayer2pos,10)				doPlayerSendTextMessage(player1.uid,18,"FIGHT!")				doPlayerSendTextMessage(player2.uid,18,"FIGHT!")
			else				doPlayerSendCancel(cid,"Both fighters must have level 50.")
			end
		else
			doPlayerSendCancel(cid,"You need 2 players for a duel.")
		end
	else
		return 0
   	end

	return 1
end
