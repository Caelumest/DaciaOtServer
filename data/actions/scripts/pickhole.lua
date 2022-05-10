--Pick 100% rl By mock.
local tempo = 6000

local function fechar(totals)
topos = totals.topos
local npos = {x=topos.x, y=topos.y, z=topos.z, stackpos=0}
local grounditem = getThingfromPos(npos)
	doRemoveItem(grounditem.uid,1)
local item = math.random(351,355)
local itam = doCreateItem(item,1,npos)
    doSetItemActionId(itam,2124) 
 end

function onUse(cid, item, frompos, item2, topos)
	if item2.itemid == 0 then
		return 0
	end 
 	npos = {x=topos.x, y=topos.y, z=topos.z, stackpos=0}
	grounditem = getThingfromPos(npos)
	if grounditem.itemid == 351 and grounditem.actionid == 2124 then
           doTransformItem(grounditem.uid,383)
           doSendMagicEffect(npos,2)
                      totals ={topos = topos}
           addEvent(fechar, tempo, totals)

	elseif grounditem.itemid == 352 and grounditem.actionid == 2124 then
           doTransformItem(grounditem.uid,383)
           doSendMagicEffect(npos,2)
                      totals ={topos = topos}
           addEvent(fechar, tempo, totals)
	
	elseif grounditem.itemid == 353 and grounditem.actionid == 2124 then
           doTransformItem(grounditem.uid,383)
           doSendMagicEffect(npos,2)
                      totals ={topos = topos}
           addEvent(fechar, tempo, totals)
	
	elseif grounditem.itemid == 354 and grounditem.actionid == 2124 then
           doTransformItem(grounditem.uid,383)
           doSendMagicEffect(npos,2)
                      totals ={topos = topos}
           addEvent(fechar, tempo, totals)
	
	elseif grounditem.itemid == 355 and grounditem.actionid == 2124 then
           doTransformItem(grounditem.uid,383)
           doSendMagicEffect(npos,2)
           totals ={topos = topos}
           addEvent(fechar, tempo, totals)
  	else
		return 0
	end
	return 1
end
 