function onThink(interval, lastExecution)
  -- Configurações
    local cor = 22 -- Defina a cor da mensagem (22 = branco)
    local mensagens ={
[[Baiak Yurots Information: 
Para Saber Hightscore Digite !rank,!rank magic...

Novo Comando Adicionado !notice


BOM JOGO A TODOS QUE JOGAM NO BAIAK YUROTS!!!

BY:Baiak
]]
}

  -- Fim de Configurações

  doBroadcastMessage(mensagens[math.random(1,table.maxn(mensagens))], cor)
return TRUE
end