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

-- [[ FLOATING BUTTON IKKONCORPS ]] --
local ScreenGui = Instance.new("ScreenGui")
local OpenButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "IkkonCorpsRestore"
ScreenGui.Parent = game.CoreGui
ScreenGui.Enabled = false

OpenButton.Name = "RestoreUI"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenButton.BorderSizePixel = 0
OpenButton.Position = UDim2.new(0.02, 0, 0.4, 0)
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Text = "IKK"
OpenButton.TextColor3 = Color3.fromRGB(255, 0, 0)
OpenButton.TextSize = 20
OpenButton.Draggable = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = OpenButton

Window.OnMinimize:Connect(function()
    ScreenGui.Enabled = true
end)

OpenButton.MouseButton1Click:Connect(function()
    Window:Minimize()
    ScreenGui.Enabled = false
end)

-- [[ PERFORMANCE MONITOR TAB ]] --
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "fish" }),
    Stats = Window:AddTab({ Title = "Performance", Icon = "activity" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local PingLabel = Tabs.Stats:AddParagraph({
    Title = "Network Status",
    Content = "Ping: Fetching..."
})

local CPULabel = Tabs.Stats:AddParagraph({
    Title = "System Status",
    Content = "CPU Load: Calculating..."
})

-- Update Stats Loop
spawn(function()
    while true do
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        
        PingLabel:SetTitle("Ping: " .. ping .. "ms ⚡")
        CPULabel:SetTitle("FPS / Performance: " .. fps .. " FPS 💀")
        task.wait(1)
    end
end)

-- [[ MAIN CHEATS ]] --
Tabs.Main:AddToggle("AutoFish", {Title = "Auto Fishing IkkonCorps", Default = false}):OnChanged(function(Value)
    _G.AutoFish = Value
    if Value then
        Fluent:Notify({Title = "IKKONCORPS", Content = "Auto-Fishing Engaged! 😈", Duration = 3})
    end
end)

Fluent:Notify({
    Title = "IKKONCORPS LOADED",
    Content = "Welcome back, Master RianModss. 💀🔥",
    Duration = 5
})
