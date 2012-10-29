-- ds_base_alchemy.lua

require("base.common");
module("alchemy.base.alchemy", package.seeall)

function InitAlchemy()
    InitPlants()
	InitPotions()
end

-- the list of plants with their substances
plantSubstanceList = {};

function InitPlantSubstance()
    setPlant(133, "Adrazin", "Orcanol") -- sunherb / Sonnenkraut
    setPlant(758, "Adrzain", "") -- heart blood / Herzblut
end;

function setPlantSubstance(id, plusSubstance, minusSubstance)
    plantList[id] = {plusSubstance, minusStubstance}
end

function getPlantSubstance(id)
    if not plantList[id] then
	    return false
	end	
	local plus; local minus
	if plantList[id][1] == nil then
	    plus = ""
	elseif plantList[id][2] == nil then
	    minus = ""
	else
        plus = plantList[id][1]
		minus = plantList[id][2]
    end     	
	return plus, minus    
end


-- the list of possible potions effects
potionsList = {};

-- on reload, this function is called
-- setPotion(effect id, stock data, gemdust ,Herb1, Herb2, Herb3, Herb4, Herb5, Herb6, Herb7, Herb8)
-- every effect id is only used once!
-- stock data is the concentration of the active substances put together in the following order: Adrazin, Illidrium, Caprazin, Hyperborelium, Echolon, Dracolin, Orcanol, Fenolin 
-- gemdust is the id of the gemdust used
-- Herb1...Herb8 are optional. If you use only x Herbs and x < 8 just leave the others out
-- Example: setPotion(15, 95554553, 133, 15, 81)
-- document properly, please
function InitPotions()
    setPotion(45, 55555555, 450, 775, 3443, 33);
end;

--- Set the effect of a potion
-- @param resultingEffect the resulting effect of the potion
-- @param ... the components effecting the potion one by one
function setPotion(resultingEffect, ...)
	local currentList = potionsList;
	for i, v in ipairs(arg) do
		if (currentList[v] == nil) then
			currentList[v] = {};
		end;
		currentList = currentList[v];
	end;
	currentList[0] = resultingEffect;
end;

--- Get the effect of a potion
-- @param ... the components effecting the potion one by one
-- @return the resulting effect of the potion
function getPotion(...)
	local currentList = potionsList;
	for i, v in ipairs(arg) do
			if (currentList[v] == nil) then
					return 0;
			end;
			currentList = currentList[v];
	end;
   
	if (currentList[0] == nil) then
			return 0;
	end;
	return currentList[0];
end;


--Qualit�tsbezeichnungen
qListDe={"f�rchterliche","schlechte","schwache","leicht schwache","durchschnittliche","gute","sehr gute","gro�artige","hervorragende"};
qListEn={"awful","bad","weak","slightly weak","average","good","very good","great","outstanding"};

--                stock,bluestone,ruby,emerald,blackstone,amethyst,topaz,diamant
gemList        = {"non",446      ,447 ,448    ,449       ,450     ,451  ,452}
cauldronPotion = {1012 ,1011     ,1016,1013   ,1009      ,1015    ,1018 ,1017} 
bottlePotion   = {331  ,327      ,59  ,165    ,329       ,166     ,167  ,330}

-- Liste der Wirkstoffnamen
wirkstoff = {};
wirkung_de = {};
wirkung_en = {};

wirkstoff[1] = "Adrazin";
wirkstoff[2] = "Illidrium";
wirkstoff[3] = "Caprazin";
wirkstoff[4] = "Hyperborlium";
wirkstoff[5] = "Echolon";
wirkstoff[6] = "Dracolin";
wirkstoff[7] = "Orcanol";
wirkstoff[8] = "Fenolin";

wirkung_de[1] = "ges�ttigte Anreicherung von";
wirkung_de[2] = "eine sehr ausgepr�gte Menge";
wirkung_de[3] = "merklich";
wirkung_de[4] = "schwache Konzentration an";
wirkung_de[5] = "kein";
wirkung_de[6] = "geringe Mengen";
wirkung_de[7] = "etwas";
wirkung_de[8] = "konzentriertes";
wirkung_de[9] = "hoch toxisches";

wirkung_en[1] = "highly toxic";
wirkung_en[2] = "dominant marked";
wirkung_en[3] = "distinctive";
wirkung_en[4] = "slightly marked";
wirkung_en[5] = "no";
wirkung_en[6] = "slightly pronounced";
wirkung_en[7] = "enriched";
wirkung_en[8] = "dominant pronounced";
wirkung_en[9] = "highly noxious";

-- Liste der Krankheiten

illness = {};

illness[1] = {};
illness[2] = {};
-- deutsche Bezeichnugnen                -- englische Bezeichnungen

illness[1][1] = "Ork-Fieber";            illness[2][1] = "orc-fever";
illness[1][2] = "Sumpfkrampf";           illness[2][2] = "bog-attack";
illness[1][3] = "Trollsucht";            illness[2][3] = "Troll's rash";
illness[1][4] = "Gnom-Wahn";             illness[2][4] = "gnome-paranoia";
illness[1][5] = "Vein'sches Syndrom";    illness[2][5] = "Veins'syndrome";
illness[1][6] = "Drachenpocken";         illness[2][6] = "dragon's pox";
illness[1][7] = "Skorpion-Seuche";       illness[2][7] = "scorpion's pestilence";
illness[1][8] = "Wolfspest";             illness[2][8] = "wolves pest";

-- illness seriousness: 1-8
illness_seriousness = {};

illness_seriousness[1] = 1;
illness_seriousness[2] = 2;
illness_seriousness[3] = 3;
illness_seriousness[4] = 4;
illness_seriousness[5] = 5;
illness_seriousness[6] = 6;
illness_seriousness[7] = 7;
illness_seriousness[8] = 8;

--Wirkungen auf Attribute
--Reihe 1
attr_r1 = {};                   untererGrenzwert = {};      obererGrenzwert = {};
attr_r1[1] ="hitpoints";        untererGrenzwert[1] = 0;    obererGrenzwert[1] = 10000;
attr_r1[2] ="body_height";      untererGrenzwert[2] = 35;   obererGrenzwert[2] = 84;
attr_r1[3] ="foodlevel";        untererGrenzwert[3] = 0;    obererGrenzwert[3] = 50000;
attr_r1[4] ="luck"       ;      untererGrenzwert[4] = 0;    obererGrenzwert[4] = 100;
attr_r1[5] ="attitude";         untererGrenzwert[5] = 0;    obererGrenzwert[5] = 100;
attr_r1[6] ="poisonvalue";      untererGrenzwert[6] = 0;    obererGrenzwert[6] = 10000;
attr_r1[7] ="mental capacity";  untererGrenzwert[7] = 0;    obererGrenzwert[7] = 2400;
attr_r1[8] ="mana";             untererGrenzwert[8] = 0;    obererGrenzwert[8] = 10000;
--Reihe 2
attr_r2 = {};
attr_r2[1] ="strength";
attr_r2[2] ="perception";
attr_r2[3] ="dexterity";
attr_r2[4] ="intelligence";
attr_r2[5] ="essence";
attr_r2[6] ="willpower";
attr_r2[7] ="constitution";
attr_r2[8] ="agility";

taste = {};
taste[0]   ={"fruchtig","herb"     ,"bitter"    ,"faulig"      ,"sauer"       ,"salzig" ,"scharf"   ,"s��"};
taste[1]   ={"fruity"  ,"tartly"   ,"bitter"    ,"putrefactive","sour"        ,"salty"  ,"hot"      ,"sweet"};

-- -------------------------------------------------------------------------------
function CheckAttrRow(User,dataZList)

   retVal = true
   if dataZList[9] == 0 then
      -- Attributsreihe 1 soll angewandt werden
   else
      -- Attributsreihe 2 soll angewandt werden
      retVal = false
   end
   return retVal
end
-- -------------------------------------------------------------------------------
function ImpactRow1(User,dataZList)
   --User:inform("debug 12")

  for i=1,8 do

    if dataZList[i] < 4 then

        User:inform(dataZList[i].." Vor-Wirkung R1 : "..attr_r1[i].." : "..User:increaseAttrib(attr_r1[i],0 ))
        User:setAttrib(attr_r1[i],(User:increaseAttrib(attr_r1[i],0)*(dataZList[i]*30/100)))
        User:inform("Nach-Wirkung R1: "..attr_r1[i].." : "..User:increaseAttrib(attr_r1[i],0 ))

    elseif dataZList[i] > 5 then

        User:inform(dataZList[i].." Vor-Wirkung R1 : "..attr_r1[i].." : "..User:increaseAttrib(attr_r1[i],0 ))
        dasIstWirkung = math.floor(User:increaseAttrib(attr_r1[i],0)+(User:increaseAttrib(attr_r1[i],0)*(dataZList[i]-5)*10/100))

          if dasIstWirkung > obererGrenzwert[i] then
             dasIstWirkung = obererGrenzwert[i]
          end

          User:setAttrib(attr_r1[i],dasIstWirkung)
          User:inform("Nach-Wirkung R1: "..attr_r1[i].." : "..User:increaseAttrib(attr_r1[i],0 ))
     end

  end


  --User:inform("debug 13")
end
-- --------------------------------------------------------------------------------
function generateTasteMessage(Character,dataZList)
    local textDe = "Der Trank schmeckt ";
	local textEn = "The potion tastes ";
    local anyTaste = false;

    local usedTastes = {};

    for i=1,8 do
        if dataZList[i] > 5 then
            if usedTastes[i]==nil or usedTastes[i]<dataZList[i] then
                usedTastes[i] = dataZList[i];
            end
            anyTaste = true;
        elseif dataZList[i] < 5 then
            if usedTastes[9-i]==nil or usedTastes[9-i]<dataZList[i] then
                usedTastes[9-i] = dataZList[i];
            end
            anyTaste = true;
        end
    end
    if not anyTaste then
		textDe = textDe .. "nach nichts.";
		textEn = textEn .. "like nothing.";
    else
        for i=1,8 do
            if usedTastes[i]~=nil then
                if usedTastes[i] > 8 or usedTastes[i] < 2 then
					textDe = textDe .. "sehr ";
					textEn = textEn .. "very ";
                elseif (usedTastes[i] < 7 and usedTastes[i] > 5) or (usedTastes[i] > 3 and usedTastes[i] < 5) then
					textDe = textDe .. "etwas ";
					textEn = textEn .. "slightly ";
                end
                textDe = textDe..taste[0][i]..", ";
				textEn = textEn..taste[1][i]..", ";
            end
        end
        textDe = string.sub(textDe, 0, -3);
        textDe = textDe..".";
		textEn = string.sub(textEn, 0, -3);
        textEn = textEn..".";
    end
    base.common.InformNLS(Character,textDe,textEn);
end

function CheckIfGemDust(SourceItem)
local retVal = nil;
for i,checkId in pairs(gemList) do
    theItem = SourceItem
	if theItem.id == checkId then
    retVal = theItem
    break;
    end
end	
return retVal
end

function GetCauldronInfront(User)
    local retVal = nil
    Item = base.common.base.common.GetFrontItem(User)
	if (Item.id >= 1008) and (Item.id <= 1018) then
	    retVal = Item
	end
	return retVal
end

function CheckIfAlchemist(User,textDE,textEN)
    if User:getMagicType() ~= 3 then
	    User:inform(textDE,textEN)
		return false
	else
        return true
    end		
end

function RemoveEssenceBrew(Item)
    for i=1,8 do
	    Item:setData("essenceHerb"..i,"")  
	end	
end

function RemoveStock(Item)
    for i=1,8 do
	    Item:setData(wirkstoff[i].."Concentration","")
	end
end

function StockFromTo(fromItem,toItem)
    for i=1,8 do
	    toItem:setData(wirkstoff[i].."Concentration",fromItem:getData(wirkstoff[i].."Concentration"))
		fromItem:setData(wirkstoff[i].."Concentration","")
	end	
end

function RemoveAll(Item)
    RemoveEssenceBrew(Item)
	RemoveStock(Item)
	Item:setData("potionEffectId","")
	Item:setData("potionQuality","")
	Item:setData("cauldronFilledWith","")
	Item:setData("bottleFilledWith","")
end

function EmptyBottle(User,Bottle)
    if math.random(1,20) == 1 then
	   User:eraseItem(SourceItem,1) -- bottle breaks
	   base.common.InformNLS(User, "Die Flasche zerbricht.", "The bottle breaks.", Player.lowPriority)
	else	
		Bottle.id = 164
	    Bottle.quality = 333
		world:changeItem(SourceItem)
	end
end

function CauldronDestruction(User,cauldron,effectId)
    
	if (effectId < 1) or (effectId > 3) or (effectId == nil) then
	    effectId = 1
	end
	
	local textDE = nil; local textEN = nil
	if effectId == 1 then
	    world:gfx(1,cauldron.pos)
		world:makeSound(5,cauldron.pos)
	    User:inform("Du Inhalt des Kessels verpufft, als Du das Kraut hinzu tust.",
		            "The substance in the cauldron blows out, as you put the herb in."
					)
	elseif effectId == 2 then
	    world:makeSound(5,cauldron.pos)
		world:gfx(36,cauldron.pos)
	    User:inform("Deine letzte Handlung scheint den Inhalt des Kessels zerst�rt und zu einer Explosion gef�hrt zu haben.",
		            "Your last doing seems to have destroyed the substance in the cauldron and caused an explosion."
		            )
		local myVictims = world:getPlayersInRangeOf(cauldron.pos,1) -- we hurt everyone around the cauldron!
	    for i=1,#myVictims do
			myVictims[i]:increaseAttrib("hitpoints",-3000)
			base.common.HighInformNLS(myVictims[i], "Du wirst von einer Explosion getroffen.", "You are hit by an explosion.")
	    end			
	end
	RemoveAll(cauldron)
	cauldron.id = 1008
	world:changeItem(cauldron)
end

function GetQuality(User)
return 999
end

gemDustList  = {"non",446      ,447 ,448    ,449       ,450     ,451  ,452}
cauldronList = {1012 ,1011     ,1016,1013   ,1009      ,1015    ,1018 ,1017} 
bottleList   = {331  ,327      ,59  ,165    ,329       ,166     ,167  ,330}

function GemDustBottleCauldron(gemdust, cauldron, bottle)

    local myList
	local myValue
    if gemDust then
	    myList = gemDustList
		myValue = gemDust
	elseif cauldron then
	    myList = cauldronList
		myValue = cauldron
    elseif bottle then
        myList = bottleList	
		myValue = bottle
    else 
	    return 
	end	
	local reGemdust; local reCauldron; local reBottle
	for i=1,#myList do
	    if myList[i] == myValue then
		    reGemdust = gemDustList[i]
	        reCauldron = cauldronList[i]
			reBottle = bottleList[i]
	    end
	end
	return reGemdust, reCauldron, reBottle
end
----------------------------------------------------
-- combine of stock and essence brew to create a potion
-- function is only called when item 331 is a stock or when a potion-bottle is an essence brew
function CombineStockEssence( User, stock, essenceBrew)
   
    local cauldron = GetCauldronInfront(User)
    if cauldron then
        local parameters = {}
		local stockConc = ""
		for i=1,8 do 
		    stockConc = stockConc..stock:getData(wirkstoff[1].."Concentration")
		end
        parameters[1] = stockConc
		
	end
   
   
end