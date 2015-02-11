
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
    -- MARKSMANSHIP
    AimedShot = "19434",
    ChimaeraShot = "53209",
    KillShot = "157708",
    RapidFire = "3045",
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
    { string.PauseIncPet, { "pet.exists", "@LibHunter.ImmuneTargetCheck(1, 'target')", }, },
    { string.Pause, { "!pet.exists", "@LibHunter.ImmuneTargetCheck(1, 'target')", }, },
    -- LEFT SHIFT PAUSE ROTATION
    { string.PauseIncPet, { "pet.exists", "modifier.lshift", }, },
    { string.Pause, { "!pet.exists", "modifier.lshift", }, },
    -- FEIGN DEATH PAUSE ROTATION
    { string.PauseIncPet, { "pet.exists", "lastcast("..spell.FeignDeath..")", }, },
    { string.Pause, { "!pet.exists", "lastcast("..spell.FeignDeath.." )", }, },
    -- PLAYER EATING/DRINKING PAUSE ROTATION
    { string.PauseIncPet, { "player.buff("..spell.Food..")", }, },
}
local petmanagement = {
    { spell.Misdirection, { "pet.exists", "!pet.dead", "!pet.buff("..spell.Misdirection..")", "!focus.exists", }, "pet", },
    { spell.HeartOfThePhoenix, { "!talent(7,3)", "pet.dead", }, },
    { spell.RevivePet, { "!talent(7,3)", "pet.dead", }, },
    { spell.MendPet, { "pet.exists", "!pet.dead", "!pet.buff("..spell.MendPet..")", "pet.health <= 90", }, "pet", },
    { string.PetAttack, { "pet.exists", "timeout(petAttack, 1)", }, },
    { string.PetDash, { "pet.exists", "@LibHunter.UnitToUnitDistanceCheck('pet', 'target', 15)", "timeout(petDash, 2)", }, },
}
local poolfocus = {
    { spell.SteadyShot, { "modifier.rcontrol", "!talent(7,2)", }, },
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
    { string.HunterJump, { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },
    -- HUNTER MARKSMANSHIP
    { spell.AimedShot, "@LibHunter.CheckHunterQueue(19434)", },
    { spell.ChimaeraShot, "@LibHunter.CheckHunterQueue(53209)", },
    { spell.KillShot, "@LibHunter.CheckHunterQueue(157708)", },
    { spell.RapidFire, "@LibHunter.CheckHunterQueue(3045)", },
}

local opener = {
    { spell.Trinket1, { "modifier.cooldowns", }, },
    { spell.Trinket2, { "modifier.cooldowns", }, },
    { spell.BloodFury, { "modifier.cooldowns", }, },
    { spell.ChimaeraShot, { "!toggle.nocleave", }, },
    { spell.Berserking, { "modifier.cooldowns", }, },
    { spell.Stampede, { "modifier.cooldowns", }, },
    { spell.AMurderofCrows, { "modifier.cooldowns", }, },
    { spell.RapidFire, { "modifier.cooldowns", }, },
    { spell.AimedShot, },
}
local simc = {
    --actions=auto_shot

    --actions+=/use_item,name=lucky_doublesided_coin
    --actions+=/use_item,name=beating_heart_of_the_mountain
    --actions+=/use_item,name=primal_gladiators_badge_of_conquest
    { spell.Trinket1, { "modifier.cooldowns", }, },
    { spell.Trinket2, { "modifier.cooldowns", }, },
    --actions+=/arcane_torrent,if=focus.deficit>=30
    { spell.ArcaneTorrent, { "modifier.cooldowns", "target.deathin > 15", "player.focus <= 70", }, },
    --actions+=/blood_fury
    { spell.BloodFury, { "modifier.cooldowns", "target.deathin > 15", }, },
    --actions+=/berserking
    { spell.Berserking, { "modifier.cooldowns", "target.deathin > 15", }, },
    --actions+=/potion,name=draenic_agility,if=((buff.rapid_fire.up|buff.bloodlust.up)&(cooldown.stampede.remains<1))|target.time_to_die<=25
    { spell.AgilityPotion, { "toggle.consumables", "player.buff("..spell.RapidFire..")", "player.spell("..spell.Stampede..").cooldown < 1", }, },
    { spell.AgilityPotion, { "toggle.consumables", "player.hashero", "player.spell("..spell.Stampede..").cooldown < 1", }, },
    { spell.AgilityPotion, { "toggle.consumables", "target.deathin <= 25", }, },
    --actions+=/chimaera_shot
    { spell.ChimaeraShot, { "!toggle.nocleave", }, },
    --actions+=/kill_shot
    { spell.KillShot, },
    --actions+=/steady_shot,if=buff.pre_steady_focus.up&(14+cast_regen+action.aimed_shot.cast_regen)<=focus.deficit
    { spell.SteadyShot, { "lastcast("..spell.SteadyShot..")", "talent(4,1)", "@LibHunter.SimCMM14plusSSCRplusASCRlessthanorequaltoFD()", }, },
    --actions+=/rapid_fire
    { spell.RapidFire, { "modifier.cooldowns", }, },
    --actions+=/stampede,if=buff.rapid_fire.up|buff.bloodlust.up|target.time_to_die<=25
    { spell.Stampede, { "modifier.cooldowns", "player.buff("..spell.RapidFire..")", }, },
    { spell.Stampede, { "modifier.cooldowns", "player.hashero", }, },
    { spell.Stampede, { "modifier.cooldowns", "target.deathin <= 25", }, },
    --actions+=/call_action_list,name=careful_aim,if=buff.careful_aim.up
    --{
        --actions.careful_aim=glaive_toss,if=active_enemies>2
        { spell.GlaiveToss, { "target.area(10).enemies > 2", "modifier.multitarget", "!toggle.nocleave", }, },
        --actions.careful_aim+=/powershot,if=active_enemies>1&cast_regen<focus.deficit
        { spell.Powershot, { "target.area(10).enemies > 1", "@LibHunter.SimCMMPSCRlessthanFD()", "modifier.multitarget", "!toggle.nocleave", }, },
        --actions.careful_aim+=/barrage,if=active_enemies>1
        { spell.Barrage, { "target.area(10).enemies > 1", "modifier.multitarget", "!toggle.nocleave", }, },
        --actions.careful_aim+=/aimed_shot
        { spell.AimedShot, },
        --actions.careful_aim+=/focusing_shot,if=50+cast_regen<focus.deficit
        { spell.FocusingShot, { "@LibHunter.SimCMM50FSCRlessthanFD()", }, },
        --actions.careful_aim+=/steady_shot
        { spell.SteadyShot, },
    --}, "@LibHunter.CarefulAimCheck('rareelite')", },
    --actions+=/explosive_trap,if=active_enemies>1
    { spell.ExplosiveTrap1, { "!player.buff("..spell.TrapLauncher..")", "target.deathin >= 10", "!toggle.nocleave", "target.exists", "target.area(10).enemies > 1", }, },
    { spell.ExplosiveTrap2, { "player.buff("..spell.TrapLauncher..")", "target.deathin >= 10", "!toggle.nocleave", "target.exists", "target.area(10).enemies > 1", }, "target.ground", },
    --actions+=/a_murder_of_crows
    { spell.AMurderofCrows, { "target.deathin > 60", "modifier.cooldowns", }, },
    { spell.AMurderofCrows, { "target.deathin < 12", }, },
    --actions+=/dire_beast,if=cast_regen+action.aimed_shot.cast_regen<focus.deficit
    { spell.DireBeast, { "@LibHunter.SimCMMDBCRplusASCRlessthanFD()", }, },
    --actions+=/glaive_toss
    { spell.GlaiveToss, { "!toggle.nocleave", }, },
    --actions+=/powershot,if=cast_regen<focus.deficit
    { spell.Powershot, { "@LibHunter.SimCMMPSCRlessthanFD()", "!toggle.nocleave", }, },
    --actions+=/barrage
    { spell.Barrage, { "!toggle.nocleave", }, },
    --actions+=/steady_shot,if=focus.deficit*cast_time%(14+cast_regen)>cooldown.rapid_fire.remains
    { spell.SteadyShot, { "@LibHunter.SimCMMFDtimesSSCTdividedby14plusSSCRgreatherthanRFCD()", }, },
    --actions+=/focusing_shot,if=focus.deficit*cast_time%(50+cast_regen)>cooldown.rapid_fire.remains&focus<100
    { spell.FocusingShot, { "@LibHunter.SimCMMFDtimesFSCTdividedby50plusFSCRgreatherthanRFCD()", "player.focus < 100", }, },
    --actions+=/steady_shot,if=buff.pre_steady_focus.up&(14+cast_regen+action.aimed_shot.cast_regen)<=focus.deficit
    { spell.SteadyShot, { "lastcast("..spell.SteadyShot..")", "talent(4,1)", "@LibHunter.SimCMM14plusSSCRplusASCRlessthanorequaltoFD()", }, },
    --actions+=/multishot,if=active_enemies>6
    { spell.MultiShot, { "target.area(8).enemies > 6", "modifier.multitarget", "!toggle.nocleave", }, },
    --actions+=/aimed_shot,if=talent.focusing_shot.enabled
    { spell.AimedShot, { "talent(7,2)", }, },
    --actions+=/aimed_shot,if=focus+cast_regen>=85
    { spell.AimedShot, { "@LibHunter.SimCMMFplusASCRgreaterthanorequalto85()", }, },
    --actions+=/aimed_shot,if=buff.thrill_of_the_hunt.react&focus+cast_regen>=65
    { spell.AimedShot, { "player.buff("..spell.ThrilloftheHunt..")", "@LibHunter.SimCMMFplusASCRgreaterthanorequalto65()", }, },
    --actions+=/focusing_shot,if=50+cast_regen-10<focus.deficit
    { spell.FocusingShot, { "@LibHunter.SimCMM50plusFSCRminus10lessthanFD()", }, },
    --actions+=/steady_shot
    { spell.SteadyShot, },
}

ProbablyEngine.rotation.register_custom(254, "Rotation Agent - Marksmanship",
{
    { string.PauseIncPet, { "@LibHunter.ImmuneTargetCheck(2, 'target')", }, },
    { string.PauseIncPet, { "modifier.lshift", }, },
    { string.PauseIncPet, { "lastcast("..spell.FeignDeath..")", }, },
    { string.PauseIncPet, { "player.buff("..spell.Food..")", }, },

    { opener, { "@LibHunter.UseOpenerCheck('rareelite', 4)", }, },

    { poolfocus, },
    { spellqueue, },
    { petmanagement, { "toggle.petmgmt", }, },
    { defensive, { "toggle.defensives", }, },
    { interrupts, { "modifier.interrupts", }, },
    { misdirect, { "toggle.md", }, },
    { pvp, },

    { simc, { "!@LibHunter.UseOpenerCheck('rareelite', 4)", }, },
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
            DEBUG(5, "Marksmanship.lua:C_Timer.NewTicker()")
            CacheUnits()
            AutoTarget()
        end
    end), nil)
end
)