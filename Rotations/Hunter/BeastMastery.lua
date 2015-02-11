
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
    FeignDeathNow = "!5384",
    Flare = "1543",
    FreezingTrap1 = "1499",
    FreezingTrap2 = "60192",
    HeartOfThePhoenix = "55709",
    IceTrap1 = "13809",
    IceTrap2 = "82941",
    MastersCall = "53271",
    MendPet = "136",
    Misdirection = "34477",
    MultiShot = "2643",
    RevivePet = "982",
    SteadyShot = "56641",
    TrapLauncher = "77769",
    TranquilizingShot = "19801",
    -- GLYPHS
    Fetch = "125050",
    Fireworks = "127933",
    SnakeTrap = "82948",
    -- BEASTMASTERY
    BestialWrath = "19574",
    CobraShot = "77767",
    FocusFire = "82692",
    KillCommand = "34026",
    KillShot = "157708",
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
    -- BUFFS
    ArchmagesIncandescence = "177161",
    ArchmagesGreaterIncandescence = "177172",
    BalancedFate = "177038",
    Dazed = "15571",
    Food = "160598",
    SerpentSting = "118253",
    SteadyFocus = "177668",
    ThrilloftheHunt = "34720",
    -- DEBUFFS
    Flamethrower = "163322",
    InfestingSpores = "163242",
}
local string = {
    -- MACROS
    ExtraActionButton = "/click ExtraActionButton1",
    HunterJump = "/stopcasting\n/stopcasting\n/hunterjump",
    Pause = "/stopcasting\n/stopcasting\n/stopattack",
    PauseIncPet = "/stopcasting\n/stopcasting\n/stopattack\n/petfollow",
    PetAttack = "/petattack",
    PetDash = "/cast Dash",
}
local defensive = {
    { spell.HealthStone, { "player.health < 40", }, },
    { spell.Deterrence, { "player.health <= 10", }, },
    { spell.Exhilaration, { "player.health < 50", }, },
    { spell.MastersCall, { "pet.exists", "player.state.disorient", }, },
    { spell.MastersCall, { "pet.exists", "player.state.stun", }, },
    { spell.MastersCall, { "pet.exists", "player.state.root", }, },
    { spell.MastersCall, { "pet.exists", "player.state.snare", "!player.debuff("..spell.Dazed..")", }, },
    -- BOSS DEBUFFS
    { string.ExtraActionButton, { "player.buff("..spell.Flamethrower..")", }, },
    { spell.FeignDeath, { "player.debuff("..spell.InfestingSpores..").count >= 6", }, },
}
local interrupts = {
    { spell.CounterShot, { "target.interruptAt(50)", "modifier.interrupts" }, "target", },
    { spell.Intimidation, { "target.interruptAt(50)", "modifier.interrupts" }, "target", },
}
local mouseovers = {
    -- CC TRAP
    { spell.FreezingTrap1, { "!player.buff("..spell.TrapLauncher..")", "modifier.lcontrol", }, },
    { spell.FreezingTrap2, { "player.buff("..spell.TrapLauncher..")", "modifier.lcontrol", }, "mouseover.ground", },
    -- SERPENT STING (checks: No Debuff, Not Immune, Enemies Around Target)
    { spell.MultiShot, { "toggle.mouseovers", "!modifier.lcontrol", "modifier.multitarget", "!mouseover.debuff("..spell.SerpentSting..")", "@LibHunter.NotImmuneTargetCheck(2, 'mouseover')", "@LibHunter.UnitsAroundUnit('mouseover', 8, 2)", }, "mouseover", },
    { spell.ArcaneShot, { "toggle.mouseovers", "!modifier.lcontrol", "!mouseover.debuff("..spell.SerpentSting..")", "@LibHunter.NotImmuneTargetCheck(2, 'mouseover')", "!@LibHunter.UnitsAroundUnit('mouseover', 8, 1)", }, "mouseover", },
    -- FORCE SERPENT STING
    { spell.MultiShot, { "toggle.mouseovers", "modifier.lalt", "modifier.multitarget", "!mouseover.debuff("..spell.SerpentSting..")", "@LibHunter.UnitsAroundUnit('mouseover', 8, 2)", }, "mouseover", },
    { spell.ArcaneShot, { "toggle.mouseovers", "modifier.lalt", "!mouseover.debuff("..spell.SerpentSting..")", "!@LibHunter.UnitsAroundUnit('mouseover', 8, 1)", }, "mouseover", },
}
local misdirect = {
    { spell.Misdirection, { "focus.exists", "!focus.dead", "!focus.buff("..spell.Misdirection..")", "modifier.ralt", }, "focus", },
    { spell.Misdirection, { "!focus.exists", "!mouseover.dead", "!mouseover.buff("..spell.Misdirection..")", "modifier.ralt", }, "mouseover", },
    { spell.Misdirection, { "focus.exists", "!focus.dead", "!focus.buff("..spell.Misdirection..")", "player.threat > 50", }, "focus", },
}
local ooc = {
    { string.Pause, { "modifier.lshift", }, },
    { string.Pause, "player.buff("..spell.FeignDeath..")", },
    { string.Pause, "player.buff("..spell.Food..")", },

    { spell.DismissPet, { "pet.exists", "talent(7,3)", }, },
    { spell.RevivePet, { "pet.dead", "!talent(7,3)", }, },

    { spell.Fetch, { "modifier.lcontrol", "!lastcast("..spell.Fetch..")", "!player.moving", "pet.exists", "timeout(timerFetch, 1)", }, },
    { spell.TrapLauncher, { "!player.buff("..spell.TrapLauncher..")", }, },
}
local pause = {
    -- IMMUNE TARGET
    { spell.PauseIncPet, { "pet.exists", "@LibHunter.ImmuneTargetCheck(1, 'target')", }, },
    { spell.Pause, { "!pet.exists", "@LibHunter.ImmuneTargetCheck(1, 'target')", }, },
    -- LEFT SHIFT PAUSE ROTATION
    { spell.PauseIncPet, { "pet.exists", "modifier.lshift", }, },
    { spell.Pause, { "!pet.exists", "modifier.lshift", }, },
    -- FEIGN DEATH PAUSE ROTATION
    { spell.PauseIncPet, { "pet.exists", "lastcast("..spell.FeignDeath..")", }, },
    { spell.Pause, { "!pet.exists", "lastcast("..spell.FeignDeath.." )", }, },
    -- PLAYER EATING/DRINKING PAUSE ROTATION
    { spell.PauseIncPet, { "player.buff("..spell.Food..")", }, },
}
local petmanagement = {
    { spell.Misdirection, { "pet.exists", "!pet.dead", "!pet.buff("..spell.Misdirection..")", "!focus.exists", }, "pet", },
    { spell.HeartOfThePhoenix, { "!talent(7,3)", "pet.dead", }, },
    { spell.RevivePet, { "!talent(7,3)", "pet.dead", }, },
    { spell.MendPet, { "pet.exists", "!pet.dead", "!pet.buff("..spell.MendPet..")", "pet.health <= 90", }, "pet", },
    { spell.PetAttack, { "pet.exists", "timeout(petAttack, 1)", }, },
    { spell.PetDash, { "pet.exists", "@LibHunter.UnitToUnitDistanceCheck('pet', 'target', 15)", "timeout(petDash, 2)", }, },
}
local poolfocus = {
    { spell.CobraShot, { "modifier.rcontrol", "!talent(7,2)", }, },
    { spell.FocusingShot, { "modifier.rcontrol", "talent(7,2)", }, },
}
local pvp = {
    { spell.ConcussiveShot, { "target.moving", "!target.immune.snare", }, },
    { spell.TranquilizingShot, { "target.dispellable("..spell.TranquilizingShot..")", }, },
}
local spellqueue = {
    -- HUNTER TRAPS/GROUND SPELLS
    { spell.ExplosiveTrap1, { "@LibHunter.CheckHunterQueue(13813)", "!player.buff("..spell.TrapLauncher..")", }, },
    { spell.ExplosiveTrap2, { "@LibHunter.CheckHunterQueue(82939)", "player.buff("..spell.TrapLauncher..")", }, "mouseover.ground", },
    { spell.FreezingTrap1, { "@LibHunter.CheckHunterQueue(60192)", "!player.buff("..spell.TrapLauncher..")", }, },
    { spell.FreezingTrap2, { "@LibHunter.CheckHunterQueue(60192)", "player.buff("..spell.TrapLauncher..")", }, "mouseover.ground", },
    { spell.IceTrap1, { "@LibHunter.CheckHunterQueue(82941)", "!player.buff("..spell.TrapLauncher..")", }, },
    { spell.IceTrap2, { "@LibHunter.CheckHunterQueue(82941)", "player.buff("..spell.TrapLauncher..")", }, "mouseover.ground", },
    { spell.BindingShot, "@LibHunter.CheckHunterQueue(109248)", "mouseover.ground", },
    { spell.Flare, "@LibHunter.CheckHunterQueue(1543)", "mouseover.ground", },
    -- HUNTER GENERAL
    { spell.AMurderofCrows, "@LibHunter.CheckHunterQueue(131894)", },
    { spell.ArcaneShot, "@LibHunter.CheckHunterQueue(3044)", },
    { spell.AspectoftheFox, "@LibHunter.CheckHunterQueue(172106)", },
    { spell.Barrage, "@LibHunter.CheckHunterQueue(120360)", },
    { spell.Camouflage, "@LibHunter.CheckHunterQueue(51753)", },
    { spell.ConcussiveShot, "@LibHunter.CheckHunterQueue(5116)", },
    { spell.CounterShot, "@LibHunter.CheckHunterQueue(147362)", },
    { spell.Deterrence, "@LibHunter.CheckHunterQueue(148467)", },
    { spell.DistractingShot, "@LibHunter.CheckHunterQueue(20736)", },
    { spell.FeignDeathNow, "@LibHunter.CheckHunterQueue(5384)", },
    { spell.Flare, "@LibHunter.CheckHunterQueue(1543)", },
    { spell.FocusingShot, "@LibHunter.CheckHunterQueue(152245)", },
    { spell.GlaiveToss, "@LibHunter.CheckHunterQueue(117050)", },
    { spell.Intimidation, "@LibHunter.CheckHunterQueue(19577)", },
    { spell.MastersCall, "@LibHunter.CheckHunterQueue(53271)", },
    { spell.MultiShot, "@LibHunter.CheckHunterQueue(2643)", },
    { spell.Powershot, "@LibHunter.CheckHunterQueue(109259)", },
    { spell.Stampede, "@LibHunter.CheckHunterQueue(121818)", },
    { spell.TranquilizingShot, "@LibHunter.CheckHunterQueue(19801)", },
    { spell.WyvernSting, "@LibHunter.CheckHunterQueue(19386)", },
    { spell.HunterJump, { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },
    -- HUNTER BEAST MASTERY
    { spell.BestialWrath, "@LibHunter.CheckHunterQueue(19574)", },
    { spell.CobraShot, "@LibHunter.CheckHunterQueue(77767)", },
    { spell.FocusFire, "@LibHunter.CheckHunterQueue(82692)", },
    { spell.KillCommand, "@LibHunter.CheckHunterQueue(34026)", },
    { spell.KillShot, "@LibHunter.CheckHunterQueue(157708)", },
}

local opener = {
}
local simc = {
}

ProbablyEngine.rotation.register_custom(253, "Rotation Agent - Beast Mastery",
{
    { string.PauseIncPet, { "@LibHunter.ImmuneTargetCheck(2, 'target')", }, },
    { string.PauseIncPet, { "modifier.lshift", }, },
    { string.PauseIncPet, { "lastcast("..spell.FeignDeath..")", }, },
    { string.PauseIncPet, { "player.buff("..spell.Food..")", }, },

    { opener, { "@LibHunter.UseOpenerCheck('normal', 4)", }, },

    { poolfocus, },
    { spellqueue, },
    { petmanagement, { "toggle.petmgmt", }, },
    { defensive, { "toggle.defensives", }, },
    { interrupts, { "modifier.interrupts", }, },
    { mouseovers, { "toggle.mouseovers", }, },
    { misdirect, { "toggle.md", }, },
    { pvp, },

    { simc, { "!@LibHunter.UseOpenerCheck('normal', 4)", }, },
},

{
    { ooc, },
    { misdirect, },
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
        'pvp', 'Interface\\Icons\\Trade_archaeology_troll_voodoodoll',
        'PvP Logic', 'Toggle the usage of basic PvP abilities'
    )

    BaseStatsInit()

    C_Timer.NewTicker(0.1, (function()
        -- Out of Combat Timer Functions
        BaseStatsUpdate()

        -- In Combat Timer Functions
        if ProbablyEngine.config.read('button_states', 'MasterToggle', false)
            and ProbablyEngine.config.read('button_states', 'autotarget', false)
            and ProbablyEngine.module.player.combat
        then
            DEBUG(5, "Beastmastery.lua:C_Timer.NewTicker()")
            CacheUnits()
            AutoTarget()
        end
    end), nil)
end
)