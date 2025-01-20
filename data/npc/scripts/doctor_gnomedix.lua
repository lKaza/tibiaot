local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	local player = Player(cid)
	if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 5 or player:getStorageValue(Storage.BigfootBurden.QuestLine) == 10  then
		npcHandler:setMessage(MESSAGE_GREET, "Stand still on the examination platform |PLAYERNAME|.")
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 11)
	end
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
