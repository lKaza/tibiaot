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
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end

local voices = {
	{ text = 'This is Thancred.' }
}
npcHandler:addModule(VoiceModule:new(voices))

-- Basic Keywords

-- Names
keywordHandler:addKeyword({'GodK'}, StdModule.say, {npcHandler = npcHandler, text = 'He is just your average memeLord.'})
keywordHandler:addAliasKeyword({'Kaza'})

-- Pick quest
local pickKeyword = keywordHandler:addKeyword({'pick'}, StdModule.say, {npcHandler = npcHandler, text = 'Picks are hard to come by. I trade them only in exchange for high quality small axes. Would you like to make that deal?'})
	pickKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Splendid! Here, take your pick.', reset = true},
		function(player) return player:getItemCount(2559) > 0 end,
		function(player)
			player:removeItem(2559, 1)
			player:addItem(2553, 1)
		end
	)
	pickKeyword:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'Sorry, I am looking for a SMALL axe.', reset = true})
	pickKeyword:addChildKeyword({''}, StdModule.say, {npcHandler = npcHandler, text = 'Well, then don\'t.', reset = true})
keywordHandler:addAliasKeyword({'small', 'axe'})

npcHandler:setMessage(MESSAGE_WALKAWAY, 'Bye, bye.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Bye, bye |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_SENDTRADE, 'Buy sell buy sell.')
npcHandler:setMessage(MESSAGE_GREET, {
	'Hello, hello, |PLAYERNAME|! Please come in, look, and buy! I\'m a specialist for all sorts of {tools}. Just ask me for a {trade} to see my offers! You can also ask me for general {hints} about the game. ...',
	'You can also ask me about each {citizen} of the isle.'
})

npcHandler:addModule(FocusModule:new())
