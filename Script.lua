-- Завантаження стабільної бібліотеки Kavo UI з кастомним стилем
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Kavo.CreateLib("KATIX HUB | RELEASE", "BloodTheme")

-- Глобальні змінні
getgenv().AutoHarvest = false
getgenv().TargetCrop = ""
getgenv().AutoSell = false
getgenv().AutoHalloweenCrops = false
getgenv().AutoCatSubmit = false

getgenv().TargetBuyItem = ""
getgenv().AutoBuyTarget = false
getgenv().AutoBuyHauntedEgg = false
getgenv().AutoBuySpookyChest = false
getgenv().AutoBuyReaper = false

-- Змінні для Fly
getgenv().Flying = false
getgenv().FlySpeed = 50
local p = game.Players.LocalPlayer
local ch
local bV, bG

local function startFly()
    ch = p.Character
    if not ch or not ch:FindFirstChild("HumanoidRootPart") then return end
    
    bV = Instance.new("BodyVelocity")
    bV.Name = "FlyVelocity"
    bV.Parent = ch.HumanoidRootPart
    bV.MaxForce = Vector3.new(90000, 90000, 90000)
    bV.Velocity = Vector3.new(0, 0, 0)
    
    bG = Instance.new("BodyGyro")
    bG.Name = "FlyGyro"
    bG.Parent = ch.HumanoidRootPart
    bG.MaxTorque = Vector3.new(90000, 90000, 90000)
    bG.CFrame = ch.HumanoidRootPart.CFrame
    
    task.spawn(function()
        local cam = workspace.CurrentCamera
        while getgenv().Flying and ch and ch:FindFirstChild("HumanoidRootPart") do
            task.wait()
            local vel = Vector3.new(0,0,0)
            local uis = game:GetService("UserInputService")
            
            -- Керування швидкістю та напрямком
            vel = cam.CFrame.LookVector * getgenv().FlySpeed
            bV.Velocity = vel
            bG.CFrame = cam.CFrame
        end
        if bV then bV:Destroy() end
        if bG then bG:Destroy() end
    end)
end

local function stopFly()
    getgenv().Flying = false
    if bV then bV:Destroy() end
    if bG then bG:Destroy() end
end

-- ==========================================
-- 🌾 Вкладка: Основний Фарм
-- ==========================================
local MainTab = Window:NewTab("Main Farm")
local MainSection = MainTab:NewSection("Точковий Авто-Збір")

MainSection:NewTextBox("Рослина для збору (англ)", "Впиши назву (напр. Pumpkin) або залиш порожнім", function(txt)
    getgenv().TargetCrop = txt:lower()
end)

MainSection:NewToggle("Auto Harvest (Авто-Збір)", "Збирає вибрані або всі рослини", function(state)
    getgenv().AutoHarvest = state
    if state then
        task.spawn(function()
            while getgenv().AutoHarvest do
                task.wait(0.3)
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not getgenv().AutoHarvest then break end
                        if obj:IsA("ProximityPrompt") then
                            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                            local promptText = (obj.ObjectText .. " " .. obj.ActionText):lower()
                            
                            if getgenv().TargetCrop ~= "" then
                                if parentName:find(getgenv().TargetCrop) or promptText:find(getgenv().TargetCrop) then
                                    fireproximityprompt(obj)
                                end
                            else
                                if promptText:find("harvest") or promptText:find("collect") or promptText:find("pick") 
                                   or parentName:find("crop") or parentName:find("plant") or parentName:find("fruit") then
                                    fireproximityprompt(obj)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

local SellSection = MainTab:NewSection("Авто-Продаж")

SellSection:NewToggle("Auto Sell (Авто-Продаж)", "Автоматично продає врожай", function(state)
    getgenv().AutoSell = state
    if state then
        task.spawn(function()
            while getgenv().AutoSell do
                task.wait(1)
                pcall(function()
                    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if v:IsA("RemoteEvent") then
                            local name = v.Name:lower()
                            if name:find("sell") or name:find("vendor") or name:find("merchant") then
                                v:FireServer()
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- ==========================================
-- 🎃 Вкладка: Halloween & Cat
-- ==========================================
local EventTab = Window:NewTab("Halloween 🎃")
local EventSection = EventTab:NewSection("Івентовий Сад та Здача Коту")

EventSection:NewToggle("Auto Farm Halloween Crops", "Збирає Хелловінські рослини", function(state)
    getgenv().AutoHalloweenCrops = state
    if state then
        task.spawn(function()
            while getgenv().AutoHalloweenCrops do
                task.wait(0.3)
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not getgenv().AutoHalloweenCrops then break end
                        if obj:IsA("ProximityPrompt") then
                            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                            local promptText = (obj.ObjectText .. " " .. obj.ActionText):lower()
                            
                            if parentName:find("halloween") or parentName:find("pumpkin") or parentName:find("candy") 
                               or parentName:find("spider") or parentName:find("shrub") or parentName:find("webberry")
                               or parentName:find("kiwi") or parentName:find("root") or parentName:find("hallow")
                               or promptText:find("pumpkin") or promptText:find("candy") or promptText:find("event") then
                                fireproximityprompt(obj)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

EventSection:NewToggle("Auto Submit to Cat (Здати коту)", "Вмикає/вимикає авто-здачу коту", function(state)
    getgenv().AutoCatSubmit = state
    if state then
        task.spawn(function()
            while getgenv().AutoCatSubmit do
                task.wait(1)
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if not getgenv().AutoCatSubmit then break end
                        if obj:IsA("ProximityPrompt") then
                            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                            if parentName:find("cat") or parentName:find("witch") or parentName:find("cauldron") then
                                fireproximityprompt(obj)
                            end
                        end
                    end
                    
                    for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if event:IsA("RemoteEvent") then
                            local eName = event.Name:lower()
                            if eName:find("cat") or eName:find("submit") or eName:find("cauldron") or eName:find("event") then
                                event:FireServer("Submit All")
                                event:FireServer("Submit Held Fruit")
                                event:FireServer(2)
                                event:FireServer(3)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- ==========================================
-- 🛒 Вкладка: Smart Shop & Pets
-- ==========================================
local ShopTab = Window:NewTab("Auto Shop 🛒")
local CustomShopSection = ShopTab:NewSection("Точковий вибір (Будь-який предмет)")

CustomShopSection:NewTextBox("Точна назва предмета/пета", "Наприклад: Haunted Egg або Reaper", function(txt)
    getgenv().TargetBuyItem = txt
end)

CustomShopSection:NewToggle("Купувати вказаний предмет", "Купує тільки те, що введено вище", function(state)
    getgenv().AutoBuyTarget = state
    if state then
        task.spawn(function()
            while getgenv().AutoBuyTarget do
                task.wait(1)
                pcall(function()
                    if getgenv().TargetBuyItem ~= "" then
                        for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                            if event:IsA("RemoteEvent") then
                                local eName = event.Name:lower()
                                if eName:find("buy") or eName:find("purchase") or eName:find("shop") or eName:find("pet") or eName:find("seed") then
                                    event:FireServer(getgenv().TargetBuyItem)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

local EventPetSection = ShopTab:NewSection("Frightening Fauna (Петі та Яйця)")

EventPetSection:NewToggle("Buy Haunted Egg (Яйце)", "Авто-купівля Haunted Egg", function(state)
    getgenv().AutoBuyHauntedEgg = state
    if state then
        task.spawn(function()
            while getgenv().AutoBuyHauntedEgg do
                task.wait(1.5)
                pcall(function()
                    for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if event:IsA("RemoteEvent") then
                            local eName = event.Name:lower()
                            if eName:find("buy") or eName:find("pet") or eName:find("egg") or eName:find("fauna") then
                                event:FireServer("Haunted Egg")
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

EventPetSection:NewToggle("Buy Spooky Chest (Скриня)", "Авто-купівля Spooky Chest", function(state)
    getgenv().AutoBuySpookyChest = state
    if state then
        task.spawn(function()
            while getgenv().AutoBuySpookyChest do
                task.wait(1.5)
                pcall(function()
                    for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if event:IsA("RemoteEvent") then
                            local eName = event.Name:lower()
                            if eName:find("buy") or eName:find("chest") or eName:find("fauna") then
                                event:FireServer("Spooky Chest")
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

EventPetSection:NewToggle("Buy Reaper (Пет)", "Авто-купівля Reaper", function(state)
    getgenv().AutoBuyReaper = state
    if state then
        task.spawn(function()
            while getgenv().AutoBuyReaper do
                task.wait(1.5)
                pcall(function()
                    for _, event in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if event:IsA("RemoteEvent") then
                            local eName = event.Name:lower()
                            if eName:find("buy") or eName:find("pet") or eName:find("reaper") then
                                event:FireServer("Reaper")
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- ==========================================
-- ✈️ Вкладка: Fly & Settings
-- ==========================================
local SettingsTab = Window:NewTab("Fly & Settings")
local FlySection = SettingsTab:NewSection("Мобільний Політ (Fly)")

FlySection:NewToggle("Увімкнути Fly", "Дозволяє літати по світу гри", function(state)
    getgenv().Flying = state
    if state then
        startFly()
    else
        stopFly()
    end
end)

FlySection:NewSlider("Швидкість польоту", "Регулювання швидкості польоту", 200, 10, function(s)
    getgenv().FlySpeed = s
end)

local PlayerSection = SettingsTab:NewSection("Персонаж")

PlayerSection:NewSlider("WalkSpeed (Швидкість бігу)", "Зміна швидкості", 150, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewButton("Згорнути / Розгорнути меню", "Кнопка згортання UI", function()
    Kavo:ToggleUI()
end)
