-- Abood God-Tier Hub v9.3 | المطور: عبود
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [ نظام إشعارات فخم ]
local function notify(title, text)
    game.StarterGui:SetCore("SendNotification", {Title = "Abood Hub | " .. title, Text = text, Duration = 3})
end

-- [ الواجهة الرئيسية (Modern Dark Glass) ]
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "AboodGodTier"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 500)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 200, 255)

-- [ زر القائمة ]
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 55, 0, 55)
OpenBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
OpenBtn.Text = "By ⚡ SAD_J82"
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
OpenBtn.Draggable = true
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- [ قائمة التمرير ]
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(0.9, 0, 0.85, 0)
Scroll.Position = UDim2.new(0.05, 0, 0.1, 0)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 8)

-- [ محرك الأزرار الاحترافي ]
local function addBtn(text, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function()
        local success, err = pcall(callback)
        if not success then notify("خطأ", "فشل تنفيذ الميزة") end
    end)
end

-- [ الميزات الجبارة ]
local flying = false
local speed = 50 -- سرعة الطيران

-- دالة لتفعيل الطيران
local function toggleFly()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        if flying then
            flying = false
            hrp:FindFirstChild("FlyVel"):Destroy()
            notify("الطيران", "تم الإيقاف")
        else
            flying = true
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Name = "FlyVel"
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(0, 0, 0)

            -- تحديث السرعة أثناء الطيران
            RunService.RenderStepped:Connect(function()
                if flying and hrp then
                    local camera = workspace.CurrentCamera
                    local direction = camera.CFrame.LookVector
                    bv.Velocity = direction * speed + Vector3.new(0, 20, 0) -- إضافة ارتفاع
                end
            end)

            notify("الطيران", "تم التفعيل")
        end
    end
end

addBtn("✈️ طيران (Toggle)", toggleFly)

addBtn("👻 اختراق الجدران (Noclip)", function()
    RunService.Stepped:Connect(function()
        if player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
    notify("Noclip", "مفعل دائماً")
end)

addBtn("🛡️ حماية المنطقة (Kill Aura)", function()
    RunService.Heartbeat:Connect(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                if (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 15 then
                    p.Character.Humanoid.Health = 0
                end
            end
        end
    end)
    notify("الحماية", "نشطة")
end)

addBtn("🔄 تغيير السيرفر إلى سيرفر عشوائي", function()
    local placeId = game.PlaceId
    local teleportService = game:GetService("TeleportService")

    teleportService:Teleport(placeId, player)
    notify("تغيير السيرفر", "تم تغيير السيرفر")
end)

addBtn("💀 ريسباون", function() player.Character:BreakJoints() end)

-- [ مدخلات متطورة ]
local function addInput(placeholder, callback)
    local box = Instance.new("TextBox", Scroll)
    box.Size = UDim2.new(1, 0, 0, 40)
    box.PlaceholderText = placeholder
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", box)
    box.FocusLost:Connect(function() callback(box.Text) end)
end

-- أزرار لتغيير سرعة المشي والنط
addInput("سرعة المشي (رقم)", function(val) 
    player.Character.Humanoid.WalkSpeed = tonumber(val) or 16 
end)

addBtn("تغيير سرعة المشي", function()
    local speedInput = player.Character.Humanoid.WalkSpeed
    notify("سرعة المشي", "تم تغيير السرعة إلى: " .. speedInput)
end)

addInput("قوة النط (رقم)", function(val) 
    player.Character.Humanoid.JumpPower = tonumber(val) or 50 
end)

addBtn("تغيير قوة النط", function()
    local jumpPowerInput = player.Character.Humanoid.JumpPower
    notify("قوة النط", "تم تغيير القوة إلى: " .. jumpPowerInput)
end)

-- [ AIM BOT ]
local aimTarget = nil

local function aimAtPlayer(targetPlayer)
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp and targetPlayer.Character then
        local targetPart = targetPlayer.Character:FindFirstChild("Head") -- يمكنك تغيير هذا إلى أي جزء آخر
        if targetPart then
            hrp.CFrame = CFrame.new(targetPart.Position) -- توجيه الشخصية نحو الهدف
            aimTarget = targetPart
        end
    end
end

addInput("اسم اللاعب (AIM)", function(val)
    local target = Players:FindFirstChild(val)
    if target then
        aimAtPlayer(target)
        notify("AIM BOT", "تم توجيه الهدف إلى: " .. target.Name)
    else
        notify("خطأ", "اللاعب غير موجود")
    end
end)

addBtn("تفعيل AIM BOT", function()
    local targetName = "اسم اللاعب هنا" -- يمكن استبداله بالاسم المدخل
    local target = Players:FindFirstChild(targetName)
    if target then
        RunService.RenderStepped:Connect(function()
            aimAtPlayer(target)
        end)
        notify("AIM BOT", "تم تفعيل AIM BOT على: " .. target.Name)
    else
        notify("خطأ", "اللاعب غير موجود")
    end
end)

-- [ زر ESP ALL ]
local function createESP(targetPlayer)
    local espPart = Instance.new("Part")
    espPart.Size = Vector3.new(2, 2, 2)
    espPart.Color = Color3.new(1, 0, 0) -- لون الهيكل
    espPart.Transparency = 0.5
    espPart.Anchored = true
    espPart.Parent = workspace

    local nameTag = Instance.new("BillboardGui", espPart)
    nameTag.Size = UDim2.new(1, 0, 1, 0)
    local textLabel = Instance.new("TextLabel", nameTag)
    textLabel.Text = targetPlayer.Name .. " - " .. math.floor((player.Character.HumanoidRootPart.Position - targetPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "m"
    textLabel.Size = UDim2.new(1, 0, 1, 0)

    -- تحديث موقع ESP
    RunService.RenderStepped:Connect(function()
        if targetPlayer.Character then
            espPart.Position = targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
        else
            espPart:Destroy()
        end
    end)
end

addBtn("ESP ALL", function()
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= player then
            createESP(target)
        end
    end
    notify("ESP ALL", "تم تفعيل ESP على جميع اللاعبين")
end)

-- تفعيل ESP عند إضافة لاعب
Players.PlayerAdded:Connect(function(newPlayer)
    newPlayer.CharacterAdded:Connect(function()
        createESP(newPlayer)
    end)
end)

-- [ زر الإغلاق ]
local Close = Instance.new("TextButton", MainFrame)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(0.85, 0, 0.02, 0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)


