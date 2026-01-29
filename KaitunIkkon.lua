local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")

local Window = Fluent:CreateWindow({
    Title = "IKKONCORPS :: FISH IT OVERRIDE ⚡",
    SubTitle = "Security Bypassed by RianModss",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- [[ OVERLAY HUD EXTERNAL (PING, FPS, CPU) ]] --
local OverlayGui = Instance.new("ScreenGui")
OverlayGui.Name = "IkkonStats"
OverlayGui.Parent = game.CoreGui

local StatLabel = Instance.new("TextLabel")
StatLabel.Parent = OverlayGui
StatLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatLabel.BackgroundTransparency = 0.5
StatLabel.Position = UDim2.new(0.4, 0, 0, 10) -- Atas Tengah
StatLabel.Size = UDim2.new(0, 250, 0, 30)
StatLabel.Font = Enum.Font.Code
StatLabel.Text = "PING: ... | FPS: ... | CPU: ..."
StatLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
StatLabel.TextSize = 14
local StatCorner = Instance.new("UICorner")
StatCorner.CornerRadius = UDim.new(0, 5)
StatCorner.Parent = StatLabel

-- [[ FLOATING RESTORE BUTTON ]] --
local RestoreGui = Instance.new("ScreenGui")
local RestoreBtn = Instance.new("TextButton")
RestoreGui.Name = "IkkonRestore"
RestoreGui.Parent = game.CoreGui
RestoreGui.Enabled = false

RestoreBtn.Size = UDim2.new(0, 60, 0, 60)
RestoreBtn.Position = UDim2.new(0.5, -30, 0.5, -30) -- Tengah Layar
RestoreBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RestoreBtn.Text = "IKK"
RestoreBtn.Font = Enum.Font.BlackOpsOne
RestoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RestoreBtn.TextSize = 20
RestoreBtn.Parent = RestoreGui
RestoreBtn.Draggable = true
Instance.new("UICorner", RestoreBtn).CornerRadius = UDim.new(1, 0) -- Lingkaran

-- [[ UPDATE LOGIC ]] --
spawn(function()
    while true do
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        local cpu = math.floor(game:GetService("Stats").TotalMemoryUsageMb) -- Representasi Load Memori/CPU
        
        StatLabel.Text = string.format("PING: %dms | FPS: %d | CPU: %dMB", ping, fps, cpu)
        task.wait(0.5)
    end
end)

Window.OnMinimize:Connect(function()
    RestoreGui.Enabled = true
end)

RestoreBtn.MouseButton1Click:Connect(function()
    Window:Minimize()
    RestoreGui.Enabled = false
end)

-- [[ UI TABS ]] --
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "fish" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Tabs.Main:AddToggle("AutoFish", {Title = "Auto Fishing IkkonCorps", Default = false}):OnChanged(function(Value)
    _G.AutoFish = Value
    print("Auto-Fishing Status: ", Value)
end)

Fluent:Notify({
    Title = "IKKONCORPS ULTIMATE",
    Content = "Performance Overlay & Restore Button Active! 💀⚡",
    Duration = 5
})
