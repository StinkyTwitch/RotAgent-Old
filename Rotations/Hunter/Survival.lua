-- ProbablyEngine Rotation Packager
-- Created on Nov 1st 2014 8:14 pm
ProbablyEngine.rotation.register_custom(255, "Rotation Agent - Survival",
-- COMBAT
{
    --[[--------------------------------------------------------------------------------------------
    PAUSE
      * Rotation will stop if Left Shift is held down, Feign Death is up or the player is eating or
        is mounted. This will additionally recall your pet to prevent any outgoing DPS.
    ----------------------------------------------------------------------------------------------]]
    { "/stopcasting\n/stopcasting\n/stopattack\n/petfollow", { "@LibHunter.ImmuneTargetCheck('target')", }, },
    { "/stopcasting\n/stopattack\n/petfollow", { "modifier.lshift", }, },
    { "/stopcasting\n/stopattack\n/petfollow", { "lastcast(Feign Death)", }, },
    { "/stopattack\n/petfollow", { "player.buff(Food)", }, },










    --[[--------------------------------------------------------------------------------------------
    POOL FOCUS
      * Holding Left Control will cause the rotation to only cast Steady Shot to pool focus.
      * Cast Steady Shot if Rapid Fire is coming off of Cooldown and we are not focus capped.
    ----------------------------------------------------------------------------------------------]]
    { "Steady Shot", { "modifier.lcontrol", "!talent(7,2)", }, },
    { "Focusing Shot", { "modifier.lcontrol", "talent(7,2)", }, },










    --[[--------------------------------------------------------------------------------------------
    MAINTENANCE
      * Prevent wasting time/cast on an Aimed Shot that can not complete because we lost Thrill of
        the Hunt mid cast and we don't have enough focus now.
    ----------------------------------------------------------------------------------------------]]











    --[[--------------------------------------------------------------------------------------------
    AUTOTARGET
      * Will automatically target nearest enemy. If you accidentally select a friendly target it
        clears your selection and reselects the nearest enemy. To override this press and hold Right
        Control.
    ----------------------------------------------------------------------------------------------]]
    {{
        { "/cleartarget", { "@LibHunter.ClearCurrentTarget()", "!modifier.rcontrol" }, },
    }, "toggle.autotarget", },









    --[[--------------------------------------------------------------------------------------------
    SPELL QUEUE

    ----------------------------------------------------------------------------------------------]]
    { "Explosive Trap", "@LibHunter.CheckHunterQueue(82939)", "mouseover.ground", },
    { "Freezing Trap", "@LibHunter.CheckHunterQueue(60192)", "mouseover.ground", },
    { "Ice Trap", "@LibHunter.CheckHunterQueue(82941)", "mouseover.ground", },
    { "Binding Shot", "@LibHunter.CheckHunterQueue(109248)", "mouseover.ground", },
    { "Flare", "@LibHunter.CheckHunterQueue(1543)", "mouseover.ground", },

    { "A Murder of Crows", "@LibHunter.CheckHunterQueue(131894)", },
    { "Aspect of the Fox", "@LibHunter.CheckHunterQueue(172106)", },
    { "Barrage", "@LibHunter.CheckHunterQueue(120360)", },
    { "Concussive Shot", "@LibHunter.CheckHunterQueue(5116)", },
    { "!Feign Death", "@LibHunter.CheckHunterQueue(5384)", },
    { "Glaive Toss", "@LibHunter.CheckHunterQueue(117050)", },
    { "Intimidation", "@LibHunter.CheckHunterQueue(19577)", },
    { "Multi-Shot", "@LibHunter.CheckHunterQueue(2643)", },
    { "Stampede", "@LibHunter.CheckHunterQueue(121818)", },
    { "Wyvern Sting", "@LibHunter.CheckHunterQueue(19386)", },
    { "/stopcasting\n/stopcasting\n/hunterjump", { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },










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
        { "Deterrence", { "player.health < 10", }, },
        { "Master's Call", { "pet.exists", "player.state.disorient", }, },
        { "Master's Call", { "pet.exists", "player.state.stun", }, },
        { "Master's Call", { "pet.exists", "player.state.root", }, },
        { "Master's Call", { "pet.exists", "player.state.snare", "!player.buff(Daze)", }, },
    }, "toggle.defensives", },










    --[[--------------------------------------------------------------------------------------------
    PVP MODE
      * If target is moving use concussive shot
      * Tranq Shot on any dispellable buff
    ----------------------------------------------------------------------------------------------]]
    {{
        { "Concussive Shot", { "target.moving", "!target.immune.snare", }, },
        { "Tranquilizing Shot", { "target.dispellable", }, "target", },
    }, "toggle.pvpmode", },










    --[[--------------------------------------------------------------------------------------------
    SURVIVAL OPENER

    ----------------------------------------------------------------------------------------------]]
    {{
        { "#trinket1", { "modifier.cooldowns", }, },
        { "#trinket2", { "modifier.cooldowns", }, },
        { "Blood Fury", { "modifier.cooldowns", }, },
        { "A Murder of Crows", { "modifier.cooldowns", }, },
        { "Explosive Shot", },
        { "Black Arrow", },
        { "Arcane Shot", },
    }, {"@LibHunter.UseOpenerCheck('rareelite', 4)", }, },




















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
            { "#76089", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "player.spell(Stampede).cooldown < 1", "@LibHunter.StatProcs(2)", }, },
            { "#76089", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "player.spell(A Murder of Crows).cooldown < 1", "@LibHunter.StatProcs(2)", }, },
            { "#76089", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "player.buff(Archmage's Greater Incandescence)", }, },
            { "#76089", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "target.deathin <= 25", }, },

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
                { "Barrage", },

                --actions.aoe+=/black_arrow,if=!ticking
                { "Black Arrow", { "player.spell(Black Arrow).cooldown = 0", }, },

                --actions.aoe+=/explosive_shot,if=active_enemies<5
                { "Explosive Shot", { "target.area(10).enemies <5", }, },

                --actions.aoe+=/explosive_trap,if=dot.explosive_trap.remains<=5
                { "Explosive Trap", nil, "target.ground", },

                --actions.aoe+=/a_murder_of_crows
                { "A Murder of Crows", { "target.deathin > 60", "toggle.shortcds", }, },
                { "A Murder of Crows", { "target.deathin < 12", }, },

                --actions.aoe+=/dire_beast
                { "Dire Beast", },

                --actions.aoe+=/multishot,if=buff.thrill_of_the_hunt.react&focus>50&cast_regen<=focus.deficit|
                --             dot.serpent_sting.remains<=5|
                --             target.time_to_die<4.5
                { "Multi-Shot", { "player.buff(Thrill of the Hunt)", "player.focus > 50", "@LibHunter.SimCCRlessthanorequaltoFD()" }, },
                { "Multi-Shot", { "target.debuff(Serpent Sting).duration <=5", }, },
                { "Multi-Shot", { "target.deathin < 4.5", }, },

                --actions.aoe+=/glaive_toss
                { "Glaive Toss", },

                --actions.aoe+=/powershot
                { "Powershot", },

                --actions.aoe+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&focus+14+cast_regen<80
                { "Cobra Shot", { "lastcast(Cobra Shot)", "player.buff(Steady Focus) < 5", "@LibHunter.SimCFplus14plusCRlessthan80()", }, },

                --actions.aoe+=/multishot,if=focus>=70|
                --             talent.focusing_shot.enabled
                { "Multi-Shot", { "player.focus >= 70", }, },
                { "Multi-Shot", { "talent(7,2)", }, },

                --actions.aoe+=/focusing_shot
                { "Focusing Shot", },

                --actions.aoe+=/cobra_shot
                { "Cobra Shot", },

            }, "modifier.multitarget", },

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
            { "Black Arrow", { "player.spell(Black Arrow).cooldown = 0", }, },

            --actions+=/explosive_shot
            { "Explosive Shot", },

            --actions+=/dire_beast
            { "Dire Beast", },

            --actions+=/arcane_shot,if=buff.thrill_of_the_hunt.react&focus>35&cast_regen<=focus.deficit|
            --         dot.serpent_sting.remains<=3|
            --         target.time_to_die<4.5
            { "Arcane Shot", { "player.buff(Thrill of the Hunt)", "player.focus > 35", "@LibHunter.SimCCRlessthanorequaltoFD()", }, },
            { "Arcane Shot", { "target.debuff(Serpent Sting).duration <= 3", }, },
            { "Arcane Shot", { "target.deathin < 4.5", }, },

            --actions+=/explosive_trap
            { "Explosive Trap", { "target.deathin >= 10", }, "target.ground", },

            --# Cast a second shot for steady focus if that won't cap us.
            --actions+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&(14+cast_regen)<=focus.deficit
            { "Cobra Shot", { "lastcast(Cobra Shot)", "player.buff(Steady Focus) < 5", "@LibHunter.SimC14plusCRlessthanorequaltoFD()", }, },

            --actions+=/arcane_shot,if=focus>=80|talent.focusing_shot.enabled
            { "Arcane Shot", {"player.focus >= 80", }, },
            { "Arcane Shot", {"talent(7,2)", }, },

            --actions+=/focusing_shot
            { "Focusing Shot", },

            --actions+=/cobra_shot
            { "Cobra Shot", },

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

    { "Explosive Trap", "@LibHunter.CheckHunterQueue(82939)", "mouseover.ground", },
    { "Freezing Trap", "@LibHunter.CheckHunterQueue(60192)", "mouseover.ground", },
    { "Ice Trap", "@LibHunter.CheckHunterQueue(82941)", "mouseover.ground", },
    { "Binding Shot", "@LibHunter.CheckHunterQueue(109248)", "mouseover.ground", },
    { "Flare", "@LibHunter.CheckHunterQueue(1543)", "mouseover.ground", },

    { "A Murder of Crows", "@LibHunter.CheckHunterQueue(131894)", },
    { "Aspect of the Fox", "@LibHunter.CheckHunterQueue(172106)", },
    { "Barrage", "@LibHunter.CheckHunterQueue(120360)", },
    { "Concussive Shot", "@LibHunter.CheckHunterQueue(5116)", },
    { "Feign Death", "@LibHunter.CheckHunterQueue(5384)", },
    { "Glaive Toss", "@LibHunter.CheckHunterQueue(117050)", },
    { "Intimidation", "@LibHunter.CheckHunterQueue(19577)", },
    { "Multi-Shot", "@LibHunter.CheckHunterQueue(2643)", },
    { "Stampede", "@LibHunter.CheckHunterQueue(121818)", },
    { "Wyvern Sting", "@LibHunter.CheckHunterQueue(19386)", },
    { "/stopcasting\n/stopcasting\n/hunterjump", { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },

    { "Camouflage", { "toggle.pvpmode", "player.glyph(Glyph of Camouflage)", "!player.buff(Camouflage)", "!player.debuff(Orb of Power)", }, },
    { "Fetch", { "modifier.lcontrol", "!lastcast", "!player.moving", "pet.exists", "timeout(timerFetch, 1)", }, },
    { "Trap Launcher", { "!player.buff(Trap Launcher)", }, },
},





-- CUSTOM CODE RUN ONCE
function()
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
        'shortcds',
        'Interface\\Icons\\Achievement_bg_grab_cap_flagunderxseconds',
        'ShortCDs', 'Use short Cooldowns'
    )

    BaseStats()

    C_Timer.NewTicker(0.1, (function()
        if ProbablyEngine.config.read('button_states', 'MasterToggle', false)
            and ProbablyEngine.config.read('button_states', 'autotarget', false)
            and ProbablyEngine.module.player.combat
        then
            DEBUG(5, "Survival.lua:C_Timer.NewTicker()")
            CacheUnits()
            AutoTarget()
        end
    end), nil)
end
)