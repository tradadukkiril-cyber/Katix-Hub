-- ==========================================
-- KATIX HUB | RELEASE (Custom Mobile UI)
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Видалення старого інтерфейсу
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

getgenv().SelectedNormalSeed = "Carrot Seed"
getgenv().AutoBuyNormalSeed = false

getgenv().Flying = false
getgenv().FlySpeed = 50

-- ==========================================
-- 📱 Плаваюча кнопка згортання (Toggle Button)
-- ==========================================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "KatixToggleBtn"
ToggleBtn.Parent = KatixScreen
ToggleBtn.Size = UDim2.new(0, 180, 0, 36)
ToggleBtn.Position = UDim2.new(0.03, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "► KATIX HUB | RELEASE"
ToggleBtn.TextColor3 = Color3.fromRGB(120, 220, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 15
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
-- 🖼️ Головне вікно (Main Frame)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = KatixScreen
MainFrame.Size = UDim2.new(0, 500, 0, 310)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 16, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(200, 110, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(32, 22, 48)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.Text = "KATIX HUB | RELEASE 🌸"
TitleText.TextColor3 = Color3.fromRGB(255, 180, 230)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 17
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = TitleBar
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -34, 0, 5)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 120, 170)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 18
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 60)
MinimizeBtn.BorderSizePixel = 0

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local function toggleUI()
    MainFrame.Visible = not MainFrame.Visible
end

MinimizeBtn.MouseButton1Click:Connect(toggleUI)
ToggleBtn.MouseButton1Click:Connect(toggleUI)

-- ==========================================
-- 📑 Сайдбар та Контейнери Вкладок
-- ==========================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 125, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = Color3.fromRGB(16, 11, 24)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -130, 1, -42)
ContentArea.Position = UDim2.new(0, 128, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local function createTabScroll()
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.Visible = false
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = ContentArea
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = scroll
    
    local pad = Instance.new("UIPadding")
    pad.PaddingRight = UDim.new(0, 6)
    pad.Parent = scroll
    
    return scroll
end

local Tabs = {
    Main = createTabScroll(),
    Halloween = createTabScroll(),
    Shop = createTabScroll(),
    Fly = createTabScroll()
}

Tabs.Main.Visible = true

local function createTabBtn(text, pos, targetTab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230, 230, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.BackgroundColor3 = Color3.fromRGB(28, 20, 42)
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

createTabBtn("🌾 Main Farm", 10, Tabs.Main)
createTabBtn("🎃 Halloween", 48, Tabs.Halloween)
createTabBtn("🛒 Auto Shop", 86, Tabs.Shop)
createTabBtn("✈️ Fly & Speed", 124, Tabs.Fly)

-- ==========================================
-- 🛠️ Елементи UI (Toggle & Dropdown)
-- ==========================================
local function addToggle(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(30, 22, 46)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 52,
        
