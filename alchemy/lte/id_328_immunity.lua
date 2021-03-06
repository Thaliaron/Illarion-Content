--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>. 
]]
-- LTE f�r das Druidensystem
-- by Falk
-- immunity. Has actually nothing to do with healing potion 328 orange bottle

module("alchemy.lte.id_328_immunity", package.seeall)

-- INSERT INTO longtimeeffects VALUES (328, 'alchemy_immunity', 'alchemy.lte.id_328_immunity');

function getAction(Character,Effect,Runde)
--Hier die eigentlichen Aktionen eintragen  
end

function addEffect(Effect, Character)               -- Nur beim ersten Aufruf
--Character:inform("debug func addEffect") 
end

function callEffect(Effect,Character)                  -- Effect wird ausgef�hrt
	
	local foundImmunity, immunity, retVal = nil,nil,false;
	for i=1,8 do
		foundImmunity, immunity = Effect:findValue("immunity_"..i);
		if foundImmunity then
			if immunity == 0 then
				Effect:removeValue("immunity_"..i);
			else
				Effect:addValue("immunity_"..i,immunity-1);
				retVal = true;
			end
		end
	end
	Effect.nextCalled = 10;
	return retVal;
end

function removeEffect(Effect,Character)         
--Character:inform("debug func removeEffect")  
end

function loadEffect(Effect,Character)                  -- wenn der Charakter erneut einloggt
--Character:inform("debug func loadEffect")   
end
