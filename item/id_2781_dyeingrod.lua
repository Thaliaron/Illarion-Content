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

-- UPDATE common SET com_script='item.id_2781_dyeingrod' WHERE com_itemid IN (2781);

require("base.licence")
require("content.gatheringcraft.dyeing")

module("item.id_2781_dyeingrod", package.seeall)

function getBarrel(User)

	local targetItem = base.common.GetFrontItem(User);
	if (targetItem ~= nil and targetItem.id == 220) then
		return targetItem;
	end

	local Radius = 1;
	for x=-Radius,Radius do
		for y=-Radius,Radius do
			local targetPos = position(User.pos.x + x, User.pos.y + y, User.pos.z);
			if (world:isItemOnField(targetPos)) then
				local targetItem = world:getItemOnField(targetPos);
				if (targetItem ~= nil and targetItem.id == 220) then
					return targetItem;
				end
			end
		end
	end
	return nil;
end

function UseItem(User, SourceItem, ltstate)
	if base.licence.licence(User) then --checks if user is citizen or has a licence
		return -- avoids crafting if user is neither citizen nor has a licence
	end

	local barrelItem = getBarrel(User);
	if barrelItem then
		content.gatheringcraft.dyeing.StartGathering(User, barrelItem, ltstate);
		return
	end

	base.common.InformNLS(User,
		"Du musst neben einem Fass stehen um den Färberstab zu benutzen.",
		"You must stand next to a barrel to use the dyeing rod.");
end
