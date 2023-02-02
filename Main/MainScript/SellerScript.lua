-- Si observas esta linea en todos los codigos, significara que es importante y que jamas deberias borrarlo
if tostring( script.Parent ) == "MainScript" then return end

--[[----------------------------------------
            Configuracion inicial
----------------------------------------]]--

local seller = script.Parent.Seller
local tycoon = script.Parent.Parent


--[[----------------------------------------
            Codigo principal
----------------------------------------]]--

seller.Transparency = 1

seller.Touched:Connect(function(ent)
    if not ent:GetAttribute("isSellable") then return end
    
    local value = math.floor( ent:GetAttribute("value") * ( ent:GetAttribute("multiplier") or 1 ) )
    local money = tycoon:GetAttribute("money")
    
    tycoon:SetAttribute("money", money + value )
    
    ent:Remove()
end)
