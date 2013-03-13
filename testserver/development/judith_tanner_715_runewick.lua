-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (715, 'quest.judith_tanner_715_runewick');

require("base.common")
module("development.judith_tanner_715_runewick", package.seeall)

GERMAN = Player.german
ENGLISH = Player.english

-- Insert the quest title here, in both languages
Title = {}
Title[GERMAN] = "Das Schneiderhandwerk"
Title[ENGLISH] = "The tailoring craft"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}

Description[GERMAN][1] = "Sammel 20 Wollkballen f�r Judith Tanner im Untergeschoss des Feuerturms. Schafe kannst du im Wald von Runewick finden. Du kannst die Schafe scheren, indem du die Schere in die Hand nimmst und diese benutzt, wenn ein Schaf neben dir steht."
Description[ENGLISH][1] = "Collect 20 bales of wool for Judith Tanner in the basement of the firetower. You can find sheeps in the forest of Runewick. You can collect wool if you stay next to a sheep and use the scissors while holding them in your hand."
Description[GERMAN][2] = "Geh zu Judith Tanner, die sich im Untergeschoss des Feuerturms aufh�lt. Sie hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][2] = "Go back to Judith Tanner in the basement of the firetower, she is sure to have another task for you."
Description[GERMAN][3] = "Bring Judith Tanner im Untergeschoss des Feuerturms f�nf Garnrollen und zwei Rollen grauen Stoff. Den Stoff kannst du am Webstuhl herstellen und die Garnrollen am Spinnrad. F�r beides brauchst du unterschiedliche Mengen an Wolle."
Description[ENGLISH][3] = "Take Judith Tanner in the basement of the firetower five spools of thread and two grey cloth. You can produce the cloth at the loom. The thread can be produced at the spinning wheel, you'll need different amounts of wool to produce them both."
Description[GERMAN][4] = "Geh zu Judith Tanner, die sich im Untergeschoss des Feuerturms aufh�lt. Sie hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][4] = "Go back to Judith Tanner in the basement of the firetower, she is sure to have another task for you."
Description[GERMAN][5] = "Schneidere ein graues Gewand am Schneidertisch f�r Judith Tanner im Untergeschoss des Feuerturms. Um das Gewand herzustellen, musst du die Nadel in die Hand nehmen und diese benutzen, wenn du vor einem Schneidertisch stehst. Der Schneidertisch befindet sich neben Judith."
Description[ENGLISH][5] = "Tailor one grey dress at the tailoring table for Judith Tanner in the basement of the firetower. To produce the dress you have to take the needle in your hand and use it, while staying in front of the tailoring table. The tailoring table is right next to Judith."
Description[GERMAN][6] = "Geh zu Judith Tanner, die sich im Untergeschoss des Feuerturms aufh�lt. Sie hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][6] = "Go back to Judith Tanner in the basement of the firetower, she is sure to have another task for you."
Description[GERMAN][7] = "Stell f�nf Eimer mit roter Farbe f�r Judith Tanner im Untergeschoss des Feuerturms her. Um die rote Farbe herzustellen, musst du ein Feuer machen. Daf�r plazierst du das Holz vor dir auf dem Boden und benutzt dieses. Anschlie�end nimmst du den M�rser in die Hand und benutzt diesen."
Description[ENGLISH][7] = "Produce five buckets of red dye for Judith Tanner in the basement of the firetower. To produce red dye you have to make a fire, for this you have to place the fire on the ground and use it. Once you have done that take the mortar in your hand and use it while staying in front of the fire."
Description[GERMAN][8] = "Geh zu Judith Tanner, die sich im Untergeschoss des Feuerturms aufh�lt. Sie hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][8] = "Go back to Judith Tanner in the basement of the firetower, she is sure to have another task for you."
Description[GERMAN][9] = "F�rbe f�nf Rollen roten Stoff bei dem schwarzen Fass in der Schneiderei von Runewick f�r Judith Tanner, die sich im Untergeschoss des Feuerturms aufh�lt. Um die Stoffe herzustellen, musst du den F�rberstab in die Hand nehmen. Anschlie�end benutzt du das schwarze Fass, w�hrend du die Eimer mit Farbe und den wei�en Stoff in deinem Inventar hast."
Description[ENGLISH][9] = "Dye five cloths red for Judith Tanner in the basement of the firetower, using the black barrel. To produce the cloth you have to take the dyeing rod in your hand and use the black barrel while having red dye and white cloth in your inventory."
Description[GERMAN][10] = "Du hast alle Aufgaben von Judith Tanner erf�llt."
Description[ENGLISH][10] = "You have fulfilled all the tasks for Judith Tanner."


-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
QuestTarget = {}
QuestTarget[1] = {position(905, 780, 0), position(860, 768, 0)} -- Sheeps
QuestTarget[2] = {position(905, 780, 0)} 
QuestTarget[3] = {position(905, 780, 0), position(911, 782, 0), position(911, 781, 0)} -- Spinning wheel and loom
QuestTarget[4] = {position(905, 780, 0)}
QuestTarget[5] = {position(905, 780, 0), position(901, 779, 0)} -- Tailoring table
QuestTarget[6] = {position(905, 780, 0)} 
QuestTarget[7] = {position(905, 780, 0), position(886, 795, 0)} -- Camp fire
QuestTarget[8] = {position(905, 780, 0)}
QuestTarget[9] = {position(905, 780, 0), position(909, 778, 0)} -- Barrels

-- Insert the quest status which is reached at the end of the quest
FINAL_QUEST_STATUS = 10


function QuestTitle(user)
    return base.common.GetNLS(user, Title[GERMAN], Title[ENGLISH])
end

function QuestDescription(user, status)
    local german = Description[GERMAN][status] or ""
    local english = Description[ENGLISH][status] or ""

    return base.common.GetNLS(user, german, english)
end

function QuestTargets(user, status)
    return QuestTarget[status]
end

function QuestFinalStatus()
    return FINAL_QUEST_STATUS
end