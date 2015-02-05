-- ProbablyEngine Rotation Packager
-- Created on Nov 1st 2014 8:14 pm
ProbablyEngine.rotation.register_custom(255, "Rotation Agent - Survival (SimC)",
-- COMBAT
{
    --[[--------------------------------------------------------------------------------------------
    PAUSE
      * Rotation will stop if Left Shift is held down, Feign Death is up or the player is eating or
        is mounted. This will additionally recall your pet to prevent any outgoing DPS.
    ----------------------------------------------------------------------------------------------]]
    { "/stopcasting\n/stopcasting\n/stopattack\n/petfollow", { "@LibHunter.ImmuneTargetCheck(5, 'target')", }, },
    { "/stopcasting\n/stopattack\n/petfollow", { "modifier.lshift", }, },
    { "/stopcasting\n/stopattack\n/petfollow", { "lastcast(Feign Death)", }, },
    { "/stopattack\n/petfollow", { "player.buff(Food)", }, },










    --[[--------------------------------------------------------------------------------------------
    SPELL QUEUE

    ----------------------------------------------------------------------------------------------]]
    { "Explosive Trap", "@LibHunter.CheckHunterQueue(82939)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Explosive Trap", "@LibHunter.CheckHunterQueue(13813)", "!player.buff(Trap Launcher)", },
    { "Freezing Trap", "@LibHunter.CheckHunterQueue(60192)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Freezing Trap", "@LibHunter.CheckHunterQueue(60192)", "!player.buff(Trap Launcher)", },
    { "Ice Trap", "@LibHunter.CheckHunterQueue(82941)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Ice Trap", "@LibHunter.CheckHunterQueue(82941)", "!player.buff(Trap Launcher)", },
    { "Binding Shot", "@LibHunter.CheckHunterQueue(109248)", "mouseover.ground", },
    { "Flare", "@LibHunter.CheckHunterQueue(1543)", "mouseover.ground", },

    { "A Murder of Crows", "@LibHunter.CheckHunterQueue(131894)", },
    { "Aspect of the Fox", "@LibHunter.CheckHunterQueue(172106)", },
    { "Barrage", "@LibHunter.CheckHunterQueue(120360)", },
    { "Camouflage", "@LibHunter.CheckHunterQueue(51753)", },
    { "Concussive Shot", "@LibHunter.CheckHunterQueue(5116)", },
    { "Counter Shot", "@LibHunter.CheckHunterQueue(147362)", },
    { "Deterrence", "@LibHunter.CheckHunterQueue(148467)", },
    { "Distracting Shot", "@LibHunter.CheckHunterQueue(20736)", },
    { "!Feign Death", "@LibHunter.CheckHunterQueue(5384)", },
    { "Flare", "@LibHunter.CheckHunterQueue(1543)", },
    { "Focusing Shot", "@LibHunter.CheckHunterQueue(152245)", },
    { "Glaive Toss", "@LibHunter.CheckHunterQueue(117050)", },
    { "Intimidation", "@LibHunter.CheckHunterQueue(19577)", },
    { "Master's Call", "@LibHunter.CheckHunterQueue(53271)", },
    { "Multi-Shot", "@LibHunter.CheckHunterQueue(2643)", },
    { "Powershot", "@LibHunter.CheckHunterQueue(109259)", },
    { "Stampede", "@LibHunter.CheckHunterQueue(121818)", },
    { "Tranquilizing Shot", "@LibHunter.CheckHunterQueue(19801)", },
    { "Wyvern Sting", "@LibHunter.CheckHunterQueue(19386)", },
    { "/stopcasting\n/stopcasting\n/hunterjump", { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },
    --{ "/stopcasting\n/stopcasting\n/hackintehunterjump", { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },

    --{ "", "@LibHunter.CheckHunterQueue()", },
    { "Arcane Shot", "@LibHunter.CheckHunterQueue(3044)", },
    { "Black Arrow", "@LibHunter.CheckHunterQueue(3674)", },
    { "Explosive Shot", "@LibHunter.CheckHunterQueue(53301)", },










--[[--------------------------------------------------------------------------------------------
    SURVIVAL OPENER

    ----------------------------------------------------------------------------------------------]]
    {{
        { "#trinket1", { "modifier.cooldowns", }, },
        { "#trinket2", { "modifier.cooldowns", }, },
        { "Blood Fury", { "modifier.cooldowns", }, },
        { "A Murder of Crows", { "modifier.cooldowns", }, },
        { "Black Arrow", },
        { "Arcane Shot", { "player.buff(Thrill of the Hunt)", "player.buff(Balanced Fate)", }, },
        { "Explosive Shot", { "!player.buff(Thrill of the Hunt)", }, },
        { "Arcane Shot", { "!target.debuff(Serpent Sting)", }, },
        { "Berserking", { "modifier.cooldowns", }, },
    }, {"@LibHunter.UseOpenerCheck('worldboss', 4)", }, },










    --[[--------------------------------------------------------------------------------------------
    POOL FOCUS
      * Holding Left Control will cause the rotation to only cast Steady Shot to pool focus.
      * Cast Steady Shot if Rapid Fire is coming off of Cooldown and we are not focus capped.
    ----------------------------------------------------------------------------------------------]]
    { "Cobra Shot", { "modifier.rcontrol", "!talent(7,2)", }, },
    { "Focusing Shot", { "modifier.rcontrol", "talent(7,2)", }, },










    --[[--------------------------------------------------------------------------------------------
    MISCELLANEOUS

    ----------------------------------------------------------------------------------------------]]
    { "Freezing Trap", { "modifier.lcontrol", }, "mouseover.ground", },
    { "Multi-Shot", { "toggle.ss", "!modifier.lcontrol", "modifier.multitarget", "!mouseover.debuff(Serpent Sting)", "@LibHunter.NotImmuneTargetCheck(2, 'mouseover')", "@LibHunter.UnitsAroundUnit('mouseover', 8, 2)", }, "mouseover", },
    { "Arcane Shot", { "toggle.ss", "!modifier.lcontrol", "!mouseover.debuff(Serpent Sting)", "@LibHunter.NotImmuneTargetCheck(2, 'mouseover')", "!@LibHunter.UnitsAroundUnit('mouseover', 8, 1)", }, "mouseover", },
    { "Multi-Shot", { "toggle.ss", "modifier.lalt", "modifier.multitarget", "!mouseover.debuff(Serpent Sting)", "@LibHunter.UnitsAroundUnit('mouseover', 8, 2)", }, "mouseover", },
    { "Arcane Shot", { "toggle.ss", "modifier.lalt", "!mouseover.debuff(Serpent Sting)", "!@LibHunter.UnitsAroundUnit('mouseover', 8, 1)", }, "mouseover", },










    --[[--------------------------------------------------------------------------------------------
    AUTO CLEAR TARGET
      * Automatically clears the target if it is friendly.
    ----------------------------------------------------------------------------------------------]]
    {{
        { "/cleartarget", { "@LibHunter.ClearCurrentTarget()", "!modifier.rcontrol" }, },
    }, "toggle.autotarget", },










    --[[--------------------------------------------------------------------------------------------
    MISDIRECTION

    ----------------------------------------------------------------------------------------------]]
    {{
        { "Misdirection", { "pet.exists", "!pet.dead", "!pet.buff(Misdirection)", "!focus.exists", }, "pet", },
        { "Misdirection", { "focus.exists", "!focus.dead", "!focus.buff(Misdirection)", "player.time < 5", }, "focus", },
        { "Misdirection", { "focus.exists", "!focus.dead", "!focus.buff(Misdirection)", "player.threat > 75", }, "focus", },
    }, "toggle.md", },










    --[[--------------------------------------------------------------------------------------------
    PET MANAGEMENT

    ----------------------------------------------------------------------------------------------]]
    {{
        { "Heart of the Phoenix", { "!talent(7,3)", "pet.dead", }, },
        { "Revive Pet", { "!talent(7,3)", "pet.dead", }, },
        { "Mend Pet", { "pet.exists", "!pet.dead", "!pet.buff(Mend Pet)", "pet.health <= 90", }, "pet", },
        { "/petattack", { "pet.exists", "timeout(petAttack, 1)", }, },
        { "/cast Dash", { "pet.exists", "@LibHunter.UnitToUnitDistanceCheck('pet', 'target', 15)", "timeout(petDash, 2)", }, },
    }, "toggle.petmgmt", },










    --[[--------------------------------------------------------------------------------------------
    DEFENSIVE ABILITIES/ITEMS

    ----------------------------------------------------------------------------------------------]]
    {{
        { "#5512", { "player.health < 40", }, },
        { "#109223", { "player.health <= 10", }, },
        { "Deterrence", { "player.health <= 10", }, },
        { "Exhilaration", { "player.health < 50"}, },
        { "Master's Call", { "pet.exists", "player.state.disorient", }, },
        { "Master's Call", { "pet.exists", "player.state.stun", }, },
        { "Master's Call", { "pet.exists", "player.state.root", }, },
        { "Master's Call", { "pet.exists", "player.state.snare", "!player.debuff(Dazed)", }, },
    }, "toggle.defensives", },










    --[[--------------------------------------------------------------------------------------------
    PVP MODE
      * If target is moving use concussive shot
      * Tranq Shot on any dispellable buff
    ----------------------------------------------------------------------------------------------]]
    {{
        { "Concussive Shot", { "target.moving", "!target.immune.snare", }, },
        { "Tranquilizing Shot", { "@LibHunter.TranqABuff()", }, },
    }, "toggle.pvpmode", },










    --[[--------------------------------------------------------------------------------------------
    MAIN DAMAGE SECTION

    ----------------------------------------------------------------------------------------------]]
    {
        {
            --actions=auto_shot

            --actions+=/use_items
            { "#trinket1", { "modifier.cooldowns", }, },
            { "#trinket2", { "modifier.cooldowns", }, },

            --actions+=/arcane_torrent,if=focus.deficit>=30
            { "Arcane Torrent", { "player.focus <= 90", "modifier.cooldowns", "target.deathin > 20", }, },

            --actions+=/blood_fury
            { "Blood Fury", { "modifier.cooldowns", "target.deathin > 20", }, },

            --actions+=/berserking
            { "Berserking", { "modifier.cooldowns", "target.deathin > 20", }, },

            --actions+=/potion,name=draenic_agility,if=(((cooldown.stampede.remains<1)&(cooldown.a_murder_of_crows.remains<1))&(trinket.stat.any.up|
            --         buff.archmages_greater_incandescence_agi.up))|
            --         target.time_to_die<=25
            { "#109217", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "player.spell(Stampede).cooldown < 1", "@LibHunter.StatProcs(2)", }, },
            { "#109217", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "player.spell(A Murder of Crows).cooldown < 1", "@LibHunter.StatProcs(2)", }, },
            { "#109217", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "player.buff(Archmage's Greater Incandescence)", }, },
            { "#109217", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "target.deathin <= 25", }, },

            --actions+=/call_action_list,name=aoe,if=active_enemies>1
            {{
                --actions.aoe=stampede,if=buff.potion.up|
                --            (cooldown.potion.remains&(buff.archmages_greater_incandescence_agi.up|
                --            trinket.stat.any.up|
                --            buff.archmages_incandescence_agi.up))
                { "Stampede", { "modifier.cooldowns", "@LibHunter.EvalClassification('rareelite')", "@LibHunter.SimCBuffPoitionUp(109217)", }, },
                { "Stampede", { "modifier.cooldowns", "@LibHunter.EvalClassification('rareelite')", "@LibHunter.StatProcs(2)", }, },
                { "Stampede", { "modifier.cooldowns", "@LibHunter.EvalClassification('rareelite')", "target.deathin <= 25"}, },

                --actions.aoe+=/explosive_shot,if=buff.lock_and_load.react&(!talent.barrage.enabled|cooldown.barrage.remains>0)
                { "Explosive Shot", { "player.buff(Lock and Load)", "!talent(6,3)", }, },
                { "Explosive Shot", { "player.buff(Lock and Load)", "player.spell(Barrage).cooldown > 0", }, },

                --actions.aoe+=/barrage
                { "Barrage", { "!toggle.nocleave", "!modifier.lcontrol", }, },

                --actions.aoe+=/black_arrow,if=!ticking
                { "Black Arrow", { "player.spell(Black Arrow).cooldown = 0", "target.deathin > 12", }, },

                --actions.aoe+=/explosive_shot,if=active_enemies<5
                { "!Explosive Shot", { "player.buff(Lock and Load)", "!player.casting(Barrage)", (function() return UnitsAroundUnit('target', 10) < 5 end), }, },
                { "Explosive Shot", { "player.focus > 15", (function() return UnitsAroundUnit('target', 10) < 5 end), }, },

                --actions.aoe+=/explosive_trap,if=dot.explosive_trap.remains<=5
                { "Explosive Trap", { "!toggle.nocleave", }, "target.ground", },

                --actions.aoe+=/a_murder_of_crows
                { "A Murder of Crows", { "target.deathin > 60", "toggle.shortcds", }, },
                { "A Murder of Crows", { "target.deathin < 12", }, },

                --actions.aoe+=/dire_beast
                { "Dire Beast", { "target.deathin > 15", }, },

                --actions.aoe+=/multishot,if=buff.thrill_of_the_hunt.react&focus>50&cast_regen<=focus.deficit|
                --             dot.serpent_sting.remains<=5|
                --             target.time_to_die<4.5
                { "Multi-Shot", { "player.buff(Thrill of the Hunt)", "player.focus > 50", "@LibHunter.SimCCRlessthanorequaltoFD()", "!toggle.nocleave", }, },
                { "Multi-Shot", { "target.debuff(Serpent Sting).duration <=5", "!toggle.nocleave", }, },
                { "Multi-Shot", { "target.deathin < 4.5", "!toggle.nocleave", }, },

                --actions.aoe+=/glaive_toss
                { "Glaive Toss", { "!toggle.nocleave", "target.deathin > 7", }, },

                --actions.aoe+=/powershot
                { "Powershot", { "!toggle.nocleave", "target.deathin > 22", }, },

                --actions.aoe+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&focus+14+cast_regen<80
                { "Cobra Shot", { "lastcast(Cobra Shot)", "player.buff(Steady Focus) < 5", "@LibHunter.SimCFplus14plusCRlessthan80()", }, },

                --actions.aoe+=/multishot,if=focus>=70|
                --             talent.focusing_shot.enabled
                { "Multi-Shot", { "player.focus >= 70", "!toggle.nocleave", }, },
                { "Multi-Shot", { "talent(7,2)", "!toggle.nocleave", }, },

                --actions.aoe+=/focusing_shot
                { "Focusing Shot", { "target.deathin > 3", }, },

                --actions.aoe+=/cobra_shot
                { "Cobra Shot", { "target.deathin > 2", }, },

            }, { "modifier.multitarget", "@LibHunter.UnitsAroundUnit('target', 10, 1)", }, },

            --actions+=/stampede,if=buff.potion.up|(cooldown.potion.remains&(buff.archmages_greater_incandescence_agi.up|
            --         trinket.stat.any.up))|
            --         target.time_to_die<=25
            { "Stampede", { "modifier.cooldowns", "@LibHunter.EvalClassification('rareelite')", "@LibHunter.SimCBuffPoitionUp(109217)", }, },
            { "Stampede", { "modifier.cooldowns", "@LibHunter.EvalClassification('rareelite')", "@LibHunter.StatProcs(2)", }, },
            { "Stampede", { "modifier.cooldowns", "@LibHunter.EvalClassification('rareelite')", "target.deathin <= 25"}, },

            --actions+=/a_murder_of_crows
            { "A Murder of Crows", { "target.deathin > 60", "toggle.shortcds", }, },
            { "A Murder of Crows", { "target.deathin < 12", }, },

            --actions+=/black_arrow,if=!ticking
            { "Black Arrow", { "player.spell(Black Arrow).cooldown = 0", "target.deathin > 12", }, },

            --actions+=/explosive_shot
            { "!Explosive Shot", { "player.buff(Lock and Load)", "!player.casting(Barrage)", }, },
            { "Explosive Shot", { "player.focus > 15", }, },

            --actions+=/dire_beast
            { "Dire Beast", { "target.deathin > 15", }, },

            --actions+=/arcane_shot,if=buff.thrill_of_the_hunt.react&focus>35&cast_regen<=focus.deficit|
            --         dot.serpent_sting.remains<=3|
            --         target.time_to_die<4.5
            { "Arcane Shot", { "player.buff(Thrill of the Hunt)", "player.focus > 35", "@LibHunter.SimCCRlessthanorequaltoFD()", }, },
            { "Arcane Shot", { "target.debuff(Serpent Sting).duration <= 3", }, },
            { "Arcane Shot", { "target.deathin < 4.5", }, },

            --actions+=/explosive_trap
            { "Explosive Trap", { "target.deathin >= 10", "!toggle.nocleave", }, "target.ground", },

            --# Cast a second shot for steady focus if that won't cap us.
            --actions+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&(14+cast_regen)<=focus.deficit
            { "Cobra Shot", { "lastcast(Cobra Shot)", "player.buff(Steady Focus) < 5", "@LibHunter.SimCSV14plusCSCRlessthanorequaltoFD()", }, },

            --actions+=/arcane_shot,if=focus>=80|talent.focusing_shot.enabled
            { "Arcane Shot", { "player.focus >= 80", }, },
            { "Arcane Shot", { "talent(7,2)", }, },

            --actions+=/focusing_shot
            { "Focusing Shot", { "target.deathin > 3", }, },

            --actions+=/cobra_shot
            { "Cobra Shot", { "target.deathin > 2", }, },

        }, { "target.alive", },
    },
},




















-- OUT OF COMBAT
{
    { "pause", { "modifier.lshift", }, },
    { "pause", "player.buff(Feign Death)", },
    { "pause", "player.buff(Food)", },

    { "Dismiss Pet", { "pet.exists", "talent(7,3)", }, },
    { "Revive Pet", { "pet.dead", "!talent(7,3)", }, },

    { "Explosive Trap", "@LibHunter.CheckHunterQueue(82939)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Explosive Trap", "@LibHunter.CheckHunterQueue(13813)", "!player.buff(Trap Launcher)", },
    { "Freezing Trap", "@LibHunter.CheckHunterQueue(60192)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Freezing Trap", "@LibHunter.CheckHunterQueue(60192)", "!player.buff(Trap Launcher)", },
    { "Ice Trap", "@LibHunter.CheckHunterQueue(82941)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Ice Trap", "@LibHunter.CheckHunterQueue(82941)", "!player.buff(Trap Launcher)", },
    { "Binding Shot", "@LibHunter.CheckHunterQueue(109248)", "mouseover.ground", },
    { "Flare", "@LibHunter.CheckHunterQueue(1543)", "mouseover.ground", },

    { "A Murder of Crows", "@LibHunter.CheckHunterQueue(131894)", },
    { "Aspect of the Fox", "@LibHunter.CheckHunterQueue(172106)", },
    { "Barrage", "@LibHunter.CheckHunterQueue(120360)", },
    { "Camouflage", "@LibHunter.CheckHunterQueue(51753)", },
    { "Concussive Shot", "@LibHunter.CheckHunterQueue(5116)", },
    { "Counter Shot", "@LibHunter.CheckHunterQueue(147362)", },
    { "Deterrence", "@LibHunter.CheckHunterQueue(148467)", },
    { "Distracting Shot", "@LibHunter.CheckHunterQueue(20736)", },
    { "!Feign Death", "@LibHunter.CheckHunterQueue(5384)", },
    { "Flare", "@LibHunter.CheckHunterQueue(1543)", },
    { "Focusing Shot", "@LibHunter.CheckHunterQueue(152245)", },
    { "Glaive Toss", "@LibHunter.CheckHunterQueue(117050)", },
    { "Intimidation", "@LibHunter.CheckHunterQueue(19577)", },
    { "Master's Call", "@LibHunter.CheckHunterQueue(53271)", },
    { "Multi-Shot", "@LibHunter.CheckHunterQueue(2643)", },
    { "Powershot", "@LibHunter.CheckHunterQueue(109259)", },
    { "Stampede", "@LibHunter.CheckHunterQueue(121818)", },
    { "Tranquilizing Shot", "@LibHunter.CheckHunterQueue(19801)", },
    { "Wyvern Sting", "@LibHunter.CheckHunterQueue(19386)", },
    { "/stopcasting\n/stopcasting\n/hunterjump", { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },
    --{ "/stopcasting\n/stopcasting\n/hackintehunterjump", { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },

    { "Arcane Shot", "@LibHunter.CheckHunterQueue(3044)", },
    { "Black Arrow", "@LibHunter.CheckHunterQueue(3674)", },
    { "Explosive Shot", "@LibHunter.CheckHunterQueue(53301)", },

    { "Camouflage", { "toggle.pvpmode", "player.glyph(Glyph of Camouflage)", "!player.buff(Camouflage)", "!player.debuff(Orb of Power)", }, },
    { "Fetch", { "modifier.lcontrol", "!lastcast(Fetch)", "!player.moving", "pet.exists", "timeout(timerFetch, 1)", }, },
    { "Trap Launcher", { "!player.buff(Trap Launcher)", }, },
},





-- CUSTOM CODE RUN ONCE
function()
    ProbablyEngine.toggle.create(
        'autoamoc',
        'Interface\\Icons\\ability_hunter_murderofcrows',
        'Auto AMoC',
        'Automatically target the lowest health enemy and cast AMoC on that target.'
    )
    ProbablyEngine.toggle.create(
        'autotarget',
        'Interface\\Icons\\ability_hunter_snipershot',
        'Auto Target',
        'Automatically target the nearest enemy when target dies or does not exist'
    )
    ProbablyEngine.toggle.create(
        'consumables',
        'Interface\\Icons\\inv_alchemy_endlessflask_06',
        'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..'
    )
    ProbablyEngine.toggle.create(
        'defensives',
        'Interface\\Icons\\Ability_warrior_defensivestance',
        'Defensive Abilities', 'Toggle the usage of defensive abilities.'
    )
    ProbablyEngine.toggle.create(
        'md',
        'Interface\\Icons\\ability_hunter_misdirection',
        'Misdirect', 'Auto Misdirect to Focus or Pet'
    )
    ProbablyEngine.toggle.create(
        'nocleave',
        'Interface\\Icons\\Warrior_talent_icon_mastercleaver',
        'No Cleave', 'Do not use any cleave/aoe abilities'
    )
    ProbablyEngine.toggle.create(
        'petmgmt',
        'Interface\\Icons\\Ability_hunter_beasttraining',
        'Pet Management', 'Pet auto Attack/Heal/Revive'
    )
    ProbablyEngine.toggle.create(
        'pvpmode',
        'Interface\\Icons\\Trade_archaeology_troll_voodoodoll',
        'Enable PvP', 'Toggle the usage of PvP abilities'
    )
    ProbablyEngine.toggle.create(
        'ss',
        'Interface\\Icons\\ability_hunter_quickshot',
        'Mouseover Arcane Shot',
        'Automatically apply Arcane Shot to mouseover units while in combat'
    )
    ProbablyEngine.toggle.create(
        'shortcds',
        'Interface\\Icons\\Achievement_bg_grab_cap_flagunderxseconds',
        'ShortCDs', 'Use short Cooldowns'
    )

    BaseStats()

    C_Timer.NewTicker(0.1, (function()
        -- Out of Combat Timer Functions
        BaseStatsUpdate()

        -- In Combat Timer Functions
        if ProbablyEngine.config.read('button_states', 'MasterToggle', false)
            and ProbablyEngine.config.read('button_states', 'autotarget', false)
            and ProbablyEngine.module.player.combat
        then
            DEBUG(5, "Survival.lua:C_Timer.NewTicker()")
            CacheUnits()
            --DotCastCheck("Serpent Sting", 1, 40)
            AutoTarget()
        end
    end), nil)
end
)