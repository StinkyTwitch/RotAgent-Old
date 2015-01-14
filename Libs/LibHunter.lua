
--[[------------------------------------------------------------------------------------------------
LOCAL GLOBALS
	*	Faster access to variables and functions.
--------------------------------------------------------------------------------------------------]]
local BurstHasteBuffs = BurstHasteBuffs
local ClassificationValues = ClassificationValues
local ImmuneAuras = ImmuneAuras
local SpecialTargets = SpecialTargets
local UNITSAROUNDUNITCOUNT = UNITSAROUNDUNITCOUNT
local UNITSAROUNDUNITTIME = UNITSAROUNDUNITTIME

local LibHunter = {}
LibHunter.BurstHasteCheck = BurstHasteCheck
LibHunter.ClassificationValue = ClassificationValue
LibHunter.ClearCurrentTarget = ClearCurrentTarget
LibHunter.EvalClassification = EvalClassification
LibHunter.ImmuneTargetCheck = ImmuneTargetCheck
LibHunter.SpecialAuraCheck = SpecialAuraCheck
LibHunter.SpecialTargetCheck = SpecialTargetCheck
LibHunter.StatProcs = StatProcs
LibHunter.TrinketsOnCooldown = TrinketsOnCooldown
LibHunter.UnitsAroundUnit = UnitsAroundUnit
LibHunter.UnitToUnitDistanceCheck = UnitToUnitDistanceCheck
LibHunter.UseOpenerCheck = UseOpenerCheck

LibHunter.QueueSpell = nil
LibHunter.QueueTime = 0
LibHunter.QueueTimeValidFor = 4
LibHunter.SummonPetNumber = 0


--[[------------------------------------------------------------------------------------------------
CHECK HUNTER QUEUE

--------------------------------------------------------------------------------------------------]]
function LibHunter.CheckHunterQueue(spell_id)
	if (GetTime() - LibHunter.QueueTime) > LibHunter.QueueTimeValidFor then
		LibHunter.QueueTime = 0
		LibHunter.QueueSpell = nil
		return false
	else
		if LibHunter.QueueSpell then
			if LibHunter.QueueSpell == spell_id then
				if ProbablyEngine.parser.lastCast == GetSpellName(spell_id) then
					LibHunter.QueueSpell = nil
					LibHunter.QueueTime = 0
				end
				NotificationFrame:message(GetSpellName(spell_id).." Queued")

				DEBUG(5, "CheckHunterQueue->true")
				return true
			else
				DEBUG(5, "CheckHunterQueue->false")
				return false
			end
		end
	end
end


--[[------------------------------------------------------------------------------------------------
HUNTER JUMP

--------------------------------------------------------------------------------------------------]]
-- Slash Command
SLASH_HUNTERJUMPCMD1 = "/hunterjump"

-- Slash Command List
function SlashCmdList.HUNTERJUMPCMD(msg, editbox)
	if msg == "" then
		DisengageForward()
	else
		return
	end
end

-- Verify Vector
function VerifyDisengage(vector)
	local current_vector = ObjectFacing("player")

	if current_vector ~= vector then
		FaceDirection(vector)
		CastSpellByName("Disengage")
	else
		CastSpellByName("Disengage")
	end
end

-- Disengage Forward
function DisengageForward()
	local initial_vector = (ObjectFacing("player"))
	local disengage_vector = (mod( ObjectFacing("player") + math.pi, math.pi * 2 ))

	C_Timer.After(.001, function() FaceDirection(disengage_vector) end)
	C_Timer.After(.35, function() VerifyDisengage(disengage_vector) end)
	C_Timer.After(.50, function () FaceDirection(initial_vector) end)

	DEBUG(1, "Jump: "..initial_vector..", "..disengage_vector.."")
end


--[[------------------------------------------------------------------------------------------------
RA HUNTER SLASH COMMAND LIST

--------------------------------------------------------------------------------------------------]]
SLASH_RAHUNTERCMD1 = "/rahunter"

function SlashCmdList.RAHUNTERCMD(msg, editbox)
	local command, moretext = msg:match("^(%S*)%s*(.-)$")
	--[[if moretext ~= "" then
		command = command .." "..moretext
	end
	--]]
	command = string.lower(command)
	moretext = string.lower(moretext)

	if msg == "" then
		-- Help listing.
		-- ?
	elseif command == "autotarget" then
		if moretext == "lowest" then
			DEBUG(2, "SLASHCMD->autotarget->lowest")
			AUTOTARGETALGORITHM = "lowest"
			CACHEUNITSALGORITHM = "lowest"
		elseif moretext == "nearest" then
			DEBUG(2, "SLASHCMD->autotarget->nearest")
			AUTOTARGETALGORITHM = "nearest"
			CACHEUNITSALGORITHM = "nearest"
		elseif moretext == "focus" then
			DEBUG(2, "SLASHCMD->autotarget->focus")
			AUTOTARGETALGORITHM = "focus"
		elseif moretext == "skull" then
			DEBUG(2, "SLASHCMD->autotarget->skull")
			AUTOTARGETALGORITHM = "skull"
		elseif moretext == "cascade" then
			DEBUG(2, "SLASHCMD->autotarget->cascade")
			AUTOTARGETALGORITHM = "cascade"
		else
			print("Current Autotarget settings: "..AUTOTARGETALGORITHM.."")
			print("Usage: /rahunter autotarget lowest \124 nearest \124 focus \124 skull \124 cascade")
		end
	elseif command == "cast" then
		if moretext == "aimed shot" then				-- MM
			LibHunter.QueueSpell =  19434
		elseif moretext == "amoc" then					-- ALL Talent
			LibHunter.QueueSpell = 131894
		elseif moretext == "aotf" then					-- ALL
			LibHunter.QueueSpell = 172106
		elseif moretext == "arcane shot" then			-- SV
            LibHunter.QueueSpell = 3044
		elseif moretext == "barrage" then				-- ALL Talent
			LibHunter.QueueSpell = 120360
		elseif moretext == "binding shot" then			-- ALL Talent
			LibHunter.QueueSpell = 109248
		elseif moretext == "black arrow" then			-- SV
            LibHunter.QueueSpell = 3674
        elseif moretext == "camouflage" then			-- ALL
            LibHunter.QueueSpell = 51753
        elseif moretext == "chimaera shot" then			-- MM
			LibHunter.QueueSpell = 53209
		elseif moretext == "concussive shot" then		-- ALL
			LibHunter.QueueSpell = 5116
		elseif moretext == "counter shot" then			-- ALL
            LibHunter.QueueSpell = 147362
        elseif moretext == "deterrence" then			-- ALL
            LibHunter.QueueSpell = 148467
		elseif moretext == "disengage" then				-- ALL
			LibHunter.QueueSpell = 781
		elseif moretext == "distracting shot" then		-- ALL
            LibHunter.QueueSpell = 20736
        elseif moretext == "explosive shot" then		-- SV
            LibHunter.QueueSpell = 53301
		elseif moretext == "explosive trap" then		-- ALL
			if UnitAura("player", "Trap Launcher") then
				LibHunter.QueueSpell = 82939
			else
				LibHunter.QueueSpell = 13813
			end
		elseif moretext == "feign death" then			-- ALL
			LibHunter.QueueSpell = 5384
		elseif moretext == "flare" then					-- ALL
			LibHunter.QueueSpell = 1543
		elseif moretext == "focusing shot" then			-- ALL Talent
            LibHunter.QueueSpell = 152245
		elseif moretext == "freezing trap" then			-- ALL
			if UnitAura("player", "Trap Launcher") then
				LibHunter.QueueSpell = 60192
			else
				LibHunter.QueueSpell = 1499
			end
		elseif moretext == "glaive toss" then			-- ALL Talent
			LibHunter.QueueSpell = 117050
		elseif moretext == "ice trap" then
			if UnitAura("player", "Trap Launcher") then	-- ALL
				LibHunter.QueueSpell = 82941
			else
				LibHunter.QueueSpell = 13809
			end
		elseif moretext == "intimidation" then			-- ALL Talent
			LibHunter.QueueSpell = 19577
		elseif moretext == "kill shot" then				-- MM
			LibHunter.QueueSpell = 157708
		elseif moretext == "masters call" then			-- ALL
			LibHunter.QueueSpell = 53271
		elseif moretext == "multi-shot" then			-- ALL
			LibHunter.QueueSpell = 2643
		elseif moretext == "powershot" then				-- ALL Talent
			LibHunter.QueueSpell = 109259
		elseif moretext == "rapid fire" then			-- MM
			LibHunter.QueueSpell = 3045
		elseif moretext == "stampede" then				-- ALL Talent
			LibHunter.QueueSpell = 121818
		elseif moretext == "steady shot" then			-- MM
			LibHunter.QueueSpell = 56641
		elseif moretext == "tranquilizing shot" then	-- ALL
			LibHunter.QueueSpell = 19801
		elseif moretext == "wyvern sting" then			-- ALL Talent
			LibHunter.QueueSpell = 19386
		else
			print("Unknown 'cast' command.")
		end
	elseif command == "config" then
		--ProbablyEngine.interface.buildGUI()
		-- ?
	elseif command == "debug" then
		if moretext == "on" then
			print("DEBUG: on")
			DEBUGTOGGLE = true
		elseif moretext == "off" then
			print("DEBUG: off")
			DEBUGTOGGLE = false
		elseif moretext == "1" then
			print("DEBUG Log Level: 1")
			DEBUGLOGLEVEL = 1
		elseif moretext == "2" then
			print("DEBUG Log Level: 2")
			DEBUGLOGLEVEL = 2
		elseif moretext == "3" then
			print("DEBUG Log Level: 3")
			DEBUGLOGLEVEL = 3
		elseif moretext == "4" then
			print("DEBUG Log Level: 4")
			DEBUGLOGLEVEL = 4
		elseif moretext == "5" then
			print("DEBUG Log Level: 5")
			DEBUGLOGLEVEL = 5
		else
			if DEBUGTOGGLE then
				print("Debug is |cff00ff00On|r, Log Level: "..DEBUGLOGLEVEL.."")
			else
				print("Debug is |cffff0000Off|r, Log Level: "..DEBUGLOGLEVEL.."")
			end
			print("Usage: /rahunter debug on \124 off \124 1 \124 2 \124 3 \124 4 \124 5")
		end
	elseif command == "pet" then
		LibHunter.SummonPetNumber = LibHunter.SummonPetNumber + 1
		LibHunter.SummonPet()
	elseif command == "basestats" then
		BaseStatsPrint()
	else
		LibHunter.QueueSpell = nil
	end

	if LibHunter.QueueSpell ~= nil then LibHunter.QueueTime = GetTime() end
end




















----------------------------------------------------------------------------------------------------
-------------------------------------------------|--------------------------------------------------
--                                        SIMC FUNCTIONS                                          --
-------------------------------------------------|--------------------------------------------------
----------------------------------------------------------------------------------------------------





--[[------------------------------------------------------------------------------------------------
SimC14plusCRlessthanorequaltoFD

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimC14plusCRlessthanorequaltoFD()
	--actions+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&(14+cast_regen)<=focus.deficit
	local focus_current 	= UnitPower("player")
	local focus_max 		= UnitPowerMax("player")
	local focus_deficit 	= (focus_max - focus_current)
	local spell_haste		= UnitSpellHaste("player")
	local base_cast_time	= 2
	local cast_time 		= (base_cast_time / ((spell_haste / 100) + 1))
	local cast_regen 		= cast_time * (GetPowerRegen())

	if (14 + cast_regen) <= (focus_deficit) then
		DEBUG(4, "14plusCastRegenlessthanFocusDefict(): true (14 + "..cast_regen..") <= ("..focus_deficit..")")
		return true
	else
		DEBUG(4, "14plusCastRegenlessthanFocusDefict(): false (14 + "..cast_regen..") <= ("..focus_deficit..")")
		return false
	end
end



--[[------------------------------------------------------------------------------------------------
SimCBuffPotionUp

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCBuffPotionUp(itemID)
	local itemID = itemID
	local startTime, duration, enable = GetItemCooldown(itemID)

	if duration > 0 then
		DEBUG(4, "SimCBuffPotionUp: true")
		return true
	else
		DEBUG(4, "SimCBuffPotionUp: false")
		return false
	end
end

--[[------------------------------------------------------------------------------------------------
SimCCRlessthanorequaltoFD

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCCRlessthanorequaltoFD()
	--actions+=/arcane_shot,if=buff.thrill_of_the_hunt.react&focus>35&cast_regen<=focus.deficit|
	local focus_current 	= UnitPower("player")
	local focus_max 		= UnitPowerMax("player")
	local focus_deficit 	= (focus_max - focus_current)
	local spell_haste		= UnitSpellHaste("player")
	local base_cast_time	= 1
	local cast_time 		= (base_cast_time / ((spell_haste / 100) + 1))
	local cast_regen 		= cast_time * (GetPowerRegen())

	if cast_regen <= focus_deficit then
		DEBUG(4, "CastRegen <= Focus Deficit(): true (14 + "..cast_regen..") <= ("..focus_deficit..")")
		return true
	else
		DEBUG(4, "CastRegen <= Focus Deficit(): false ("..cast_regen..") <= ("..focus_deficit..")")
		return false
	end
end


--[[------------------------------------------------------------------------------------------------
SimCFplus14plusCRlessthan80

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCFplus14plusCRlessthan80()
	--actions.aoe+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&focus+14+cast_regen<80
	local focus_current 	= UnitPower("player")
	local spell_haste		= UnitSpellHaste("player")
	local base_cast_time	= 2
	local cast_time 		= (base_cast_time / ((spell_haste / 100) + 1))
	local cast_regen 		= cast_time * (GetPowerRegen())

	if (focus_current + 14 + cast_regen) < 80 then
		DEBUG(4, "Focus + 14 + Cast Regen < 80(): true ("..focus_current.."+ 14 + "..cast_regen..") < 80")
		return true
	else
		DEBUG(4, "Focus + 14 + Cast Regen < 80(): false ("..focus_current.."+ 14 + "..cast_regen..") < 80")
		return false
	end
end


--[[------------------------------------------------------------------------------------------------
REGISTER LIBRARY

--------------------------------------------------------------------------------------------------]]
ProbablyEngine.library.register('LibHunter', LibHunter)