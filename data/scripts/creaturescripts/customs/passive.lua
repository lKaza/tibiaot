local config = {
    enabled = true,
    doChance = 10000, --chance to do spell 1000 = 1 %
    TALKTYPE_ORANGE_1 = TALKTYPE_MONSTER_SAY,
    TALKTYPE_ORANGE_2 = TALKTYPE_MONSTER_YELL
}
local passive = CreatureEvent("passiveSpell")


local voc = {
    {
        id = 1, --sorc
        spellname = "passive spell", --TODO think for proper names
        combatDamage = COMBAT_DEATHDAMAGE,
        CombatEffect = CONST_ME_MORTAREA,
        distEffect = CONST_ANI_DEATH

    },
    {
        id = 2, --druid
        spellname = "passive spell",
        combatDamage = COMBAT_ICEDAMAGE,
        CombatEffect = CONST_ME_ICEAREA,
        distEffect = CONST_ANI_ICE

    },
    {
        id = 3, --pally
        spellname = "passive spell",
        combatDamage = COMBAT_PHYSICALDAMAGE,
        CombatEffect = CONST_ME_HITAREA,
        distEffect = CONST_ANI_THROWINGSTAR

    },
    {
        id = 4, --knight
        spellname = "passive spell",
        combatDamage = COMBAT_PHYSICALDAMAGE,
        CombatEffect = CONST_ME_DRAWBLOOD,
        distEffect = CONST_ANI_LARGEROCK
    },
}
local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local skill = Condition(CONDITION_ATTRIBUTES)
skill:setParameter(CONDITION_PARAM_SUBID, 5)
skill:setParameter(CONDITION_PARAM_TICKS, 5000)
skill:setParameter(CONDITION_PARAM_BUFF_DAMAGERECEIVED, 1)
skill:setParameter(CONDITION_PARAM_SKILL_SHIELDPERCENT, 8000)
skill:setParameter(CONDITION_PARAM_BUFF_SPELL, true)
combat:addCondition(skill)

function passive.onThink(creature, interval)
    if config.enabled then
        if creature:isPlayer() then
            local cid = creature:getId()
            local player = Player(cid)
            local conditionValue = player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

            if conditionValue and not onExerciseTraining[cid] then
                local var = {type = 1, number = creature:getId()}
                local hp = (creature:getHealth()/creature:getMaxHealth())*100
                if hp < 40.0 then
                    creature:setHealth(creature:getHealth()*1.5)
                    combat:execute(creature, var)
                    player:setTraining(true)
			        player:setStorageValue(Storage.isTraining, os.time() + 30)
                    creature:sendTextMessage(MESSAGE_BEYOND_LAST, 'Heavens gives you another chance.')
                end
            else
                creature:sendTextMessage(MESSAGE_BEYOND_LAST, 'You are not in fight.')
                creature:unregisterEvent("passiveSpell")
            end
        else

        end
    end
end


passive:register()