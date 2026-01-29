local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- [[ CORE SETTINGS ]] --
local Window = Fluent:CreateWindow({
    Title = "IKKONCORPS :: FISH IT OVERsRIDE ⚡",
    SubTitle = "Security Bypassed by RianModss",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- Dimatikan untuk mengurangi lag/error pada beberapa executor
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- [[ EXTERNAL PERFORMANCE HUD ]] --
local HudGui = Instance.new("ScreenGui")
HudGui.Name = "IkkonHud"
HudGui.Parent = game:GetService("CoreGui")

local HudFrame = Instance.new("Frame")
HudFrame.Size = UDim2.new(0, 300, 0, 25)
HudFrame.Position = UDim2.new(0.5, -150, 0, 5)
HudFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HudFrame.BackgroundTransparency = 0.4
HudFrame.Parent = HudGui

local HudLabel = Instance.new("TextLabel")
HudLabel.Size = UDim2.new(1, 0, 1, 0)
HudLabel.BackgroundTransparency = 1
HudLabel.Font = Enum.Font.Code
HudLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
HudLabel.TextSize = 14
HudLabel.Text = "WAITING FOR STATS..."
HudLabel.Parent = HudFrame

Instance.new("UICorner", HudFrame).CornerRadius = UDim.new(0, 4)

-- [[ STABLE MINIMIZE SYSTEM ]] --
local RestoreGui = Instance.new("ScreenGui")
RestoreGui.Name = "IkkonRestore"
RestoreGui.Parent = game:GetService("CoreGui")
RestoreGui.Enabled = false

local RestoreBtn = Instance.new("TextButton")
RestoreBtn.Size = UDim2.new(0, 50, 0, 50)
RestoreBtn.Position = UDim2.new(0, 10, 0.5, -25) -- Di samping kiri layar
RestoreBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
RestoreBtn.Text = "IKK"
RestoreBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
RestoreBtn.Font = Enum.Font.BlackOpsOne
RestoreBtn.TextSize = 18
RestoreBtn.Parent = RestoreGui
Instance.new("UICorner", RestoreBtn).CornerRadius = UDim.new(0, 8)

-- Perbaikan Logika Buka/Tutup
Window.OnMinimize:Connect(function()
    RestoreGui.Enabled = true
end)

RestoreBtn.MouseButton1Click:Connect(function()
    RestoreGui.Enabled = false
    -- Simulasi penekanan tombol minimize Fluent
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
end)

-- [[ PERFORMANCE TRACKER ]] --
local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")

spawn(function()
    while true do
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        local mem = math.floor(Stats:GetTotalMemoryUsageMb())
        
        HudLabel.Text = string.format("PING: %dms | FPS: %d | CPU/MEM: %dMB", ping, fps, mem)
        task.wait(0.5)
    end
end)

-- [[ TABS ]] --
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "fish" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Tabs.Main:AddToggle("AutoFish", {Title = "Auto Fishing IkkonCorps", Default = false}):OnChanged(function(v)
    _G.AutoFish = v
end)

Fluent:Notify({
    Title = "IKKONCORPS READY",
    Content = "System Stabilized. Destroy them! 💀🔥",
    Duration = 5
})
