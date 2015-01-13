-- ProbablyEngine Rotation Packager
-- Created on Nov 1st 2014 8:14 pm
ProbablyEngine.rotation.register_custom(254, "Rotation Agent - Marksmanship",
-- COMBAT
{

},





-- OUT OF COMBAT
{

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
	ProbablyEngine.toggle.create(
        'nocleave',
        'Interface\\Icons\\Warrior_talent_icon_mastercleaver',
        'No Cleave', 'Do not use any cleave/aoe abilities'
    )
	GRunAutoTargetCode = true
end
)