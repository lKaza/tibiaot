local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onTargetCreature(creature, target)
	return doChallengeCreature(creature, target)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Challenge")
spell:words("exeta res")
spell:group("support")
spell:vocation("elite knight;true")
spell:id(93)
spell:cooldown(500)
spell:groupCooldown(1500)
spell:level(15)
spell:mana(20)
spell:isAggressive(false)
spell:isPremium(false)
Spell:needLearn(false)
spell:register()
