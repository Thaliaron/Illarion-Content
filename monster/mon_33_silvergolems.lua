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
require("monster.base.base")
require("monster.base.drop")
require("monster.base.lookat")
require("monster.base.quests")
require("base.messages");
require("monster.base.kills")
require("base.arena")
module("monster.mon_33_silvergolems", package.seeall)


function ini(Monster)

init=true;
monster.base.quests.iniQuests();
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

msgs = base.messages.Messages();
msgs:addMessage("#mes imposante Erscheinung wirft einen finsteren Schatten und der Boden erbebt mit jedem Schritt.", "#me's colossal presence casts an eclipsing shadow and shakes the ground with each step.");
msgs:addMessage("#me mag einem diamantgleichen Bollwerk aus Fels und Stein gleichen, aber jene mit scharfen Blick k�nnen den eingelassenen Herzstein in der Brust des W�chters ausmachen.", "#me's adamantine bulwark of rocks and gems may seem impervious, but those with a keen eye might notice the crystalline heart-stone embedded in the guardian's chest.");
msgs:addMessage("#me stampft mit einer solchen Geschwindigkeit auf den Boden, dass die Ersch�tterung tiefe Risse hinterl��t.", "#me pounds the ground with such velocity that tremors split and crack across the ground.");
msgs:addMessage("#mes kehliges Grollen durchdringt Ohr und Mark wie eine kreischender Schleifstein.", "#me's guttural roar pierces the ear like an amplified grindstone.");
msgs:addMessage("#me steht r�cksichtslos in seinem Hoheitsgebiet Wache, jene, die die F�den der Natur ergr�ndet haben, machen abstruse Managewebe als Anstiftung seiner Wut aus.", "#me ruthlessly guards its territory, those clairvoyant to the threads of nature may sense the abstruse webs of mana inciting its rage.");
msgs:addMessage("#me richtet seine diamantenen Augen ganz und gar auf sein Ziel,  vollkommens sich der Beseitigung der Eindringlingen hingebend.", "#me trains its diamond eyes on its target utterly enraptured with eliminating intruders.");
msgs:addMessage("#me bewegt sich mit einer solchen Heftigkeit, dass der Steine Scherben aus dem Boden br�ckeln.", "#me moves with such ferocity that shards of gems and rocks crumble to the ground.");
msgs:addMessage("#me schl�gt seine steinernen F�uste zusammen, den Boden mit Fragmenten von Edelsteinen und rohem Fels bedeckend.", "#me smashes its stone fists together littering the ground with fragments of precious jewels and raw stone.");
msgs:addMessage("#me hinterl�sst beim herumtrampeln tiefe Erdpfurchen und widerhallendes Beben.", "#me leaves behind hollow pits and reverberating tremors as it tramples around.");
msgs:addMessage("#me hebt seine imposanten F�uste und st��t einen donnernden Kriegsschrei aus, der die Erde beben l�sst.", "#me raises its enormous fist and yells a terrifying warcry that makes the ground quake.");

end

function enemyNear(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end

    if math.random(1,10) == 1 then
        monster.base.drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while
    end

    return false
end

function enemyOnSight(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end

    monster.base.drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

	if monster.base.base.isMonsterArcherInRange(Monster, Enemy) then
		return true
	end

	if monster.base.base.isMonsterInRange(Monster, Enemy) then
        return true;
    else
        return false
    end
end

function onAttacked(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end
    monster.base.kills.setLastAttacker(Monster,Enemy)
    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function onCasted(Monster,Enemy)


    if init==nil then
        ini(Monster);
    end
    monster.base.kills.setLastAttacker(Monster,Enemy)
    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function onDeath(Monster)

    if base.arena.isArenaMonster(Monster) then
        return
    end


    if killer and killer[Monster.id] ~= nil then

        murderer=getCharForId(killer[Monster.id]);

        if murderer then --Checking for quests

            monster.base.quests.checkQuest(murderer,Monster);
            killer[Monster.id]=nil;
            murderer=nil;

        end
    end

    monster.base.drop.ClearDropping();
    local MonID=Monster:getMonsterType();
if (MonID==331) then --Silvergolem, Level: 6, Armourtype: medium, Weapontype: puncture

        --Category 1: Raw gems

        local done=monster.base.drop.AddDropItem(255,1,20,(100*math.random(5,6)+math.random(55,66)),0,1); --raw ruby
        if not done then done=monster.base.drop.AddDropItem(253,1,10,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw sapphire
        if not done then done=monster.base.drop.AddDropItem(257,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw topaz
        if not done then done=monster.base.drop.AddDropItem(252,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw obsidian
        if not done then done=monster.base.drop.AddDropItem(256,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw emerald

        --Category 2: Gems

        local done=monster.base.drop.AddDropItem(46,1,20,(100*math.random(5,6)+math.random(55,66)),0,2); --ruby
        if not done then done=monster.base.drop.AddDropItem(284,1,10,(100*math.random(5,6)+math.random(55,66)),0,2); end --sapphire
        if not done then done=monster.base.drop.AddDropItem(198,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --topaz
        if not done then done=monster.base.drop.AddDropItem(283,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --obsidian
        if not done then done=monster.base.drop.AddDropItem(45,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --emerald

        --Category 3: Special Loot

        local done=monster.base.drop.AddDropItem(22,1,20,(100*math.random(5,6)+math.random(55,66)),0,3); --iron ore
        if not done then done=monster.base.drop.AddDropItem(733,1,10,(100*math.random(5,6)+math.random(55,66)),0,3); end --stone block
        if not done then done=monster.base.drop.AddDropItem(234,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --gold nugget
        if not done then done=monster.base.drop.AddDropItem(2534,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --merinium ore

		--Category 4: Perma Loot
        monster.base.drop.AddDropItem(3077,math.random(2,5),100,333,0,4); --silver coins

    end
    monster.base.drop.Dropping(Monster);
end
