--[[--------------------------------
        Configuracion Variables
--------------------------------]]--

local debugging = true

local players = game:GetService("Players")
local database = game:GetService("DataStoreService"):GetDataStore("tycoon")
local storage = game:GetService("ReplicatedStorage")


--[[--------------------------------
            JSON Module
--------------------------------]]--

local json = {}

function json.decode(str)
    return type(str) == "string" and game:GetService("HttpService"):JSONDecode(str) or str
end

function json.encode(tbl)
    return type(tbl) == "table" and game:GetService("HttpService"):JSONEncode(tbl) or tbl
end


local plySpawn = {}

--[[--------------------------------
        OnPlayerInitialSpawn
--------------------------------]]--

players.PlayerAdded:Connect(function(ply)


    --[[--------------------------------
                Crear variables
    --------------------------------]]--
    
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = ply

    local money = Instance.new("IntValue")
    money.Name = "Dinero"
    money.Parent = leaderstats

    local rebirth = Instance.new("IntValue")
    rebirth.Name = "Reinicios"
    rebirth.Parent = leaderstats


    ply:SetAttribute("money", 0)
    ply:SetAttribute("rebirth", 0)
    ply:SetAttribute("hasTycoon", false)
    ply:SetAttribute("buyed", "[]")


    --[[--------------------------------
        Conexion a la base de datos
    --------------------------------]]--

    local buyed = {}
    local connections = 0
    local success, failed = pcall(function()

        money.Value = database:GetAsync(ply.UserId.."_money") or 0
        rebirth.Value = database:GetAsync(ply.UserId.."_rebirth") or 0

        buyed = json.encode( database:GetAsync(ply.UserId.."_buyed") or {} ) or "[]"
        ply:SetAttribute("buyed", buyed)

        --[[--------------------------------
                Datos estadisticos
        --------------------------------]]--

        connections = database:GetAsync(ply.UserId.."_connections") or 0

        ply:SetAttribute("money", money.Value)
        ply:SetAttribute("rebirth", rebirth.Value)

        if ply.UserId == 182030639 then
            money.Value = 7000
            ply:SetAttribute("money", money.Value)
        end
    end)


    --[[--------------------------------
            Prevencion de Errores
    --------------------------------]]--

    if success then
        if debugging then
            print(ply.Name .. " has join the game with the follow data:")
            print(ply.UserId.."_money" .. "            ", money.Value)
            print(ply.UserId.."_rebirth" .. "          ", rebirth.Value)
            print(ply.UserId.."_connections" .. "   ", connections)
            print(ply.UserId.."_buyed", buyed)
        end
    else
        warn("ERROR GETTING DATA")
        warn(failed)
    end
    
    ply.CharacterAdded:Connect(function(character)
        if ply:GetAttribute("hasTycoon") then
            if not plySpawn[ ply.UserId ] then
                for _, tycoon in ipairs(workspace:GetChildren()) do
                    if tycoon:GetAttribute("owner") == ply.UserId then
                        plySpawn[ ply.UserId ] = tycoon.Main.TycoonSpawn
                    end
                end
            end
            
            wait()
            character:PivotTo( plySpawn[ply.UserId].CFrame * CFrame.new(0, 10, 0) )
        end
    end)
end)


--[[--------------------------------
        PlayerDisconnected
--------------------------------]]--

players.PlayerRemoving:Connect(function(ply)

    local pucharsed = json.decode( ply:GetAttribute("buyed") ) or {}

    for _, v in pairs(workspace:GetChildren()) do
        if v:GetAttribute("owner") == ply.UserId then
            
            pucharsed = {}

            for _, buyed in pairs(v:GetChildren()) do
                
                if buyed:GetAttribute("enabled") or buyed:GetAttribute("ignore") then continue end
                if buyed:GetAttribute("isDropper") or buyed:GetAttribute("isConveyor") or buyed:GetAttribute("isUpgrader") or buyed:GetAttribute("isWall") or buyed:GetAttribute("isSeller") then
                    pucharsed[ buyed.Name ] = true
                end

            end

            v:SetAttribute("owner", 0)
        end
    end

    --[[--------------------------------
            Guardado de Datos
    --------------------------------]]--
    local success, failed = pcall(function()

        local connections = ( database:GetAsync(ply.UserId.."_connections") or 0 ) + 1

        database:SetAsync(ply.UserId.."_buyed", pucharsed)
        database:SetAsync(ply.UserId.."_money", ply.leaderstats.Dinero.Value)
        database:SetAsync(ply.UserId.."_rebirth", ply.leaderstats.Reinicios.Value)
        database:SetAsync(ply.UserId.."_connections", connections)

    end)

    if success then
        print(ply.Name .. " has left successful")
    else
        warn("ERROR WRITING DATA")
        warn(failed)
    end
end)
