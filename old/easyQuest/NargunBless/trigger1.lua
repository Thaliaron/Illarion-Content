require("questsystem.base")
module("questsystem.NargunBless.trigger1", package.seeall)

local QUEST_NUMBER = 10000
local PRECONDITION_QUESTSTATE = 0
local POSTCONDITION_QUESTSTATE = 15

local POSITION = position(255, 293, -5)
local RADIUS = 10
local LOOKAT_TEXT_DE = "F�r einen Moment kam es dir so vor  als ob du einen Raben, der dich gerade noch angestarrt hatte, auf Nargun`s Altar sitzen gesehen h�ttest. Du bekommst eine G�nsehaut."
local LOOKAT_TEXT_EN = "For a moment it seemed to you as if a raven had sat at the altar and stared at you. That gives you the creeps."

function LookAtItem(PLAYER, item)
  if PLAYER:isInRangeToPosition(POSITION,RADIUS)
      and ADDITIONALCONDITIONS(PLAYER)
      and questsystem.base.fulfilsPrecondition(PLAYER, QUEST_NUMBER, PRECONDITION_QUESTSTATE) then

    itemInformNLS(PLAYER, item, LOOKAT_TEXT_DE, LOOKAT_TEXT_EN)
    
    HANDLER(PLAYER)
    
    questsystem.base.setPostcondition(PLAYER, QUEST_NUMBER, POSTCONDITION_QUESTSTATE)
    return true
  end

  return false
end

function itemInformNLS(player, item, textDe, textEn)
  if player:getPlayerLanguage() == Player.german then
    world:itemInform(player, item, textDe)
  else
    world:itemInform(player, item, textEn)
  end
end


function HANDLER(PLAYER)
end

function ADDITIONALCONDITIONS(PLAYER)
return true
end