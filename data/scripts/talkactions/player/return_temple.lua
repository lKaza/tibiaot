local returnTemple = TalkAction("!return")


function returnTemple.onSay(player)
    local position = player:getPosition()

	if not player:isPzLocked() and not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
		player:teleportTo(getTownTemplePosition(player:getTown():getId()))

		Position(position):sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:sendCancelMessage("You can't use this when you're in a fight.")
		Position(position):sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

returnTemple:register()
