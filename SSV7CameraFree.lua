-- ⚡ SSV7 Free Camera Mobile - كاميرا حرة للجوال 100% ⚡
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local ControlsFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Notification = Instance.new("Frame")
local UICorner3 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")

-- أزرار الحركة
local ForwardBtn = Instance.new("TextButton")
local BackBtn = Instance.new("TextButton")
local LeftBtn = Instance.new("TextButton")
local RightBtn = Instance.new("TextButton")
local UpBtn = Instance.new("TextButton")
local DownBtn = Instance.new("TextButton")

-- أزرار التدوير
local RotLeftBtn = Instance.new("TextButton")
local RotRightBtn = Instance.new("TextButton")
local RotUpBtn = Instance.new("TextButton")
local RotDownBtn = Instance.new("TextButton")

-- السرعة
local SpeedUpBtn = Instance.new("TextButton")
local SpeedDownBtn = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")

-- المتغيرات
local isFreeCam = false
local cameraConnection = nil
local moveSpeed = 50
local rotSpeed = 3

-- حالات الأزرار
local forwardHeld = false
local backHeld = false
local leftHeld = false
local rightHeld = false
local upHeld = false
local downHeld = false
local rotLeftHeld = false
local rotRightHeld = false
local rotUpHeld = false
local rotDownHeld = false

-- إعدادات الشاشة
ScreenGui.Name = "SSV7_FreeCam"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== الزر الرئيسي ==========
MainButton.Size = UDim2.new(0, 120, 0, 40)
MainButton.Position = UDim2.new(0.5, -60, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(0, 255, 200)
MainButton.Text = "📷 كاميرا"
MainButton.TextSize = 14
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 3
MainButton.BorderColor3 = Color3.fromRGB(0, 255, 200)
MainButton.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainButton

-- ========== إطار الأزرار ==========
ControlsFrame.Size = UDim2.new(0, 300, 0, 350)
ControlsFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
ControlsFrame.BackgroundTransparency = 1
ControlsFrame.Visible = false
ControlsFrame.Parent = ScreenGui

-- ========== إنشاء الأزرار ==========

local function createBtn(parent, text, color, x, y, size)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, size, 0, size)
    btn.Position = UDim2.new(0, x, 0, y)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.4
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.TextSize = size * 0.45
    btn.Font = Enum.Font.GothamBlack
    btn.BorderSizePixel = 0
    btn.ZIndex = 10
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, size/2)
    corner.Parent = btn
    
    return btn
end

-- صف 1: الأعلى والأسفل والتدوير
UpBtn = createBtn(ControlsFrame, "🔝", Color3.fromRGB(100, 200, 255), 10, 5, 55)
DownBtn = createBtn(ControlsFrame, "🔚", Color3.fromRGB(100, 200, 255), 75, 5, 55)
RotLeftBtn = createBtn(ControlsFrame, "↩️", Color3.fromRGB(255, 180, 50), 190, 5, 55)
RotRightBtn = createBtn(ControlsFrame, "↪️", Color3.fromRGB(255, 180, 50), 250, 5, 55)

-- صف 2: الأمام والخلف والتدوير
RotUpBtn = createBtn(ControlsFrame, "🔼", Color3.fromRGB(200, 150, 255), 10, 75, 55)
RotDownBtn = createBtn(ControlsFrame, "🔽", Color3.fromRGB(200, 150, 255), 75, 75, 55)
ForwardBtn = createBtn(ControlsFrame, "⬆️", Color3.fromRGB(0, 200, 100), 180, 65, 70)
BackBtn = createBtn(ControlsFrame, "⬇️", Color3.fromRGB(200, 50, 50), 180, 145, 70)

-- صف 3: اليسار واليمين
LeftBtn = createBtn(ControlsFrame, "⬅️", Color3.fromRGB(50, 150, 200), 105, 85, 65)
RightBtn = createBtn(ControlsFrame, "➡️", Color3.fromRGB(50, 150, 200), 260, 85, 65)

-- صف 4: السرعة
SpeedDownBtn = createBtn(ControlsFrame, "➖", Color3.fromRGB(200, 50, 50), 80, 250, 45)
SpeedUpBtn = createBtn(ControlsFrame, "➕", Color3.fromRGB(0, 200, 100), 175, 250, 45)

-- عداد السرعة
SpeedLabel.Size = UDim2.new(0, 100, 0, 30)
SpeedLabel.Position = UDim2.new(0.5, -50, 0, 260)
SpeedLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SpeedLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
SpeedLabel.Text = "⚡ " .. moveSpeed
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.GothamBlack
SpeedLabel.BorderSizePixel = 2
SpeedLabel.BorderColor3 = Color3.fromRGB(0, 255, 200)
SpeedLabel.Parent = ControlsFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 15)
speedCorner.Parent = SpeedLabel

-- ========== إشعار ==========
Notification.Size = UDim2.new(0, 230, 0, 32)
Notification.Position = UDim2.new(0.5, -115, 0, -38)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(0, 255, 200)
Notification.Visible = false
Notification.Parent = ScreenGui

UICorner3.CornerRadius = UDim.new(0, 8)
UICorner3.Parent = Notification

NotificationText.Size = UDim2.new(1, -12, 1, 0)
NotificationText.Position = UDim2.new(0, 6, 0, 0)
NotificationText.BackgroundTransparency = 1
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 12
NotificationText.Font = Enum.Font.GothamBold
NotificationText.Parent = Notification

-- ========== ربط الأزرار بالأحداث ==========

local function bindButton(btn, heldVar)
    btn.MouseButton1Down:Connect(function()
        heldVar = true
    end)
    
    btn.MouseButton1Up:Connect(function()
        heldVar = false
    end)
    
    btn.MouseLeave:Connect(function()
        heldVar = false
    end)
    
    -- للمس الطويل على الجوال
    btn.TouchLongPress:Connect(function()
        heldVar = true
    end)
    
    btn.TouchTap:Connect(function()
        heldVar = false
    end)
end

-- ربط كل الأزرار
bindButton(ForwardBtn, forwardHeld)
bindButton(BackBtn, backHeld)
bindButton(LeftBtn, leftHeld)
bindButton(RightBtn, rightHeld)
bindButton(UpBtn, upHeld)
bindButton(DownBtn, downHeld)
bindButton(RotLeftBtn, rotLeftHeld)
bindButton(RotRightBtn, rotRightHeld)
bindButton(RotUpBtn, rotUpHeld)
bindButton(RotDownBtn, rotDownHeld)

-- ========== وظائف ==========

local function updateSpeed()
    SpeedLabel.Text = "⚡ " .. moveSpeed
end

local function showNotification(text)
    NotificationText.Text = text
    Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -115, 0, -38)
    
    spawn(function()
        for i = 1, 5 do
            Notification.Position = UDim2.new(0.5, -115, 0, -38 + (i * 8))
            task.wait(0.01)
        end
        task.wait(1.5)
        for i = 1, 5 do
            Notification.Position = UDim2.new(0.5, -115, 0, 2 - (i * 8))
            task.wait(0.01)
        end
        Notification.Visible = false
    end)
end

local function startFreeCam()
    if isFreeCam then return end
    isFreeCam = true
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    
    if character then
        -- تثبيت الشخصية
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
            end
        end
    end
    
    -- كاميرا حرة
    local camera = workspace.CurrentCamera
    if camera then
        camera.CameraType = Enum.CameraType.Scriptable
    end
    
    ControlsFrame.Visible = true
    
    -- حلقة التحديث
    cameraConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not isFreeCam then return end
        
        local camera = workspace.CurrentCamera
        if not camera then return end
        
        local moveVector = Vector3.zero
        
        -- الحركة عبر الأزرار
        if forwardHeld then moveVector = moveVector + camera.CFrame.LookVector end
        if backHeld then moveVector = moveVector - camera.CFrame.LookVector end
        if leftHeld then moveVector = moveVector - camera.CFrame.RightVector end
        if rightHeld then moveVector = moveVector + camera.CFrame.RightVector end
        if upHeld then moveVector = moveVector + Vector3.new(0, 1, 0) end
        if downHeld then moveVector = moveVector - Vector3.new(0, 1, 0) end
        
        -- التدوير عبر الأزرار
        if rotLeftHeld then camera.CFrame = camera.CFrame * CFrame.Angles(0, math.rad(rotSpeed), 0) end
        if rotRightHeld then camera.CFrame = camera.CFrame * CFrame.Angles(0, math.rad(-rotSpeed), 0) end
        if rotUpHeld then camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(rotSpeed), 0, 0) end
        if rotDownHeld then camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(-rotSpeed), 0, 0) end
        
        -- تحريك الكاميرا
        if moveVector.Magnitude > 0 then
            camera.CFrame = camera.CFrame + (moveVector.Unit * moveSpeed * 0.15)
        end
        
        -- WASD للكمبيوتر
        local uis = game:GetService("UserInputService")
        if uis:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + camera.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - camera.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - camera.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + camera.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.E) then moveVector = moveVector + Vector3.new(0, 1, 0) end
        if uis:IsKeyDown(Enum.KeyCode.Q) then moveVector = moveVector - Vector3.new(0, 1, 0) end
        
        if moveVector.Magnitude > 0 then
            camera.CFrame = camera.CFrame + (moveVector.Unit * moveSpeed * 0.15)
        end
        
        -- تدوير بالماوس
        if uis:IsMouseButtonPressed(1) then
            local delta = uis:GetMouseDelta()
            camera.CFrame = camera.CFrame * CFrame.Angles(0, math.rad(-delta.X * 0.3), 0) * CFrame.Angles(math.rad(-delta.Y * 0.3), 0, 0)
        end
    end)
    
    MainButton.Text = "⏹ إيقاف"
    MainButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    MainButton.BorderColor3 = Color3.fromRGB(255, 100, 100)
    
    showNotification("📷 الكاميرا تعمل | استخدم الأزرار")
end

local function stopFreeCam()
    if not isFreeCam then return end
    isFreeCam = false
    
    if cameraConnection then
        cameraConnection:Disconnect()
        cameraConnection = nil
    end
    
    -- استعادة الكاميرا
    local camera = workspace.CurrentCamera
    if camera then
        camera.CameraType = Enum.CameraType.Custom
        local localPlayer = game.Players.LocalPlayer
        if localPlayer.Character then
            camera.CameraSubject = localPlayer.Character:FindFirstChild("Humanoid")
        end
    end
    
    -- استعادة الشخصية
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character then
        for _, part in pairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = false
            end
        end
    end
    
    -- إعادة تعيين الحركات
    forwardHeld = false; backHeld = false; leftHeld = false; rightHeld = false
    upHeld = false; downHeld = false
    rotLeftHeld = false; rotRightHeld = false; rotUpHeld = false; rotDownHeld = false
    
    ControlsFrame.Visible = false
    
    MainButton.Text = "📷 كاميرا"
    MainButton.TextColor3 = Color3.fromRGB(0, 255, 200)
    MainButton.BorderColor3 = Color3.fromRGB(0, 255, 200)
    
    showNotification("🔴 تم إيقاف الكاميرا")
end

-- ========== أحداث إضافية ==========

MainButton.MouseButton1Click:Connect(function()
    if isFreeCam then stopFreeCam() else startFreeCam() end
end)

SpeedUpBtn.MouseButton1Click:Connect(function()
    moveSpeed = math.min(moveSpeed + 10, 200)
    updateSpeed()
end)

SpeedDownBtn.MouseButton1Click:Connect(function()
    moveSpeed = math.max(moveSpeed - 10, 10)
    updateSpeed()
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if isFreeCam then stopFreeCam() end
end)

updateSpeed()
showNotification("📷 اضغط لتفعيل الكاميرا")
