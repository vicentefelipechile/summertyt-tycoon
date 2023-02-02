-- Si observas esta linea en todos los codigos, significara que es importante y que jamas deberias borrarlo
if tostring( script.Parent ) == "MainScript" then return end

local button = script.Parent
local price = button:GetAttribute("value")

button.Display.BillboardGui.Frame.Frame.Text.Text = price <= 0 and "Gratis" or price .. "$"
button.Display.BillboardGui2.Text.Text = button:GetAttribute("name")
