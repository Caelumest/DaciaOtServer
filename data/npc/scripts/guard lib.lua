--[[
        ==========================
        |                        |
        |   Guard system 1.0     |
        |    Author: GS TEAM     |
        |   Create to OTNET      |
        |   Mock and kaotar     |
        ==========================

 1.0 Features:
        - Attack monsters and Pk players
]]

GUARD = 1
SELFGUARD = 2



Guard = {
        movingBack = false,
        move = {
            moving = false
        },
        config = {
            speed = 800,
            changeFloor = false,
            moveType = GUARD,
            moveBack = true,
            playerExp = true,
            delay_attack = 0.5,
            exaustHeal=20,
            GPS=100,
            TIME=60,
        },
        focus={},
        combat = {
            min = 100,
            max = 200,
        },
        ignoreList = {
        }
}

function Guard:new()
        local tab = {}
        tab.combat = {}
        setmetatable(tab.combat, self.combat)
        tab.combat.__index = self.combat
        tab.ignoreList = {}
        setmetatable(tab.ignoreList, self.ignoreList)
        tab.ignoreList.__index = self.ignoreList
        tab.move = {}
        setmetatable(tab.move, self.move)
        tab.move.__index = self.move
        setmetatable (tab, self)
        self.__index = self
        return tab
end

function Guard:check(first)
    if (first) then
        if (self.config.moveType == 2 and self.player and isPlayer(self.player) == TRUE) then
            return false
                end
        end
        if not (self.cid) then
                return false
        end
        if not (self.firstPos) then
                self.firstPos = getThingPos(self.cid)
        end
        if (self:samePos(getThingPos(self.cid), self.firstPos)) then
                self.move.movingBack = false
        end
        if (self.config) then
                for i, v in pairs(Guard.config) do
                        if (tostring(self.config[i]) ~= "nil") then
                                if not (type(v) == type(self.config[i])) then
                                        print("Guard System - Config error:\n Variable ".. i .." is a not correct type.\n It's is setable a defaul value: "..   tostring(Guard.config[i]))
                                        self.config[i] = v
                                end
                        else
                                self.config[i] = v
                        end
                end
        end
        return true
end

function Guard:doMove()
        if (not self.move.moving and self.move.movingBack or self.target and isCreature(self.target) == TRUE and not self.move.moving) then
                if (self.config.changeFloor or self.move.movingBack or getThingPos(self.target).z == getThingPos(self.cid).z) then
                        if (not self.move.movingBack and getThingPos(self.target).z ~= getThingPos(self.cid).z) then
                                doTeleportThing(self.cid, getThingPos(self.config.moveType == 2 and self.player or self.target), TRUE)
                        end
                        if (self.move.movingBack or self.player == self.target and getDistanceBetween(getThingPos(self.cid), getThingPos(self.target)) > 2 or self.target ~= self.player and getDistanceBetween(getThingPos(self.cid), getThingPos(self.target)) > 1) then
                                if (self.move.movingBack and self.config.moveBack and getDistanceBetween(getThingPos(self.cid), self.firstPos) >= 50) then
                                        doTeleportThing(self.cid, self.firstPos)
                                        self.player = nil
                                        self.target = nil
                                        self.move.movingBack = nil
                                        self.move.moving = nil
                                        return false
                                end
                                local q = self:findDir(getThingPos(self.cid), self.move.movingBack == false and getThingPos(self.target) or self.firstPos)
                                local x = 0
                                while (not q and x <= 1) do
                                        q = self:findDir(getThingPos(self.cid), self.move.movingBack == false and getThingPos(self.target) or self.firstPos)
                                        if not (self.player == self.target) then
                                                break
                                        end
                                        x = x+1
                                end
                                if (q) then
                                        self:doMoving(true, q)
                                        for i = 1, #q do
                                                addEvent(eventMove, i*self.config.speed, self,  q[i])
                                        end
                                else
                                        if (self.player and self.player ~= self.target and not self.move.movingBack) then
                                                self.ignoreList[#self.ignoreList+1] = {self.target, os.clock()}
                                                self.target = self.player
                                        elseif (self.player == self.target and not self.move.movingBack) then
                                                doCreatureSay(self.cid, "I'm sorry, but I'm lost", 3)
                                                self.player = nil
                                                self.move.moving = true
                                                addEvent(function (var) var.target, self.move.moving = nil, false end, 3000, self)
                                        elseif (self.move.movingBack) then
                                                doTeleportThing(self.cid, self.firstPos)
                                        end
                                end
                        end
                else
                        doCreatureSay(self.cid, "I'm sorry, but I'm lost", 3)
                        self.player = nil
                        self.target = nil
                end
        elseif (self.target == nil or isCreature(self.target) == FALSE) then
                if (self.config.moveType == 2 and isPlayer(self.player) == TRUE) then
                        self.target = self.player
                elseif (self.config.moveType == 2 and isPlayer(self.player) == FALSE) then
                        self.player = nil
                        self.target = nil
                        if (self.config.changeFloor and self.config.moveBack) then
                                doTeleportThing(self.cid, self.firstPos)
                        elseif (not self.config.changeFloor and self.config.moveBack) then
                                self.move.movingBack = true
                        end
                elseif (self.config.moveType == 1 and self.config.changeFloor and self.config.moveBack) then
                        doTeleportThing(self.cid, self.firstPos)
                elseif (self.config.moveType == 1 and not self.config.changeFloor and self.config.moveBack) then
                        if (not self:samePos(getThingPos(self.cid), self.firstPos) and not self.moving) then
                                self.move.movingBack = true
                                self.target = nil
                        end
                else
                        self.player = nil
                        self.target = nil
                end
        elseif (self.move.moving and self.moveType == 2) then
                if (self:samePos(getThingPos(self.cid), self.move.lastPos or {x=0, y=0})) then
                        if (self.move.lastPos[2] and os.clock()-self.move.lastPos[2] >= 5) then
                                self.move.moving = false
                        else
                                return true
                        end
                else
                        self.move.lastPos = {getThingPos(self.cid), os.clock()}
                end
        end
end


function Guard:doMoving(bool, tab)
        if (bool and tab) then
                self.move.moveTable = tab
                self.move.moving = true
        else
                if (self.move.moveTable and #self.move.moveTable > 0) then
                        table.remove(self.move.moveTable, 1)
                        if (#self.move.moveTable == 0) then
                                self.move.moving = false
                                self.move.moveTable = nil
                                if (self.move.movingBack) then
                                        self.move.movingBack = false
                                end
                        end
                else
                        self.move.moving = false
                        self.move.moveTable = nil
                end
        end
end


function eventMove(var, dir)
        var:doMoving()
        if (isWalkable(getPosByDir(getCreaturePosition(var.cid), dir), true) == true) then
                doMoveCreature(var.cid, dir)
        end
end

function Guard:isNext()
        local dir
        if (self:samePos(getThingPos(self.target), getThingPos(self.cid))) then
                return true
        end
        for dir = 0, 7 do
                local pos = self:getPosByDir(getThingPos(self.cid), dir)
                if (self:samePos(getThingPos(self.target), pos)) then
                        return true
                end
        end
        return false
end

function Guard:doCheckAttack()
        local isIgnore = function(tableIgnore, uid)
                if not (#tableIgnore == 0) then
                        for i, v in pairs(tableIgnore) do
                                if (v[1] == uid) then
                                        return true
                                end
                        end
                end
                return false
        end
        if (self.ignoreList) then
                for i, v in pairs(self.ignoreList) do
                        if (type(v) == "table" and v[2] and os.clock()-v[2] >= 15) then
                                table.remove(self.ignoreList, i)
                        end
                end
        end
        if (self.config.moveType == 2 and isPlayer(self.player) == FALSE) then
                return false
        end
        battlelist = getSpectators(getThingPos(self.config.moveType == 2 and self.player or self.cid), 7, 8, false)
        if (type(battlelist) == "table" and #battlelist > 0) then
                if (self.config.moveType == 2 and isInArray(battlelist, self.player) == FALSE or isInArray(battlelist, self.cid) == FALSE) then
                        self.target = self.player
                        return false
                end
                for i = 1, #battlelist do
                        if (battlelist[i] ~= self.cid and battlelist[i] ~= self.player and not isIgnore(self.ignoreList, battlelist[i])) then
                                if (isMonster(battlelist[i]) == TRUE or isNpc(battlelist[i]) == FALSE and getCreatureSkullType(battlelist[i]) > 1 and isPlayerPzLocked(battlelist[i]) == TRUE) then
                                        if (self.target ~= self.player and isInArray(battlelist, self.target) == TRUE) then
                                                self:doAttack()
                                                break
                                        else
                                                self.target = battlelist[i]
                                                self:doAttack()
                                                break
                                        end
                                end
                        elseif (isIgnore(self.ignoreList, battlelist[i])) then
                                self:doMoving()
                        end
                end
        end
end

function Guard:doAttack()
        if (self:isNext() == true) then
                if not (self.combat.min or self.combat.max) then
                        error("GUARD SYSTEM: Can not found min or max value for attack")
                        return false
                end
                if (self.combat.min > self.combat.max) then
                        error("GUARD SYSTEM: Combat min value is greater of max")
                        return false
                end
                if (self.config.playerExp) then
                        doTargetCombatHealth(self.config.moveType == SELFGUARD and self.player or self.cid, self.target, COMBAT_PHYSICALDAMAGE, -self.combat.min, -self.combat.max, CONST_ME_DRAWBLOOD)
                else
                        doTargetCombatHealth(self.cid, self.target, COMBAT_PHYSICALDAMAGE, -self.combat.min, -self.combat.max, CONST_ME_DRAWBLOOD)
                end
        end
end

function  Guard:cash()
    if self.player then
        if isPlayer(self.player)   then
                        self.last_ =  self.last_ or os.time()
                        if  self.last_ <= os.time() then
                                if  getPlayerMoney(self.player) >= self.config.GPS then
                                        doPlayerRemoveMoney(self.player,self.config.GPS)
                                        doPlayerSendTextMessage(self.player,12,'You paid  '..self.config.GPS..'  now left '..getPlayerMoney(self.player)..',  you can hunt arond   '..((getPlayerMoney(self.player)/self.config.GPS)*self.config.TIME)..'   seconds yet.')
                else
                    selfSay('You  dont  have enghout money, bye!',self.player)
                                        self.player =  nil
                    self.target =  nil
                end
                                self.last_ =  os.time()+self.config.TIME
                        end
        else
                        self.player = nil
            self.target = nil
        end
    end
end
function Guard:runAttack()
    self.config.time = self.config.time or os.clock()
    if self.config.time <= os.clock() then
                self:doCheckAttack()
                self.config.time = os.clock()+self.config.delay_attack
    end
end

-- Mock Lib(Auto Walk)
function Guard:isPos(p1, q)
        for i, p2 in pairs(q) do
                if (p1.x == p2.x and p1.y == p2.y) then
                        return true
                end
        end
end

function Guard:getDir(start, finish, walked)
        local menor = getDistanceBetween(start, finish)+10
        local dir = nil
        for i=0,7 do
                ae = self:getPosByDir(start, i)
                if (isWalkable(ae, TRUE) == TRUE and self:isPos(ae, walked) == nil) then
                        if (getDistanceBetween(ae, finish) < menor) then
                                menor = getDistanceBetween(ae, finish)
                                dir = i
                        end
                end
        end
        return dir
end

function Guard:findDir(start, finish)
        local q = 0
    local walked = {}
        local go = {}
        local distance = getDistanceBetween(start, finish)
        local moves = self.move.movingBack and getDistanceBetween(start, finish) + 1 or getDistanceBetween(start, finish)
        while (moves > 1) do
                table.insert(walked, 1, start)
                local dir = self:getDir(start, finish, walked)
                if (not dir or q >= 25+distance) then
                        return false
                end
                start = self:getPosByDir(start, dir)
                if (self:samePos(start, finish) == true and not self.move.movingBack) then
                        break
                end
                table.insert(go, dir)
                q = q+1
                moves = getDistanceBetween(start, finish)
        end
        return go
end

function Guard:getPosByDir(position, direction, size)
        local n = size or 1
        local pos = position
        if(direction == NORTH) then
                return {x=pos.x, y=pos.y-1, z=pos.z}
        elseif(direction == SOUTH) then
                return {x=pos.x, y=pos.y+1, z=pos.z}
        elseif(direction == WEST) then
                return {x=pos.x-1, y=pos.y, z=pos.z}
        elseif(direction == EAST) then
                return {x=pos.x+1, y=pos.y, z=pos.z}
        elseif(direction == NORTHWEST) then
                return {x=pos.x-1, y=pos.y-1, z=pos.z}
        elseif(direction == SOUTHWEST) then
                return {x=pos.x-1, y=pos.y+1, z=pos.z}
        elseif(direction == NORTHEAST) then
                return {x=pos.x+1, y=pos.y-1, z=pos.z}
        elseif(direction == SOUTHEAST) then
                return {x=pos.x+1, y=pos.y+1, z=pos.z}
        end
end

function Guard:samePos(p1,p2)
        if (p1.x == p2.x and p1.y == p2.y) then
                return true
        end
end

function isWalkable(pos, creature, proj, pz)-- by Nord
        if hasSqm(pos) == false then return false end
        if isCreature(getThingFromPos({x=pos.x,y=pos.y,z=pos.  z,stackpos=255}).uid) and creature then return false end
        if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
        if getTileInfo(pos).protection and pz then return false, true end
        local n = not proj and 3 or 2
        for i = 0, 255 do
                pos.stackpos = i
                local tile = getTileThingByPos(pos)
                if tile.itemid == 459 then
                        return true
                end
                if tile.itemid ~= 0 and not isCreature(tile.uid) then
                        if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
                                return false
                        end
                end
        end
        return true
end

function hasSqm(pos)-- by Mock
    return getTileThingByPos({x=pos.x,y=pos.y,z=pos.z,stackpos=0}).itemid ~= 0
end