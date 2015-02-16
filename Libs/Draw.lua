local LibDraw = LibStub("LibDraw-1.0")

-- Any time you want to change the color or width of the lines being drawn, you have access to these functions.
--LibDraw.SetColor(255, 0, 0, 255) -- Sets the RGB color in values of 0-255
--LibDraw.SetColorRaw(1, 1, 1, 1) -- Sets the RGB color in values of 0-1
--LibDraw.SetWidth(1) -- Sets the width of the line in pixels

-- If you need help with X, Y and Z coordinates or are confused about which direction is which.
-- You can set the helper value to true and it will draw a origin that should help a lot.



--[[------------------------------------------------------------------------------------------------
LIB DRAW

--------------------------------------------------------------------------------------------------]]
LibDraw.Sync(function()
    if FireHack then
        for index=1, #CACHEUNITSTABLE do
            local serpent_stung = UnitDebuff(CACHEUNITSTABLE[index].key, "Serpent Sting")
            if not serpent_stung then
                LibDraw.helper = true
                LibDraw.SetColor(255, 0, 0, 255)
                LibDraw.SetWidth(1)
                local targetX, targetY, targetZ = ObjectPosition(CACHEUNITSTABLE[index].key)
                LibDraw.Circle(targetX, targetY, targetZ, 2)
            end
        end
    end
    --[[
    if FireHack and UnitExists("target") then

        LibDraw.SetColor(255, 0, 0, 255)
        LibDraw.SetWidth(1)

        local playerX, playerY, playerZ = ObjectPosition("player")
        local targetX, targetY, targetZ = ObjectPosition("target")

        LibDraw.Line(playerX, playerY, playerZ, targetX, targetY, targetZ)

        LibDraw.Circle(targetX, targetY, targetZ, 5)
    end
    ]]
end)