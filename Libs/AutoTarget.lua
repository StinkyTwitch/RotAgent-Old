
AUTOTARGETALGORITHM = "lowest"
CACHEUNITSALGORITHM = "lowest"
CACHEUNITSTABLE = {}

--[[------------------------------------------------------------------------------------------------
AUTO TARGET

--------------------------------------------------------------------------------------------------]]
function AutoTarget()
    if UnitExists("target") and not UnitIsDeadOrGhost("target") then
        return false
    end

    local count = table.getn(CACHEUNITSTABLE)
    DEBUG(5, "CACHEUNITSTABLE count: ("..count..")")

    if AUTOTARGETALGORITHM == "lowest" or AUTOTARGETALGORITHM == "nearest" then
        for i=1, count do
            if ObjectExists(CACHEUNITSTABLE[i].key) then
                DEBUG(5, "ObjectExists(): true")
                if not ImmuneTargetCheck(CACHEUNITSTABLE[i].key) then
                    DEBUG(5, "ImmuneTargetCheck(): false")
                    if TargetIsInFrontCheck(CACHEUNITSTABLE[i].key) then
                        DEBUG(5, "TargetIsInFrontCheck(): true")
                        if UnitCanAttack("player", CACHEUNITSTABLE[i].key) then
                            DEBUG(5, "UnitCanAttack(true)")
                            DEBUG(4, "Targeting: "..CACHEUNITSTABLE[i].key.."")
                            return Macro("/target "..CACHEUNITSTABLE[i].key)
                        else
                            DEBUG(5, "UnitCanAttack(false)")
                        end
                    else
                        DEBUG(5, "TargetIsInFrontCheck(): false")
                    end
                else
                    DEBUG(5, "ImmuneTargetCheck(): true")
                end
            else
                DEBUG(5, "ObjectExists(): false")
            end
        end
    else
        for i=1, count do
            if GetRaidTargetIndex("..CACHEUNITSTABLE[i].key..") == 8 then
                DEBUG(4, "Targeting: Skull")
                return Macro("/target "..CACHEUNITSTABLE[i].key)
            end
        end
        if UnitExists("focustarget") then
            DEBUG(4, "Targeting: Focus' Target")
            return Macro("/target focustarget")
        else
            for i=1, count do
                if ObjectExists(CACHEUNITSTABLE[i].key) then
                    DEBUG(5, "ObjectExists(): true")
                    if not ImmuneTargetCheck(CACHEUNITSTABLE[i].key) then
                        DEBUG(5, "ImmuneTargetCheck(): false")
                        if TargetIsInFrontCheck(CACHEUNITSTABLE[i].key) then
                            DEBUG(5, "TargetIsInFrontCheck(): true")
                            if UnitCanAttack("player", CACHEUNITSTABLE[i].key) then
                                DEBUG(5, "UnitCanAttack(true)")
                                DEBUG(4, "Targeting: "..CACHEUNITSTABLE[i].key.."")
                                return Macro("/target "..CACHEUNITSTABLE[i].key)
                            else
                                DEBUG(5, "UnitCanAttack(false)")
                            end
                        else
                            DEBUG(5, "TargetIsInFrontCheck(): false")
                        end
                    else
                        DEBUG(5, "ImmuneTargetCheck(): true")
                    end
                else
                    DEBUG(5, "ObjectExists(): false")
                end
            end
        end

    end

    DEBUG(5, "AutoTarget() false")
    return false
end

--[[------------------------------------------------------------------------------------------------
CACHE UNITS

--------------------------------------------------------------------------------------------------]]
function CacheUnits()
    wipe(CACHEUNITSTABLE)
    local total_objects = ObjectCount()

    for i=1, total_objects do
        local _, object = pcall(ObjectWithIndex, i)
        local _, object_exists = pcall(ObjectExists, object)

        if object_exists then
            local _, obj_text = pcall(tostring, object)
            local _, oType = pcall(ObjectType, object)
            local bitband = bit.band(oType, ObjectTypes.Unit)

            local _, x1, y1, z1 = pcall(ObjectPosition, "player")
            local _, x2, y2, z2 = pcall(ObjectPosition, object)
            local dx = x2 - x1
            local dy = y2 - y1
            local dz = z2 - z1
            local distance = math.sqrt((dx*dx) + (dy*dy) + (dz*dz))

            local _, pcall_health = pcall(UnitHealth, object)
            local _, pcall_health_max = pcall(UnitHealthMax, object)
            local health = math.floor((pcall_health / pcall_health_max) * 100)

            local _, reaction = pcall(UnitReaction, "player", object)
            local _, special_target = pcall(SpecialTargetCheck, object)
            local _, tapped_by_me = pcall(UnitIsTappedByPlayer, object)
            local _, tapped_by_all_threat_list = pcall(UnitIsTappedByAllThreatList, object)


            if bitband > 0 then
                DEBUG(4, "("..i..") bit.band compare true: "..oType..","..ObjectTypes.Unit.." bit.band:  ("..bitband..")")
                if distance <= 40 then
                    DEBUG(4, "("..i..") Distance: ("..distance..") <= 40 true")
                    if health > 0 then
                        DEBUG(4, "("..i..") Health: ("..health..") > 0 true")
                        if reaction and reaction <= 4 and (tapped_by_me or tapped_by_all or special_target) then
                            DEBUG(4, "("..i..") Reaction("..reaction..") TappedByMe("..tostring(tapped_by_me)..") TappedByAll("..tostring(tapped_by_all_threat_list)..") or SpecialTarget("..tostring(special_target)..")")
                            if CACHEUNITSALGORITHM == "nearest" then
                                CACHEUNITSTABLE[#CACHEUNITSTABLE+1] = {key = obj_text, value = distance}
                                table.sort(CACHEUNITSTABLE, function(a,b) return a.value < b.value end)
                                DEBUG(3, ""..i..": Object Pointer: "..obj_text.." - Distance: "..distance.."")
                            elseif CACHEUNITSALGORITHM == "lowest" then
                                CACHEUNITSTABLE[#CACHEUNITSTABLE+1] = {key = obj_text, value = health}
                                table.sort(CACHEUNITSTABLE, function(a,b) return a.value < b.value end)
                                DEBUG(3, ""..i..": Object Pointer: "..obj_text.." - Health: "..health.."")
                            end
                        else
                            DEBUG(5, "("..i..") Reaction("..reaction..") TappedByMe("..tostring(tapped_by_me)..") TappedByAll("..tostring(tapped_by_all_threat_list)..") or SpecialTarget("..tostring(special_target)..")")
                        end
                    else
                        DEBUG(5, "("..i..") health: ("..health..") > 0 false")
                    end
                else
                    DEBUG(5, "("..i..") distance: ("..distance..") <= 40 false")
                end
            else
                DEBUG(5, "("..i..") bit.band compare false: "..oType..","..ObjectTypes.Unit.." bit.band:  ("..bitband..")")
            end
        end
    end
end