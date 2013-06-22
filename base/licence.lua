require("base.common")
require("base.factions")

module("base.licence", package.seeall)

--licencePos={}
licencePosCad={position(150,700,0)}; --Cadomyr
licencePosRun={position(900,900,0)}; --Runewick
licencePosGal={position(383,276,0),position(408,263,0),position(376,233,0)}; --Galmair workshop, alchemy hous, kitchen (Crest)


--licenceGalmairPos={position(383,276,0),position(408,263,0),position(376,233,0)}; --Galmair workshop, alchemy hous, kitchen (Crest)
--licenceGalmairPos[1]="383,276,0"; --Galmair workshop
--licenceGalmairPos[2]=408,263,0;	--Galmair alchemy hous
--licenceGalmairPos[3]={position(376,233,0)}	--Galmair kitchen (Crest)

function licence(char)
		local AmountCad = table.getn(licencePosCad)	--Cadomyr
		for i= 1,AmountCad do
			local licencePos = licencePosCad[i]
			local licenceDistance = char:distanceMetricToPosition (licencePos)
			if licenceDistance < 11 then
				licencerequired = 1
				licenceQuestID = 811
				licenceCheck(char)
			end
		end

		local AmountRun = table.getn(licencePosRun)	--Runewick
		for i= 1,AmountRun do
			local licencePos = licencePosRun[i]
			local licenceDistance = char:distanceMetricToPosition (licencePos)
			if licenceDistance < 11 then
				licencerequired = 2
				licenceQuestID = 812
				licenceCheck(char)
			end
		end

		local AmountGal = table.getn(licencePosGal)	--Galmair
		for i= 1,AmountGal do
			local licencePos = licencePosGal[i]
			local licenceDistance = char:distanceMetricToPosition (licencePos)
			if licenceDistance < 11 then
				licencerequired = 3
				licenceQuestID = 813
				licenceCheck(char)
			end
		end
end

function licenceCheck(char)
	if base.factions.getMembership(char) == 0 or base.factions.getRankpoints(char) >=100 then
		if base.factions.getMembership(char) == licencerequired or char:getQuestProgress(licenceQuestID) > 0 then	
			stopcraftingnolicence = false
		else
			base.common.InformNLS(char,"Du besitzt keine Lizenz f�r die Verwendung der Ger�te dieser Stadt. Gehe ins Zensurb�ro, um dort eine zu erwerben und damit die Ger�te verwenden zu k�nnen oder werde B�rger dieser Stadt.","You do not have a licence for the use of static tools in this town. Go to the census office and purchase one in order to be able to use their static tools or become a citizen.");
			stopcraftingnolicence = true 
			return
		end
	else
	stopcraftingnolicence = false
	end
end