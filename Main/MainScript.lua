--[[----------------------------------------------------
					Main Script
----------------------------------------------------]]--

local fallbackBlocks = script.Parent.Parent
local players = game:GetService("Players")
local storage = game:GetService("ReplicatedStorage")
local errorHandle = storage:FindFirstChild("Tycoon") and storage.Tycoon:FindFirstChild("ErrorHandle") and require( storage.Tycoon:FindFirstChild("ErrorHandle") ) or nil


--[[----------------------------------------------------
					JSON Module
----------------------------------------------------]]--

local json = {}

function json.decode(str)
	return type(str) == "string" and game:GetService("HttpService"):JSONDecode(str) or str
end

function json.encode(tbl)
	return type(tbl) == "table" and game:GetService("HttpService"):JSONEncode(tbl) or tbl
end




local conveyors = {}
local stuff = {}

for _, buttons in ipairs( script.Parent.Parent.Buttons:GetChildren() ) do
	if not buttons:GetAttribute("isButton") then continue end


	--[[--------------------------------------------
					Buy Items
	--------------------------------------------]]--
	stuff[buttons.Name] = stuff[buttons.Name] or {
		ent = buttons,
		enabled = false
	}

	local buttonScript = script.BuyScript:Clone()
	buttonScript.Parent = buttons

	buttons.Display.Touched:Connect(function(ent)

		if fallbackBlocks:GetAttribute("owner") == 0 then return end

		local ply = game.Players:GetPlayerFromCharacter(ent.Parent)
		if not ply then return end

		if ply.UserId ~= fallbackBlocks:GetAttribute("owner") then return end

		local playerMoney = ply.leaderstats.Dinero.Value
		local value = buttons:GetAttribute("value") or 0
		if playerMoney < value then return end

		ply.leaderstats.Dinero.Value = ply.leaderstats.Dinero.Value - value

		stuff[ buttons:GetAttribute("modelToBuy") ].enabled = true

		local model = stuff[ buttons:GetAttribute("modelToBuy") ].ent
		model.Parent = script.Parent.Parent
		buttons.Parent = nil



		--[[--------------------------------------------
						Remove previus Models
		--------------------------------------------]]--

		local targetmodel = fallbackBlocks:FindFirstChild( buttons:GetAttribute("_removetarget") )
		if targetmodel then
			local removemodel = targetmodel:FindFirstChild( targetmodel:GetAttribute("_removemodel") )

			if removemodel then
				removemodel.Parent = nil
			end
		else
			targetmodel = fallbackBlocks:FindFirstChild( buttons:GetAttribute("dependency") )
			local removemodel = targetmodel:FindFirstChild( targetmodel:GetAttribute("_removemodel") )

			if targetmodel then
				targetmodel.Parent = nil
			end
		end

		wait()
		model:SetAttribute("buyed", true)

	end)

	if buttons:GetAttribute("dependency") then
		local dependency = buttons:GetAttribute("dependency")
		if not fallbackBlocks:FindFirstChild(dependency) then continue end

		fallbackBlocks[ dependency ]:GetAttributeChangedSignal("buyed"):Connect(function()

			if stuff[ dependency ]["ent"]:GetAttribute("buyed") == false then return end
			buttons.Parent = fallbackBlocks

		end)
	end

	continue
end


for _, block in ipairs( script.Parent.Parent:GetChildren() ) do

	--[[--------------------------------------------
					Ignore Blocks
	--------------------------------------------]]--
	if block:GetAttribute("ignore") or block:GetAttribute("enabled") then
		if tostring( block ) == "Main" then continue end

		stuff[block.Name] = {
			ent = block,
			ignore = true,
			enabled = true
		}
	end


	--[[--------------------------------------------
			Buy Items (Backward compatibility)
	--------------------------------------------]]--
	if block:GetAttribute("isButton") then
		if stuff[block.Name] ~= nil then continue end

		stuff[block.Name] = stuff[block.Name] or {
			ent = block,
			enabled = false
		}

		local buttonScript = script.BuyScript:Clone()
		buttonScript.Parent = block

		block.Display.Touched:Connect(function(ent)

			if fallbackBlocks:GetAttribute("owner") == 0 then return end

			local ply = game.Players:GetPlayerFromCharacter(ent.Parent)
			if not ply then return end

			if ply.UserId ~= fallbackBlocks:GetAttribute("owner") then return end

			local playerMoney = ply.leaderstats.Dinero.Value
			local value = block:GetAttribute("value") or 0
			if playerMoney < value then return end

			ply.leaderstats.Dinero.Value = ply.leaderstats.Dinero.Value - value

			stuff[ block:GetAttribute("modelToBuy") ].enabled = true

			local model = stuff[ block:GetAttribute("modelToBuy") ].ent
			model.Parent = script.Parent.Parent
			block.Parent = nil



			--[[--------------------------------------------
							Remove Models
			--------------------------------------------]]--

			local targetmodel = fallbackBlocks:FindFirstChild( block:GetAttribute("_removetarget") )
			if targetmodel then
				local removemodel = targetmodel:FindFirstChild( targetmodel:GetAttribute("_removemodel") )

				if removemodel then
					removemodel.Parent = nil
				end
			else
				targetmodel = fallbackBlocks:FindFirstChild( block:GetAttribute("dependency") )
				local removemodel = targetmodel:FindFirstChild( targetmodel:GetAttribute("_removemodel") )

				if targetmodel then
					targetmodel.Parent = nil
				end
			end

			wait()
			model:SetAttribute("buyed", true)

		end)

		if block:GetAttribute("dependency") then
			local dependency = block:GetAttribute("dependency")
			if not fallbackBlocks:FindFirstChild(dependency) then continue end

			fallbackBlocks[ dependency ]:GetAttributeChangedSignal("buyed"):Connect(function()

				if stuff[ dependency ]["ent"]:GetAttribute("buyed") == false then return end
				block.Parent = fallbackBlocks

			end)
		end

		continue
	end


	--[[--------------------------------------------
					Upgraders
	--------------------------------------------]]--
	if block:GetAttribute("isUpgrader") then
		stuff[block.Name] = stuff[block.Name] or {
			ent = block,
			enabled = false
		}

		local upgraderScript = script.UpgraderScript:Clone()
		upgraderScript.Parent = block

		continue
	end


	--[[--------------------------------------------
					Walls
	--------------------------------------------]]--
	if block:GetAttribute("isWall") then
		stuff[block.Name] = stuff[block.Name] or {
			ent = block,
			enabled = false
		}

		continue
	end


	--[[--------------------------------------------
					Conveyors
	--------------------------------------------]]--
	if block:GetAttribute("isConveyor") then
		stuff[block.Name] = stuff[block.Name] or {
			ent = block,
			enabled = false
		}

		for _, subBlocks in block:GetChildren() do

			if subBlocks:GetAttribute("Conveyor") then
				local script = script.ConveyorScript:Clone()
				script.Parent = subBlocks
			end

			if subBlocks:GetAttribute("Ghosting") then
				subBlocks.Transparency = 1
			end

		end
		
		if block:GetAttribute("_removemodel") ~= ( nil or "" ) then
			local removemodel = block[ block:GetAttribute("_removemodel") ]
			if removemodel then
				stuff[block.Name]["removemodel"] = removemodel
			end
		end


		if not block:GetAttribute("_model") or block:GetAttribute("_model") == ( "" or nil ) then
			errorHandle(block, "model", "string", "This will disable the style/script for decorations", false)
			continue
		end

		local parts = block[block:GetAttribute("_model")]:GetChildren()
		if parts == nil then continue end

		for _, blocks in pairs(parts) do

			--[[--------------------------------------------
							Fading Lights
			--------------------------------------------]]--
			if blocks:GetAttribute("type") == "FadingLight" then
				table.insert(conveyors, blocks)
			end


			--[[--------------------------------------------
							Invisible Blocks
			--------------------------------------------]]--
			if blocks:GetAttribute("Ghosting") then
				blocks.Transparency = 1
			end

		end

		continue
	end


	--[[--------------------------------------------
					Seller Blocks
	--------------------------------------------]]--
	if block:GetAttribute("isSeller") then
		stuff[block.Name] = stuff[block.Name] or {
			ent = block,
			enabled = false
		}

		local parts = block[block:GetAttribute("_model")]:GetChildren() or nil
		if parts == nil then continue end

		local sellerScript = script.SellerScript:Clone()
		sellerScript.Parent = block

		for _, blocks in pairs(parts) do

			--[[--------------------------------------------
							Invisible Blocks
			--------------------------------------------]]--
			if blocks:GetAttribute("Ghosting") then
				blocks.Transparency = 1
			end


		end

		continue
	end


	--[[--------------------------------------------
					Dropper Blocks
	--------------------------------------------]]--
	if block:GetAttribute("isDropper") then
		stuff[block.Name] = stuff[block.Name] or {
			ent = block,
			enabled = false
		}

		local dropScript = script.DropScript:Clone()
		dropScript.Parent = block

		continue
	end

end


--[[----------------------------------------------------
					Post-Script
----------------------------------------------------]]--
local breakwhile = false

function resetTycoon()
	fallbackBlocks:SetAttribute("money", 0)
	
	local reenable = {}
	
	for _, drop in ipairs(fallbackBlocks:GetChildren()) do
		if drop:GetAttribute("isSellable") then
			drop:Remove()
		end
	end
	
	for block, attributes in pairs(stuff) do
		if attributes["ent"]:GetAttribute("enabled") then
			table.insert(reenable, attributes["ent"])
			attributes["enabled"] = true
		end
		
		if attributes["ignore"] then continue end

		if attributes["removemodel"] then
			attributes["removemodel"].Parent = attributes["ent"]
		end

		attributes["enabled"] = false
		attributes["ent"].Parent = nil
		attributes["ent"]:SetAttribute("buyed", false)
	end
	
	for _, block in ipairs(reenable) do
		block.Parent = fallbackBlocks
	end
end
resetTycoon()

fallbackBlocks:GetAttributeChangedSignal("owner"):Connect(function()
	local newOwner = fallbackBlocks:GetAttribute("owner")

	if newOwner == 0 then
		resetTycoon()
		return
	end
	
	local ply = players:GetPlayerByUserId(newOwner)
	if not ply then return end
	
	local tbl = ply:GetAttribute("buyed")
	if tbl == "[]" then return end

	local buyed = json.decode(tbl) or {}
	 
	if type(buyed) == "string" then return end
	
	for item in pairs(buyed) do
		if not stuff[ item ] then continue end

		stuff[ item ]["enabled"] = true
		stuff[ item ]["ent"].Parent = fallbackBlocks
		stuff[ item ]["ent"]:SetAttribute("buyed", true)
	end
	
	-- wait()
	
	for name, block in pairs(stuff) do
		if block["ent"]:GetAttribute("isButton") then
			
			if block["ent"]:GetAttribute("enabled") then
				block["ent"].Parent = nil
				continue
			end

			local dependency = block["ent"]:GetAttribute("dependency")
			local targetbuy  = block["ent"]:GetAttribute("modelToBuy")

			if not stuff[dependency] then continue end
			if not stuff[targetbuy] then continue end

			local removemodel = stuff[dependency]["ent"]:GetAttribute("_removemodel") ~= ( "" or "none" ) and stuff[dependency]["ent"]:GetAttribute("_removemodel") or nil
			if removemodel then
				if stuff[dependency]["ent"]:GetAttribute("buyed") and stuff[targetbuy]["ent"]:GetAttribute("buyed") then
					local lastThing = stuff[ dependency ]["ent"]:FindFirstChild(removemodel)
					if lastThing then
						lastThing.Parent = nil
					end
				end
			end


			if not stuff[dependency]["ent"]:GetAttribute("buyed") then
				
				stuff[ name ]["ent"].Parent = nil
				stuff[ name ]["enabled"] = false
				continue
			end

			if stuff[targetbuy]["ent"]:GetAttribute("buyed") then
				
				stuff[ name ]["ent"].Parent = nil
				stuff[ name ]["enabled"] = true
				continue
			end

			block["ent"].Parent = fallbackBlocks
			block["enabled"] = true
		end
	end
end)


script.Parent.TycoonSpawn.Touched:Connect(function(ent)
	if fallbackBlocks:GetAttribute("owner") ~= 0 then return end
	
	local ply = players:GetPlayerFromCharacter(ent.Parent)
	if not ply then return end

	if ply:GetAttribute("hasTycoon") then return end

	ply:SetAttribute("hasTycoon", true)
	fallbackBlocks:SetAttribute("owner", ply.UserId)
end)

--[[
local Integer = 0
while not breakwhile do

	Integer = Integer >= 0.7 and -0.8 or Integer + 0.1

	for _, Block in pairs(conveyors) do
		Block.Color = Color3.new( math.abs(Integer), 1, 1)
	end

	wait(0.4)
end
--]]
