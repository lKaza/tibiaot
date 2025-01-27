
local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local spell = Spell("instant")


function spell.onCastSpell(player, fromPosition, toPosition)
	if not player:isPzLocked() and not player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
		player:teleportTo(getTownTemplePosition(player:getTown():getId()))

		Position(fromPosition):sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:sendCancelMessage("You can't use this when you're in a fight.")
		Position(fromPosition):sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Return temple")
spell:words("utevo return")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "knight;true", "elite knight;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true")
spell:id(10)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(8)
spell:mana(20)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()

