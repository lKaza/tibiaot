local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local skill = Condition(CONDITION_ATTRIBUTES)
skill:setParameter(CONDITION_PARAM_SUBID, 5)
skill:setParameter(CONDITION_PARAM_TICKS, 35000)
skill:setParameter(CONDITION_PARAM_SKILL_SHIELDPERCENT, 220)
skill:setParameter(CONDITION_PARAM_BUFF_DAMAGERECEIVED, 80)
skill:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(skill)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	if creature:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5) then
		creature:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5)
	end
	return combat:execute(creature, variant)
end

spell:name("Protector")
spell:words("utamo tempo")
spell:group("support", "focus")
spell:vocation("knight;true", "elite knight;true")
spell:id(132)
spell:cooldown(1000)
spell:groupCooldown( 1000, 1000)
spell:level(55)
spell:mana(50)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(true)
spell:needLearn(false)
spell:register()
