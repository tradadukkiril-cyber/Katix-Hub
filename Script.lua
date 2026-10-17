-- ==========================================
-- KATIX HUB | RELEASE (Custom Mobile UI)
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Видалення старого інтерфейсу перед запуском
if CoreGui:FindFirstChild("KatixHubUI") then
    CoreGui.KatixHubUI:Destroy()
end

-- Створення головного ScreenGui
local KatixScreen = Instance.new("ScreenGui")
KatixScreen.Name = "KatixHubUI"
KatixScreen.ResetOnSpawn = false
KatixScreen.Parent = CoreGui

-- Глобальні змінні стану
getgenv().AutoHarvest = false
getgenv().TargetCrop = "All"
getgenv().AutoSell = false

getgenv().AutoHalloweenCrops = false
getgenv().AutoCatSubmit = false
getgenv().SelectedScarySeed = "Halloween Candy Corn Carrot"
getgenv().AutoBuyScarySeed = false

getgenv().SelectedFauna = "Haunted Egg"
getgenv().AutoBuyFauna = false

getgenv().SelectedNormalSeed = "Basic Seed"
getgenv().AutoBuyNormalSeed = false

getgenv().Flying = false
getgenv().FlySpeed = 50

-- ==========================================
-- 📱 Плаваюча неонова кнопка згортання (Toggle Button)
-- ==========================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "KatixToggleBtn"
ToggleBtn.Parent = KatixScreen
ToggleBtn.Size = UDim2.new(0, 190, 0, 36)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "► KATIX HUB | RELEASE"
ToggleBtn.TextColor3 = Color3.fromRGB(120, 220, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 180, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- ==========================================
-- 🖼️ Головне вікно скрипта (Main Frame)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = KatixScreen
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(180, 100, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Заголовок вікна
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Text = "KATIX HUB | RELEASE 🌸"
TitleText.TextColor3 = Color3.fromRGB(255, 180, 220)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = TitleBar
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -38, 0, 5)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 100, 150)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 20
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 55)
MinimizeBtn.BorderSizePixel = 0

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

-- Логіка згортання / розгортання
local isMinimized = false
local function toggleUI()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
end

MinimizeBtn.MouseButton1Click:Connect(toggleUI)
ToggleBtn.MouseButton1Click:Connect(toggleUI)

-- ==========================================
-- 📑 Вкладки (Tabs Navigation)
-- ==========================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 10, 22)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -135, 1, -45)
ContentArea.Position = UDim2.new(0, 132, 0, 42)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local function createTabFrame()
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ScrollBarThickness = 4
    f.Visible = false
    f.Parent = ContentArea
    
    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 8)
    list.Parent = f
    return f
end

local Tabs = {
    Main = createTabFrame(),
    Halloween = createTabFrame(),
    Shop = createTabFrame(),
    Fly = createTabFrame()
}

Tabs.Main.Visible = true

local function createTabBtn(name, text, pos, targetTab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(25, 18, 38)
    btn.BorderSizePixel = 0
    btn.Parent = Sidebar
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        targetTab.Visible = true
    end)
end

createTabBtn("Main", "🌾 Main Farm", 10, Tabs.Main)
createTabBtn("Halloween", "🎃 Halloween", 48, Tabs.Halloween)
createTabBtn("Shop", "🛒 Auto Shop", 86, Tabs.Shop)
createTabBtn("Fly", "✈️ Fly & Speed", 124, Tabs.Fly)

-- ==========================================
-- 🛠️ Елементи UI (Toggle, Dropdown, Button)
-- ==========================================

local function addToggle(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.96, 0, 0, 35)
    frame.BackgroundColor3 = Color3.fromRGB(28, 20, 42)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 24)
    btn.Position = UDim2.new(1, -55, 0.5, -12)
    btn.Parent = frame
    btn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = btn
    
    local state = default
    local function update()
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 120) or Color3.fromRGB(80, 40, 60)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    update()
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        update()
        callback(state)
    end)
end

local function addDropdown(parent, title, options, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.96, 0, 0, 55)
    frame.BackgroundColor3 = Color3.fromRGB(28, 20, 42)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 2)
    label.Text = title
    label.TextColor3 = Color3.fromRGB(200, 180, 230)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = frame
    
    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(0.94, 0, 0, 24)
    dropBtn.Position = UDim2.new(0.03, 0, 0, 24)
    dropBtn.Text = default .. "  ▼"
    dropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
    dropBtn.Font = Enum.Font.SourceSans
    dropBtn.TextSize = 13
    dropBtn.BorderSizePixel = 0
    dropBtn.Parent = frame
    
    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(0, 4)
    dCorner.Parent = dropBtn
    
    local currentIndex = 1
    for i, opt in ipairs(options) do
        if opt == default then currentIndex = i break end
    end
    
    dropBtn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then currentIndex = 1 end
        local selected = options[currentIndex]
        dropBtn.Text = selected .. "  ▼"
        callback(selected)
    end)
end

-- ==========================================
-- 🌾 Вкладка 1: Main Farm
-- =================================
