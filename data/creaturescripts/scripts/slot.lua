---Script by mock the bear!
local conditionMP,conditionHP,conditionML,conditionCLUB, conditionSHI,conditionDIST,conditionAMP = {},{},{},{},{},{},{}
for i=1,100 do ---Carrega as conditions
--- HP
conditionHP[i] = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(conditionHP[i], CONDITION_PARAM_TICKS, -1)
setConditionParam(conditionHP[i], CONDITION_PARAM_STAT_MAXHEALTHPERCENT, 100+i)
setConditionParam(conditionHP[i], CONDITION_PARAM_BUFF, true)
setConditionParam(conditionHP[i], CONDITION_PARAM_SUBID, 50)
--MANA
conditionMP[i] = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(conditionMP[i], CONDITION_PARAM_TICKS, -1)
setConditionParam(conditionMP[i], CONDITION_PARAM_STAT_MAXMANAPERCENT, 100+i)
setConditionParam(conditionMP[i], CONDITION_PARAM_BUFF, true)
setConditionParam(conditionMP[i], CONDITION_PARAM_SUBID, 51)
--Magic level
conditionML[i] = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(conditionML[i], CONDITION_PARAM_TICKS, -1)
setConditionParam(conditionML[i], CONDITION_PARAM_STAT_MAGICLEVELPERCENT, 100+i)
setConditionParam(conditionML[i], CONDITION_PARAM_BUFF, true)
setConditionParam(conditionML[i], CONDITION_PARAM_SUBID, 52)
--club axe sword
conditionCLUB[i] = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(conditionCLUB[i], CONDITION_PARAM_TICKS, -1)
setConditionParam(conditionCLUB[i], CONDITION_PARAM_SKILL_CLUBPERCENT, 100+i)
setConditionParam(conditionCLUB[i], CONDITION_PARAM_SKILL_SWORDPERCENT, 100+i)
setConditionParam(conditionCLUB[i], CONDITION_PARAM_SKILL_AXEPERCENT, 100+i)
setConditionParam(conditionCLUB[i], CONDITION_PARAM_BUFF, true)
setConditionParam(conditionCLUB[i], CONDITION_PARAM_SUBID, 53)
--- shield
conditionSHI[i] = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(conditionSHI[i], CONDITION_PARAM_TICKS, -1)
setConditionParam(conditionSHI[i], CONDITION_PARAM_SKILL_SHIELDPERCENT, 100+i)
setConditionParam(conditionSHI[i], CONDITION_PARAM_BUFF, true)
setConditionParam(conditionSHI[i], CONDITION_PARAM_SUBID, 54)
--- dist
conditionDIST[i] = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(conditionDIST[i], CONDITION_PARAM_TICKS, -1)
setConditionParam(conditionDIST[i], CONDITION_PARAM_SKILL_DISTANCEPERCENT, 100+i)
setConditionParam(conditionDIST[i], CONDITION_PARAM_BUFF, true)
setConditionParam(conditionDIST[i], CONDITION_PARAM_SUBID, 55)
end
function getSlotType(n) --By mock the bear
if not n then
return false
end
if n:match('%[(.+)%]') then
n = n:match('%[(.+)%]')
if n == '?' then
return 0,n
else
return n:match('(.-)%.([+-])(%d+)%%')
end
else
return false
end

end
local function loadSet(cid)
local t = {}
for slot=1,9 do
t[slot] = ''
--print()
local s = getPlayerSlotItem(cid,slot).uid
if s ~= 0 then
t[slot] = getItemName(s)
end
end
return t
end
function isInArray2(arr,var) -- Because in some servers it return 1 and 0 and others true and false
for i,b in pairs(arr) do
if var == b then
return true
end
end
return false
end
function check2(cid,i)
if i == 5 or i == 6 then
if isInArray({'head','necklace','backpack','body','le gs','feet','ring'},getItemValue(getPlayerSlotItem( cid,i).itemid,'slotType') or '') then
return false
end
end
return true
end
function chk(cid,f)
if not isPlayer(cid) then return end
local t = loadSet(cid)
for i=1,#f do
if f[i] ~= t[i] then
equip(cid,nil,slot)
break
end
end
addEvent(chk,2000,cid,t)
end
items = { ---- Only to get attr: slotType because getItemName dont return it -.-'
_VERSION='1.0 By mock',
XML_DIR='data/items/items.xml',
}
do
local ia = os.clock()
io.write('Loading items')
local i = io.open(items.XML_DIR,'r')
local u = i:read(-1)
i:close()
local u = u:match('<items>(.+)</items>')
for mi,id,mid,name,data,me in u:gmatch('<(%a-)%s*id%s*=%s*"(%d+)"%s*(.-)%s*name%s*=%s*"(.-)"%s*>(.-)</(%a*)>') do
if mi == 'item' and me == 'item' then
local td = {name=name,id=id,type=1}
for key,value in data:gmatch('<attribute key="(.-)" value="(.-)"/>') do
td[key] = value
end
for key,value in mid:gmatch('(.-)="(.-)"') do
td[key] = value
end
items[tonumber(id)] = td
if not name then print(id,'l',mi,id,mid,data,me) end
items[name] = td
end
end
for mi,id,mid,name,data in u:gmatch('<(%a-)%s*id%s*=%s*"(%d*)"%s*(.-)%s*name%s*=%s*"(%a+)"%s*/>') do
if mi == 'item' then
local td = {name=name,id=id,type=2}
for key,value in mid:gmatch('(.-)="(.-)"') do
td[key] = value
end
items[tonumber(id)] = td
items[name] = td
end
end
io.write('[done '..os.clock()-ia..']\n')
end
function getItemValue(item,value)
return items[item] and items[item][value]
end
function equip(cid,item,slot) --By mock the bear
local HP = getCreatureHealth(cid)
local MP = getCreatureMana(cid)
local t = {}
if item then
local mm,sinal,qto = getSlotType(getItemName(item.uid))
t[mm] = tonumber(qto)
end
for i=1,9 do -- Not on slot 10 > arrow
if i ~= slot then
if getPlayerSlotItem(cid,i).itemid ~= 0 then
local aab = getPlayerSlotItem(cid,i).uid
if aab and check2(cid,i) then
for _ in getItemName(aab):gmatch('(%[.-%])') do
local mm,sinal,qto2 = getSlotType(_)
if mm then
if not t[mm] then
t[mm] = 0
end
t[mm] = t[mm]+tonumber(qto2)
print(mm,qto2)
t[mm] = t[mm] > 100 and 100 or t[mm]
end
end
end
end
end
end
local fu = 0
local ca = {}
local s = ''
for sl,n in pairs(t) do
fu = fu+1
s = s..''..n..'% more of '..sl..'\n'
if sl == 'hp' then
doAddCondition(cid,conditionHP[tonumber(n)])
doCreatureAddHealth(cid,HP-getCreatureHealth(cid))
ca[50] = 1
doPlayerSendTutorial(cid,19)
elseif sl == 'mp' then
doAddCondition(cid,conditionMP[tonumber(n)])
doCreatureAddMana(cid,HP-getCreatureMana(cid))
ca[51] = 1
doPlayerSendTutorial(cid,19)
elseif sl == 'ml' then
doAddCondition(cid,conditionML[tonumber(n)])
ca[52] = 1
elseif sl == 'cas' then
doAddCondition(cid,conditionCLUB[tonumber(n)])
ca[53] = 1
elseif sl == 'shield' then
doAddCondition(cid,conditionSHI[tonumber(n)])
ca[54] = 1
elseif sl == 'dist' then
doAddCondition(cid,conditionDIST[tonumber(n)])
ca[55] = 1
end
end
if fu > 0 then
addEvent(doPlayerSendTextMessage,100,cid,24,'You have:\n'..s)
for i=50,55 do
if not ca[i] then
doRemoveCondition(cid,CONDITION_ATTRIBUTES,i)
end
end
else
for i=50,55 do
doRemoveCondition(cid,CONDITION_ATTRIBUTES,i)
end
end
return true
end
function onLogin(cid) ---Script by mock the bear!
equip(cid,nil,slot)
addEvent(chk,2000,cid,loadSet(cid))
return TRUE
end