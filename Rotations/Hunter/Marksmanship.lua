-- ProbablyEngine Rotation Packager
-- Created on Nov 1st 2014 8:14 pm
ProbablyEngine.rotation.register_custom(254, "Rotation Agent - Marksmanship (SimC)",
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

	----------------------------------------------------------------------------------------------]]
	{ "/stopcasting\n/stopcasting", { "!player.buff(Thrill of the Hunt)", "player.focus < 50", "@LibHunter.CastingCheck('Aimed Shot')", }, },










	--[[--------------------------------------------------------------------------------------------
	AUTO CLEAR TARGET
	  * Automatically clears the target if it is friendly.
	----------------------------------------------------------------------------------------------]]
	{{
		{ "/cleartarget", { "@LibHunter.ClearCurrentTarget()", "!modifier.rcontrol" }, },
	}, "toggle.autotarget", },









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

	{ "Aimed Shot", "@LibHunter.CheckHunterQueue(19434)", },
	{ "Chimaera Shot", "@LibHunter.CheckHunterQueue(53209)", },
	{ "Kill Shot", "@LibHunter.CheckHunterQueue(157708)", },
	{ "Rapid Fire", "@LibHunter.CheckHunterQueue(3045)", },
	{ "Steady Shot", "@LibHunter.CheckHunterQueue(56641)", },










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
	MARKSMANSHIP OPENER

	----------------------------------------------------------------------------------------------]]
	{{
		{ "#trinket1", { "modifier.cooldowns", }, },
		{ "#trinket2", { "modifier.cooldowns", }, },
		{ "Blood Fury", { "modifier.cooldowns", }, },
		{ "Chimaera Shot", },
		{ "A Murder of Crows", { "modifier.cooldowns", }, },
		{ "Stampede", { "modifier.cooldowns", }, },
		{ "Rapid Fire", { "toggle.shortcds", }, },
		{ "Aimed Shot", },
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

			--actions+=/potion,name=draenic_agility,if=((buff.rapid_fire.up|buff.bloodlust.up)&(cooldown.stampede.remains<1))|target.time_to_die<=25
			{ "#76089", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "player.buff(Rapid Fire)", "player.spell(Stampede).cooldown < 1", }, },
			{ "#76089", { "toggle.consumables", "@LibHunter.EvalClassification('rareelite')", "target.deathin <= 25", }, },

			--actions+=/chimaera_shot
			{ "Chimaera Shot", { "!toggle.nocleave", }, },

			--actions+=/kill_shot
			{ "Kill Shot", },

			--actions+=/rapid_fire
			{ "Rapid Fire", { "target.deathin >= 15", "toggle.shortcds", }, },

			--actions+=/stampede,if=buff.rapid_fire.up|buff.bloodlust.up|target.time_to_die<=25
			{ "Stampede", { "modifier.cooldowns", "player.buff(Rapid Fire)", }, },
			{ "Stampede", { "modifier.cooldowns", "@LibHunter.BurstHasteCheck()", }, },
			{ "Stampede", { "modifier.cooldowns", "target.deathin <= 25", }, },

			--actions+=/call_action_list,name=careful_aim,if=buff.careful_aim.up
			{{
				--actions.careful_aim=glaive_toss,if=active_enemies>2
				{ "Glaive Toss", { "@LibHunter.UnitsAroundUnit('target', 10, 2)", "!toggle.nocleave", }, },
				--actions.careful_aim+=/powershot,if=active_enemies>1&cast_regen<focus.deficit
				{ "Powershot", { "@LibHunter.UnitsAroundUnit('target', 10, 1)", "@LibHunter.SimCMMPSCRlessthanFD()", "!toggle.nocleave", }, },
				--actions.careful_aim+=/barrage,if=active_enemies>1
				{ "Barrage", { "@LibHunter.UnitsAroundUnit('target', 10, 1)", "!toggle.nocleave", }, },
				--actions.careful_aim+=/aimed_shot
				{ "Aimed Shot", },
				--actions.careful_aim+=/focusing_shot,if=50+cast_regen<focus.deficit
				{ "Focusing Shot", { "@LibHunter.SimCMM50FSCRlessthanFD()", }, },
				--actions.careful_aim+=/steady_shot
				{ "Steady Shot", },
			}, { "@LibHunter.CarefulAimCheck('rareelite')", }, },

			--actions+=/explosive_trap,if=active_enemies>1
			{ "Explosive Trap", { "@LibHunter.UnitsAroundUnit('target', 10, 1)", "!toggle.nocleave", }, "target.ground", },

			--actions+=/a_murder_of_crows
			{ "A Murder of Crows", { "target.deathin > 60", "toggle.shortcds", }, },
			{ "A Murder of Crows", { "target.deathin < 12", }, },

			--actions+=/dire_beast,if=cast_regen+action.aimed_shot.cast_regen<focus.deficit
			{ "Dire Beast", { "@LibHunter.SimCMMDBCRplusASCRlessthanFD()", }, },

			--actions+=/glaive_toss
			{ "Glaive Toss", { "!toggle.nocleave", }, },

			--actions+=/powershot,if=cast_regen<focus.deficit
			{ "Powershot", { "@LibHunter.SimCMMPSCRlessthanFD()", "!toggle.nocleave", }, },

			--actions+=/barrage
			{ "Barrage", { "!toggle.nocleave", }, },

			--# Pool max focus for rapid fire so we can spam AimedShot with Careful Aim buff
			--actions+=/steady_shot,if=focus.deficit*cast_time%(14+cast_regen)>cooldown.rapid_fire.remains
			{ "Steady Shot", { "@LibHunter.SimCMMFDtimesSSCTdividedby14plusSSCRgreatherthanRFCD()", }, },

			--actions+=/focusing_shot,if=focus.deficit*cast_time%(50+cast_regen)>cooldown.rapid_fire.remains&focus<100
			{ "Focusing Shot", { "@LibHunter.SimCMMFDtimesFSCTdividedby50plusFSCRgreatherthanRFCD()", "player.focus < 100", }, },

			--# Cast a second shot for steady focus if that won't cap us.
			--actions+=/steady_shot,if=buff.pre_steady_focus.up&(14+cast_regen+action.aimed_shot.cast_regen)<=focus.deficit
			{ "Steady Shot", { "talent(4,1)", "lastcast(Steady Shot)", "@LibHunter.SimCMM14plusSSCRplusASCRlessthanorequaltoFD()", }, },

			--actions+=/multishot,if=active_enemies>6
			{ "Multi-Shot", { "modifier.multitarget", "@LibHunter.UnitsAroundUnit('target', 10, 6)", "!toggle.nocleave", }, },

			--actions+=/aimed_shot,if=talent.focusing_shot.enabled
			{ "Aimed Shot", { "talent(7,2)", }, },

			--actions+=/aimed_shot,if=focus+cast_regen>=85
			{ "Aimed Shot", { "@LibHunter.SimCMMFplusASCRgreaterthanorequalto85()", }, },

			--actions+=/aimed_shot,if=buff.thrill_of_the_hunt.react&focus+cast_regen>=65
			{ "Aimed Shot", { "player.buff(Thrill of the Hunt)", "@LibHunter.SimCMMFplusASCRgreaterthanorequalto65()", }, },

			--# Allow FS to over-cap by 10 if we have nothing else to do
			--actions+=/focusing_shot,if=50+cast_regen-10<focus.deficit
			{ "Focusing Shot", { "@LibHunter.SimCMM50plusFSCRminus10lessthanFD()", }, },

			--actions+=/steady_shot
			{ "Steady Shot", },

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

	{ "Aimed Shot", "@LibHunter.CheckHunterQueue(19434)", },
	{ "Chimaera Shot", "@LibHunter.CheckHunterQueue(53209)", },
	{ "Kill Shot", "@LibHunter.CheckHunterQueue(157708)", },
	{ "Rapid Fire", "@LibHunter.CheckHunterQueue(3045)", },
	{ "Steady Shot", "@LibHunter.CheckHunterQueue(56641)", },

	{ "Camouflage", { "toggle.pvpmode", "player.glyph(Glyph of Camouflage)", "!player.buff(Camouflage)", "!player.debuff(Orb of Power)", }, },
	{ "Fetch", { "modifier.lcontrol", "!lastcast(Fetch)", "!player.moving", "pet.exists", "timeout(timerFetch, 1)", }, },
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
			DEBUG(5, "Marksmanship.lua:C_Timer.NewTicker()")
			CacheUnits()
			AutoTarget()
		end
	end), nil)
end
)