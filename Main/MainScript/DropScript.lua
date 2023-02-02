-- Si observas esta linea en todos los codigos, significara que es importante y que jamas deberias borrarlo
if tostring( script.Parent ) == "MainScript" then return end

--[[----------------------------------------
            Configuracion inicial
----------------------------------------]]--
local dropper = script.Parent

local retraso = dropper:GetAttribute("blockDelay") or 1.5
local offset = dropper:GetAttribute("blockSpawnOffset") or 1.4

--[[----------------------------------------
            Codigo principal
----------------------------------------]]--

local block = game:GetService("ReplicatedStorage").Tycoon.Block

local value = dropper:GetAttribute("blockValue") or 5
local remove = dropper:GetAttribute("blockRemove") or 5

while true do

    wait(retraso)

    local part = block:Clone()
    part:SetAttribute("value", value)
    part.Parent = script.Parent.Parent
    part.CFrame = dropper.Dropper.CFrame - Vector3.new(0, offset, 0)
    game.Debris:AddItem(part, remove)

end
