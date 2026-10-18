-- Завантаження стабільної бібліотеки Orion UI
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "KATIX HUB | RELEASE 🌸", 
    HidePremium = true, 
    SaveConfig = false, 
    ConfigFolder = "KatixHub"
})

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
-- 🌾 Вкладка 1: Main Farm
-- ==========================================
local MainTab = Window:MakeTab({
    Name = "Main Farm 🌾",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddDropdown({
    Name = "Вибір рослини для збору",
    Default = "All",
    Options = {"All", "Pumpkin", "Carrot", "Tomato", "Watermelon"},
    Callback = function(val)
        getgenv().TargetCrop = tostring(val):lower()
    end    
})

MainTab:AddToggle({
    Name = "Auto Harvest (Авто-Збір)",
    Default = false,
    Callback = function(state)
        getgenv().AutoHarvest = state
        if state then
            task.spawn(function()
                while getgenv().AutoHarvest do
                    task.wait(0.2)
                    pcall(function()
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not getgenv().AutoHarvest then break end
                            if obj:IsA("ProximityPrompt") then
                                local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                                local promptText = (obj.ObjectText .. " " .. obj.ActionText):lower()
                                
                                if getgenv().TargetCrop ~= "all" then
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
    end
})

MainTab:AddToggle({
    Name = "Auto Sell (Авто-Продаж)",
    Default = false,
    Callback = function(state)
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
    end
})

-- ==========================================
-- 🎃 Вкладка 2: Halloween Event
-- ==========================================
local EventTab = Window:MakeTab({
    Name = "Halloween 🎃",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

EventTab:AddToggle({
    Name = "Auto Farm Halloween Crops",
    Default = false,
    Callback = function(state)
        getgenv().AutoHalloweenCrops = state
        if state then
            task.spawn(function()
                while getgenv().AutoHalloweenCrops do
                    task.wait(0.2)
                    pcall(function()
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not getgenv().AutoHalloweenCrops then break end
                            if obj:IsA("ProximityPrompt") then
                                local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                                if parentName:find("halloween") or parentName:find("pumpkin") or parentName:find("candy") or parentName:find("spider") or parentName:find("shrub") then
                                    fireproximityprompt(obj)
                                end
                            end
                        end
                    end)
                end
            end)
        end
    end
})

EventTab:AddToggle({
    Name = "Auto Submit to Cat (Здати коту 🐱)",
    Default = false,
    Callback = function(state)
        getgenv().AutoCatSubmit = state
        if state then
            task.spawn(function()
                while getgenv().AutoCatSubmit do
                    task.wait(0.6)
                    pcall(function()
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not getgenv().AutoCat
                                            
