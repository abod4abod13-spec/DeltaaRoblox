-- ⚡ SSV7 Anti Bang Crazy Spin - سبين مجنون مع درع ⚡
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local ToggleButton = Instance.new("TextButton")
local UICorner4 = Instance.new("UICorner")
local StatusText = Instance.new("TextLabel")
local Notification = Instance.new("Frame")
local UICorner5 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")

local isActive = false
local protectionCount = 0
local originalPosition = nil
local myShield = nil
local spinParts = {}
local isEvading = false

ScreenGui.Name = "SSV7_AntiBang"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- زر رئيسي
MainButton.Size = UDim2.new(0, 140, 0, 50)
MainButton.Position = UDim2.new(0.5, -70, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(0, 255, 200)
MainButton.Text = "🛡️ ANTI BANG"
MainButton.TextSize = 15
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 4
MainButton.BorderColor3 = Color3.fromRGB(0, 255, 200)
MainButton.Parent = ScreenGui
UICorner.CornerRadius = UDim.new(0, 12); UICorner.Parent = MainButton

-- واجهة
MainFrame.Size = UDim2.new(0, 280, 0, 180)
MainFrame.Position = UDim2.new(0.5, -140, 0, 65)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
MainFrame.Visible = false; MainFrame.Draggable = true
MainFrame.BorderSizePixel = 3; MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
MainFrame.Parent = ScreenGui
UICorner2.CornerRadius = UDim.new(0, 12); UICorner2.Parent = MainFrame

Title.Size = UDim2.new(1, -45, 0, 24); Title.Position = UDim2.new(0, 18, 0, 5)
Title.BackgroundTransparency = 1; Title.Text = "🛡️ ANTI BANG SPIN"
Title.TextColor3 = Color3.fromRGB(0, 255, 200); Title.TextSize = 14
Title.Font = Enum.Font.GothamBlack; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.Parent = MainFrame

CloseButton.Size = UDim2.new(0, 22, 0, 22); CloseButton.Position = UDim2.new(1, -28, 0, 6)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40); CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"; CloseButton.TextSize = 13; CloseButton.Font = Enum.Font.GothamBlack
CloseButton.BorderSizePixel = 0; CloseButton.Parent = MainFrame
UICorner3.CornerRadius = UDim.new(0, 11); UICorner3.Parent = CloseButton

ToggleButton.Size = UDim2.new(1, -30, 0, 55); ToggleButton.Position = UDim2.new(0, 15, 0, 40)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0); ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "🛡️ تشغيل الحماية المجنونة"; ToggleButton.TextSize = 15
ToggleButton.Font = Enum.Font.GothamBlack; ToggleButton.BorderSizePixel = 0; ToggleButton.Parent = MainFrame
UICorner4.CornerRadius = UDim.new(0, 12); UICorner4.Parent = ToggleButton

StatusText.Size = UDim2.new(1, -30, 0, 28); StatusText.Position = UDim2.new(0, 15, 0, 110)
StatusText.BackgroundColor3 = Color3.fromRGB(12, 12, 12); StatusText.TextColor3 = Color3.fromRGB(0, 255, 200)
StatusText.Text = "🔴 متوقفة | 0"; StatusText.TextSize = 14
StatusText.Font = Enum.Font.GothamBlack; StatusText.BorderSizePixel = 2
StatusText.BorderColor3 = Color3.fromRGB(0, 255, 200); StatusText.Parent = MainFrame
local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0, 11); sc.Parent = StatusText

Notification.Size = UDim2.new(0, 260, 0, 38); Notification.Position = UDim2.new(0.5, -130, 0, -45)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0); Notification.BorderSizePixel = 3
Notification.BorderColor3 = Color3.fromRGB(0, 255, 200); Notification.Visible = false; Notification.Parent = ScreenGui
UICorner5.CornerRadius = UDim.new(0, 10); UICorner5.Parent = Notification
NotificationText.Size = UDim2.new(1, -16, 1, 0); NotificationText.Position = UDim2.new(0, 8, 0, 0)
NotificationText.BackgroundTransparency = 1; NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 14; NotificationText.Font = Enum.Font.GothamBlack; NotificationText.Parent = Notification

local function noti(msg)
    NotificationText.Text = msg; Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -130, 0, -45)
    spawn(function() for i=1,6 do Notification.Position=UDim2.new(0.5,-130,0,-45+i*8); task.wait(0.01) end
    task.wait(2); for i=1,6 do Notification.Position=UDim2.new(0.5,-130,0,3-i*8); task.wait(0.01) end
    Notification.Visible=false end)
end

-- ========== نظام الدرع والسبين ==========

local function createFullShield()
    -- تنظيف الدروع القديمة
    for _, part in pairs(spinParts) do if part then part:Destroy() end end
    spinParts = {}
    if myShield then myShield:Destroy() end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- درع رئيسي كبير
    myShield = Instance.new("Part")
    myShield.Size = Vector3.new(40, 40, 40)
    myShield.Shape = Enum.PartType.Ball
    myShield.Anchored = true
    myShield.CanCollide = true
    myShield.Transparency = 0.3
    myShield.Color = Color3.fromRGB(0, 255, 200)
    myShield.Material = Enum.Material.Neon
    myShield.Parent = workspace
    
    -- 8 كرات تدور حولي
    for i = 1, 8 do
        local orb = Instance.new("Part")
        orb.Size = Vector3.new(8, 8, 8)
        orb.Shape = Enum.PartType.Ball
        orb.Anchored = true
        orb.CanCollide = true
        orb.Transparency = 0.3
        orb.Color = Color3.fromRGB(255, 100, 0)
        orb.Material = Enum.Material.Neon
        orb.Parent = workspace
        table.insert(spinParts, {Part = orb, Angle = i * 45, Radius = 25, Speed = 15 + i * 2, Height = 0})
    end
    
    -- 4 حلقات تدور
    for i = 1, 4 do
        local ring = Instance.new("Part")
        ring.Size = Vector3.new(2, 2, 30)
        ring.Shape = Enum.PartType.Cylinder
        ring.Anchored = true
        ring.CanCollide = true
        ring.Transparency = 0.4
        ring.Color = Color3.fromRGB(0, 200, 255)
        ring.Material = Enum.Material.Neon
        ring.Parent = workspace
        table.insert(spinParts, {Part = ring, Angle = i * 90, Radius = 22, Speed = 10, Height = 0, IsRing = true})
    end
    
    -- تحديث الدرع والسبين
    spawn(function()
        while isActive and lp.Character do
            local r = lp.Character:FindFirstChild("HumanoidRootPart")
            if r then
                local pos = r.Position
                
                -- الدرع الرئيسي يتبعني
                if myShield and myShield.Parent then
                    myShield.CFrame = CFrame.new(pos) * CFrame.Angles(0, tick() * 3, 0)
                end
                
                -- الكرات والحلقات تدور حولي
                for _, data in pairs(spinParts) do
                    if data.Part and data.Part.Parent then
                        data.Angle = data.Angle + data.Speed * 0.05
                        local rad = math.rad(data.Angle)
                        local x = math.cos(rad) * data.Radius
                        local z = math.sin(rad) * data.Radius
                        local y = math.sin(tick() * 3 + data.Angle) * 5
                        
                        if data.IsRing then
                            data.Part.CFrame = CFrame.new(pos + Vector3.new(x, y, z)) * CFrame.Angles(math.rad(data.Angle), 0, math.rad(90))
                        else
                            data.Part.CFrame = CFrame.new(pos + Vector3.new(x, y, z))
                        end
                    end
                end
            end
            task.wait()
        end
        
        -- تنظيف
        if myShield then myShield:Destroy(); myShield = nil end
        for _, data in pairs(spinParts) do if data.Part then data.Part:Destroy() end end
        spinParts = {}
    end)
end

local function detectBanger()
    local lp = game.Players.LocalPlayer
    if not lp.Character then return nil, nil end
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil, nil end
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            local tr = plr.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                local d = (root.Position - tr.Position).Magnitude
                local s = tr.Velocity.Magnitude
                if (d < 15 and s > 10) or d < 3 then return plr, d end
            end
        end
    end
    return nil, nil
end

-- سبين مجنون سريع
local function crazySpin()
    if isEvading then return end; isEvading = true
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then isEvading = false; return end
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local hum = lp.Character:FindFirstChild("Humanoid")
    if not root then isEvading = false; return end
    
    if not originalPosition then originalPosition = root.Position end
    if hum then hum.Health = hum.MaxHealth end
    
    -- ForceField
    local ff = Instance.new("ForceField"); ff.Parent = lp.Character
    
    -- وميض
    for i = 1, 10 do
        local f = Instance.new("Part")
        f.Size = Vector3.new(60, 60, 60); f.Shape = Enum.PartType.Ball
        f.Position = root.Position + Vector3.new(math.random(-30,30), math.random(-30,30), math.random(-30,30))
        f.Anchored = true; f.CanCollide = false; f.Material = Enum.Material.Neon; f.Transparency = 0.5
        f.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
        f.Parent = workspace
        spawn(function() for j=1,10 do f.Transparency=f.Transparency+0.05; task.wait(0.05) end; f:Destroy() end)
    end
    
    -- صوت
    pcall(function() local s = Instance.new("Sound"); s.SoundId = "rbxassetid://9119260688"; s.Volume = 10; s.Parent = root; s:Play(); task.wait(1); s:Destroy() end)
    
    -- إعلان
    local head = lp.Character:FindFirstChild("Head")
    if head then
        local bb = Instance.new("BillboardGui"); bb.Size = UDim2.new(0,350,0,60); bb.StudsOffset = Vector3.new(0,8,0); bb.AlwaysOnTop = true; bb.Parent = head
        local lb = Instance.new("TextLabel"); lb.Size = UDim2.new(1,0,1,0); lb.BackgroundTransparency = 1; lb.TextColor3 = Color3.fromRGB(255,255,0); lb.TextStrokeTransparency = 0
        lb.Text = "🛡️ SPIN PROTECTION 🛡️"; lb.TextSize = 16; lb.Font = Enum.Font.GothamBlack; lb.Parent = bb
        spawn(function() task.wait(5); bb:Destroy() end)
    end
    
    noti("🌪 سبين مجنون!")
    
    -- سبين سريع يمين يسار فوق تحت
    for i = 1, 40 do
        local x = math.sin(i * 0.5) * 30  -- يمين يسار
        local z = math.cos(i * 0.5) * 30  -- أمام خلف
        local y = math.sin(i * 0.3) * 20  -- فوق تحت
        
        root.CFrame = CFrame.new(originalPosition + Vector3.new(x, y + 3, z)) * CFrame.Angles(0, math.rad(i * 20), 0)
        root.Velocity = Vector3.new(math.random(-50,50), 30, math.random(-50,50))
        
        if hum then hum.Health = hum.MaxHealth end
        task.wait(0.02)
    end
    
    -- دوران سريع في المكان
    noti("🔄 دوران سريع!")
    for i = 1, 50 do
        root.CFrame = CFrame.new(originalPosition + Vector3.new(0, 5, 0)) * CFrame.Angles(math.rad(i*10), math.rad(i*20), math.rad(i*5))
        root.Velocity = Vector3.new(0, 20, 0)
        if hum then hum.Health = hum.MaxHealth end
        task.wait(0.015)
    end
    
    -- قفزات سريعة
    noti("🦘 قفزات!")
    for i = 1, 20 do
        root.CFrame = root.CFrame + Vector3.new(math.random(-20,20), 10, math.random(-20,20))
        root.Velocity = Vector3.new(math.random(-100,100), 80, math.random(-100,100))
        if hum then hum.Health = hum.MaxHealth end
        task.wait(0.03)
    end
    
    -- طيران حلزوني للأعلى
    noti("🌪 طيران!")
    for i = 1, 30 do
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(60), 0) + Vector3.new(0, 35, 0)
        root.Velocity = Vector3.new(math.random(-150,150), 600, math.random(-150,150))
        if hum then hum.Health = hum.MaxHealth end
        task.wait(0.015)
    end
    
    -- نزول آمن
    noti("🌀 عودة...")
    local safePos = originalPosition or root.Position
    root.CFrame = CFrame.new(safePos + Vector3.new(0, 200, 0))
    root.Anchored = true; task.wait(0.3); root.Anchored = false
    
    for i = 1, 60 do
        root.CFrame = root.CFrame - Vector3.new(0, 3, 0)
        root.Velocity = Vector3.new(0, -3, 0)
        if hum then hum.Health = hum.MaxHealth end
        task.wait(0.03)
    end
    
    root.Velocity = Vector3.zero
    if hum then hum.Health = hum.MaxHealth end
    root.Anchored = true; task.wait(0.3); root.Anchored = false
    
    if ff then ff:Destroy() end
    
    protectionCount = protectionCount + 1
    StatusText.Text = "🟢 تعمل | " .. protectionCount
    isEvading = false
end

local function protectionLoop()
    if not isActive then return end
    local banger, dist = detectBanger()
    if banger then
        noti("⚠️ " .. banger.DisplayName .. " على بعد " .. math.floor(dist) .. "m!")
        crazySpin()
    end
end

local function startProtection()
    if isActive then return end; isActive = true
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        originalPosition = lp.Character.HumanoidRootPart.Position
    end
    createFullShield()
    ToggleButton.Text = "🛡️ إيقاف الحماية"; ToggleButton.BackgroundColor3 = Color3.fromRGB(255,50,50)
    MainButton.TextColor3 = Color3.fromRGB(0,255,0); MainButton.BorderColor3 = Color3.fromRGB(0,255,0)
    StatusText.Text = "🟢 تعمل | " .. protectionCount; StatusText.TextColor3 = Color3.fromRGB(0,255,0)
    noti("🛡️ الحماية المجنونة مفعلة!")
    spawn(function() while isActive do pcall(protectionLoop); task.wait(0.08) end end)
end

local function stopProtection()
    isActive = false
    if myShield then myShield:Destroy(); myShield = nil end
    for _, data in pairs(spinParts) do if data.Part then data.Part:Destroy() end end
    spinParts = {}
    
    if originalPosition then
        local lp = game.Players.LocalPlayer
        if lp.Character then
            local root = lp.Character:FindFirstChild("HumanoidRootPart"); local hum = lp.Character:FindFirstChild("Humanoid")
            if root then
                root.CFrame = CFrame.new(originalPosition + Vector3.new(0, 100, 0))
                root.Anchored = true; task.wait(0.3); root.Anchored = false
                for i=1,30 do
                    root.CFrame = root.CFrame - Vector3.new(0, 3, 0)
                    root.Velocity = Vector3.new(0, -3, 0)
                    if hum then hum.Health = hum.MaxHealth end
                    task.wait(0.03)
                end
                root.Velocity = Vector3.zero
                if hum then hum.Health = hum.MaxHealth end
            end
        end
    end
    
    ToggleButton.Text = "🛡️ تشغيل الحماية المجنونة"; ToggleButton.BackgroundColor3 = Color3.fromRGB(0,180,0)
    MainButton.TextColor3 = Color3.fromRGB(0,255,200); MainButton.BorderColor3 = Color3.fromRGB(0,255,200)
    StatusText.Text = "🔴 متوقفة | " .. protectionCount; StatusText.TextColor3 = Color3.fromRGB(255,100,100)
    noti("🔴 تم الإيقاف - رجعت لمكانك")
end

local function toggleProtection() if isActive then stopProtection() else startProtection() end end

-- ========== الأحداث ==========
MainButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
ToggleButton.MouseButton1Click:Connect(toggleProtection)
game.Players.LocalPlayer.CharacterAdded:Connect(function(c) if isActive then task.wait(0.5); createFullShield() end end)
noti("🛡️ اضغط الزر لفتح الواجهة")
