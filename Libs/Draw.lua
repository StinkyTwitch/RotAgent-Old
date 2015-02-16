local LibDraw = LibStub("LibDraw-1.0")

--[[------------------------------------------------------------------------------------------------
LIBDRAW SYNC

--------------------------------------------------------------------------------------------------]]
LibDraw.Sync(function()
    if FireHack then
        for index=1, #CACHEUNITSTABLE do
            local _, serpent_stung = pcall(UnitDebuff, CACHEUNITSTABLE[index].key, "Serpent Sting")
            local _, unit_exists = pcall(UnitExists, CACHEUNITSTABLE[index].key)

            if not serpent_stung and unit_exists then
                LibDraw.SetColor(255, 0, 0, 255)
                LibDraw.SetWidth(1)

                local targetX, targetY, targetZ = ObjectPosition(CACHEUNITSTABLE[index].key)
                local _, combat_reach = pcall(UnitCombatReach,CACHEUNITSTABLE[index].key)

                LibDraw.Circle(targetX, targetY, targetZ, combat_reach)
            end
        end

        if LIBDRAWPARSEDTARGET ~= nil then
            LibDraw.SetColor(0, 255, 0, 255)
            LibDraw.SetWidth(1)
            local _, unit_exists = pcall(UnitExists, LIBDRAWPARSEDTARGET)
            local playerX, playerY, playerZ = ObjectPosition("player")
            local _, targetX, targetY, targetZ = pcall(ObjectPosition, LIBDRAWPARSEDTARGET)
            local _, combat_reach = pcall(UnitCombatReach, LIBDRAWPARSEDTARGET)

            if unit_exists then
                LibDraw.Circle(targetX, targetY, targetZ, combat_reach)
                LibDraw.Line(playerX, playerY, playerZ, targetX, targetY, targetZ)
                C_Timer.After(1, function() LIBDRAWPARSEDTARGET = nil end)
            end
        end
        --[[
        if UnitExists("target") then
            LibDraw.SetColor(255, 0, 0, 255)
            LibDraw.SetWidth(1)

            local binding_shot = "109248"
            local binding_shot_reach = 5
            local barrage = "120360"
            local barrage_reach = 40
            local bsstart, bsduration, bsenabled = GetSpellCooldown(binding_shot)
            local barstart, barduration, barenabled = GetSpellCooldown(barrage)
            local combat_reach = UnitCombatReach("target")
            local playerX, playerY, playerZ = ObjectPosition("player")
            local targetX, targetY, targetZ = ObjectPosition("target")
            local reaction = UnitReaction("player", "target")
            local rotation = ObjectFacing("player")

            --LibDraw.Circle(targetX, targetY, targetZ, combat_reach)

            --if bsduration == 0 and reaction and reaction <= 4 then
            --    LibDraw.Circle(targetX, targetY, targetZ, binding_shot_reach)
            --end

            --if barduration == 0 and reaction and reaction <= 4 then
            --    LibDraw.Arc(playerX, playerY, playerZ, barrage_reach, 180, rotation)
            --end
        end
        ]]
    end
end)