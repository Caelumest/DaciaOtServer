dofile('data/npc/scripts/guard lib.lua')
local guarda = Guard:new()
guarda.config = {
        moveType=SELFGUARD,
        speed = 800,
        changeFloor = false,
        playerExp = false,
        delay_attack=1,
        exaustHeal=20,
        --- Payment
        GPS=100, --- Pagar 100 GPS a X de tempo
        TIME=60, --- Pagar a quantia acima a cada X segundos, no caso 60
}
guarda.focus={}

guarda.combat = {
    min = 40,
    max = 120
}


function onCreatureAppear(cid)
  guarda.cid = getNpcId()
end

function onCreatureDisappear(cid)
end

function onCreatureSay(cid, tsype, msg)
        msg = msg:lower()
        if msg == 'hi' and isInArray(guarda.focus,cid) == false and getDistanceBetween(getThingPos(cid), getThingPos(getNpcCid())) <= 5 then
            table.insert(guarda.focus,1,cid)
            selfSay("Hello '..getCreatureName(cid)..'!",cid)
        end
        if isInArray(guarda.focus,cid) and getDistanceBetween(getThingPos(cid), getThingPos(getNpcCid())) <= 5  then
            if msg:find('help') then
                if (guarda:check(true)) then
                    if (guarda.config.moveType == SELFGUARD) then
                            selfSay('It will cost '..guarda.config.GPS..' each '..guarda.config.TIME..' seconds.',cid)
                            selfSay('I will help you '..getCreatureName(cid)..'!',cid)
                            guarda.cid = getNpcId()
                            guarda.player = cid
                            guarda.target = cid
                    else
                        selfSay('Sorry but i cant help.',cid)
                    end
                else
                    if guarda.player == cid then
                        selfSay('I am helping you.',cid)
                    else
                        selfSay('Sorry i am busy.',cid)
                    end
                end
            elseif msg:find('heal') then
                local percent = (getCreatureHealth(cid)/getCreatureMaxHealth(cid))*100
                if percent <= 15 then
                    if getPlayerStorageValue(cid,15001) >= os.time() then
                        if not isPlayerPzLocked(cid) then
                            doCreatureAddHealth(cid,(getCreatureMaxHealth(cid)  *(percent-15))/100)
                            setPlayerStorageValue(cid,15001,os.time()+ guarda['config']['exaustHeal'] )
                            selfSay('Oh my god! you are verry bad! i can heal you now.',cid)
                        else
                            selfSay('I cant heal you now.',cid)
                        end
                    else
                        selfSay('I am retired, i cant heal you now.',cid)
                    end
                else
                    selfSay('You aren\'t too bad.',cid)
                end
            elseif msg:find('leave') then
                if not (guarda:check(true)) then
                    if (guarda.config.moveType == SELFGUARD) then
                        if guarda.player == cid then
                            guarda.player = nil
                            guarda.target = nil
                            selfSay('Okay, i will stay here.',cid)
                        end
                    end
                end
            elseif msg:find('job') then
                selfSay('I am guard i can help you for '..guarda.config.GPS..' each '..guarda.config.TIME..' seconds.',cid)
            elseif msg == 'bye' then
                for i,b in pairs(guarda.focus) do
                    if b == cid then
                        table.remove(guarda.focus,i)
                    end
                end
                if guarda.player and guarda.player == cid then
                    guarda.player = nil
                    guarda.target = nil
                end
                selfSay('Okay, bye',cid)
            end
        end
end

function onPlayerCloseChannel(cid)
end

function onPlayerEndTrade(cid)
end




function onThink()
    guarda:cash()
    if (guarda:check()) then
        guarda:runAttack()
        guarda:doMove() -- A ordem dos fatores altera o resultado
    end
    for i,b in pairs(guarda.focus) do
        if not isPlayer(b) then
            table.remove(guarda.focus,i)
        elseif getDistanceBetween(getThingPos(b), getThingPos(getNpcCid())) > 5 and guarda.player ~= b then
            table.remove(guarda.focus,i)
            selfSay('Then bye...',b)
        end
    end
end