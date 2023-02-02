-- Si observas esta linea en todos los codigos, significara que es importante y que jamas deberias borrarlo
if tostring( script.Parent ) == "MainScript" then return end

--[[----------------------------------------
            Configuracion inicial
----------------------------------------]]--

local upgrader = script.Parent.Upgrader
local multiplier = script.Parent:GetAttribute("add") or 1


--[[----------------------------------------
            Codigo principal
----------------------------------------]]--

upgrader.Touched:Connect(function(ent)

    if not ent:GetAttribute("isSellable") then return end
    if ent:GetAttribute("lastUpgrade") == tostring( script.Parent ) then return end

    local blockMultiplier = ent:GetAttribute("multiplier")

    ent:SetAttribute("lastUpgrade", tostring( script.Parent ))
    ent:SetAttribute("multiplier", blockMultiplier + multiplier)

end)
