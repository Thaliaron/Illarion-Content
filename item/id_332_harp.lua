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
-- I_332 Harfe spielen

-- UPDATE common SET com_script='item.id_332_harp' WHERE com_itemid=332;

require("item.base.music")
require("item.general.wood")

module("item.id_332_harp", package.seeall)

skill = Character.harp

item.base.music.addTalkText("#me plays the harp with a horrible crash","#me macht ein furchtbares Geräusch mit der Harfe", skill);
item.base.music.addTalkText("#me plays a stilted tune on the harp","#me spielt eine gezierte Melodie auf der Harfe", skill);
item.base.music.addTalkText("#me plays a smooth melody on the harp","#me spielt eine gleichbleibende Melodie auf der Harfe", skill);
item.base.music.addTalkText("#me plays a pretty tune on the harp","#me spielt eine nette Melodie auf der Harfe", skill);
item.base.music.addTalkText("#me plays a beautiful melody on the harp","#me spielt eine wunderschöne Melodie auf der Harfe", skill);

function UseItem(User, SourceItem)
    item.base.music.PlayInstrument(User,SourceItem, skill);
end

LookAtItem = item.general.wood.LookAtItem
