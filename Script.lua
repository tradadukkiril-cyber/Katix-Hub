-- Завантаження стабільної бібліотеки Kavo UI
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Kavo.CreateLib("KATIX HUB | Grow a Garden 🎃", "Midnight")

-- Глобальні змінні
getgenv().AutoHarvest = false
getgenv().AutoSell = false
getgenv().AutoHalloween = false
getgenv().AutoBuySeeds = false
getgenv().AutoBuyGears = false
getgenv().AutoBuyEggs = false

-- ==========================================
-- 🌾 Вкладка: Основний Фарм
-- ==========================================
local MainTab = Window:NewTab("Main Farm")
local MainSection = MainTab:NewSection("Автоматизація саду")

-- Точковий Авто-Збір
MainSection:NewToggle("Auto Harvest (Точковий)", "Збирає тільки урожай", function(state)
    getgenv().AutoHarvest = state
    if state then
        task.spawn(function()
            while getgenv().AutoHarvest do
                task.wait(0.4)
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not getgenv().AutoHarvest then break end
                        if obj:IsA("ProximityPrompt") then
                            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                            local promptText = (obj.ObjectText .. obj.ActionText):lower()
                            if promptText:find("harvest") or promptText:find("collect") or promptText:find("pick") 
                               or parentName:find("crop") or parentName:find("plant") or parentName:find("fruit") then
                                fireproximityprompt(obj)
                            end
                        end
                        if obj:IsA("RemoteEvent") then
                            local eName = obj.Name:lower()
                            if eName == "harvest" or eName == "collectcrop" or eName == "harvestcrop" then
                                obj:FireServer()
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- Авто-Продаж
MainSection:NewToggle("Auto Sell (Авто-Продаж)", "Автоматично продає урожай", function(state)
    getgenv().AutoSell = state
    if state then
        task.spawn(function()
            while getgenv().AutoSell do
                task.wait(1.5)
                pcall(function()
                    for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if event:IsA("RemoteEvent") and (event.Name:lower():find("sell") or event.Name:lower():find("vendor")) then
                            event:FireServer()
                        end
                    end
                end)
            end
        end)
    end
end)

-- ==========================================
-- 🎃 Вкладка: Halloween Event
-- ==========================================
local EventTab = Window:NewTab("Halloween 🎃")
local EventSection = EventTab:NewSection("Івентові функції")

EventSection:NewToggle("Auto Farm Halloween Event", "Збирає гарбузи та івентові об'єкти", function(state)
    getgenv().AutoHalloween = state
    if state then
        task.spawn(function()
            while getgenv().AutoHalloween do
                task.wait(0.5)
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not getgenv().AutoHalloween then break end
                        if obj:IsA("ProximityPrompt") then
                            local promptText = (obj.ObjectText .. obj.ActionText):lower()
                            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                            if promptText:find("pumpkin") or promptText:find("candy") or promptText:find("spooky")
                               or parentName:find("pumpkin") or parentName:find("halloween") or parentName:find("event") then
                                fireproximityprompt(obj)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- ==========================================
-- 🛒 Вкладка: Авто-Купівля (Shop)
-- ==========================================
local ShopTab = Window:NewTab("Auto Shop 🛒")
local ShopSection = ShopTab:NewSection("Магазин")

ShopSection:NewToggle("Auto Buy Seeds (Семочки)", "Авто-купівля насіння", function(state)
    getgenv().AutoBuySeeds = state
    if state then
        task.spawn(function()
            while getgenv().AutoBuySeeds do
                task.wait(2)
                pcall(function()
                    for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if event:IsA("RemoteEvent") and (event.Name:lower():find("buyseed") or event.Name:lower():find("purchase")) then
                            event:FireServer()
                        end
                    end
                end)
            end
        end)
    end
end)

ShopSection:NewToggle("Auto Buy Gears (Гіри/Спорядження)", "Авто-купівля інструментів", function(state)
    getgenv().AutoBuyGears = state
    if state then
        task.spawn(function()
            while getgenv().AutoBuyGears do
                task.wait(2)
                pcall(function()
                    for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if event:IsA("RemoteEvent") and event.Name:lower():find("gear") then
                            event:FireServer()
                        end
                    end
                end)
            end
        end)
    end
end)

ShopSection:NewToggle("Auto Buy Eggs (Яйця)", "Авто-купівля яєць", function(state)
    getgenv().AutoBuyEggs = state
    if state then
        task.spawn(function()
            while getgenv().AutoBuyEggs do
                task.wait(2)
                pcall(function()
                    for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if event:IsA("RemoteEvent") and (event.Name:lower():find("egg") or event.Name:lower():find("hatch")) then
                            event:FireServer()
                        end
                    end
                end)
            end
        end)
    end
end)

-- ==========================================
-- ⚙️ Вкладка: Налаштування та Персонаж
-- ==========================================
local PlayerTab = Window:NewTab("Settings & Player")
local PlayerSection = PlayerTab:NewSection("Налаштування гравця")

PlayerSection:NewSlider("Швидкість (WalkSpeed)", "Змінює швидкість бігу", 150, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

local SettingsSection = PlayerTab:NewSection("Керування інтерфейсом")

SettingsSection:NewButton("Сховати / Показати меню", "Натисни, щоб приховати KATIX HUB", function()
    Kavo:ToggleUI()
end)
