
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
    -- BUFFS
    ArchmagesIncandescence = "177161",
    ArchmagesGreaterIncandescence = "177172",
    BalancedFate = "177038",
    Dazed = "15571",
    Food = "160598",
    LockandLoad = "168980",
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
    { spell.Misdirection, { "!focus.exists", "!mouseover.buff("..spell.Misdirection..")", "modifier.ralt", }, "mouseover", },
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
    { string.HunterJump, { "@LibHunter.CheckHunterQueue(781)", "timeout(HunterJump, 1)", }, },
    -- HUNTER SURVIVAL
    { spell.BlackArrow, "@LibHunter.CheckHunterQueue(3674)", },
    { spell.ExplosiveShot, "@LibHunter.CheckHunterQueue(53301)", },
}

local opener = {
    { spell.Trinket1, { "modifier.cooldowns", }, },
    { spell.Trinket2, { "modifier.cooldowns", }, },
    { spell.BloodFury, { "modifier.cooldowns", }, },
    { spell.AMurderofCrows, { "modifier.cooldowns", }, },
    { spell.ExplosiveShot, },
    { spell.BlackArrow, },
    { spell.ArcaneShot, { "player.buff("..spell.ThrilloftheHunt..").count > 2", }, },
    { spell.ExplosiveShot, { "player.buff("..spell.LockandLoad..")", }, },
    { spell.Berserking, { "modifier.cooldowns", }, },
    { spell.ArcaneTorrent, { "modifier.cooldowns", }, },
}
local azor_singletarget = {
    { spell.ArcaneTorrent, { "modifier.cooldowns", }, },
    { spell.BloodFury, { "modifier.cooldowns", }, },
    { spell.Berserking, { "modifier.cooldowns", }, },

    { spell.BlackArrow, { "!target.debuff("..spell.BlackArrow..")", "player.spell("..spell.BlackArrow..").cooldown = 0", }, },
    { spell.ArcaneShot, { "!target.debuff("..spell.SerpentSting..")", }, },
    { spell.ExplosiveShot, { "player.buff("..spell.LockandLoad..")", }, },
    { spell.ArcaneShot, { "player.buff("..spell.ThrilloftheHunt..")", "player.buff("..spell.BalancedFate..")", }, },
    { spell.ExplosiveShot, },
    { spell.AMurderofCrows, { "target.deathin > 60", "modifier.cooldowns", }, },
    { spell.AMurderofCrows, { "target.deathin < 12", }, },
    { spell.ArcaneShot, { "player.focus > 10", "player.buff("..spell.ThrilloftheHunt..")", }, },
    { spell.ExplosiveTrap1, { "player.moving", "!player.buff("..spell.TrapLauncher..")", "target.deathin >= 7", "!toggle.nocleave", }, },
    { spell.ExplosiveTrap2, { "player.moving", "player.buff("..spell.TrapLauncher..")", "target.deathin >= 7", "!toggle.nocleave", }, "target.ground", },
    { spell.ArcaneShot, { "player.focus > 30", }, },
    { spell.FocusingShot, { "player.focus < 50", }, },
    { spell.CobraShot, { "player.focus < 86", "!talent(7,2)", }, },
}
local azor_multitarget = {
    { spell.ArcaneTorrent, { "modifier.cooldowns", }, },
    { spell.BloodFury, { "modifier.cooldowns", }, },
    { spell.Berserking, { "modifier.cooldowns", }, },

    { spell.BlackArrow, { "!target.debuff("..spell.BlackArrow..")", "player.spell("..spell.BlackArrow..").cooldown = 0", }, },
    { spell.ArcaneShot, { "!target.debuff("..spell.SerpentSting..")", "target.area(8).enemies > 1", "target.area(8).enemies <= 2", }, },
    { spell.MultiShot, { "!target.debuff("..spell.SerpentSting..")", "target.area(8).enemies > 2", }, },
    { spell.Barrage, },
    { spell.ExplosiveShot, { "player.buff("..spell.LockandLoad..")", }, },
    { spell.ArcaneShot, { "player.buff("..spell.ThrilloftheHunt..")", "player.buff("..spell.BalancedFate..")", }, },
    { spell.ExplosiveShot, },
    { spell.ExplosiveTrap1, { "!player.buff("..spell.TrapLauncher..")", "target.deathin >= 7", }, },
    { spell.ExplosiveTrap2, { "player.buff("..spell.TrapLauncher..")", "target.deathin >= 7", }, "target.ground", },
    { spell.AMurderofCrows, { "target.deathin > 60", "modifier.cooldowns", }, },
    { spell.AMurderofCrows, { "target.deathin < 12", }, },
    { spell.ArcaneShot, { "player.focus > 10", "player.buff("..spell.ThrilloftheHunt..")", }, },
    { spell.Barrage, { "!player.buff("..spell.ThrilloftheHunt..")", "!player.buff("..spell.BalancedFate..")", },},
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
    { spell.ArcaneTorrent, { "modifier.cooldowns", "target.deathin > 20", "player.focus <= 70", }, },
    --actions+=/blood_fury
    { spell.BloodFury, { "modifier.cooldowns", "target.deathin > 20", }, },
    --actions+=/berserking
    { spell.Berserking, { "modifier.cooldowns", "target.deathin > 20", }, },
    --actions+=/potion,name=draenic_agility,if=(((cooldown.stampede.remains<1)&(cooldown.a_murder_of_crows.remains<1))&(trinket.stat.any.up|
    --         buff.archmages_greater_incandescence_agi.up))|
    --         target.time_to_die<=25
    { spell.AgilityPotion, { "toggle.consumables", "player.spell("..spell.Stampede..").cooldown < 1", "@LibHunter.StatProcs('agility')", }, },
    { spell.AgilityPotion, { "toggle.consumables", "player.spell("..spell.AMurderofCrows..").cooldown < 1", "@LibHunter.StatProcs('agility')", }, },
    { spell.AgilityPotion, { "toggle.consumables", "player.spell("..spell.Stampede..").cooldown < 1", "player.buff("..spell.ArchmagesGreaterIncandescence..")", }, },
    { spell.AgilityPotion, { "toggle.consumables", "player.spell("..spell.AMurderofCrows..").cooldown < 1", "player.buff("..spell.ArchmagesGreaterIncandescence..")", }, },
    { spell.AgilityPotion, { "toggle.consumables", "target.deathin <= 25", }, },
    --actions+=/call_action_list,name=aoe,if=active_enemies>1
    {{
        --actions.aoe=stampede,if=buff.potion.up|
        --            (cooldown.potion.remains&(buff.archmages_greater_incandescence_agi.up|
        --            trinket.stat.any.up|
        --            buff.archmages_incandescence_agi.up))
        { spell.Stampede, { "modifier.cooldowns", "@LibHunter.SimCBuffPotionUp(109217)", }, },
        { spell.Stampede, { "modifier.cooldowns", "player.buff("..spell.ArchmagesGreaterIncandescence..")", }, },
        { spell.Stampede, { "modifier.cooldowns", "@LibHunter.StatProcs('agility')", }, },
        --actions.aoe+=/explosive_shot,if=buff.lock_and_load.react&(!talent.barrage.enabled|cooldown.barrage.remains>0)
        { spell.ExplosiveShot, { "player.buff("..spell.LockandLoad..")", "!talent(6,3)", }, },
        { spell.ExplosiveShot, { "player.buff("..spell.LockandLoad..")", "player.spell("..spell.Barrage..").cooldown > 0", }, },
        --actions.aoe+=/barrage
        { spell.Barrage, { "!toggle.nocleave", }, },
        --actions.aoe+=/black_arrow,if=!ticking
        { spell.BlackArrow, { "player.spell("..spell.BlackArrow..").cooldown = 0", "target.deathin > 12", }, },
        --actions.aoe+=/explosive_shot,if=active_enemies<5
        { spell.ExplosiveShot, { "target.area(10).enemies < 5", }, },
        --actions.aoe+=/explosive_trap,if=dot.explosive_trap.remains<=5
        { spell.ExplosiveTrap1, { "!player.buff("..spell.TrapLauncher..")", }, },
        { spell.ExplosiveTrap2, { "player.buff("..spell.TrapLauncher..")", }, "target.ground", },
        --actions.aoe+=/a_murder_of_crows
        { spell.AMurderofCrows, { "modifier.cooldowns", "target.deathin > 60", }, },
        { spell.AMurderofCrows, { "target.deathin < 12", }, },
        --actions.aoe+=/dire_beast
        { spell.DireBeast, { "target.deathin > 15", }, },
        --actions.aoe+=/multishot,if=buff.thrill_of_the_hunt.react&focus>50&cast_regen<=focus.deficit|
        --             dot.serpent_sting.remains<=5|
        --             target.time_to_die<4.5
        { spell.MultiShot, { "player.buff("..spell.ThrilloftheHunt..")", "player.focus > 50", "@LibHunter.SimCCRlessthanorequaltoFD()", }, },
        { spell.MultiShot, { "target.debuff("..spell.SerpentSting..").duration <= 5", }, },
        { spell.MultiShot, { "target.deathin < 4.5", }, },
        --actions.aoe+=/glaive_toss
        { spell.GlaiveToss, { "target.deathin > 7", }, },
        --actions.aoe+=/powershot
        { spell.Powershot, { "target.deathin > 22", }, },
        --actions.aoe+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&focus+14+cast_regen<80
        { spell.CobraShot, { "lastcast("..spell.CobraShot..")", "player.buff("..spell.SteadyFocus..") < 5", "@LibHunter.SimCFplus14plusCRlessthan80()", }, },
        --actions.aoe+=/multishot,if=focus>=70|
        --             talent.focusing_shot.enabled
        { spell.MultiShot, { "player.focus >= 70", }, },
        { spell.MultiShot, { "talent(7,2)", }, },
        --actions.aoe+=/focusing_shot
        { spell.FocusingShot, { "target.deathin > 3", }, },
        --actions.aoe+=/cobra_shot
        { spell.CobraShot, { "target.deathin > 2", }, },
    }, { "modifier.multitarget", "target.area(10).enemies > 1", }, },
    --actions+=/stampede,if=buff.potion.up|(cooldown.potion.remains&(buff.archmages_greater_incandescence_agi.up|
    --         trinket.stat.any.up))|
    --         target.time_to_die<=25
    { spell.Stampede, { "modifier.cooldowns", "player.buff("..spell.AgilityPotion..")", }, },
    { spell.Stampede, { "modifier.cooldowns", "player.buff("..spell.ArchmagesGreaterIncandescence..")", }, },
    { spell.Stampede, { "modifier.cooldowns", "@LibHunter.StatProcs('agility')", }, },
    { spell.Stampede, { "modifier.cooldowns", "target.deathin <= 25", }, },
    --actions+=/a_murder_of_crows
    { spell.AMurderofCrows, { "target.deathin > 60", "modifier.cooldowns", }, },
    { spell.AMurderofCrows, { "target.deathin < 12", }, },
    --actions+=/black_arrow,if=!ticking
    { spell.BlackArrow, { "player.spell("..spell.BlackArrow..").cooldown = 0", "target.deathin > 12", }, },
    --actions+=/explosive_shot
    { spell.ExplosiveShot, },
    --actions+=/dire_beast
    { spell.DireBeast, { "target.deathin > 15", }, },
    --actions+=/arcane_shot,if=buff.thrill_of_the_hunt.react&focus>35&cast_regen<=focus.deficit|
    --         dot.serpent_sting.remains<=3|
    --         target.time_to_die<4.5
    { spell.ArcaneShot, { "player.buff("..spell.ThrilloftheHunt..")", "player.focus > 35", "@LibHunter.SimCCRlessthanorequaltoFD()", }, },
    { spell.ArcaneShot, { "target.debuff("..spell.SerpentSting..").duration <= 3", }, },
    { spell.ArcaneShot, { "target.deathin < 4.5", }, },
    --actions+=/explosive_trap
    { spell.ExplosiveTrap1, { "!player.buff("..spell.TrapLauncher..")", "target.deathin >= 10", "!toggle.nocleave", "target.exists", }, },
    { spell.ExplosiveTrap2, { "player.buff("..spell.TrapLauncher..")", "target.deathin >= 10", "!toggle.nocleave", "target.exists", }, "target.ground", },
    --# Cast a second shot for steady focus if that won't cap us.
    --actions+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&(14+cast_regen)<=focus.deficit
    { spell.CobraShot, { "lastcast("..spell.CobraShot..")", "player.buff("..spell.SteadyFocus..") < 5", "@LibHunter.SimCSV14plusCSCRlessthanorequaltoFD()", }, },
    --actions+=/arcane_shot,if=focus>=80|talent.focusing_shot.enabled
    { spell.ArcaneShot, { "player.focus >= 80", }, },
    { spell.ArcaneShot, { "talent(7,2)", }, },
    --actions+=/focusing_shot
    { spell.FocusingShot, { "target.deathin > 3", }, },
    --actions+=/cobra_shot
    { spell.CobraShot, { "target.deathin > 2", }, },
}

ProbablyEngine.rotation.register_custom(255, "Rotation Agent - Survival",
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

    --{ azor_singletarget, { "target.area(10).enemies < 2", }, },
    --{ azor_multitarget, { "target.area(10).enemies >= 2", "modifier.multitarget", }, },
    { simc, { "!@LibHunter.UseOpenerCheck('normal', 4)", }, },
},

{
    { ooc, },
    { misdirect, { "toggle.md", }, },
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
            DEBUG(5, "Survival.lua:C_Timer.NewTicker()")
            CacheUnits()
            AutoTarget()
        end
    end), nil)
end
)