-- Завантаження бібліотеки Kavo UI
local Success, Kavo = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)
"seed") or eName:find("egg") or eName:find("shop") then
                                event:FireServer(getgenv().SelectedNormalSeed)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- ==========================================
-- ✈️ Вкладка 4: Fly & Settings
-- ==========================================
local SettingsTab = Window:NewTab("Fly & Settings")
local FlySection = SettingsTab:NewSection("Мобільний Політ (Fly)")

FlySection:NewDropdown("Швидкість польоту", "Вибери швидкість", {"30", "50", "80", "120"}, function(val)
    getgenv().FlySpeed = tonumber(val) or 50
end)

local flyConn
FlySection:NewToggle("Увімкнути Fly", "Політ за допомогою джойстика та камери", function(state)
    getgenv().Flying = state
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local hum = char:FindFirstChildOfClass("Humanoid")

    if state then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "KatixFlyVelocity"
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Parent = hrp
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "KatixFlyGyro"
        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bg.Parent = hrp
        
        if hum then hum.PlatformStand = true end
        
        flyConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not getgenv().Flying or not hrp:FindFirstChild("KatixFlyVelocity") then
                if flyConn then flyConn:Disconnect() end
                if hum then hum.PlatformStand = false end
                if hrp:FindFirstChild("KatixFlyVelocity") then hrp.KatixFlyVelocity:Destroy() end
                if hrp:FindFirstChild("KatixFlyGyro") then hrp.KatixFlyGyro:Destroy() end
                return
            end
            
            local cam = workspace.CurrentCamera
            local moveDir = hum and hum.MoveDirection or Vector3.new(0,0,0)
            
            if moveDir.Magnitude > 0 then
                bv.Velocity = cam.CFrame:VectorToWorldSpace(cam.CFrame:VectorToObjectSpace(moveDir) * getgenv().FlySpeed)
            else
                bv.Velocity = Vector3.new(0, 0, 0)
            end
            bg.CFrame = cam.CFrame
        end)
    else
        if hum then hum.PlatformStand = false end
        if hrp:FindFirstChild("KatixFlyVelocity") then hrp.KatixFlyVelocity:Destroy() end
        if hrp:FindFirstChild("KatixFlyGyro") then hrp.KatixFlyGyro:Destroy() end
        if flyConn then flyConn:Disconnect() end
    end
end)

local PlayerSection = SettingsTab:NewSection("Налаштування Персонажа")

PlayerSection:NewSlider("WalkSpeed (Швидкість)", "Зміна швидкості бігу", 150, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewButton("Перезапустити/Згорнути UI", "Відкрити/Закрити вікно", function()
    Kavo:ToggleUI()
end)
