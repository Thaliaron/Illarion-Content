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
require("base.class")
require("npc.base.condition.condition")

module("npc.base.condition.language", package.seeall)

language = base.class.class(npc.base.condition.condition.condition,
function(self, value)
    npc.base.condition.condition.condition:init(self);
    if (value == "german" or value == "deutsch") then
        self["value"] = Player.german;
    else
        self["value"] = Player.english;
    end;
    self["check"] = _language_helper_equal;
end);

function _language_helper_equal(self, npcChar, texttype, player)
    return (player:getPlayerLanguage() == self.value);
end;
