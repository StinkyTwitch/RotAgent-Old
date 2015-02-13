
--[[------------------------------------------------------------------------------------------------
LOCAL GLOBALS
    *   Faster access to variables and functions.
--------------------------------------------------------------------------------------------------]]
local BurstHasteBuffs = BurstHasteBuffs
local ClassificationValues = ClassificationValues
local ImmuneAuras = ImmuneAuras
local SpecialTargets = SpecialTargets
local UnitsAroundUnit_Count = UnitsAroundUnit_Count
local UnitsAroundUnit_Time = UnitsAroundUnit_Time

local LibHunter = {}
LibHunter.BurstHasteCheck = BurstHasteCheck
LibHunter.CastingCheck = CastingCheck
LibHunter.ClassificationValue = ClassificationValue
LibHunter.ClearCurrentTarget = ClearCurrentTarget
LibHunter.ClusterTarget = ClusterTarget
LibHunter.EvalClassification = EvalClassification
LibHunter.ImmuneTargetCheck = ImmuneTargetCheck
LibHunter.NotImmuneTargetCheck = NotImmuneTargetCheck
LibHunter.SpecialAuraCheck = SpecialAuraCheck
LibHunter.SpecialTargetCheck = SpecialTargetCheck
LibHunter.StatProcs = StatProcs
LibHunter.TrinketsOnCooldown = TrinketsOnCooldown
LibHunter.UnitsAroundUnit = UnitsAroundUnit
LibHunter.UnitInRangeCheck = UnitInRangeCheck
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
    local _, current_vector = pcall(ObjectFacing, "player")

    if current_vector ~= vector then
        FaceDirection(vector)
        CastSpellByName("Disengage")
    else
        CastSpellByName("Disengage")
    end
end

-- Disengage Forward
function DisengageForward()
    local _, initial_vector = pcall(ObjectFacing, "player")
    local disengage_vector = (mod( initial_vector + math.pi, math.pi * 2 ))

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
            print("Autotargetting changed to: lowest")
            AUTOTARGETALGORITHM = "lowest"
            CACHEUNITSALGORITHM = "lowest"
        elseif moretext == "nearest" then
            print("Autotargetting changed to: nearest")
            AUTOTARGETALGORITHM = "nearest"
            CACHEUNITSALGORITHM = "nearest"
        elseif moretext == "cascade" then
            print("Autotargetting changed to: cascade")
            AUTOTARGETALGORITHM = "cascade"
        else
            print("Current Autotarget settings: "..AUTOTARGETALGORITHM.."")
            print("Usage: /rahunter autotarget lowest \124 nearest \124 cascade")
        end
    elseif command == "cast" then
        if moretext == "aimed shot" then                -- MM
            LibHunter.QueueSpell =  19434
        elseif moretext == "amoc" then                  -- ALL Talent
            LibHunter.QueueSpell = 131894
        elseif moretext == "aotf" then                  -- ALL
            LibHunter.QueueSpell = 172106
        elseif moretext == "arcane shot" then           -- SV
            LibHunter.QueueSpell = 3044
        elseif moretext == "arcane torrent" then        -- RACIAL
            LibHunter.QueueSpell = 80483
        elseif moretext == "barrage" then               -- ALL Talent
            LibHunter.QueueSpell = 120360
        elseif moretext == "beastial wrath" then        -- BM
            LibHunter.QueueSpell = 19574
        elseif moretext == "berserking" then            -- RACIAL
            LibHunter.QueueSpell = 26297
        elseif moretext == "binding shot" then          -- ALL Talent
            LibHunter.QueueSpell = 109248
        elseif moretext == "black arrow" then           -- SV
            LibHunter.QueueSpell = 3674
        elseif moretext == "blood fury" then            -- RACIAL
            LibHunter.QueueSpell = 20572
        elseif moretext == "camouflage" then            -- ALL
            LibHunter.QueueSpell = 51753
        elseif moretext == "chimaera shot" then         -- MM
            LibHunter.QueueSpell = 53209
        elseif moretext == "cobra shot" then            -- BM
            LibHunter.QueueSpell = 77767
        elseif moretext == "concussive shot" then       -- ALL
            LibHunter.QueueSpell = 5116
        elseif moretext == "counter shot" then          -- ALL
            LibHunter.QueueSpell = 147362
        elseif moretext == "deterrence" then            -- ALL
            LibHunter.QueueSpell = 148467
        elseif moretext == "disengage" then             -- ALL
            LibHunter.QueueSpell = 781
        elseif moretext == "distracting shot" then      -- ALL
            LibHunter.QueueSpell = 20736
        elseif moretext == "explosive shot" then        -- SV
            LibHunter.QueueSpell = 53301
        elseif moretext == "explosive trap" then        -- ALL
            if UnitAura("player", "Trap Launcher") then
                LibHunter.QueueSpell = 82939
            else
                LibHunter.QueueSpell = 13813
            end
        elseif moretext == "feign death" then           -- ALL
            LibHunter.QueueSpell = 5384
        elseif moretext == "flare" then                 -- ALL
            LibHunter.QueueSpell = 1543
        elseif moretext == "focus fire" then            -- BM
            LibHunter.QueueSpell = 82692
        elseif moretext == "focusing shot" then         -- ALL Talent
            LibHunter.QueueSpell = 152245
        elseif moretext == "freezing trap" then         -- ALL
            if UnitAura("player", "Trap Launcher") then
                LibHunter.QueueSpell = 60192
            else
                LibHunter.QueueSpell = 1499
            end
        elseif moretext == "glaive toss" then           -- ALL Talent
            LibHunter.QueueSpell = 117050
        elseif moretext == "ice trap" then
            if UnitAura("player", "Trap Launcher") then -- ALL
                LibHunter.QueueSpell = 82941
            else
                LibHunter.QueueSpell = 13809
            end
        elseif moretext == "intimidation" then          -- ALL Talent
            LibHunter.QueueSpell = 19577
        elseif moretext == "kill command" then          -- BM
            LibHunter.QueueSpell = 34026
        elseif moretext == "kill shot" then             -- MM
            LibHunter.QueueSpell = 157708
        elseif moretext == "masters call" then          -- ALL
            LibHunter.QueueSpell = 53271
        elseif moretext == "mend pet" then              -- ALL
            LibHunter.QueueSpell = 136
        elseif moretext == "multi-shot" then            -- ALL
            LibHunter.QueueSpell = 2643
        elseif moretext == "powershot" then             -- ALL Talent
            LibHunter.QueueSpell = 109259
        elseif moretext == "rapid fire" then            -- MM
            LibHunter.QueueSpell = 3045
        elseif moretext == "stampede" then              -- ALL Talent
            LibHunter.QueueSpell = 121818
        elseif moretext == "steady shot" then           -- MM
            LibHunter.QueueSpell = 56641
        elseif moretext == "tranquilizing shot" then    -- ALL
            LibHunter.QueueSpell = 19801
        elseif moretext == "wyvern sting" then          -- ALL Talent
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


--[[------------------------------------------------------------------------------------------------
SERPENT STING DOT CHECK
    *
--------------------------------------------------------------------------------------------------]]
function LibHunter.SerpentStingDotCheck()
    local count = table.getn(CACHEUNITSTABLE)
    local unit_without_serpent_sting = nil

    for i=1, count do
        local _, x1, y1, z1 = pcall(ObjectPosition, "player")
        local _, x2, y2, z2 = pcall(ObjectPosition, CACHEUNITSTABLE[i].key)
        local dx = x2 - x1
        local dy = y2 - y1
        local dz = z2 - z1
        local distance = math.sqrt((dx*dx) + (dy*dy) + (dz*dz))
        local _, has_serpent_sting = pcall(UnitAura, CACHEUNITSTABLE[i].key, "Serpent Sting")
        --local has_serpent_sting = UnitDebuff(CACHEUNITSTABLE[i].key, "Serpent Sting")

        if has_serpent_sting == nil then
            if distance <= 40 then
                DEBUG(1, "Unit("..CACHEUNITSTABLE[i].key..") has serpent sting ("..tostring(has_serpent_sting)..")")
                unit_without_serpent_sting = i
            end
        end
    end
    if unit_without_serpent_sting ~= nil then
        Macro("/target "..CACHEUNITSTABLE[unit_without_serpent_sting].key)
        Macro("/cast Arcane Shot")
        Macro("/targetlasttarget")
        return true
    end
    return false
end


--[[------------------------------------------------------------------------------------------------
SERPENT STING DOT CHECK
    *
--------------------------------------------------------------------------------------------------]]
function SerpentStingDotCheck()
    local count = table.getn(CACHEUNITSTABLE)
    local unit_without_serpent_sting = nil

    for i=1, count do
        local _, x1, y1, z1 = pcall(ObjectPosition, "player")
        local _, x2, y2, z2 = pcall(ObjectPosition, CACHEUNITSTABLE[i].key)
        local dx = x2 - x1
        local dy = y2 - y1
        local dz = z2 - z1
        local distance = math.sqrt((dx*dx) + (dy*dy) + (dz*dz))
        local _, has_serpent_sting = pcall(UnitAura, CACHEUNITSTABLE[i].key, "Serpent Sting")
        --local has_serpent_sting = UnitDebuff(CACHEUNITSTABLE[i].key, "Serpent Sting")

        if has_serpent_sting == nil then
            if distance <= 40 then
                DEBUG(1, "Unit("..CACHEUNITSTABLE[i].key..") has serpent sting ("..tostring(has_serpent_sting)..")")
                unit_without_serpent_sting = i
            end
        end
    end
    if unit_without_serpent_sting ~= nil then
        ProbablyEngine.dsl.parsedTarget = CACHEUNITSTABLE[unit_without_serpent_sting].key
        return true
    end
    return false
end


--[[------------------------------------------------------------------------------------------------
SUMMON PET
    * Need to verify we have no pet or dismiss pet if we do before using CastSpellByName
--------------------------------------------------------------------------------------------------]]
function LibHunter.SummonPet()
    if LibHunterPRA.SummonPetNumber == 6 then
        LibHunterPRA.SummonPetNumber = 1
    end

    NotificationFrame:message("Summon Pet "..LibHunter.SummonPetNumber.."")

    if UnitExists("pet") then
        CastSpellByName("Dismiss Pet")
        C_Timer.After(4, function() CastSpellByName( "Call Pet "..LibHunter.SummonPetNumber.."" ) end)
    else
        CastSpellByName( "Call Pet "..LibHunter.SummonPetNumber.."" )
    end
end


--[[------------------------------------------------------------------------------------------------
TRANQ A BUFF
    * If target is attackable then we search through the targets buffs/debuffs for "Magic" and ""
    debuffTypes. The "" (blank) type is an oddity with Blizzard. Its the "Enrage" debuffType. If
    it finds a buff we can dispell with Tranquillize the function returns true, otherwise returns
    false.
--------------------------------------------------------------------------------------------------]]
function LibHunter.TranqABuff()

    if UnitExists("target") then
        local total = 0
        local totalObjects = ObjectCount()

        for i = 1, totalObjects do
            local _, object = pcall(ObjectWithIndex, i)
            local _, object_exists = pcall(ObjectExists, object)
            local _, obj_text = pcall(tostring, object)

            if object_exists then
                local _, oType = pcall(ObjectType, object)
                local bitband = bit.band(oType, ObjectTypes.Unit)

                if bitband > 0 then
                    local _, dead = pcall(UnitIsDeadOrGhost, object)
                    local _, reaction = pcall(UnitReaction, "player", object)
                    local _, special_target = pcall(LibHunter.SpecialTargetCheck, object)
                    local _, tapped_by_me = pcall(UnitIsTappedByPlayer, object)
                    local _, tapped_by_all = pcall(UnitIsTappedByAllThreatList, object)

                    if reaction and reaction <= 4 and not dead and (tapped_by_me or tapped_by_all or special_target) then
                        for i = 1, 40 do
                            local dispell_type = select(6, pcall(UnitAura, object, i))

                            if dispell_type == "" or dispell_type == "Magic" then
                                DEBUG(1, "TranqABuff(true) dispell_type:("..dispell_type..") switching target.")
                                Macro("/target "..object.."")
                                return true
                            end
                        end

                        DEBUG(5, "TranqullizeABuff dispellable buff not found")
                        return false

                    end
                end
            end
        end
    else
        DEBUG(5, "TranqullizeABuff->UnitExists false")
        return false
    end
end




















----------------------------------------------------------------------------------------------------
-------------------------------------------------|--------------------------------------------------
--                                        SIMC FUNCTIONS                                          --
-------------------------------------------------|--------------------------------------------------
----------------------------------------------------------------------------------------------------





--[[------------------------------------------------------------------------------------------------
SimC MM 14 + Steady Shot Cast Regen + Aimed Shot Cast Regen <= Focus Deficit

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMM14plusSSCRplusASCRlessthanorequaltoFD()
    --actions+=/steady_shot,if=buff.pre_steady_focus.up&(14+cast_regen+action.aimed_shot.cast_regen)<=focus.deficit
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local ss_base_cast_time = 2
    local ss_cast_time      = (ss_base_cast_time / ((spell_haste / 100) + 1))
    local ss_cast_regen     = ss_cast_time * (GetPowerRegen())
    local as_base_cast_time = 2.5
    local as_cast_time      = (as_base_cast_time / ((spell_haste / 100) + 1))
    local as_cast_regen     = as_cast_time * (GetPowerRegen())

    if (14 + ss_cast_regen + as_cast_regen) <= focus_deficit then
        DEBUG(1, "14 + Steady Shot Cast Regen("..ss_cast_regen..") + Aimed Shot Cast Regen("..as_cast_regen..") <= Focus Deficit("..focus_deficit..") is true")
        return true
    else
        DEBUG(5, "14 + Steady Shot Cast Regen("..ss_cast_regen..") + Aimed Shot Cast Regen("..as_cast_regen..") <= Focus Deficit("..focus_deficit..") is false")
        return false
    end

end


--[[------------------------------------------------------------------------------------------------
SimC MM 50 + Focusing Shot Cast Regen < Focus Deficit

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMM50FSCRlessthanFD()
    --actions.careful_aim+=/focusing_shot,if=50+cast_regen<focus.deficit
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local fs_base_cast_time = 3
    local fs_cast_time      = (fs_base_cast_time / ((spell_haste / 100) + 1))
    local fs_cast_regen     = fs_cast_time * (GetPowerRegen() )

    if (fs_cast_regen < focus_deficit) then
        DEBUG(2, "Focusing Shot Cast Regen("..fs_cast_regen..") < Focus Deficit("..focus_deficit..") is true")
        return true
    else
        DEBUG(5, "Focusing Shot Cast Regen("..fs_cast_regen..") < Focus Deficit("..focus_deficit..") is false")
        return false
    end
end



--[[------------------------------------------------------------------------------------------------
SimC MM 50 + Focusing Shot Cast Regen - 10 < Focus Deficit

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMM50plusFSCRminus10lessthanFD()
    --actions+=/focusing_shot,if=50+cast_regen-10<focus.deficit
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local fs_base_cast_time = 3
    local fs_cast_time      = (fs_base_cast_time / ((spell_haste / 100) + 1))
    local fs_cast_regen     = fs_cast_time * (GetPowerRegen())

    if (50 + fs_cast_regen - 10) < focus_deficit then
        DEBUG(2, "50 + Focusing Shot Cast Regen("..fs_cast_regen..") - 10 < Focus Deficit("..focus_deficit..") is true")
        return true
    else
        DEBUG(5, "50 + Focusing Shot Cast Regen("..fs_cast_regen..") - 10 < Focus Deficit("..focus_deficit..") is false")
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SimC MM Dire Beast Cast Regen + Aimed Shot Cast Regen < Focus Deficit

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMMDBCRplusASCRlessthanFD()
    --actions+=/dire_beast,if=cast_regen+action.aimed_shot.cast_regen<focus.deficit
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local db_base_cast_time = 1
    local db_cast_time      = (db_base_cast_time / ((spell_haste / 100) + 1))
    local db_cast_regen     = db_cast_time * (GetPowerRegen())

    local as_base_cast_time = 2.5
    local as_cast_time      = (as_base_cast_time / ((spell_haste / 100) + 1))
    local as_cast_regen     = as_cast_time * (GetPowerRegen())

    if (db_cast_regen + as_cast_regen) < focus_deficit then
        DEBUG(2, "Dire Beast Cast Regen("..db_cast_regen..") + Aimed Shot Cast Regen("..as_cast_regen..") < Focus Deficit("..focus_deficit..") is true")
        return true
    else
        DEBUG(5, "Dire Beast Cast Regen("..db_cast_regen..") + Aimed Shot Cast Regen("..as_cast_regen..") < Focus Deficit("..focus_deficit..") is false")
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SimC MM Focus + Aimed Shot Cast Regen >= 65

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMMFplusASCRgreaterthanorequalto65()
    --actions+=/aimed_shot,if=buff.thrill_of_the_hunt.react&focus+cast_regen>=65
    local focus_check       = 65
    local focus_current     = UnitPower("player")
    local spell_haste       = UnitSpellHaste("player")
    local as_base_cast_time = 2.5
    local as_cast_time      = (as_base_cast_time / ((spell_haste / 100) + 1))
    local as_cast_regen     = as_cast_time * (GetPowerRegen())

    if (focus_current + as_cast_regen) >= focus_check then
        DEBUG(1, "Focus("..focus_current..") + Aimed Shot Cast Regen("..as_cast_regen..") >= 65 is true")
        return true
    else
        DEBUG(5, "Focus("..focus_current..") + Aimed Shot Cast Regen("..as_cast_regen..") >= 65 is false")
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SimC MM Focus + Aimed Shot Cast Regen >= 85

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMMFplusASCRgreaterthanorequalto85()
    --actions+=/aimed_shot,if=focus+cast_regen>=85
    local focus_check       = 85
    local focus_current     = UnitPower("player")
    local spell_haste       = UnitSpellHaste("player")
    local as_base_cast_time = 2.5
    local as_cast_time      = (as_base_cast_time / ((spell_haste / 100) + 1))
    local as_cast_regen     = as_cast_time * (GetPowerRegen())

    if (focus_current + as_cast_regen) >= focus_check then
        DEBUG(1, "Focus("..focus_current..") + Aimed Shot Cast Regen("..as_cast_regen..") >= 85 is true")
        return true
    else
        DEBUG(5, "Focus("..focus_current..") + Aimed Shot Cast Regen("..as_cast_regen..") >= 85 is false")
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SimC MM Focus Deficit * Focusing Shot Cast Time / 50 + Focusing Shot Cast Regen > Rapid Fire Cooldown

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMMFDtimesFSCTdividedby50plusFSCRgreatherthanRFCD()
    --actions+=/focusing_shot,if=focus.deficit*cast_time%(50+cast_regen)>cooldown.rapid_fire.remains&focus<100
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local fs_base_cast_time = 3
    local fs_cast_time      = (fs_base_cast_time / ((spell_haste / 100) + 1))
    local fs_cast_regen     = fs_cast_time * ( GetPowerRegen() )
    local rapid_fire_start, rapid_fire_duration, enabled = GetSpellCooldown("Rapid Fire")
    local rapid_fire_cd     = math.abs((rapid_fire_start + rapid_fire_duration) - GetTime())

    if ((focus_deficit * fs_cast_time) / (14 + fs_cast_regen)) > rapid_fire_cd then
        DEBUG(2, "F.D.("..focus_deficit..") * F.S.C.T.("..fs_cast_time..") / 50 + F.S.C.R.("..fs_cast_regen..") > Rapid Fire Cooldown("..rapid_fire_cd..") is true")
        return true
    else
        DEBUG(5, "F.D.("..focus_deficit..") * F.S.C.T.("..fs_cast_time..") / 50 + F.S.C.R.("..fs_cast_regen..") > Rapid Fire Cooldown("..rapid_fire_cd..") is false")
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SimC MM Focus Deficit * Steady Shot Cast Time / 14 + Steady Shot Cast Regen > Rapid Fire Cooldown

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMMFDtimesSSCTdividedby14plusSSCRgreatherthanRFCD()
    --actions+=/steady_shot,if=focus.deficit*cast_time%(14+cast_regen)>cooldown.rapid_fire.remains
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local ss_base_cast_time = 2
    local ss_cast_time      = (ss_base_cast_time / ((spell_haste / 100) + 1))
    local ss_cast_regen     = ss_cast_time * ( GetPowerRegen() )
    local rapid_fire_start, rapid_fire_duration, enabled = GetSpellCooldown("Rapid Fire")
    local rapid_fire_cd     = math.abs((rapid_fire_start + rapid_fire_duration) - GetTime())

    if ((focus_deficit * ss_cast_time) / (14 + ss_cast_regen)) > rapid_fire_cd then
        DEBUG(1, "S.D.("..focus_deficit..") * S.S.C.T.("..ss_cast_time..") / 14 + S.S.C.R.("..ss_cast_regen..") > Rapid Fire Cooldown("..rapid_fire_cd..") is true")
        return true
    else
        DEBUG(5, "F.D.("..focus_deficit..") * S.S.C.T.("..ss_cast_time..") / 14 + S.S.C.R.("..ss_cast_regen..") > Rapid Fire Cooldown("..rapid_fire_cd..") is false")
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SimC MM Powershot Cast Regen < Focus Deficit

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCMMPSCRlessthanFD()
    --actions+=/powershot,if=cast_regen<focus.deficit
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local ps_base_cast_time = 2.25
    local ps_cast_time      = (ps_base_cast_time / ((spell_haste / 100) + 1))
    local ps_cast_regen     = ps_cast_time * (GetPowerRegen() )

    if (ps_cast_regen < focus_deficit) then
        DEBUG(2, "Powershot Cast Regen("..ps_cast_regen..") < Focus Deficit("..focus_deficit..") is true")
        return true
    else
        DEBUG(5, "Powershot Cast Regen("..ps_cast_regen..") < Focus Deficit("..focus_deficit..") is false")
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SimC SV 14 + Cobra Shot Cast Regen <= Focus Deficit

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCSV14plusCSCRlessthanorequaltoFD()
    --actions+=/cobra_shot,if=buff.pre_steady_focus.up&buff.steady_focus.remains<5&(14+cast_regen)<=focus.deficit
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local cs_base_cast_time = 2
    local cs_cast_time      = (cs_base_cast_time / ((spell_haste / 100) + 1))
    local cs_cast_regen     = cs_cast_time * (GetPowerRegen())

    if (14 + cs_cast_regen) <= (focus_deficit) then
        DEBUG(2, "14 + Cobra Shot Cast Regen("..cs_cast_regen..") <= Focus Deficit("..focus_deficit..") is true")
        return true
    else
        DEBUG(5, "14 + Cobra Shot Cast Regen("..cs_cast_regen..") <= Focus Deficit("..focus_deficit..") is true")
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
Careful Aim Check

--------------------------------------------------------------------------------------------------]]
function LibHunter.CarefulAimCheck(check_value)
    --actions+=/call_action_list,name=careful_aim,if=buff.careful_aim.up
    if UnitCanAttack("player", "target") then
        local check_target = ClassificationValue(UnitClassification("target"))
        local check_value = ClassificationValue(check_value)
        local target_health = (tonumber(format("%.2f", (UnitHealth("target") / UnitHealthMax("target")) * 100 )))
        local combat_time = (GetTime() - ProbablyEngine.module.player.combatTime)
        local rapid_fire_start, rapid_fire_duration, enabled = GetSpellCooldown("Rapid Fire")
        local rapid_fire_active = (math.abs(rapid_fire_start - GetTime()))

        if UnitBuff("player", "Rapid Fire") then
            DEBUG(1, "Using Careful Aim rotation (Rapid Fire up)!"..rapid_fire_active.."")
            return true
        elseif (check_target >= check_value) and target_health > 80 then
            DEBUG(1, "Using Careful Aim rotation (Target health > 80)!"..combat_time.."")
            return true
        else
            DEBUG(5, "Rapid Fire and/or Careful Aim not active")
            return false
        end
    else
        DEBUG(5, "Player can not attack target")
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SimCCRlessthanorequaltoFD

--------------------------------------------------------------------------------------------------]]
function LibHunter.SimCCRlessthanorequaltoFD()
    --actions+=/arcane_shot,if=buff.thrill_of_the_hunt.react&focus>35&cast_regen<=focus.deficit|
    local focus_current     = UnitPower("player")
    local focus_max         = UnitPowerMax("player")
    local focus_deficit     = (focus_max - focus_current)
    local spell_haste       = UnitSpellHaste("player")
    local base_cast_time    = 1
    local cast_time         = (base_cast_time / ((spell_haste / 100) + 1))
    local cast_regen        = cast_time * (GetPowerRegen())

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
    local focus_current     = UnitPower("player")
    local spell_haste       = UnitSpellHaste("player")
    local base_cast_time    = 2
    local cast_time         = (base_cast_time / ((spell_haste / 100) + 1))
    local cast_regen        = cast_time * (GetPowerRegen())

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