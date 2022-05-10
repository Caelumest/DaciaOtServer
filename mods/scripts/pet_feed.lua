-- Advanced Pet System By Races
--       scripted by josejunior
--    otland.net / otserv.com.br
--	 especial thanks to TFS!
function onAddItem(moveitem, tileitem, position, cid)
	if(isCreature(getPlayerPet(cid)) == true) then
		local pet = getCreaturePosition(getPlayerPet(cid))
		if(position.x == pet.x) and (position.y == pet.y) then
			if(isFood(moveitem.itemid) == true) then
				if(getPlayerStorageValue(cid, aps_storages.exhaustion.exh_food) < os.time()) then	
					doPetFeed(cid, moveitem.itemid)
					doRemoveItem(moveitem.uid, 1)
					if(math.random(1, 2) == math.random(1, 2)) then
						setPetStatus(cid, 1)
					end	
					doCreatureSay(getPlayerPet(cid), getRamdomThing(aps_texts.food_voices) .. " " .. string.upper(getItemNameById(moveitem.itemid)) .. "...", TALKTYPE_ORANGE_1)					
				end
			elseif(isPotion(moveitem.itemid) == true) then
				local potion = aps_potions[getItemNameById(moveitem.itemid)]
				if(potion.hpAmmount) then
					doCreatureAddHealth(getPlayerPet(cid), potion.hpAmmount)
				end
				if(potion.manaAmmount) then
					addPetMana(cid, potion.manaAmmount)
					if(potion.manaAmmount) > getPetMaxMana(cid) - getPetMana(cid) then
						setPlayerStorageValue(cid, aps_storages.mana, getPetMaxMana(cid))
					end	
				end
				if(potion.text) then
					doCreatureSay(getPlayerPet(cid), potion.text, TALKTYPE_ORANGE_1)
					doSendMagicEffect(getCreaturePosition(getPlayerPet(cid)), CONST_ME_MAGIC_BLUE)
				end
				doRemoveItem(moveitem.uid, 1)
			end	
		end
	end	
	return true
end