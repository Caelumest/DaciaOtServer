function onUse(cid, item, frompos, item2, topos) --Script by Mock The Bear (MTB)
	local map = getItemAttribute(item.uid,'text')
	if not map then
		local p = getCreaturePosition(cid)
		local pos_str = ('X: %d Y: %d Z: %d'):format(p.x,p.y,p.z)
		doItemSetAttribute(item.uid,'name','Map to telepor to '..pos_str)
		doItemSetAttribute(item.uid,'text',pos_str)
		doPlayerPopupFYI(cid,'You have defined position.')
		return true
	else

		if map:match('X: (%d+) Y: (%d+) Z: (%d+)') then
			local x,y,z= map:match('X: (%d+) Y: (%d+) Z: (%d+)')
			local pos = {x=tonumber(x),y=tonumber(y),z=tonumber(z)}
			if hasCondition(cid,CONDITION_INFIGHT) or isPlayerPzLocked(cid) then
				doPlayerPopupFYI(cid,'You cannot use the map now.')
				return true
			else
				if isWalkable(pos, true,true,false) then
					doTeleportThing(cid,pos)
					doRemoveItem(item.uid,1)
				else
					doPlayerPopupFYI(cid,'Invalid position')
				end
			end
		else
			doPlayerPopupFYI(cid,'Invalid position')
		end
	end
	return true
end
--Script by Mock The Bear (MTB)
function isWalkable(pos, creature, proj, pz)-- by Nord
	if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
	if getTopCreature(pos).uid > 0 and creature then return false end
	if getTileInfo(pos).protection and pz then return false, true end
	local n = not proj and 3 or 2
	for i = 0, 255 do
		pos.stackpos = i
		local tile = getTileThingByPos(pos)
		if tile.itemid ~= 0 and not isCreature(tile.uid) then
			if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
				return false
			end
		end
	end
	return true
end
 
