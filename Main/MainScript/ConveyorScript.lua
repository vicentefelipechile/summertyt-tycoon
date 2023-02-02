-- Si observas esta linea en todos los codigos, significara que es importante y que jamas deberias borrarlo
if tostring( script.Parent ) == "MainScript" then return end

local conveyor = script.Parent
local speed = conveyor.Parent:GetAttribute("speed") or 23

while true do
	conveyor.Velocity = conveyor.CFrame.lookVector * speed
	wait(0.2)
end
