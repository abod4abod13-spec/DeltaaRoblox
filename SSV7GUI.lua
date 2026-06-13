-- ⚡ SSV7 TP - الإصدار الأسطوري النهائي ⚡
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local SearchFrame = Instance.new("Frame")
local UICorner7 = Instance.new("UICorner")
local SearchBox = Instance.new("TextBox")
local ModeFrame = Instance.new("Frame")
local UICorner4 = Instance.new("UICorner")
local ModeLabel = Instance.new("TextLabel")
local BehindButton = Instance.new("TextButton")
local UICorner5 = Instance.new("UICorner")
local AboveButton = Instance.new("TextButton")
local UICorner6 = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")
local PlayerListFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local FriendNotification = Instance.new("Frame")
local FriendNotificationCorner = Instance.new("UICorner")
local FriendNotificationText = Instance.new("TextLabel")
local SpeedButton = Instance.new("TextButton")
local UICorner9 = Instance.new("UICorner")
local InvisibleButton = Instance.new("TextButton")
local UICorner10 = Instance.new("UICorner")
local NoclipButton = Instance.new("TextButton")
local UICorner11 = Instance.new("UICorner")
local FlyButton = Instance.new("TextButton")
local UICorner12 = Instance.new("UICorner")
local CameraButton = Instance.new("TextButton")
local UICorner13 = Instance.new("UICorner")
local RespawnButton = Instance.new("TextButton")
local UICorner14 = Instance.new("UICorner")
local ESPButton = Instance.new("TextButton")
local UICorner15 = Instance.new("UICorner")

-- المتغيرات
local currentMode = "Behind"
local targetPlayer = nil
local followConnection = nil
local isFollowing = false
local friendsList = {}
local notificationDebounce = false
local isNoclipping = false
local isFlying = false
local flyConnection = nil
local noclipConnection = nil
local isInvisible = false
local invisibleConnection = nil
local isESPEnabled = false
local espConnections = {}
local cameraLocked = true

-- إعدادات الشاشة
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== الزر الرئيسي ==========
MainButton.Name = "MainButton"
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 120, 0, 45)
MainButton.Position = UDim2.new(0.5, -60, 0, 20)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(0, 255, 255)
MainButton.Text = "⚡ SSV7 TP"
MainButton.TextSize = 16
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 3
MainButton.BorderColor3 = Color3.fromRGB(0, 255, 255)

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainButton

-- ========== القائمة الرئيسية ==========
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 320, 0, 550)
MainFrame.Position = UDim2.new(0.5, -160, 0, 75)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)

UICorner2.CornerRadius = UDim.new(0, 15)
UICorner2.Parent = MainFrame

-- ========== إشعارات الأصدقاء ==========
FriendNotification.Name = "FriendNotification"
FriendNotification.Parent = ScreenGui
FriendNotification.Size = UDim2.new(0, 300, 0, 65)
FriendNotification.Position = UDim2.new(1, -310, 0, -75)
FriendNotification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FriendNotification.BorderSizePixel = 3
FriendNotification.BorderColor3 = Color3.fromRGB(0, 255, 200)
FriendNotification.Visible = false

FriendNotificationCorner.CornerRadius = UDim.new(0, 12)
FriendNotificationCorner.Parent = FriendNotification

FriendNotificationText.Parent = FriendNotification
FriendNotificationText.Size = UDim2.new(1, -20, 1, -10)
FriendNotificationText.Position = UDim2.new(0, 10, 0, 5)
FriendNotificationText.BackgroundTransparency = 1
FriendNotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
FriendNotificationText.TextSize = 14
FriendNotificationText.Font = Enum.Font.GothamBold
FriendNotificationText.TextWrapped = true

-- ========== العنوان ==========
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -50, 0, 45)
Title.Position = UDim2.new(0, 25, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "⚡ SSV7 TRACKER PRO"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left

-- ========== زر الإغلاق ==========
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -45, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBlack
CloseButton.BorderSizePixel = 0

UICorner3.CornerRadius = UDim.new(0, 8)
UICorner3.Parent = CloseButton

-- ========== مربع البحث ==========
SearchFrame.Parent = MainFrame
SearchFrame.Size = UDim2.new(1, -30, 0, 42)
SearchFrame.Position = UDim2.new(0, 15, 0, 55)
SearchFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SearchFrame.BorderSizePixel = 2
SearchFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)

UICorner7.CornerRadius = UDim.new(0, 10)
UICorner7.Parent = SearchFrame

SearchBox.Parent = SearchFrame
SearchBox.Size = UDim2.new(1, -20, 0, 38)
SearchBox.Position = UDim2.new(0, 10, 0, 2)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = ""
SearchBox.PlaceholderText = "🔍 ابحث عن لاعب..."
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchBox.TextSize = 14
SearchBox.Font = Enum.Font.Gotham
SearchBox.BorderSizePixel = 0

-- ========== إطار اختيار الوضع ==========
ModeFrame.Parent = MainFrame
ModeFrame.Size = UDim2.new(1, -30, 0, 75)
ModeFrame.Position = UDim2.new(0, 15, 0, 107)
ModeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ModeFrame.BorderSizePixel = 2
ModeFrame.BorderColor3 = Color3.fromRGB(255, 0, 255)

UICorner4.CornerRadius = UDim.new(0, 12)
UICorner4.Parent = ModeFrame

ModeLabel.Parent = ModeFrame
ModeLabel.Size = UDim2.new(1, 0, 0, 22)
ModeLabel.Position = UDim2.new(0, 0, 0, 5)
ModeLabel.BackgroundTransparency = 1
ModeLabel.Text = "🎯 اختر وضعية التتبع:"
ModeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ModeLabel.TextSize = 13
ModeLabel.Font = Enum.Font.GothamBold

-- زر حقيبة الظهر
BehindButton.Parent = ModeFrame
BehindButton.Size = UDim2.new(0.45, 0, 0, 40)
BehindButton.Position = UDim2.new(0.025, 0, 0, 30)
BehindButton.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
BehindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BehindButton.Text = "🎒 حقيبة ظهر"
BehindButton.TextSize = 13
BehindButton.Font = Enum.Font.GothamBlack
BehindButton.BorderSizePixel = 0

UICorner5.CornerRadius = UDim.new(0, 8)
UICorner5.Parent = BehindButton

-- زر القبعة
AboveButton.Parent = ModeFrame
AboveButton.Size = UDim2.new(0.45, 0, 0, 40)
AboveButton.Position = UDim2.new(0.525, 0, 0, 30)
AboveButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AboveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AboveButton.Text = "👑 قبعة"
AboveButton.TextSize = 13
AboveButton.Font = Enum.Font.GothamBlack
AboveButton.BorderSizePixel = 0

UICorner6.CornerRadius = UDim.new(0, 8)
UICorner6.Parent = AboveButton

-- ========== أدوات إضافية (الصف الأول) ==========
SpeedButton.Parent = MainFrame
SpeedButton.Size = UDim2.new(0.22, 0, 0, 30)
SpeedButton.Position = UDim2.new(0, 15, 0, 192)
SpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.Text = "⚡ سرعة"
SpeedButton.TextSize = 11
SpeedButton.Font = Enum.Font.GothamBold
SpeedButton.BorderSizePixel = 0

UICorner9.CornerRadius = UDim.new(0, 6)
UICorner9.Parent = SpeedButton

InvisibleButton.Parent = MainFrame
InvisibleButton.Size = UDim2.new(0.22, 0, 0, 30)
InvisibleButton.Position = UDim2.new(0.26, 15, 0, 192)
InvisibleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
InvisibleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InvisibleButton.Text = "👻 تخفي"
InvisibleButton.TextSize = 11
InvisibleButton.Font = Enum.Font.GothamBold
InvisibleButton.BorderSizePixel = 0

UICorner10.CornerRadius = UDim.new(0, 6)
UICorner10.Parent = InvisibleButton

NoclipButton.Parent = MainFrame
NoclipButton.Size = UDim2.new(0.22, 0, 0, 30)
NoclipButton.Position = UDim2.new(0.52, 15, 0, 192)
NoclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.Text = "🚫 نوكلب"
NoclipButton.TextSize = 11
NoclipButton.Font = Enum.Font.GothamBold
NoclipButton.BorderSizePixel = 0

UICorner11.CornerRadius = UDim.new(0, 6)
UICorner11.Parent = NoclipButton

-- ========== أدوات إضافية (الصف الثاني) ==========
FlyButton.Parent = MainFrame
FlyButton.Size = UDim2.new(0.22, 0, 0, 30)
FlyButton.Position = UDim2.new(0, 15, 0, 227)
FlyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.Text = "✈️ طيران"
FlyButton.TextSize = 11
FlyButton.Font = Enum.Font.GothamBold
FlyButton.BorderSizePixel = 0

UICorner12.CornerRadius = UDim.new(0, 6)
UICorner12.Parent = FlyButton

CameraButton.Parent = MainFrame
CameraButton.Size = UDim2.new(0.22, 0, 0, 30)
CameraButton.Position = UDim2.new(0.26, 15, 0, 227)
CameraButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
CameraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CameraButton.Text = "📷 كاميرا"
CameraButton.TextSize = 11
CameraButton.Font = Enum.Font.GothamBold
CameraButton.BorderSizePixel = 0

UICorner13.CornerRadius = UDim.new(0, 6)
UICorner13.Parent = CameraButton

ESPButton.Parent = MainFrame
ESPButton.Size = UDim2.new(0.22, 0, 0, 30)
ESPButton.Position = UDim2.new(0.52, 15, 0, 227)
ESPButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.Text = "👁️ ESP"
ESPButton.TextSize = 11
ESPButton.Font = Enum.Font.GothamBold
ESPButton.BorderSizePixel = 0

UICorner15.CornerRadius = UDim.new(0, 6)
UICorner15.Parent = ESPButton

RespawnButton.Parent = MainFrame
RespawnButton.Size = UDim2.new(0.22, 0, 0, 30)
RespawnButton.Position = UDim2.new(0.78, 15, 0, 227)
RespawnButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RespawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RespawnButton.Text = "🔄 رجوع"
RespawnButton.TextSize = 11
RespawnButton.Font = Enum.Font.GothamBold
RespawnButton.BorderSizePixel = 0

UICorner14.CornerRadius = UDim.new(0, 6)
UICorner14.Parent = RespawnButton

-- ========== حالة التتبع ==========
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, -30, 0, 25)
StatusLabel.Position = UDim2.new(0, 15, 0, 265)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🔴 لا يوجد تتبع"
StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.GothamBold

-- ========== قائمة اللاعبين ==========
PlayerListFrame.Parent = MainFrame
PlayerListFrame.Size = UDim2.new(1, -30, 1, -305)
PlayerListFrame.Position = UDim2.new(0, 15, 0, 300)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.ScrollBarThickness = 6
PlayerListFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
PlayerListFrame.BorderSizePixel = 2
PlayerListFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)

UIListLayout.Parent = PlayerListFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

--- ========== الوظائف الأساسية ==========

-- تفعيل النوكلب
local function enableNoclip()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return end
    
    for _, part in pairs(localPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- وظيفة التخفي الحقيقي (بدون أثر)
local function toggleInvisibility()
    local localPlayer = game.Players.LocalPlayer
    isInvisible = not isInvisible
    
    if isInvisible then
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        InvisibleButton.Text = "👻 ظاهر"
        
        invisibleConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if localPlayer.Character then
                for _, part in pairs(localPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                    end
                    if part:IsA("Decal") or part:IsA("Texture") then
                        part.Transparency = 1
                    end
                end
                -- إخفاء الاسم فوق الرأس
                local head = localPlayer.Character:FindFirstChild("Head")
                if head then
                    local billboard = head:FindFirstChildOfClass("BillboardGui")
                    if billboard then
                        billboard.Enabled = false
                    end
                end
            end
        end)
    else
        InvisibleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        InvisibleButton.Text = "👻 تخفي"
        
        if invisibleConnection then
            invisibleConnection:Disconnect()
            invisibleConnection = nil
        end
        
        if localPlayer.Character then
            for _, part in pairs(localPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
                if part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 0
                end
            end
            local head = localPlayer.Character:FindFirstChild("Head")
            if head then
                local billboard = head:FindFirstChildOfClass("BillboardGui")
                if billboard then
                    billboard.Enabled = true
                end
            end
        end
    end
end

-- وظيفة ESP للاعبين
local function toggleESP()
    isESPEnabled = not isESPEnabled
    
    if isESPEnabled then
        ESPButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        ESPButton.Text = "👁️ ESP ON"
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                spawn(function()
                    addESP(player)
                end)
            end
        end
    else
        ESPButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ESPButton.Text = "👁️ ESP"
        
        for _, conn in pairs(espConnections) do
            pcall(function() conn:Disconnect() end)
        end
        espConnections = {}
        
        -- إزالة كل ESP الموجود
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local esp = player.Character:FindFirstChild("ESP_Highlight")
                if esp then esp:Destroy() end
            end
        end
    end
end

-- إضافة ESP للاعب
function addESP(player)
    if not player.Character then
        local conn = player.CharacterAdded:Connect(function()
            addESP(player)
        end)
        table.insert(espConnections, conn)
        return
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = friendsList[player.UserId] and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character
    
    local conn = player.CharacterRemoving:Connect(function()
        if highlight then highlight:Destroy() end
    end)
    table.insert(espConnections, conn)
end

-- وظيفة آمنة لنقل الشخصية
local function safeTeleport(rootPart, targetCFrame)
    if not rootPart then return false end
    
    rootPart.Velocity = Vector3.zero
    rootPart.RotVelocity = Vector3.zero
    rootPart.AssemblyLinearVelocity = Vector3.zero
    rootPart.AssemblyAngularVelocity = Vector3.zero
    
    rootPart.CFrame = targetCFrame
    
    task.wait()
    rootPart.Velocity = Vector3.zero
    rootPart.RotVelocity = Vector3.zero
    rootPart.AssemblyLinearVelocity = Vector3.zero
    rootPart.AssemblyAngularVelocity = Vector3.zero
    
    return true
end

-- وظيفة النوكلب
local function toggleNoclip()
    local localPlayer = game.Players.LocalPlayer
    isNoclipping = not isNoclipping
    
    if isNoclipping then
        NoclipButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        NoclipButton.Text = "✅ نوكلب"
        
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if localPlayer.Character then
                for _, part in pairs(localPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        NoclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        NoclipButton.Text = "🚫 نوكلب"
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if localPlayer.Character then
            for _, part in pairs(localPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- وظيفة الطيران
local function toggleFly()
    local localPlayer = game.Players.LocalPlayer
    isFlying = not isFlying
    
    if isFlying then
        FlyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        FlyButton.Text = "✅ طيران"
        
        flyConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local root = localPlayer.Character.HumanoidRootPart
                local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
                
                if humanoid then
                    humanoid.PlatformStand = true
                end
                
                root.Velocity = Vector3.zero
                root.RotVelocity = Vector3.zero
            end
        end)
    else
        FlyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        FlyButton.Text = "✈️ طيران"
        
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if localPlayer.Character then
            local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
    end
end

-- إظهار إشعار الصديق
local function showFriendNotification(friendName, action)
    if notificationDebounce then return end
    notificationDebounce = true
    
    FriendNotificationText.Text = "👋 " .. friendName .. " " .. action .. "!"
    FriendNotification.Visible = true
    FriendNotification.Position = UDim2.new(1, -310, 0, -75)
    
    for i = 1, 10 do
        FriendNotification.Position = UDim2.new(1, -310, 0, -75 + (i * 8))
        task.wait(0.02)
    end
    
    task.wait(3)
    
    for i = 1, 10 do
        FriendNotification.Position = UDim2.new(1, -310, 0, 5 - (i * 8))
        task.wait(0.02)
    end
    
    FriendNotification.Visible = false
    notificationDebounce = false
end

-- فتح/إغلاق القائمة
MainButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        MainButton.Text = "⚡ SSV7 TP ●"
    else
        MainButton.Text = "⚡ SSV7 TP"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MainButton.Text = "⚡ SSV7 TP"
end)

-- اختيار وضعية حقيبة الظهر
BehindButton.MouseButton1Click:Connect(function()
    currentMode = "Behind"
    BehindButton.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
    AboveButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    if isFollowing and targetPlayer then
        stopFollowing()
        startFollowing(targetPlayer)
    end
end)

-- اختيار وضعية القبعة
AboveButton.MouseButton1Click:Connect(function()
    currentMode = "Above"
    AboveButton.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    BehindButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    if isFollowing and targetPlayer then
        stopFollowing()
        startFollowing(targetPlayer)
    end
end)

-- أزرار الأدوات
SpeedButton.MouseButton1Click:Connect(function()
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            if humanoid.WalkSpeed == 16 then
                humanoid.WalkSpeed = 50
                SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                SpeedButton.Text = "⚡ سرعة 50"
            else
                humanoid.WalkSpeed = 16
                SpeedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                SpeedButton.Text = "⚡ سرعة"
            end
        end
    end
end)

InvisibleButton.MouseButton1Click:Connect(toggleInvisibility)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)
FlyButton.MouseButton1Click:Connect(toggleFly)
ESPButton.MouseButton1Click:Connect(toggleESP)

-- زر الكاميرا
CameraButton.MouseButton1Click:Connect(function()
    cameraLocked = not cameraLocked
    if cameraLocked then
        CameraButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        CameraButton.Text = "📷 كاميرا"
    else
        CameraButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        CameraButton.Text = "📷 حر"
    end
end)

-- زر الرجوع
RespawnButton.MouseButton1Click:Connect(function()
    stopFollowing()
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Sit = false
            humanoid.PlatformStand = false
            humanoid.WalkSpeed = 16
        end
        for _, part in pairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
                part.CanCollide = true
            end
        end
        -- إعادة ضبط الموقع
        local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 5, 0)
        end
    end
    if isNoclipping then toggleNoclip() end
    if isFlying then toggleFly() end
    if isInvisible then toggleInvisibility() end
    if isESPEnabled then toggleESP() end
end)

-- وظيفة إيقاف التتبع
function stopFollowing()
    if followConnection then
        followConnection:Disconnect()
        followConnection = nil
    end
    
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Sit = false
            humanoid.PlatformStand = false
        end
        local rootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Velocity = Vector3.zero
            rootPart.RotVelocity = Vector3.zero
            rootPart.AssemblyLinearVelocity = Vector3.zero
            rootPart.AssemblyAngularVelocity = Vector3.zero
        end
    end
    
    isFollowing = false
    targetPlayer = nil
    StatusLabel.Text = "🔴 لا يوجد تتبع"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
end

-- وظيفة بدء التتبع (المضمونة مع تتبع الاتجاه)
function startFollowing(player)
    stopFollowing()
    
    if not player then return end
    
    targetPlayer = player
    isFollowing = true
    
    local modeText = currentMode == "Behind" and "🎒 حقيبة ظهر" or "👑 قبعة"
    StatusLabel.Text = "🟢 " .. modeText .. " لـ " .. player.DisplayName
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    
    local localPlayer = game.Players.LocalPlayer
    
    if not isNoclipping then
        toggleNoclip()
    end
    
    -- حلقة التتبع الكاملة مع تتبع الاتجاه والكاميرا
    followConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not targetPlayer or not targetPlayer.Character then
            stopFollowing()
            return
        end
        
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if not targetRoot then
            stopFollowing()
            return
        end
        
        if not localPlayer.Character then
            stopFollowing()
            return
        end
        
        local localHumanoid = localPlayer.Character:FindFirstChild("Humanoid")
        local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if not localRoot then
            stopFollowing()
            return
        end
        
        enableNoclip()
        
        if localHumanoid then
            if not localHumanoid.Sit then
                localHumanoid.Sit = true
            end
            localHumanoid.PlatformStand = false
        end
        
        -- حساب الموقع مع تتبع اتجاه الهدف
        local targetCFrame = targetRoot.CFrame
        local newCFrame
        
        if currentMode == "Behind" then
            -- حقيبة الظهر: خلف اللاعب مع نفس اتجاهه
            local backDirection = -targetCFrame.LookVector
            local behindPosition = targetCFrame.Position + (backDirection * 2.5)
            behindPosition = Vector3.new(behindPosition.X, targetCFrame.Position.Y - 1.5, behindPosition.Z)
            -- نجعل اتجاهنا نفس اتجاه الهدف
            newCFrame = CFrame.new(behindPosition) * CFrame.Angles(0, math.atan2(backDirection.X, backDirection.Z), 0)
        else
            -- القبعة: فوق الرأس مع نفس اتجاه الهدف
            local abovePosition = targetCFrame.Position + Vector3.new(0, 3.5, 0)
            -- نجعل اتجاهنا نفس اتجاه الهدف
            newCFrame = CFrame.new(abovePosition) * CFrame.Angles(0, math.atan2(targetCFrame.LookVector.X, targetCFrame.LookVector.Z), 0)
        end
        
        safeTeleport(localRoot, newCFrame)
        
        -- تثبيت الكاميرا على الهدف إذا كانت مفعلة
        if cameraLocked and targetPlayer.Character:FindFirstChild("Head") then
            local targetHead = targetPlayer.Character.Head
            game.Workspace.CurrentCamera.CFrame = CFrame.new(targetHead.Position + Vector3.new(0, 2, 5), targetHead.Position)
        end
    end)
end

-- وظيفة البحث
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = SearchBox.Text:lower()
    for _, child in pairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            local buttonText = child.Text:lower()
            if searchText == "" or buttonText:find(searchText) then
                child.Visible = true
            else
                child.Visible = false
            end
        end
    end
end)

-- تحديث قائمة اللاعبين
local function updatePlayerList()
    for _, child in pairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local players = game.Players:GetPlayers()
    table.sort(players, function(a, b)
        if friendsList[a.UserId] and not friendsList[b.UserId] then return true end
        if not friendsList[a.UserId] and friendsList[b.UserId] then return false end
        return a.DisplayName:lower() < b.DisplayName:lower()
    end)
    
    for _, player in pairs(players) do
        if player ~= game.Players.LocalPlayer then
            local isFriend = friendsList[player.UserId]
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Parent = PlayerListFrame
            PlayerButton.Size = UDim2.new(1, 0, 0, 48)
            PlayerButton.BackgroundColor3 = isFriend and Color3.fromRGB(60, 50, 0) or Color3.fromRGB(30, 30, 30)
            PlayerButton.TextColor3 = isFriend and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(255, 255, 255)
            PlayerButton.Text = (isFriend and "⭐ " or "👤 ") .. player.DisplayName
            PlayerButton.TextSize = 14
            PlayerButton.Font = Enum.Font.GothamBold
            PlayerButton.BorderSizePixel = 2
            PlayerButton.BorderColor3 = isFriend and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 255, 255)
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 10)
            Corner.Parent = PlayerButton
            
            PlayerButton.MouseEnter:Connect(function()
                PlayerButton.BackgroundColor3 = isFriend and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 255, 200)
                PlayerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            end)
            
            PlayerButton.MouseLeave:Connect(function()
                PlayerButton.BackgroundColor3 = isFriend and Color3.fromRGB(60, 50, 0) or Color3.fromRGB(30, 30, 30)
                PlayerButton.TextColor3 = isFriend and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(255, 255, 255)
            end)

            PlayerButton.MouseButton1Click:Connect(function()
                startFollowing(player)
                MainFrame.Visible = false
                MainButton.Text = "⚡ SSV7 TP"
            end)
        end
    end
    
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

-- تحديث قائمة الأصدقاء
local function updateFriendsList()
    local localPlayer = game.Players.LocalPlayer
    friendsList = {}
    
    pcall(function()
        for _, friend in pairs(localPlayer:GetFriendsOnline()) do
            friendsList[friend.VisitorId] = true
        end
    end)
    
    updatePlayerList()
end

-- الأحداث
updateFriendsList()
game.Players.PlayerAdded:Connect(function(player)
    updatePlayerList()
    if friendsList[player.UserId] then
        showFriendNotification(player.DisplayName, "دخل السيرفر")
    end
    if isESPEnabled then
        spawn(function() addESP(player) end)
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        stopFollowing()
    end
    if friendsList[player.UserId] then
        showFriendNotification(player.DisplayName, "غادر السيرفر")
    end
    updatePlayerList()
end)
