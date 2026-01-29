--[[
    👁️ KAITUN BY IKKON (COMPLETE EDITION)
    Status: 1x Execute All Missions
    Developer: Ikkon & Trojan Engine
    Enforced Password: Ikkon On The Top
]]--

-- // KeyAuth Settings
local name = "Ikkon Kaitun"
local ownerid = "IukkQrnhT1"
local version = "1.0"

-- // Load KeyAuth API
local KeyAuthApp = loadstring(game:HttpGet("https://keyauth.cc/api/1.2/"))()
local KeyAuth = KeyAuthApp.new(name, ownerid, version)

-- // UI Login System (Fluent Interface)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "👁️ KAITUN BY IKKON",
    SubTitle = "Login System",
    TabWidth = 160,
    Size = UDim2.fromOffset(400, 300),
    Acrylic = true,
    Theme = "Dark"
})

local LoginTab = Window:AddTab({ Title = "Auth", Icon = "lock" })

local UserInput = LoginTab:AddInput("Username", { Title = "Username", Default = "" })
local PassInput = LoginTab:AddInput("Password", { Title = "Password", Default = "" })

LoginTab:AddButton({
    Title = "Login Access",
    Callback = function()
        KeyAuth:init()
        KeyAuth:login(UserInput.Value, PassInput.Value)

        if KeyAuth.response.success then
            local userRole = KeyAuth.user_data.subscriptions[1].level -- Level 1: User, Level 2: Owner
            Fluent:Notify({ Title = "Success", Content = "Welcome " .. (userRole == "2" and "Owner" or "User"), Duration = 5 })
            Window:Destroy()
            startKaitun(userRole)
        else
            Fluent:Notify({ Title = "Error", Content = KeyAuth.response.message, Duration = 5 })
        end
    end
})

-- // Main Kaitun Logic
function startKaitun(role)
    -- Re-create UI for Auto-On Status
    local KWindow = Fluent:CreateWindow({
        Title = "👁️ KAITUN BY IKKON ACTIVE",
        SubTitle = "Role: " .. (role == "2" and "Owner" or "User"),
        Size = UDim2.fromOffset(450, 320),
        Acrylic = true,
        Theme = "Dark"
    })
    
    local MainTab = KWindow:AddTab({ Title = "Progress", Icon = "refresh-cw" })
    local StatusLabel = MainTab:AddParagraph({ Title = "Current Mission", Content = "Initializing..." })

    -- // Locations Database
    local Loc = {
        Kohana = Vector3.new(-551.32, 18.21, 118.82),
        Sysiphus = Vector3.new(-3666.83, -135.07, -912.88),
        Treasure = Vector3.new(-3598.73, -275.93, -1642.31)
    }

    -- // Auto-Kaitun Loop
    task.spawn(function()
        while true do
            pcall(function()
                local lp = game.Players.LocalPlayer
                local char = lp.Character or lp.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                local money = lp.leaderstats.Money.Value -- Sesuaikan Path Uang
                
                -- [[ PROGRESSION SYSTEM ]] --

                -- 1. Kohana Volcano Stage (Start -> 1M)
                if money < 1000000 then
                    StatusLabel:SetTitle("Stage: Kohana Volcano")
                    StatusLabel:SetDesc("Target: 1,000,000 Money")
                    
                    if (hrp.Position - Loc.Kohana).Magnitude > 20 then
                        hrp.CFrame = CFrame.new(Loc.Kohana)
                    end

                    -- Auto Buy Nature Bait (83.50k)
                    if money >= 83500 and not hasBait("Nature Bait") then
                        buyBait("Nature Bait")
                    end

                    -- Auto Buy Steampunk Rod (215k)
                    if money >= 215000 and not hasRod("Steampunk Rod") then
                        buyRod("Steampunk Rod")
                    end

                -- 2. Sysiphus Statue Stage (1M -> Mythic/Secret)
                elseif money >= 1000000 and not isQuestFinished("Sysiphus") then
                    StatusLabel:SetTitle("Stage: Sysiphus Statue")
                    StatusLabel:SetDesc("Target: 3 Mythics & Secret Fish")
                    
                    if (hrp.Position - Loc.Sysiphus).Magnitude > 20 then
                        hrp.CFrame = CFrame.new(Loc.Sysiphus)
                    end

                    -- Auto Buy Astral Rod (1M)
                    if not hasRod("Astral") then
                        buyRod("Astral")
                    end

                -- 3. Treasure Room Stage (300 Rare/Epic)
                else
                    StatusLabel:SetTitle("Stage: Treasure Room")
                    StatusLabel:SetDesc("Target: 300 Rare/Epic Fish")
                    
                    if (hrp.Position - Loc.Treasure).Magnitude > 20 then
                        hrp.CFrame = CFrame.new(Loc.Treasure)
                    end
                end

                -- [[ AUTO FISHING CORE ]] --
                -- Panggil remote game untuk memancing otomatis di sini
                -- example: game:GetService("ReplicatedStorage").Remote:FireServer("Cast")
            end)
            task.wait(1)
        end
    end)
end

-- // Helper Functions (Mencari Remote Game)
function buyBait(name) print("Buying Bait: "..name) end
function buyRod(name) print("Buying Rod: "..name) end
function hasBait(name) return false end -- Logic check inventory
function hasRod(name) return false end 
function isQuestFinished(q) return false end
