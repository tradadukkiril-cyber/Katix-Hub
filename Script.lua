-- ==========================================
-- KATIX HUB | RELEASE (Fixed UI & Logic)
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

-- Головний ScreenGui
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
ToggleBtn
