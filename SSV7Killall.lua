-- ⚡ SSV7 Kill All Pro - زر واحد مع تأكيد القتل ⚡
local ScreenGui = Instance.new("ScreenGui")
local KillButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local StatusText = Instance.new("TextLabel")
local Notification = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")

-- المتغيرات
local isKilling = false
local killConnection = nil
local killCount = 0
local realKillCount = 0
local killSpeed = 0.15
local lastTarget = nil

-- إعدادات الشاشة
ScreenGui.Name = "SSV7_KillAll"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== زر القتل ==========
KillButton.Size = UDim2.new(0, 90, 0, 90)
KillButton.Position = UDim2.new(0.5, -45, 0.5, -45)
KillButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
KillButton.BackgroundTransparency = 0.3
KillButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KillButton.Text = "💀\nKILL"
KillButton.TextSize = 18
KillButton.Font = Enum.Font.GothamBlack
KillButton.Draggable = true
KillButton.Active = true
KillButton.BorderSizePixel = 4
KillButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
KillButton.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 45)
UICorner.Parent = KillButton

-- ========== عداد القتلى ==========
StatusText.Size = UDim2.new(0, 80, 0, 26)
StatusText.Position = UDim2.new(0.5, -40, 0.5, -80)
StatusText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.Text = "💀 0"
StatusText.TextSize = 14
StatusText.Font = Enum.Font.GothamBlack
StatusText.BorderSizePixel = 2
StatusText.BorderColor3 = Color3.fromRGB(255, 50, 50)
StatusText.BackgroundTransparency = 0.3
StatusText.Parent = ScreenGui

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 13)
statusCorner.Parent = StatusText

-- ========== إشعار ==========
Notification.Size = UDim2.new(0, 200, 0, 28)
Notification.Position = UDim2.new(0.5, -100, 0, -35)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(255, 50, 50)
Notification.Visible = false
Notification.Parent = ScreenGui

UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = Notification

NotificationText.Size = UDim2.new(1, -10, 1, 0)
NotificationText.Position = UDim2.new(0, 5, 0, 0)
NotificationText.BackgroundTransparency = 1
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 11
NotificationText.Font = Enum.Font.GothamBold
NotificationText.Parent = Notification

-- ========== وظائف ==========

local function showNotification(text)
    NotificationText.Text = text
    Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -100, 0, -35)
    spawn(function()
        for i = 1, 5 do Notification.Position = UDim2.new(0.5, -100, 0, -35 + (i * 7)); task.wait(0.01) end
        task.wait(1.5)
        for i = 1, 5 do Notification.Position = UDim2.new(0.5, -100, 0, 0 - (i * 7)); task.wait(0.01) end
        Notification.Visible = false
    end)
end

-- تجهيز أفضل سلاح
local function equipBestWeapon()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return nil end
    local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
    if not humanoid then return nil end
    
    -- إذا معاه سلاح بالفعل
    local currentTool = localPlayer.Character:FindFirstChildOfClass("Tool")
    if currentTool then
        -- نتأكد إنه سلاح (له Handle)
        if currentTool:FindFirstChild("Handle") or currentTool.PrimaryPart then
            return currentTool
        end
    end
    
    -- نجيب أفضل سلاح من الباكباك
    local backpack = localPlayer:FindFirstChild("Backpack")
    if backpack then
        local bestTool = nil
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                -- نفضل الأدوات اللي لها Handle
                if tool:FindFirstChild("Handle") then
                    humanoid:EquipTool(tool)
                    return tool
                end
                if not bestTool then
                    bestTool = tool
                end
            end
        end
        -- إذا ما لقينا أداة بـ Handle، نستخدم أي أداة
        if bestTool then
            humanoid:EquipTool(bestTool)
            return bestTool
        end
    end
    
    return nil
end

-- التحقق إذا اللاعب ميت فعلاً
local function isPlayerDead(player)
    if not player or not player.Character then return true end
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid then return true end
    return humanoid.Health <= 0
end

-- إيجاد أقرب لاعب حي
local function findClosestAlivePlayer()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return nil end
    
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    local closest = nil
    local closestDist = math.huge
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and not isPlayerDead(player) then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local dist = (localRoot.Position - targetRoot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = player
                end
            end
        end
    end
    
    return closest
end

-- قتل لاعب معين مع تأكيد الموت
local function killPlayer(player)
    if not player or isPlayerDead(player) then return true end
    
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return false end
    
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
    local targetHumanoid = player.Character:FindFirstChild("Humanoid")
    
    if not localRoot or not targetRoot or not targetHumanoid then return false end
    
    -- 1. تيليبورت للهدف
    localRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 2, 0)
    task.wait(0.05)
    
    -- 2. تجهيز السلاح
    local weapon = equipBestWeapon()
    
    -- 3. محاولات القتل
    local killed = false
    
    -- طريقة 1: Damage مباشر (أسرع طريقة)
    pcall(function()
        if targetHumanoid and targetHumanoid.Health > 0 then
            targetHumanoid.Health = 0
            targetHumanoid:TakeDamage(99999)
        end
    end)
    
    task.wait(0.05)
    
    -- نتأكد إذا مات
    if isPlayerDead(player) then return true end
    
    -- طريقة 2: Touch بالسلاح
    if weapon then
        pcall(function()
            local handle = weapon:FindFirstChild("Handle") or weapon.PrimaryPart
            if handle then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        firetouchinterest(handle, part, 0)
                        task.wait(0.01)
                        firetouchinterest(handle, part, 1)
                    end
                end
            end
        end)
    end
    
    task.wait(0.05)
    if isPlayerDead(player) then return true end
    
    -- طريقة 3: Click Detector
    pcall(function()
        for _, obj in pairs(player.Character:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                fireclickdetector(obj)
            end
        end
    end)
    
    task.wait(0.05)
    if isPlayerDead(player) then return true end
    
    -- طريقة 4: BreakJoints
    pcall(function()
        if targetHumanoid.Health > 0 then
            player.Character:BreakJoints()
        end
    end)
    
    task.wait(0.05)
    if isPlayerDead(player) then return true end
    
    -- طريقة 5: Destroy كامل
    pcall(function()
        if targetHumanoid.Health > 0 then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part:Destroy()
                end
            end
            player.Character:Destroy()
        end
    end)
    
    task.wait(0.1)
    return isPlayerDead(player)
end

-- حلقة القتل الرئيسية
local function killLoop()
    if not isKilling then return end
    
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character or isPlayerDead(localPlayer) then
        showNotification("⚠️ أنت ميت!")
        stopKilling()
        return
    end
    
    -- تجهيز سلاح دايم
    equipBestWeapon()
    
    -- إيجاد أقرب هدف
    local target = findClosestAlivePlayer()
    
    if not target then
        showNotification("✅ تم قتل الجميع! 💀" .. realKillCount)
        stopKilling()
        return
    end
    
    -- حفظ الهدف
    lastTarget = target
    
    -- محاولة القتل
    local killed = killPlayer(target)
    
    if killed then
        -- نتأكد إنه مات فعلاً
        task.wait(0.1)
        if isPlayerDead(target) then
            realKillCount = realKillCount + 1
            StatusText.Text = "💀 " .. realKillCount
        end
    end
    
    killCount = killCount + 1
    task.wait(killSpeed)
end

local function startKilling()
    if isKilling then return end
    isKilling = true
    killCount = 0
    realKillCount = 0
    StatusText.Text = "💀 0"
    
    KillButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    KillButton.Text = "⏹\nSTOP"
    KillButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
    
    showNotification("💀 بدأ القتل!")
    
    killConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isKilling then
            pcall(killLoop)
        end
    end)
end

local function stopKilling()
    isKilling = false
    
    if killConnection then
        killConnection:Disconnect()
        killConnection = nil
    end
    
    KillButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    KillButton.Text = "💀\nKILL"
    KillButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
    
    showNotification("🔴 تم الإيقاف | 💀" .. realKillCount)
end

local function toggleKilling()
    if isKilling then
        stopKilling()
    else
        startKilling()
    end
end

-- ========== الأحداث ==========
KillButton.MouseButton1Click:Connect(toggleKilling)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if isKilling then
        task.wait(0.5)
    end
end)

showNotification("💀 اضغط الزر للبدء")
