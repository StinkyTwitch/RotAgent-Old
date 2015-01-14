
----------------------------------------------------------------------------------------------------
-------------------------------------------------|--------------------------------------------------
--                                            GLOBALS                                             --
-------------------------------------------------|--------------------------------------------------
----------------------------------------------------------------------------------------------------
DEBUGLOGLEVEL = 1
DEBUGTOGGLE = true
BASESTATVALUE = {}
UNITSAROUNDUNITCOUNT = 0
UNITSAROUNDUNITTIME = 0










----------------------------------------------------------------------------------------------------
-------------------------------------------------|--------------------------------------------------
--                                       VARIABLES/TABLES                                         --
-------------------------------------------------|--------------------------------------------------
----------------------------------------------------------------------------------------------------


--[[------------------------------------------------------------------------------------------------
GLOBAL TABLE OF BURST HASTE BUFFS

--------------------------------------------------------------------------------------------------]]
BurstHasteBuffs = {
	32182,		-- Heroism
	90355,		-- Ancient Hysteria
	80353,		-- Time Warp
	2825,		-- Bloodlust
	146555		-- Drums
}


--[[------------------------------------------------------------------------------------------------
CLASSIFICATION VALUES FOR NPC UNIT TYPES

--------------------------------------------------------------------------------------------------]]
ClassificationValues = {
	worldboss	= 64,
	rareelite	= 32,
	elite		= 16,
	rare 		= 8,
	normal		= 4,
	trivial		= 2,
	minus		= 1,
	none		= 0,
}


--[[------------------------------------------------------------------------------------------------
GLOBAL TABLE OF IMMUNE AURAS
* Credit: MrTheSoulz for the framework
--------------------------------------------------------------------------------------------------]]
ImmuneAuras = {
	-- CROWD CONTROL
	118,        -- Polymorph
	1513,       -- Scare Beast
	1776,       -- Gouge
	2637,       -- Hibernate
	3355,       -- Freezing Trap
	6770,       -- Sap
	9484,       -- Shackle Undead
	19386,      -- Wyvern Sting
	20066,      -- Repentance
	28271,      -- Polymorph (turtle)
	28272,      -- Polymorph (pig)
	49203,      -- Hungering Cold
	51514,      -- Hex
	61025,      -- Polymorph (serpent) -- FIXME: gone ?
	61305,      -- Polymorph (black cat)
	61721,      -- Polymorph (rabbit)
	61780,      -- Polymorph (turkey)
	76780,      -- Bind Elemental
	82676,      -- Ring of Frost
	90337,      -- Bad Manner (Monkey) -- FIXME: to check
	115078,     -- Paralysis
	115268,     -- Mesmerize
	-- MOP DUNGEONS/RAIDS/ELITES
	106062,     -- Water Bubble (Wise Mari)
	110945,     -- Charging Soul (Gu Cloudstrike)
	116994,     -- Unstable Energy (Elegon)
	122540,     -- Amber Carapace (Amber Monstrosity - Heat of Fear)
	123250,     -- Protect (Lei Shi)
	143574,     -- Swelling Corruption (Immerseus)
	143593,     -- Defensive Stance (General Nazgrim)
	-- WOD DUNGEONS/RAIDS/ELITES
}


--[[------------------------------------------------------------------------------------------------
GLOBAL TABLE OF SPECIAL CASE TARGETS
* Credit: MrTheSoulz for the framework
--------------------------------------------------------------------------------------------------]]
SpecialTargets = {
	-- TRAINING DUMMIES
	31144,      -- Training Dummy - Lvl 80
	31146,      -- Raider's Training Dummy - Lvl ??
	32541,      -- Initiate's Training Dummy - Lvl 55 (Scarlet Enclave)
	32542,      -- Disciple's Training Dummy - Lvl 65
	32545,      -- Initiate's Training Dummy - Lvl 55
	32546,      -- Ebon Knight's Training Dummy - Lvl 80
	32666,      -- Training Dummy - Lvl 60
	32667,      -- Training Dummy - Lvl 70
	46647,      -- Training Dummy - Lvl 85
	60197,      -- Scarlet Monastery Dummy
	67127,      -- Training Dummy - Lvl 90
	87761,      -- Dungeoneer's Training Dummy <Damage> HORDE GARRISON
	88288,		-- Dunteoneer's Training Dummy <Tanking> HORDE GARRISON
	88289,		-- Training Dummy <Healing> HORDE GARRISON
	88314,      -- Dungeoneer's Training Dummy <Tanking> ALLIANCE GARRISON
	88316,      -- Training Dummy <Healing> ALLIANCE GARRISON
	89078,      -- Training Dummy (Garrison)
	87318,      -- Dungeoneer's Training Dummy <Damage>
	-- WOD DUNGEONS/RAIDS
	75966,      -- Defiled Spirit (Shadowmoon Burial Grounds)
	76220,		-- Blazing Trickster (Auchindoun Normal)
	76518,      -- Ritual of Bones (Shadowmoon Burial Grounds)
	79511,		-- Blazing Trickster (Auchindoun Heroic)
	81638,      -- Aqueous Globule (The Everbloom)
}


--[[------------------------------------------------------------------------------------------------
BUFSS THAT WE CAN TRANQUILLIZE SHOT OFF

--------------------------------------------------------------------------------------------------]]
TranqableBuffs = {
	-- PVE
	155498,		-- Black Iron Alchemist (UBRS)
	161203,		-- Kyrak (UBRS)
	-- PVP
}










----------------------------------------------------------------------------------------------------
-------------------------------------------------|--------------------------------------------------
--                                           FUNCTIONS                                            --
-------------------------------------------------|--------------------------------------------------
----------------------------------------------------------------------------------------------------


--[[------------------------------------------------------------------------------------------------
BASE STATS

--------------------------------------------------------------------------------------------------]]
function BaseStats()
	for i=1, 5 do
		BASESTATVALUE[#BASESTATVALUE+1] = UnitStat("player", i)
	end
end


--[[------------------------------------------------------------------------------------------------
BASE STATS PRINT

--------------------------------------------------------------------------------------------------]]
function BaseStatsPrint()
	for k,v in pairs(BASESTATVALUE) do
		print(k, v)
	end
end


--[[------------------------------------------------------------------------------------------------
BURST HASTE CHECK

--------------------------------------------------------------------------------------------------]]
function BurstHasteCheck()
	local count = table.getn(BurstHasteBuffs)

	for i = 1, count do
		if UnitBuff("player", GetSpellName(BurstHasteBuffs[i])) then
			DEBUG(1, "Burst Haste Active!")
			return true
		else
            return false
        end
    end
end


--[[------------------------------------------------------------------------------------------------
CLASSIFICATION VALUE

--------------------------------------------------------------------------------------------------]]
function ClassificationValue(check_value)
	local check_value = string.lower(check_value)

	if check_value == "worldboss" then
		return ClassificationValues.worldboss
	elseif check_value == "rareelite" then
		return ClassificationValues.rareelite
	elseif check_value == "elite" then
		return ClassificationValues.elite
	elseif check_value == "rare" then
		return ClassificationValues.rare
	elseif check_value == "normal" then
		return ClassificationValues.normal
	elseif check_value == "trivial" then
		return ClassificationValues.trivial
	elseif check_value == "minus" then
		return ClassificationValues.minus
	else
		return ClassificationValues.none
	end
end


--[[------------------------------------------------------------------------------------------------
CLEAR TARGET
--------------------------------------------------------------------------------------------------]]
function ClearCurrentTarget()
    if not UnitExists("target") then
    	DEBUG(5, "ClearCurrentTarget->not UnitExists->false")
    	return false
    elseif ImmuneTargetCheck("target") then
    	DEBUG(5, "ClearCurrentTarget->SpecialTargetCheck->false")
        return false
    elseif UnitCanAttack("player", "target") then
    	DEBUG(5, "ClearCurrentTarget->false3")
    	return false
    elseif UnitAffectingCombat("target") then
    	DEBUG(5, "ClearCurrentTarget->false4")
    	return false
    else
    	DEBUG(5, "ClearCurrentTarget->true")
    	return true
    end
end


--[[------------------------------------------------------------------------------------------------
DEBUG PRINT

--------------------------------------------------------------------------------------------------]]
function DEBUG(level, debug_string)
	if DEBUGTOGGLE then
		if level == 5 and DEBUGLOGLEVEL >= 5 then
			print(debug_string)
		elseif level == 4 and DEBUGLOGLEVEL >= 4 then
			print(debug_string)
		elseif level == 3 and DEBUGLOGLEVEL >= 3 then
			print(debug_string)
		elseif level == 2 and DEBUGLOGLEVEL >= 2 then
			print(debug_string)
		elseif level == 1 and DEBUGLOGLEVEL >= 1 then
			print(debug_string)
		else
			return
		end
	end
end


--[[------------------------------------------------------------------------------------------------
EVALUATE CLASSIFICATION

--------------------------------------------------------------------------------------------------]]
function EvalClassification(check_value)
	local check_value = ClassificationValue(string.lower(check_value))
	local actual_value = ClassificationValue(UnitClassification("target"))

	if check_value == actual_value then
		DEBUG(5, "EvalClassification: "..check_value.." = "..actual_value.."")
		return true
	else
		DEBUG(5, "EvalClassification: "..check_value.." != "..actual_value.."")
		return false
	end
end


--[[------------------------------------------------------------------------------------------------
IMMUNE TARGET CHECK
* Credit: MrTheSoulz for the framework

--------------------------------------------------------------------------------------------------]]
function ImmuneTargetCheck(unit)
	local unit = unit

	if not UnitExists(unit) then
		DEBUG(2, "ImmuneTargetCheck() UnitExists->true")
		return false
	else
		if SpecialAuraCheck(unit, ImmuneAuras) then
	    	DEBUG(2, "ImmuneTargetCheck->SpecialAuraCheck->true")
	        return true
	    elseif not UnitCanAttack("player", unit) and not UnitIsFriend("player", unit) then
	    	DEBUG(2, "ImmuneTargetCheck->UnitCanAttack->true")
			return true
	    elseif not UnitAffectingCombat(unit) and not SpecialTargetCheck(unit) then
	    	DEBUG(2, "ImmuneTargetCheck->UnitAffectingCombat,SpecialTargetCheck->true")
	        return true
	    else
	    	DEBUG(2, "ImmuneTargetCheck() false")
	        return false
	    end
	end
end


--[[------------------------------------------------------------------------------------------------
NOTIFICATION FRAME
Creates a textual frame with a status message. Used in the SPELL QUEUE library.
--------------------------------------------------------------------------------------------------]]
function onUpdate(NotificationFrame, elapsed)
	if NotificationFrame.time < GetTime() - 2.0 then
		if NotificationFrame:GetAlpha() == 0 then
			NotificationFrame:Hide()
		else
			NotificationFrame:SetAlpha(NotificationFrame:GetAlpha() - .05)
		end
	end
end
NotificationFrame = CreateFrame("Frame",nil,UIParent)
NotificationFrame:SetSize(500,50)
NotificationFrame:Hide()
NotificationFrame:SetScript("OnUpdate",onUpdate)
NotificationFrame:SetPoint("CENTER")
NotificationFrame.text = NotificationFrame:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
NotificationFrame.text:SetTextHeight(24)
NotificationFrame.text:SetAllPoints()
NotificationFrame.texture = NotificationFrame:CreateTexture()
NotificationFrame.texture:SetAllPoints()
NotificationFrame.texture:SetTexture(0,0,0,.50)
NotificationFrame.time = 0
function NotificationFrame:message(message)
	self.text:SetText(message)
	self:SetAlpha(1)
	self.time = GetTime()
	self:Show()
end


--[[------------------------------------------------------------------------------------------------
SPECIAL AURA CHECK

--------------------------------------------------------------------------------------------------]]
function SpecialAuraCheck(unit, special_aura_table)
	local unit = unit

	if not UnitExists(unit) then
		return false
	end

    for i = 1, 40 do
        local spell_id = select(11, UnitDebuff(unit, i))

        for k,v in pairs(special_aura_table) do
            if spell_id == v then
                return true
            end
        end
        return false
    end
end


--[[------------------------------------------------------------------------------------------------
SPECIAL TARGET CHECK

--------------------------------------------------------------------------------------------------]]
function SpecialTargetCheck(unit)
    local unit = unit
    local count = table.getn(SpecialTargets)

    if not UnitExists(unit) then
        return false
    end

    if UnitGUID(unit) then
        targets_guid = tonumber(string.match(UnitGUID(unit), "-(%d+)-%x+$"))
    else
        targets_guid = 0
    end

    for i=1, count do
        if targets_guid == SpecialTargets[i] then
            return true
        end
    end

    return false
end


--[[------------------------------------------------------------------------------------------------
STAT PROCS

--------------------------------------------------------------------------------------------------]]
function StatProcs(index)
	local index = index
	local current_stat = UnitStat("player", index)

	if current_stat > BASESTATVALUE[index] then
		DEBUG(5, "StatProcs(): TRUE ("..current_stat.." > "..BASESTATVALUE[index]..")")
		return true
	else
		DEBUG(5, "StatProcs(): FALSE ("..current_stat.." < "..BASESTATVALUE[index]..")")
		return false
	end
end


--[[------------------------------------------------------------------------------------------------
TARGET IS INFRONT CHECK

--------------------------------------------------------------------------------------------------]]
function TargetIsInFrontCheck(unit)
	local unit = unit

	if not UnitExists(unit) then
		DEBUG(5, "TargetIsInFrontCheck->UnitExists(unit)->false")
        return false
    end

    local aX, aY, aZ = ObjectPosition(unit)
    local bX, bY, bZ = ObjectPosition("player")
    local player_facing = GetPlayerFacing()
    local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796

    --[[
    if math.abs(math.deg(math.abs(player_facing - (facing))) - 180) < 90 then
    	DEBUG(5, "TargetIsInFrontCheck->angle<90->true")
    	return true
    else
    	DEBUG(5, "TargetIsInFrontCheck->angle<90->false")
    	return false
    end
    --]]
    return math.abs(math.deg(math.abs(player_facing - (facing))) - 180) < 90
end



--[[------------------------------------------------------------------------------------------------
TRINKETS ON COOLDOWN

--------------------------------------------------------------------------------------------------]]
function TrinketsOnCooldown()
	local trinket13_start, trinket13_duration, trinket13_enable = GetActionCooldown(13)
	local trinket14_start, trinket14_duration, trinket14_enable = GetActionCooldown(14)
	if (trinket13_duration > 0) or (trinket14_duration > 0) then
		return true
	else
		return false
	end
end


--[[------------------------------------------------------------------------------------------------
UNITS AROUND UNIT

--------------------------------------------------------------------------------------------------]]
function UnitsAroundUnit(unit, distance, check_value)
    local unit = tostring(unit)
    local distance = tonumber(distance)
    local check_value = check_value
    local update = 0.1

    if UNITSAROUNDUNITTIME and ( (UNITSAROUNDUNITTIME + update) > GetTime() ) then
        if UNITSAROUNDUNITCOUNT > check_value then
        	DEBUG(1, "Total Units Around Unit("..unit.."): "..UNITSAROUNDUNITCOUNT.."")
        	return true
        else
        	return false
        end
    end

    if UnitExists(unit) then
        local total = 0
        local totalObjects = ObjectCount()

        for i = 1, totalObjects do
            local _, object = pcall(ObjectWithIndex, i)
            local _, object_exists = pcall(ObjectExists, object)

            if object_exists then
                local _, oType = pcall(ObjectType, object)
                local bitband = bit.band(oType, ObjectTypes.Unit)

                if bitband > 0 then
                	local _, dead = pcall(UnitIsDeadOrGhost, object)
                	local _, reaction = pcall(UnitReaction, "player", object)
                    local _, special_target = pcall(SpecialTargetCheck, object)
                    local _, tapped_by_me = pcall(UnitIsTappedByMe, object)
                    local _, tapped_by_all = pcall(UnitIsTappedByAllThreatList, object)
                    local _, x1, y1, z1 = pcall(ObjectPosition, unit)
                    local _, x2, y2, z2 = pcall(ObjectPosition, object)
                    local dx = x2 - x1
                    local dy = y2 - y1
                    local dz = z2 - z1
                    local distance_between_unit_and_object = math.sqrt((dx*dx) + (dy*dy) + (dz*dz))

                    if reaction and reaction <= 4 and not dead and (tapped_by_me or tapped_by_all or special_target) then
                        if distance_between_unit_and_object <= distance then
                            total = total + 1
                        end
                    end
                end
            end
        end

        DEBUG(1, "Total Units Around Unit("..unit.."): "..total.."")
        UNITSAROUNDUNITCOUNT = total
        UNITSAROUNDUNITTIME = GetTime()

        if total > check_value then
        	return true
        else
        	return false
        end
    end

end


--[[------------------------------------------------------------------------------------------------
UNIT TO UNIT DISTANCE CHECK

--------------------------------------------------------------------------------------------------]]
function UnitToUnitDistanceCheck(unit1, unit2, distance_check)
	if UnitExists(unit1) and UnitExists(unit2) and UnitCanAttack(unit1, unit2) and not UnitIsDead(unit2) then
		local x1, y1, z1 = ObjectPosition(unit1)
		local x2, y2, z2 = ObjectPosition(unit2)

		local dx = x2 - x1
		local dy = y2 - y1
		local dz = z2 - z1

		local distance = math.sqrt((dx*dx) + (dy*dy) + (dz*dz))

		if distance > distance_check then
			return true
		else
			return false
		end
	else
		return false
	end
end


--[[------------------------------------------------------------------------------------------------
USE OPENER CHECK

--------------------------------------------------------------------------------------------------]]
function UseOpenerCheck(eval_target_type, eval_combat_time)
	if UnitCanAttack("player", "target" ) then
		local actual_target_type = ClassificationValue(UnitClassification("target"))
		local eval_target_type = ClassificationValue(eval_target_type)
		local actual_combat_time = (GetTime() - ProbablyEngine.module.player.combatTime)

		if actual_combat_time <= eval_combat_time and ( actual_target_type >= eval_target_type ) then
			DEBUG(1, "Using Opener: "..actual_combat_time.."")
			return true
		else
			return false
		end
	else
		return false
	end
end