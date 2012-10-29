-- Druidsystem: potion

require("base.common")
require("alchemy.base.alchemy")
require("base.character")

module("alchemy.item.id_166_pink_bottle", package.seeall)

-- UPDATE common SET com_script='alchemy.item.id_166_pink_bottle' WHERE com_itemid = 166;

bottomBorder = 2;
topBorder = {7000       ,7000  ,50000      ,10000        ,7000         ,7000    ,50000        ,10000}
attribList ={"hitpoints","mana","foodlevel","poisonvalue","hitpointsOT","manaOT","foodlevelOT","poisonvalueOT"}

function DrinkPotion(User,SourceItem)
    local potionEffectId = tonumber(SourceItem:getData("potionEffectId"))
	
	if potionEffectId == 0 or potionEffectId == nil  then -- no effect	
	    base.common.InformNLS(User, "Du hast nicht das Gef�hl, dass etwas passiert.", 
		"You don't have the feeling that something happens.")
	    return
	
	elseif potionEffectId >= 11111111 then -- it's an attribute changer  
	    
		-- there is already an effect; sadly,therefore, the current potion will have no effect
		foundEffect, myEffect = User.effects:find(166)
		if foundEffect then
			base.common.InformNLS(User, "Du hast nicht das Gef�hl, dass etwas passiert. Scheinbar verhindert der bereits wirkende Heiltranktrank weitere Effekte.", 
			"You don't have the feeling that something happens. It seems that the already affecting healing potion prevents other effects.")
			return
	    end
	
	    local dataZList = druid.base.alchemy.SplitBottleData(User,potionEffectId);
	    -- taste and effect message
	    druid.base.alchemy.generateTasteMessage(User,dataZList)
		GenerateEffectMessage(User,dataZList)
		for i=1,8 do
			-- effects
			if (i == 3) or (i == 6) then  -- poison
				CalculationStep = ((10-dataZList[i])-5) -- we need a slightly different calculation for poison
			else
				CalculationStep = (dataZList[i]-5) -- for everything else
			end
			
			local Val = CalculationStep * (topBorder[i]/5) * base.common.Scale( 0.5, 1, math.floor(SourceItem.quality/100) * 11 );
			
			-- over time effect values
			if ( attribList[i] == "hitpointsOT" ) then
				hitpointsOT = (Val * 1.25) / 5;
			elseif ( attribList[i] == "poisonvalueOT" ) then
				   poisonvalueOT = (Val * 1.25) / 5;
			elseif ( attribList[i] == "manaOT" ) then
				   manaOT = (Val * 1.25) / 5;
			elseif ( attribList[i] == "foodlevelOT" ) then     			
				   foodlevelOT = (Val * 1.25) / 5;
			-- instatnt poison value cannot be < 0
			elseif ( attribList[i] == "poisonvalue" ) then
				Val = base.common.Limit( (User:getPoisonValue() + Val) , 0, 10000 ); 
				User:setPoisonValue( Val );
			-- instant foodlevel; you cannot overeat on food potion
			elseif ( attribList[i] == "foodlevel" ) then
				Val = base.common.Limit( (User:increaseAttrib("foodlevel",0) + Val) , 0 , 60000 );
			else
				User:increaseAttrib(attribList[i],Val);
			end
	    end
	    -- LTE
		myEffect=LongTimeEffect(166,70);
		-- now we add the values
	   myEffect:addValue("hitpointsIncrease",hitpointsOT)
	   myEffect:addValue("manaIncrease",manaOT)
	   myEffect:addValue("foodlevelIncrease",foodlevelOT)
	   myEffect:addValue("poisonvalueIncrease",poisonvalueOT)
	   myEffect:addValue("counterPink",5)	   
	   User.effects:addEffect(myEffect)
	else
	    --whatever
	end	
end

function GenerateEffectMessage(User,dataZList)
    local effectMessageDE = ""
	local effectMessageEN = ""
	local anyEffect = false
	
	ListPositiveEffectDE = {"Deine Lebenskraft nimmt sofort zu."   ,"Dein Mana nimmt sofort zu."   ,"Du f�hlst dich sofort satter."      ,"Das Gift in dir wird geschw�cht."       ,"Deine Lebenskraft nimmt mit der Zeit zu.","Dein Mana nimmt mit der Zeit zu.","Mit der Zeit nimmt dein Hunger ab.","Das Gift in dir wird mit der Zeit schw�cher."}
	ListNegativeEffectDE = {"Deine Lebenskraft nimmt sofort ab."   ,"Dein Mana nimmt sofort ab."   ,"Du f�hlst dich pl�tlzich hungriger.","Gift breitet sich in dir aus."          ,"Deine Lebenskraft nimmt mit der Zeit ab.","Dein Mana nimmt mit der Zeit ab.","Mit der Zeit nimmt dein Hunger zu.","Mit der Zeit breitet sich ein st�rker werdendes Gift aus."}
	ListPositiveEffectEN = {"Your life energy increases instantly.","Your mana increases instanly.","You feel instantly more sated."     ,"The poison in you is instalny weakened.","Your life energy increases with time."   ,"Your mana increases with time."  ,"Your hunger decreases with time."  ,"The poison is weakend with time."}
	ListNegativeEffectEN = {"Your life energy decreases instantly.","Your mana decreases instanly.","You feel instantly more hungry."    ,"You are poisoned."                      ,"Your life energy decreases with time."   ,"Your mana decreases with time."  ,"Your hunger increases with time."  ,"A with time stronger getting poison spreads in your body."}
	
	for i=1,8 do
		if (dataZList[i] > 5) then
		   effectMessageDE = effectMessageDE.." "..ListPositiveEffectDE[i]
		   effectMessageEN = effectMessageEN.." "..ListPositiveEffectEN[i]
	       anyEffect = true
	   elseif (dataZList[i] < 5) then
			effectMessageDE = effectMessageDE.." "..ListNegativeEffectDE[i]
			effectMessageEN = effectMessageEN.." "..ListNegativeEffectEN[i]
	        anyEffect = true
	   end
	end
	if anyEffect == false then
	    effectMessageDE = "Du sp�hrst keine Wirkung."
		effectMessageEN = "You don't feel any effect."
	end
	base.common.InformNLS(User,effectMessageDE,effectMessageEN);
end

function UseItem(User,SourceItem,TargetItem,Counter,Param,ltstate)
 
	if not ((SourceItem:getData("potionEffectId")~="") or (SourceItem:getData("essenceBrew") =="true")) then
		return -- no potion, no essencebrew, something else
	end
	
	if base.common.GetFrontItemID(User) == 1008 then -- infront of a cauldron?
	   local cauldron = base.common.GetFrontItem( User );
	
	   -- is the char an alchemist?
	    if User:getMagicType() ~= 3 then
		  User:talkLanguage(Character.say, Player.german, "nur alchemisten");
          base.common.InformNLS( User,
				"Nur jene, die in die Kunst der Alchemie eingef�hrt worden sind, k�nnen hier ihr Werk vollrichten.",
				"Only those who have been introduced to the art of alchemy are able to work here.")
		  return;
	    end
	   
	   if ( ltstate == Action.abort ) then
	        base.common.InformNLS(User, "Du brichst deine Arbeit ab.", "You abort your work.")
	       return
		end
		
		if ( ltstate == Action.none ) then
            if (SourceItem:getData("essenceBrew") =="true") and (cauldron:getData("stockData") ~= "") then
		        actionDuration = 40 -- when we combine a stock and an essence brew, it takes longer
            else
                actionDuration = 20
            end				
			User:startAction( actionDuration, 21, 5, 10, 45)
			return
		end	
		
	   if (SourceItem:getData("essenceBrew") =="true") then -- essence brew should be filled into the cauldron
			-- water, essence brew or potion is in the cauldron; leads to a failure
			if cauldron:getData("cauldronFilledWith") == "water" then
			    world:gfx(1,cauldron.pos)
		        base.common.InformNLS(User, "Du Inhalt des Kessels verpufft, als Du das Gebr�u hinzu tust.", 
		                                    "The substance in the cauldron blows out, as you fill the mixture in.")
			    cauldron:setData("cauldronFilledWith","")
			
			elseif cauldron:getData("cauldronFilledWith") == "essenceBrew" then 
			     druid.base.alchemy.CauldronExplosion(User,cauldron,{4,44})
			
			elseif cauldron:getData("potionEffectId") ~= "" then
			     if cauldron:getData("potionId") == "165" then -- support potion
			        druid.item.id_165_blue_bottle.SupportEssencebrew(User,cauldron,SourceItem)
			     else
				    druid.base.alchemy.CauldronExplosion(User,cauldron,{4,45})
			     end
			
			elseif cauldron:getData("stockData") ~= "" then -- stock is in the cauldron; we call the combin function
				druid.base.alchemy.CombineStockEssence( User, SourceItem, cauldron, Counter, Param, ltstate )
				
			else -- nothing in the cauldron, we just fill in the essence brew
				cauldron:setData("cauldronFilledWith","essenceBrew")
				cauldron:setData("potionId",""..SourceItem.id)
				cauldron:setData("essenceHerbs",SourceItem:getData("essenceHerbs"))
			end
		
		    SourceItem:setData("essenceBrew","")
			SourceItem:setData("potionId","")
			SourceItem:setData("essenceHerbs")orld:changeItem(SourceItem)
			
		elseif (SourceItem:getData("potionEffectId")~="") then -- potion should be filled into the cauldron
		    -- water, essence brew, potion or stock is in the cauldron; leads to a failure
			if cauldron:getData("cauldronFilledWith") == "water" then
			    world:gfx(1,cauldron.pos)
		        base.common.InformNLS(User, "Du Inhalt des Kessels verpufft, als Du das Wasser hinzu tust.", 
		                            "The substance in the cauldron blows out, as you fill the water in.")
			    cauldron:setData("cauldronFilledWith","")
			
			elseif cauldron:getData("cauldronFilledWith") == "essenceBrew" then 
			    druid.base.alchemy.CauldronExplosion(User,cauldron,{4,45})
			
			elseif cauldron:getData("potionEffectId") ~= "" then
			    if cauldron:getData("potionId") == "165" then -- support potion
			        druid.item.id_165_blue_bottle.SupportPotion(User,cauldron,SourceItem)
			    else
				    druid.base.alchemy.CauldronExplosion(User,cauldron,{4,38})
			    end
				
			elseif cauldron:getData("stockData") ~= "" then
				druid.base.alchemy.CauldronExplosion(User,cauldron,{4,36})
			
			else -- nothing in the cauldron, we just fill in the potion
                cauldron:setData("potionEffectId",SourceItem:getData("potionEffectId"))
                cauldron:setData("potionId",""..SourceItem.id)
				cauldron:setData("potionQuality",""..SourceItem.quality)
			end
                
            SourceItem:setData("potionEffectId","")
			SourceItem:setData("potionId","")				
			SourceItem:setData("potionQuality","")
		end
	    if math.random(1,20) == 1 then
		    world:erase(SourceItem,1)	 -- bottle breaks
		    base.common.InformNLS(User, "Die Flasche zerbricht.", "The bottle breaks.")
        else	
		    SourceItem.id = 164
			SourceItem.quality = 333
			world:changeItem(SourceItem)
        end
		world:changeItem(cauldron)		
			
    else -- not infront of a cauldron, therefore drink!
        if User.attackmode then
		   base.common.InformNLS(User, "Du kannst das Gebr�u nicht nutzen, w�hrend Du k�mpfst.", "You cannot use the potion while fighting.")
		else
			User:talkLanguage(Character.say, Player.german, "#me trinkt eine rote Fl�ssigkeit.");
			User:talkLanguage(Character.say, Player.english, "#me drinks a red liquid.");
			SourceItem.id = 164
			SourceItem.quality = 333
			if math.random(1,20) == 1 then
			   world:erase(SourceItem,1) -- bottle breaks
			   base.common.InformNLS(User, "Die Flasche zerbricht.", "The bottle breaks.", Player.lowPriority)
			else	
				world:changeItem(SourceItem)
			end
			User.movepoints=User.movepoints - 20
			DrinkPotion(User,SourceItem)
	    end
	end  
end

function LookAtItem(User,Item)
    world:itemInform(User, Item, base.lookat.GenerateLookAt(User, Item, 0))
end   