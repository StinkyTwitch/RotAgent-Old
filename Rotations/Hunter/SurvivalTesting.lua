
local spell = {
    -- CORE
    ArcaneShot = "3044",
    AspectoftheCheetah = "5118",
    AspectoftheFox = "172106",
    AspectofthePack = "13159",
    AutoShot = "75",
    CallPet1 = "883",
    CallPet2 = "83242",
    CallPet3 = "83243",
    CallPet4 = "83244",
    CallPet5 = "83245",
    Camouflage = "51753",
    Deterrence = "148467",
    ConcussiveShot = "5116",
    CounterShot = "147362",
    DismissPet = "2641",
    Disengage = "781",
    DistractingShot = "20736",
    EagleEye = "6197",
    ExplosiveTrap1 = "13813",
    ExplosiveTrap2 = "82939",
    FeedPet = "6991",
    FeignDeath = "5384",
    Flare = "1543",
    FreezingTrap1 = "1499",
    FreezingTrap2 = "60192",
    IceTrap1 = "13809",
    IceTrap2 = "82941",
    MastersCall = "53271",
    MendPet = "136",
    Misdirection = "34477",
    MultiShot = "2643",
    RevivePet = "982",
    TrapLauncher = "77769",
    TranquilizingShot = "19801",
    -- GLYPHS
    Fetch = "125050",
    Fireworks = "127933",
    --SnakeTrap = "",
    -- SURVIVAL
    BlackArrow = "3674",
    CobraShot = "77767",
    ExplosiveShot = "53301",
    ExplosiveShotNow = "!53301",
    -- TALENTS
    AMurderofCrows = "131894",
    Barrage = "120360",
    BindingShot  = "109248",
    DireBeast = "120679",
    Exhilaration = "109304",
    FocusingShot = "152245",
    GlaiveToss = "117050",
    Intimidation = "19577",
    Powershot = "109259",
    Stampede = "121818",
    WyvernSting = "19386",
    -- RACIALS
    ArcaneTorrent = "80483",
    BloodFury = "20572",
    Berserking = "26297",
    -- OBJECTS
    AgilityPotion = "#109217",
    HealthStone = "#5512",
    Trinket1 = "#trinket1",
    Trinket2 = "#trinket2",
}
local pause = {
    { "/stopcasting\n/stopcasting\n/stopattack\n/petfollow", { "pet.exists", "@LibHunter.ImmuneTargetCheck(1, 'target')", }, },
    { "/stopcasting\n/stopcasting\n/stopattack", { "!pet.exists", "@LibHunter.ImmuneTargetCheck(1, 'target')", }, },
    { "/stopcasting\n/stopattack\n/petfollow", { "pet.exists", "modifier.lshift", }, },
    { "/stopcasting\n/stopattack", { "!pet.exists", "modifier.lshift", }, },
    { "/stopcasting\n/stopattack\n/petfollow", { "pet.exists", "lastcast(Feign Death)", }, },
    { "/stopcasting\n/stopattack", { "!pet.exists", "lastcast(Feign Death)", }, },
    { "/stopattack\n/petfollow", { "player.buff(Food)", }, },
}
local spellqueue = {
    -- HUNTER TRAPS/GROUND
    { "Explosive Trap", "@LibHunter.CheckHunterQueue(82939)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Explosive Trap", "@LibHunter.CheckHunterQueue(13813)", "!player.buff(Trap Launcher)", },
    { "Freezing Trap", "@LibHunter.CheckHunterQueue(60192)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Freezing Trap", "@LibHunter.CheckHunterQueue(60192)", "!player.buff(Trap Launcher)", },
    { "Ice Trap", "@LibHunter.CheckHunterQueue(82941)", "mouseover.ground", "player.buff(Trap Launcher)", },
    { "Ice Trap", "@LibHunter.CheckHunterQueue(82941)", "!player.buff(Trap Launcher)", },
    { "Binding Shot", "@LibHunter.CheckHunterQueue(109248)", "mouseover.ground", },
    { "Flare", "@LibHunter.CheckHunterQueue(1543)", "mouseover.ground", },
    -- HUNTER GENERAL
    { "A Murder of Crows", "@LibHunter.CheckHunterQueue(131894)", },
    { "Arcane Shot", "@LibHunter.CheckHunterQueue(3044)", },
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
    -- HUNTER SURVIVAL
    { "Black Arrow", "@LibHunter.CheckHunterQueue(3674)", },
    { "Explosive Shot", "@LibHunter.CheckHunterQueue(53301)", },
}
local petmanagement = {
    { "Misdirection", { "pet.exists", "!pet.dead", "!pet.buff(Misdirection)", "!focus.exists", }, "pet", },
    { "Heart of the Phoenix", { "!talent(7,3)", "pet.dead", }, },
    { "Revive Pet", { "!talent(7,3)", "pet.dead", }, },
    { "Mend Pet", { "pet.exists", "!pet.dead", "!pet.buff(Mend Pet)", "pet.health <= 90", }, "pet", },
    { "/petattack", { "pet.exists", "timeout(petAttack, 1)", }, },
    { "/cast Dash", { "pet.exists", "@LibHunter.UnitToUnitDistanceCheck('pet', 'target', 15)", "timeout(petDash, 2)", }, },
}
local defensive = {
    { spell.HealthStone, { "player.health < 40", }, },
    { spell.Deterrence, { "player.health <= 10", }, },
    { spell.Exhilaration, { "player.health < 50", }, },
    { spell.MastersCall, { "pet.exists", "player.state.disorient", }, },
    { spell.MastersCall, { "pet.exists", "player.state.stun", }, },
    { spell.MastersCall, { "pet.exists", "player.state.root", }, },
    { spell.MastersCall, { "pet.exists", "player.state.snare", "!player.debuff(Dazed)", }, },
}
local interrupts = {
    { spell.CounterShot, { "target.interruptAt(50)", "modifier.interrupts" }, "target", },
    { spell.Intimidation, { "target.interruptAt(50)", "modifier.interrupts" }, "target", },
}
local mouseovers = {
    -- CC TRAP
    { spell.FreezingTrap1, { "!player.buff(Trap Launcher)", "modifier.lcontrol", }, },
    { spell.FreezingTrap2, { "player.buff(Trap Launcher)", "modifier.lcontrol", }, "mouseover.ground", },
    -- SERPENT STING (checks: No Debuff, Not Immune, Enemies Around Target)
    { spell.MultiShot, { "toggle.ss", "!modifier.lcontrol", "modifier.multitarget", "!mouseover.debuff(Serpent Sting)", "@LibHunter.NotImmuneTargetCheck(2, 'mouseover')", "@LibHunter.UnitsAroundUnit('mouseover', 8, 2)", }, "mouseover", },
    { spell.ArcaneShot, { "toggle.ss", "!modifier.lcontrol", "!mouseover.debuff(Serpent Sting)", "@LibHunter.NotImmuneTargetCheck(2, 'mouseover')", "!@LibHunter.UnitsAroundUnit('mouseover', 8, 1)", }, "mouseover", },
    -- FORCE SERPENT STING
    { spell.MultiShot, { "toggle.ss", "modifier.lalt", "modifier.multitarget", "!mouseover.debuff(Serpent Sting)", "@LibHunter.UnitsAroundUnit('mouseover', 8, 2)", }, "mouseover", },
    { spell.ArcaneShot, { "toggle.ss", "modifier.lalt", "!mouseover.debuff(Serpent Sting)", "!@LibHunter.UnitsAroundUnit('mouseover', 8, 1)", }, "mouseover", },
}
local misdirect = {
    { spell.Misdirection, { "focus.exists", "!focus.dead", "!focus.buff(Misdirection)", "modifier.ralt", }, "focus", },
    { spell.Misdirection, { "focus.exists", "!focus.dead", "!focus.buff(Misdirection)", "player.threat > 50", }, "focus", },
}
local ooc = {
    { "pause", { "modifier.lshift", }, },
    { "pause", "player.buff(Feign Death)", },
    { "pause", "player.buff(Food)", },

    { "Dismiss Pet", { "pet.exists", "talent(7,3)", }, },
    { "Revive Pet", { "pet.dead", "!talent(7,3)", }, },

    { "Camouflage", { "toggle.pvpmode", "player.glyph(Glyph of Camouflage)", "!player.buff(Camouflage)", "!player.debuff(Orb of Power)", }, },
    { "Fetch", { "modifier.lcontrol", "!lastcast(Fetch)", "!player.moving", "pet.exists", "timeout(timerFetch, 1)", }, },
    { "Trap Launcher", { "!player.buff(Trap Launcher)", }, },
}
local opener = {
    { "#trinket1", { "modifier.cooldowns", }, },
    { "#trinket2", { "modifier.cooldowns", }, },
    { spell.BloodFury, { "modifier.cooldowns", }, },
    { spell.AMurderofCrows, { "modifier.cooldowns", }, },
    { spell.BlackArrow, },
    { spell.ArcaneShot, { "player.buff(Thrill of the Hunt)", "player.buff(Balanced Fate)", }, },
    { spell.ExplosiveShot, { "!player.buff(Thrill of the Hunt)", }, },
    { spell.ArcaneShot, { "!target.debuff(Serpent Sting)", }, },
    { spell.Berserking, { "modifier.cooldowns", }, },
}
local azor_singletarget = {
    { spell.ArcaneTorrent, { "modifier.cooldowns", }, },
    { spell.BloodFury, { "modifier.cooldowns", }, },
    { spell.Berserking, { "modifier.cooldowns", }, },

    { spell.BlackArrow, { "!target.debuff(Black Arrow)", "player.spell(Black Arrow).cooldown = 0", }, },
    { spell.ArcaneShot, { "!target.debuff(Serpent Sting)", }, },
    { spell.ExplosiveShot, { "player.buff(Lock and Load)", }, },
    { spell.ArcaneShot, { "player.buff(Thrill of the Hunt)", "player.buff(Balanced Fate)", }, },
    { spell.ExplosiveShot, },
    { spell.AMurderofCrows, { "target.deathin > 60", "toggle.shortcds", }, },
    { spell.AMurderofCrows, { "target.deathin < 12", }, },
    { spell.ArcaneShot, { "player.focus > 10", "player.buff(Thrill of the Hunt)", }, },
    { spell.ExplosiveTrap1, { "player.moving", "!player.buff(Trap Launcher)", "target.deathin >= 7", "!toggle.nocleave", }, },
    { spell.ExplosiveTrap2, { "player.moving", "player.buff(Trap Launcher)", "target.deathin >= 7", "!toggle.nocleave", }, "target.ground", },
    { spell.ArcaneShot, { "player.focus > 30", }, },
    { spell.FocusingShot, { "player.focus < 50", }, },
    { spell.CobraShot, { "player.focus < 86", "!talent(7,2)", }, },
}
local azor_multitarget = {
    { spell.ArcaneTorrent, { "modifier.cooldowns", }, },
    { spell.BloodFury, { "modifier.cooldowns", }, },
    { spell.Berserking, { "modifier.cooldowns", }, },

    { spell.BlackArrow, { "!target.debuff(Black Arrow)", "player.spell(Black Arrow).cooldown = 0", }, },
    { spell.ArcaneShot, { "!target.debuff(Serpent Sting)", "target.area(8).enemies > 1", "target.area(8).enemies <= 2", }, },
    { spell.MultiShot, { "!target.debuff(Serpent Sting)", "target.area(8).enemies > 2", }, },
    { spell.Barrage, },
    { spell.ExplosiveShot, { "player.buff(Lock and Load)", }, },
    { spell.ArcaneShot, { "player.buff(Thrill of the Hunt)", "player.buff(Balanced Fate)", }, },
    { spell.ExplosiveShot, },
    { spell.ExplosiveTrap1, { "!player.buff(Trap Launcher)", "target.deathin >= 7", }, },
    { spell.ExplosiveTrap2, { "player.buff(Trap Launcher)", "target.deathin >= 7", }, "target.ground", },
    { spell.AMurderofCrows, { "target.deathin > 60", "toggle.shortcds", }, },
    { spell.AMurderofCrows, { "target.deathin < 12", }, },
    { spell.ArcaneShot, { "player.focus > 10", "player.buff(Thrill of the Hunt)", }, },
    { spell.Barrage, { "!player.buff(Thrill of the Hunt)", "!player.buff(Balanced Fate)", },},
    { spell.ArcaneShot, { "player.focus > 30", }, },
    { spell.FocusingShot, { "player.focus < 50", }, },
    { spell.CobraShot, { "player.focus < 86", }, },
}
local simc = {
    --actions=auto_shot
    --actions+=/use_items
    { spell.Trinket1, { "modifier.cooldowns", }, },
    { spell.Trinket2, { "modifier.cooldowns", }, },

    --actions+=/arcane_torrent,if=focus.deficit>=30
    { spell.ArcaneShot, { "modifier.cooldowns", "target.deathin > 20", "player.focus <= 70", }, },

    --actions+=/blood_fury
    { spell.BloodFury, { "modifier.cooldowns", "target.deathin > 20", }, },

    --actions+=/berserking
    { spell.Berserking, { "modifier.cooldowns", "target.deathin > 20", }, },

    --actions+=/potion,name=draenic_agility,if=(((cooldown.stampede.remains<1)&(cooldown.a_murder_of_crows.remains<1))&(trinket.stat.any.up|
    --         buff.archmages_greater_incandescence_agi.up))|
    --         target.time_to_die<=25
    { spell.AgilityPotion, { "toggle.consumables", "player.spell(Stampede).cooldown < 1", "@LibHunter.StatProcs(2)", }, },
    { spell.AgilityPotion, { "toggle.consumables", "player.spell(A Murder of Crows).cooldown < 1", "@LibHunter.StatProcs(2)", }, },
    { spell.AgilityPotion, { "toggle.consumables", "player.spell(Stampede).cooldown < 1", "player.buff(Archmage's Greater Incandescence)", }, },
    { spell.AgilityPotion, { "toggle.consumables", "player.spell(A Murder of Crows).cooldown < 1", "player.buff(Archmage's Greater Incandescence)", }, },
    { spell.AgilityPotion, { "toggle.consumables", "target.deathin <= 25", }, },

    --actions+=/call_action_list,name=aoe,if=active_enemies>1
    {{
        --actions.aoe=stampede,if=buff.potion.up|
        --            (cooldown.potion.remains&(buff.archmages_greater_incandescence_agi.up|
        --            trinket.stat.any.up|
        --            buff.archmages_incandescence_agi.up))
        { spell.Stampede, { "modifier.cooldowns", "@LibHunter.SimCBuffPoitionUp(109217)", }, },
        { spell.Stampede, { "modifier.cooldowns", "player.buff(Archmage's Greater Incandescence)", }, },
        { spell.Stampede, { "modifier.cooldowns", "@LibHunter.StatProcs(2)", }, },

        --actions.aoe+=/explosive_shot,if=buff.lock_and_load.react&(!talent.barrage.enabled|cooldown.barrage.remains>0)
        { spell.ExplosiveShotNow, { "!player.casting(Focusing Shot)", "!player.casting(Barrage)", "player.buff(Lock and Load)", "!talent(6,3)", }, },
        { spell.ExplosiveShotNow, { "!player.casting(Focusing Shot)", "!player.casting(Barrage)", "player.buff(Lock and Load)", "player.spell(Barrage).cooldown > 0", }, },

        --actions.aoe+=/barrage
        { spell.Barrage, { "!toggle.nocleave", }, },

        --actions.aoe+=/black_arrow,if=!ticking
        { spell.BlackArrow, { "player.spell(Black Arrow).cooldown = 0", "target.deathin > 12", }, },

        --actions.aoe+=/explosive_shot,if=active_enemies<5
        { spell.ExplosiveShotNow, { "!player.casting(Barrage)", "target.area(10).enemies < 5", }, },

        --actions.aoe+=/explosive_trap,if=dot.explosive_trap.remains<=5
        { spell.ExplosiveTrap1, { "!player.buff(Trap Launcher)", }, },
        { spell.ExplosiveTrap2, { "player.buff(Trap Launcher)", }, "target.ground", },

        --actions.aoe+=/a_murder_of_crows
        { spell.AMurderofCrows, { "modifier.cooldowns", "target.deathin > 60", }, },
        { spell.AMurderofCrows, { "target.deathin < 12", }, },

        --actions.aoe+=/dire_beast
        { spell.DireBeast, { "target.deathin > 15", }, },

        --actions.aoe+=/multishot,if=buff.thrill_of_the_hunt.react&focus>50&cast_regen<=focus.deficit|
        --             dot.serpent_sting.remains<=5|
        --             target.time_to_die<4.5
        { spell.MultiShot, { "player.buff(Thrill of the Hunt)", "player.focus > 50", "@LibHunter.SimCCRlessthanorequaltoFD()", }, },
        { spell.MultiShot, { "target.debuff(Serpent Sting).duration <= 5", }, },
        { spell.MultiShot, { "target.deathin < 4.5", }, },

        --actions.aoe+=/glaive_toss
        { spell.GlaiveToss, { "target.deathin > 7", }, },

        --actions.aoe+=/powershot
        { spell.Powershot, { "target.deathin > 22", }, },

        --actions.aoe+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&focus+14+cast_regen<80
        { spell.CobraShot, { "lastcast(Cobra Shot)", "player.buff(Steady Focus) < 5", "@LibHunter.SimCFplus14plusCRlessthan80()", }, },

        --actions.aoe+=/multishot,if=focus>=70|
        --             talent.focusing_shot.enabled
        { spell.MultiShot, { "player.focus >= 70", }, },
        { spell.MultiShot, { "talent(7,2)", }, },

        --actions.aoe+=/focusing_shot
        { spell.FocusingShot, { "target.deathin > 3", }, },

        --actions.aoe+=/cobra_shot
        { spell.CobraShot, { "target.deathin > 2", }, },

    }, { "modifier.multitarget", "target.area(8).enemies > 1", }, },

    --actions+=/stampede,if=buff.potion.up|(cooldown.potion.remains&(buff.archmages_greater_incandescence_agi.up|
    --         trinket.stat.any.up))|
    --         target.time_to_die<=25
    { spell.Stampede, { "modifier.cooldowns", "player.buff(Draenic Agility Potion)", }, },
    { spell.Stampede, { "modifier.cooldowns", "player.buff(Archmage's Greater Incandescence)", }, },
    { spell.Stampede, { "modifier.cooldowns", "@LibHunter.StatProcs(2)", }, },
    { spell.Stampede, { "modifier.cooldowns", "target.deathin <= 25", }, },

    --actions+=/a_murder_of_crows
    { spell.AMurderofCrows, { "target.deathin > 60", "toggle.shortcds", }, },
    { spell.AMurderofCrows, { "target.deathin < 12", }, },

    --actions+=/black_arrow,if=!ticking
    { spell.BlackArrow, { "player.spell(Black Arrow).cooldown = 0", "target.deathin > 12", }, },

    --actions+=/explosive_shot
    { spell.ExplosiveShotNow, { "!player.casting(Focusing Shot)", "!player.casting(Barrage)", }, },

    --actions+=/dire_beast
    { spell.DireBeast, { "target.deathin > 15", }, },

    --actions+=/arcane_shot,if=buff.thrill_of_the_hunt.react&focus>35&cast_regen<=focus.deficit|
    --         dot.serpent_sting.remains<=3|
    --         target.time_to_die<4.5
    { spell.ArcaneShot, { "player.buff(Thrill of the Hunt)", "player.focus > 35", "@LibHunter.SimCCRlessthanorequaltoFD()", }, },
    { spell.ArcaneShot, { "target.debuff(Serpent Sting).duration <= 3", }, },
    { spell.ArcaneShot, { "target.deathin < 4.5", }, },

    --actions+=/explosive_trap
    { spell.ExplosiveTrap1, { "!player.buff(Trap Launcher)", "target.deathin >= 10", "!toggle.nocleave", }, },
    { spell.ExplosiveTrap2, { "player.buff(Trap Launcher)", "target.deathin >= 10", "!toggle.nocleave", }, "target.ground", },

    --# Cast a second shot for steady focus if that won't cap us.
    --actions+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&(14+cast_regen)<=focus.deficit
    { spell.CobraShot, { "lastcast(Cobra Shot)", "player.buff(Steady Focus) < 5", "@LibHunter.SimCSV14plusCSCRlessthanorequaltoFD()", }, },

    --actions+=/arcane_shot,if=focus>=80|talent.focusing_shot.enabled
    { spell.ArcaneShot, { "player.focus >= 80", }, },
    { spell.ArcaneShot, { "talent(7,2)", }, },

    --actions+=/focusing_shot
    { spell.FocusingShot, { "target.deathin > 3", }, },

    --actions+=/cobra_shot
    { spell.CobraShot, { "target.deathin > 2", }, },
}

ProbablyEngine.rotation.register_custom(255, "Rotation Agent - Survival Testing",
{
    { "/stopcasting\n/stopcasting\n/stopattack\n/petfollow", { "@LibHunter.ImmuneTargetCheck(2, 'target')", }, },
    { "/stopcasting\n/stopattack\n/petfollow", { "modifier.lshift", }, },
    { "/stopcasting\n/stopattack\n/petfollow", { "lastcast(Feign Death)", }, },
    { "/stopattack\n/petfollow", { "player.buff(Food)", }, },

    { spellqueue, },
    { petmanagement, { "toggle.petmgmt", }, },
    { defensive, { "toggle.defensives", }, },
    { interrupts, { "modifier.interrupts", }, },
    { mouseovers, { "toggle.mouseovers", }, },

    { opener, {"@LibHunter.UseOpenerCheck('normal', 4)", }, },
    --{ azor_singletarget, { "target.area(10).enemies < 2", }, },
    --{ azor_multitarget, { "target.area(10).enemies >= 2", "modifier.multitarget", }, },
    { simc, },
},

{
    { ooc, },
    { spellqueue, },
},

function()
    ProbablyEngine.toggle.create(
        'autotarget', 'Interface\\Icons\\ability_hunter_snipershot',
        'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist'
    )
    ProbablyEngine.toggle.create(
        'consumables', 'Interface\\Icons\\inv_alchemy_endlessflask_06',
        'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..'
    )
    ProbablyEngine.toggle.create(
        'defensives', 'Interface\\Icons\\Ability_warrior_defensivestance',
        'Defensive Abilities', 'Toggle the usage of defensive abilities.'
    )
    ProbablyEngine.toggle.create(
        'md', 'Interface\\Icons\\ability_hunter_misdirection',
        'Misdirect', 'Auto Misdirect to Focus or Pet'
    )
    ProbablyEngine.toggle.create(
        'mouseovers', 'Interface\\Icons\\ability_hunter_quickshot',
        'Mouseover Serpent Sting', 'Automatically apply Arcane Shot/Multi-Shot to mouseover units while in combat'
    )
    ProbablyEngine.toggle.create(
        'nocleave', 'Interface\\Icons\\Warrior_talent_icon_mastercleaver',
        'No Cleave', 'Do not use any cleave/aoe abilities'
    )
    ProbablyEngine.toggle.create(
        'petmgmt', 'Interface\\Icons\\Ability_hunter_beasttraining',
        'Pet Management', 'Pet auto misdirect/attack/heal/revive'
    )
    ProbablyEngine.toggle.create(
        'shortcds', 'Interface\\Icons\\Achievement_bg_grab_cap_flagunderxseconds',
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
            AutoTarget()
        end
    end), nil)
end
)