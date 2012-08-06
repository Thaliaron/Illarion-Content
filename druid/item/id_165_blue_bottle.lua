--I_165_blaue_flasche
-- new effects for reworked alchemy system
-- support potions: the effect other potions (stocks or essencebrews) or the effect of potion
-- e.g. change a potion's quality, remove cooldown of  potion

require("base.common")
require("druid.base.alchemy")

module("druid.item.id_165_blue_bottle", package.seeall)

-- UPDATE common SET com_script='druid.item.id_165_blue_bottle' WHERE com_itemid = 165;

function DrinkPotion(User,SourceItem)
    -- no effecs yet
	 base.common.InformNLS(User, "Du hast nicht das Gef�hl, dass etwas passiert.", 
		"You don't have the feeling that something happens.")
end

function UseItem(User,SourceItem,TargetItem,Counter,Param)
	potionEffectId = tonumber(SourceItem:getData("potionEffectId"))
	if potionEffectId == nil then
	    potionEffectId = 0
	end	
	
	if base.common.GetFrontItemID(User) == 1008 then -- infront of a cauldron?
	   local cauldron = base.common.GetFrontItem( User )
	
	   -- is the char an alchemist?
	    if User:getMagicType() ~= 3 then
		  User:talkLanguage(Character.say, Player.german, "nur alchemisten")
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
			    world:gfx(1)
		        base.common.InformNLS(User, "Du Inhalt des Kessels verpufft, als Du das Gebr�u hinzu tust.", 
		                                    "The substance in the cauldron blows out, as you fill the mixture in.")
			    cauldron:setData("cauldronFilledWith","")
			
			elseif cauldron:getData("cauldronFilledWith") == "essenceBrew" then 
			     druid.base.alchemy.CauldronExplosion(User,cauldron,{4,44})
			
			elseif cauldron:getData("potionEffectId") ~= "" then
			     druid.base.alchemy.CauldronExplosion(User,cauldron,{4,45})
			
			elseif cauldron:getData("stockData") ~= "" then -- stock is in the cauldron; we call the combin function
				druid.base.alchemy.CombineStockEssence( User, SourceItem, cauldron)
				
			else -- nothing in the cauldron, we just fill in the essence brew
				cauldron:setData("cauldronFilledWith","essenceBrew")
				cauldron:setData("potionId",""..SourceItem.id)
				cauldron:setData("essenceHerbs",SourceItem:getData("essenceHerbs"))
			end
		
		    SourceItem:setData("essenceBrew","")
			SourceItem:setData("potionId","")
			SourceItem:setData("essenceHerbs")
	
	    elseif (SourceItem:getData("potionEffectId")~="") then -- potion should be filled into the cauldron
		    -- water leads to a failure
			if cauldron:getData("cauldronFilledWith") == "water" then
			    world:gfx(1)
		    
			elseif cauldron:getData("cauldronFilledWith") == "essenceBrew" then 
			    SupportEssencebrew(User,SourceItem,cauldron)
			
			elseif cauldron:getData("potionEffectId") ~= "" then
			    SupportPotion(User,SourceItem,cauldron)
			
			elseif cauldron:getData("stockData") ~= "" then
				SupportStock(User,SourceItem,cauldron)
			
			else -- nothing in the cauldron, we just fill in the potion
                cauldron:setData("potionEffectId",SourceItem:getData("potionEffectId"))
                cauldron:setData("potionId",""..SourceItem.id)
				cauldron:setData("potionQuality",""..SourceItem.quality)
			end
                
            SourceItem:setData("potionEffectId","")
			SourceItem:setData("potionId","")				
			SourceItem:setData("potionQuality","")
	    else
            -- neither essence brew nor a potion; placeholder 
	    end
		if math.random(1,20) == 1 then
		    world:erase(SourceItem,1)	 -- bottle breaks
		    User:talkLanguage(Character.say, Player.german, "flasche kaputt");
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
			User:talkLanguage(Character.say, Player.german, "#me trinkt eine hellblaue Fl�ssigkeit.");
			User:talkLanguage(Character.say, Player.english, "#me drinks a light blue liquid.");
			SourceItem.id = 164
			SourceItem.quality = 333
			if math.random(1,20) == 1 then
			   world:erase(SourceItem,1) -- bottle breaks
			   base.common.InformNLS(User, "Die Flasche zerbricht.", "The bottle breaks.")
			else	
				world:changeItem(SourceItem)
			end
			User.movepoints=User.movepoints - 20
			DrinkPotion(User,SourceItem)
	    end
	end  
end

function SupportStock(User,support,stock)
    if potion.id == 1008 then -- in case the potion is in a cauldron and the support in a bottle
	    targetPotionId = tonumber(potion:getData("potionId"))
		targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
	    targetPotionQuality = tonumber(potion:getData("potionQuality"))
	
	    supportQuality = support.quality
    else -- support in cauldron, potion in bottle
	    targetPotionId = potion.id
	    targetPotionQuality = potion.quality
		targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
		
		supportQuality = support:getData("potionQuality")
	end
	targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
	supportPotionEffectId = tonumber(support:getData("potionEffectId"))	
	
	if targetPotionEffectId == nil then
	   targetPotionEffectId = 0
	elseif supportPotionEffectId == nil then
	    supportPotionEffectId = 0 
	end	
	
	cauldron = base.common.GetFrontItem( User )
	
	-- no effects yet
    cauldron:setData("potionId",targetPotionId)
	cauldron:setData("potionEffectId",targetPotionEffectId)
    world:changeItem(cauldron)
end

function SupportEssencebrew(User,support,essencebrew)
    if potion.id == 1008 then -- in case the potion is in a cauldron and the support in a bottle
	    targetPotionId = tonumber(potion:getData("potionId"))
		targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
	    targetPotionQuality = tonumber(potion:getData("potionQuality"))
	
	    supportQuality = support.quality
    else -- support in cauldron, potion in bottle
	    targetPotionId = potion.id
	    targetPotionQuality = potion.quality
		targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
		
		supportQuality = support:getData("potionQuality")
	end
	targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
	supportPotionEffectId = tonumber(support:getData("potionEffectId"))	
	
	if targetPotionEffectId == nil then
	   targetPotionEffectId = 0
	elseif supportPotionEffectId == nil then
	    supportPotionEffectId = 0 
	end	
	
	cauldron = base.common.GetFrontItem( User )
	
	-- no effects yet
	cauldron:setData("potionId",targetPotionId)
	cauldron:setData("potionEffectId",targetPotionEffectId)
    world:changeItem(cauldron)
	
end

function SupportPotion(User,support,potion)
    if potion.id == 1008 then -- in case the potion is in a cauldron and the support in a bottle
	    targetPotionId = tonumber(potion:getData("potionId"))
		targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
	    targetPotionQuality = tonumber(potion:getData("potionQuality"))
	
	    supportQuality = support.quality
    else -- support in cauldron, potion in bottle
	    targetPotionId = potion.id
	    targetPotionQuality = potion.quality
		targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
		
		supportQuality = support:getData("potionQuality")
	end
	targetPotionEffectId = tonumber(potion:getData("potionEffectId"))
	supportPotionEffectId = tonumber(support:getData("potionEffectId"))	
	
	if targetPotionEffectId == nil then
	   targetPotionEffectId = 0
	elseif supportPotionEffectId == nil then
	    supportPotionEffectId = 0 
	end	
	
	cauldron = base.common.GetFrontItem( User )
	
	if (supportPotionEffectId > 0) and (supportPotionEffectId <= 7) then -- quality raiser
	    PotionList = {59,165,166,327,328,329,330} -- potion ids
	
	    if targetPotionId == PotionList[supportPotionEffectId] then -- support and potion belong together
		
		    local chance = (math.floor(supportQuality/100))*9  -- support quality * 9 = chance that potion's quality is increased
		    if base.common.Chance(chance, 100)==true then 
			    local newQuali = Limit(targetPotionQuality+100, 100, 999)
			    cauldron:setData("potionQuality",newQuali)
		        world:gfx(53,cauldron.pos)
			else -- no success, quality stays the same
		        cauldron:setData("potionQuality",targetPotionQuality)
                world:gfx(1,cauldron.pos)
			end
		
		else 
	        world:gfx(1,cauldron.pos)
	    end

	else
	    world:gfx(1,cauldron.pos)
	end	

	cauldron:setData("potionId",targetPotionId)
	cauldron:setData("potionEffectId",targetPotionEffectId)
    world:changeItem(cauldron)
end

function LookAtItem(User,Item)
  
  if (Character:getPlayerLanguage()==0) then
	world:itemInform(Character,Item,"Du siehst ein Flaschenetikett mit der Aufschrift: \"Wunderpaste\"")
  else
	world:itemInform(Character,Item,"You look at a sticker telling: \"Marvel Paste\"")      
  end
  
end
