-- ⚡ SSV7 Player Tracker - نسخة مستقرة 100% ⚡
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local StopTrackButton = Instance.new("TextButton")
local UICorner4 = Instance.new("UICorner")
local PlayerScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ConfirmFrame = Instance.new("Frame")
local UICorner5 = Instance.new("UICorner")
local ConfirmText = Instance.new("TextLabel")
local ConfirmYes = Instance.new("TextButton")
local UICorner6 = Instance.new("UICorner")
local ConfirmNo = Instance.new("TextButton")
local UICorner7 = Instance.new("UICorner")
local Notification = Instance.new("Frame")
local UICorner8 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")

-- المتغيرات
local targetPlayer = nil
local isTracking = false
local highlight = nil
local billboard = nil
local arrow = nil
local beam = nil
local attach0 = nil
local attach1 = nil
local ring = nil
local updateConnection = nil
local currentPlayerButton = nil

-- إعدادات الشاشة
ScreenGui.Name = "SSV7_Tracker_Main"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== الزر الرئيسي ==========
MainButton.Name = "MainButton"
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 100, 0, 32)
MainButton.Position = UDim2.new(0.5, -50, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "👥 SSV7"
MainButton.TextSize = 13
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 2
MainButton.BorderColor3 = Color3.fromRGB(0, 200, 255)
MainButton.ZIndex = 10

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = MainButton

-- ========== الواجهة الرئيسية ==========
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 250, 0, 380)
MainFrame.Position = UDim2.new(0.5, -125, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)
MainFrame.ZIndex = 10

UICorner2.CornerRadius = UDim.new(0, 6)
UICorner2.Parent = MainFrame

-- ========== العنوان ==========
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -80, 0, 28)
Title.Position = UDim2.new(0, 15, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "👥 Players"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left

-- ========== زر الإغلاق ==========
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 22, 0, 22)
CloseButton.Position = UDim2.new(1, -50, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"
CloseButton.TextSize = 13
CloseButton.Font = Enum.Font.GothamBlack
CloseButton.BorderSizePixel = 0

UICorner3.CornerRadius = UDim.new(0, 4)
UICorner3.Parent = CloseButton

-- ========== زر إيقاف التتبع ==========
StopTrackButton.Parent = MainFrame
StopTrackButton.Size = UDim2.new(0, 22, 0, 22)
StopTrackButton.Position = UDim2.new(1, -25, 0, 7)
StopTrackButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
StopTrackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopTrackButton.Text = "⏹"
StopTrackButton.TextSize = 11
StopTrackButton.Font = Enum.Font.GothamBlack
StopTrackButton.BorderSizePixel = 0

UICorner4.CornerRadius = UDim.new(0, 4)
UICorner4.Parent = StopTrackButton

-- ========== شريط الحالة ==========
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, -20, 0, 18)
StatusLabel.Position = UDim2.new(0, 10, 0, 34)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🔴 لا يوجد تتبع"
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ========== قائمة اللاعبين ==========
PlayerScrollFrame.Parent = MainFrame
PlayerScrollFrame.Size = UDim2.new(1, -20, 1, -60)
PlayerScrollFrame.Position = UDim2.new(0, 10, 0, 55)
PlayerScrollFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScrollFrame.ScrollBarThickness = 4
PlayerScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
PlayerScrollFrame.BorderSizePixel = 1
PlayerScrollFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)

UIListLayout.Parent = PlayerScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

-- ========== نافذة التأكيد ==========
ConfirmFrame.Parent = MainFrame
ConfirmFrame.Size = UDim2.new(1, -40, 0, 80)
ConfirmFrame.Position = UDim2.new(0.5, -85, 0.5, -40)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ConfirmFrame.Visible = false
ConfirmFrame.BorderSizePixel = 2
ConfirmFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
ConfirmFrame.ZIndex = 20

UICorner5.CornerRadius = UDim.new(0, 8)
UICorner5.Parent = ConfirmFrame

ConfirmText.Parent = ConfirmFrame
ConfirmText.Size = UDim2.new(1, -20, 0, 30)
ConfirmText.Position = UDim2.new(0, 10, 0, 10)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "هل تريد إغلاق السكربت؟"
ConfirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmText.TextSize = 12
ConfirmText.Font = Enum.Font.GothamBold

ConfirmYes.Parent = ConfirmFrame
ConfirmYes.Size = UDim2.new(0.4, 0, 0, 25)
ConfirmYes.Position = UDim2.new(0.08, 0, 0, 45)
ConfirmYes.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ConfirmYes.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmYes.Text = "نعم"
ConfirmYes.TextSize = 11
ConfirmYes.Font = Enum.Font.GothamBlack
ConfirmYes.BorderSizePixel = 0

UICorner6.CornerRadius = UDim.new(0, 4)
UICorner6.Parent = ConfirmYes

ConfirmNo.Parent = ConfirmFrame
ConfirmNo.Size = UDim2.new(0.4, 0, 0, 25)
ConfirmNo.Position = UDim2.new(0.52, 0, 0, 45)
ConfirmNo.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ConfirmNo.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmNo.Text = "لا"
ConfirmNo.TextSize = 11
ConfirmNo.Font = Enum.Font.GothamBlack
ConfirmNo.BorderSizePixel = 0

UICorner7.CornerRadius = UDim.new(0, 4)
UICorner7.Parent = ConfirmNo

-- ========== إشعار ==========
Notification.Parent = ScreenGui
Notification.Size = UDim2.new(0, 200, 0, 35)
Notification.Position = UDim2.new(0.5, -100, 0, -40)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(0, 200, 255)
Notification.Visible = false

UICorner8.CornerRadius = UDim.new(0, 6)
UICorner8.Parent = Notification

NotificationText.Parent = Notification
NotificationText.Size = UDim2.new(1, -10, 1, 0)
NotificationText.Position = UDim2.new(0, 5, 0, 0)
NotificationText.BackgroundTransparency = 1
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 11
NotificationText.Font = Enum.Font.GothamBold

-- ========== وظائف التتبع ==========

-- تنظيف كل شيء
local function cleanupAll()
    -- إيقاف التحديث
    if updateConnection then
        pcall(function() updateConnection:Disconnect() end)
        updateConnection = nil
    end
    
    -- إزالة الهايلايت
    if highlight then
        pcall(function() highlight:Destroy() end)
        highlight = nil
    end
    
    -- إزالة لوحة المعلومات
    if billboard then
        pcall(function() billboard:Destroy() end)
        billboard = nil
    end
    
    -- إزالة السهم
    if arrow then
        pcall(function() arrow:Destroy() end)
        arrow = nil
    end
    
    -- إزالة خط التتبع
    if beam then
        pcall(function() beam:Destroy() end)
        beam = nil
    end
    if attach0 then
        pcall(function() attach0:Destroy() end)
        attach0 = nil
    end
    if attach1 then
        pcall(function() attach1:Destroy() end)
        attach1 = nil
    end
    
    -- إزالة الحلقة
    if ring then
        pcall(function() ring:Destroy() end)
        ring = nil
    end
end

-- إيقاف التتبع
local function stopTracking()
    cleanupAll()
    targetPlayer = nil
    isTracking = false
    
    StatusLabel.Text = "🔴 لا يوجد تتبع"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    StopTrackButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    -- إعادة تعيين ألوان الأزرار
    if currentPlayerButton then
        pcall(function()
            currentPlayerButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        end)
        currentPlayerButton = nil
    end
end

-- إنشاء ESP للاعب
local function createESP(player)
    if not player or not player.Character then return end
    
    local character = player.Character
    local head = character:FindFirstChild("Head")
    local root = character:FindFirstChild("HumanoidRootPart")
    
    if not head or not root then return end
    
    -- هايلايت
    highlight = Instance.new("Highlight")
    highlight.Name = "SSV7_Tracker_Highlight"
    highlight.FillColor = Color3.fromRGB(0, 255, 200)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.4
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    
    -- حلقة حول الأقدام
    ring = Instance.new("Part")
    ring.Name = "SSV7_Tracker_Ring"
    ring.Size = Vector3.new(4, 0.2, 4)
    ring.Shape = Enum.PartType.Cylinder
    ring.Anchored = true
    ring.CanCollide = false
    ring.Color = Color3.fromRGB(0, 255, 200)
    ring.Material = Enum.Material.Neon
    ring.Transparency = 0.5
    ring.Parent = character
    
    -- لوحة معلومات
    billboard = Instance.new("BillboardGui")
    billboard.Name = "SSV7_Tracker_Info"
    billboard.Size = UDim2.new(0, 220, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "InfoText"
    infoLabel.Size = UDim2.new(1, 0, 1, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextStrokeTransparency = 0
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.TextSize = 11
    infoLabel.Font = Enum.Font.GothamBlack
    infoLabel.Parent = billboard
    
    -- سهم ثلاثي الأبعاد
    arrow = Instance.new("Part")
    arrow.Name = "SSV7_Tracker_Arrow"
    arrow.Size = Vector3.new(1, 0.5, 3)
    arrow.Anchored = true
    arrow.CanCollide = false
    arrow.Color = Color3.fromRGB(255, 255, 0)
    arrow.Material = Enum.Material.Neon
    arrow.Parent = game.Workspace
    
    -- خط تتبع
    beam = Instance.new("Beam")
    beam.Name = "SSV7_Tracker_Beam"
    beam.Parent = game.Workspace.Terrain
    
    attach0 = Instance.new("Attachment")
    attach0.Parent = game.Workspace.Terrain
    
    attach1 = Instance.new("Attachment")
    attach1.Parent = root
    
    beam.Attachment0 = attach0
    beam.Attachment1 = attach1
    beam.Color = ColorSequence.new(Color3.fromRGB(0, 255, 200))
    beam.Width0 = 0.2
    beam.Width1 = 0.2
    beam.Transparency = NumberSequence.new(0.3)
end

-- تحديث ESP
local function updateESP()
    local localPlayer = game.Players.LocalPlayer
    
    -- التحقق من وجود كل شيء
    if not localPlayer.Character then return end
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
    if not targetPlayer then
        stopTracking()
        return
    end
    
    if not targetPlayer.Character then
        stopTracking()
        return
    end
    
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetHead = targetPlayer.Character:FindFirstChild("Head")
    
    if not targetRoot then
        stopTracking()
        return
    end
    
    local targetPos = targetRoot.Position
    local localPos = localRoot.Position
    local distance = (localPos - targetPos).Magnitude
    
    -- تحديث الهايلايت
    if highlight and highlight.Parent then
        highlight.FillColor = Color3.fromRGB(0, 255, 200)
    end
    
    -- تحديث الحلقة
    if ring and ring.Parent then
        ring.CFrame = CFrame.new(targetPos) * CFrame.Angles(math.rad(90), 0, 0)
    end
    
    -- تحديث المعلومات
    if billboard and billboard.Parent then
        local infoLabel = billboard:FindFirstChild("InfoText")
        if infoLabel then
            local health = targetPlayer.Character:FindFirstChild("Humanoid") and math.floor(targetPlayer.Character.Humanoid.Health) or 0
            local maxHealth = targetPlayer.Character:FindFirstChild("Humanoid") and math.floor(targetPlayer.Character.Humanoid.MaxHealth) or 100
            local weapon = "لا يوجد"
            local tool = targetPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then weapon = tool.Name end
            
            -- تحديد الاتجاه
            local lookVector = localRoot.CFrame.LookVector
            local toTarget = (targetPos - localPos).Unit
            local dot = lookVector:Dot(toTarget)
            local cross = lookVector:Cross(toTarget)
            
            local direction = ""
            if dot > 0.8 then direction = "⬆️ أمامك"
            elseif dot < -0.8 then direction = "⬇️ خلفك"
            elseif cross.Y > 0.5 then direction = "➡️ يمينك"
            elseif cross.Y < -0.5 then direction = "⬅️ يسارك"
            elseif dot > 0 then direction = "↗️ أمام"
            else direction = "↙️ خلف" end
            
            local displayText = "👤 " .. targetPlayer.DisplayName .. "\n"
            displayText = displayText .. "📍 " .. direction .. "\n"
            displayText = displayText .. "📏 " .. math.floor(distance) .. "m | ❤️ " .. health .. "/" .. maxHealth .. "\n"
            displayText = displayText .. "🔫 " .. weapon
            
            infoLabel.Text = displayText
        end
    end
    
    -- تحديث السهم
    if arrow and arrow.Parent then
        local lookAt = (targetPos - localPos).Unit
        local midPoint = localPos + lookAt * 8
        arrow.CFrame = CFrame.new(midPoint, targetPos)
        arrow.Transparency = distance < 5 and 0.7 or 0.2
    end
    
    -- تحديث خط التتبع
    if beam and beam.Parent and attach0 and attach0.Parent then
        attach0.WorldPosition = localPos + Vector3.new(0, 2, 0)
        beam.Width0 = 0.2
        beam.Width1 = 0.2
    end
    
    -- تحديث حالة الواجهة
    StatusLabel.Text = "🟢 تتبع: " .. targetPlayer.DisplayName .. " (" .. math.floor(distance) .. "m)"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
end

-- بدء التتبع
local function startTracking(player)
    -- إيقاف أي تتبع سابق
    stopTracking()
    
    if not player then return end
    if player == game.Players.LocalPlayer then return end
    
    targetPlayer = player
    isTracking = true
    
    -- انتظار تحميل الشخصية إذا لم تكن موجودة
    if not player.Character then
        player.CharacterAdded:Wait()
    end
    
    -- إنشاء ESP
    createESP(player)
    
    -- بدء التحديث المستمر
    updateConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if isTracking then
            pcall(updateESP)
        end
    end)
    
    StatusLabel.Text = "🟢 تتبع: " .. player.DisplayName
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    StopTrackButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    
    showNotification("📍 تتبع: " .. player.DisplayName)
end

-- ========== وظائف مساعدة ==========

-- إظهار إشعار
local function showNotification(text)
    NotificationText.Text = text
    Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -100, 0, -40)
    
    spawn(function()
        for i = 1, 8 do
            Notification.Position = UDim2.new(0.5, -100, 0, -40 + (i * 5))
            task.wait(0.015)
        end
        
        task.wait(1.5)
        
        for i = 1, 8 do
            Notification.Position = UDim2.new(0.5, -100, 0, 0 - (i * 5))
            task.wait(0.015)
        end
        
        Notification.Visible = false
    end)
end

-- تحميل الأفاتار
local function loadAvatar(player, imageLabel)
    spawn(function()
        local success, content = pcall(function()
            return game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
        end)
        
        if success and content then
            imageLabel.Image = content
        end
    end)
end

-- تحديث قائمة اللاعبين
local function updatePlayerList()
    -- تنظيف القائمة
    for _, child in pairs(PlayerScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local players = game.Players:GetPlayers()
    
    -- ترتيب أبجدي
    table.sort(players, function(a, b)
        return a.DisplayName:lower() < b.DisplayName:lower()
    end)
    
    for _, player in pairs(players) do
        if player ~= game.Players.LocalPlayer then
            local isTarget = (player == targetPlayer)
            
            local playerFrame = Instance.new("Frame")
            playerFrame.Parent = PlayerScrollFrame
            playerFrame.Size = UDim2.new(1, -6, 0, 42)
            playerFrame.Position = UDim2.new(0, 3, 0, 0)
            playerFrame.BackgroundColor3 = isTarget and Color3.fromRGB(0, 150, 200) or Color3.fromRGB(25, 25, 25)
            playerFrame.BorderSizePixel = 1
            playerFrame.BorderColor3 = isTarget and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(40, 40, 40)
            
            if isTarget then
                currentPlayerButton = playerFrame
            end
            
            local frameCorner = Instance.new("UICorner")
            frameCorner.CornerRadius = UDim.new(0, 4)
            frameCorner.Parent = playerFrame
            
            -- أفاتار
            local avatarImage = Instance.new("ImageLabel")
            avatarImage.Parent = playerFrame
            avatarImage.Size = UDim2.new(0, 32, 0, 32)
            avatarImage.Position = UDim2.new(0, 5, 0, 5)
            avatarImage.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            avatarImage.BorderSizePixel = 1
            avatarImage.BorderColor3 = Color3.fromRGB(50, 50, 50)
            avatarImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            
            local avatarCorner = Instance.new("UICorner")
            avatarCorner.CornerRadius = UDim.new(0, 16)
            avatarCorner.Parent = avatarImage
            
            loadAvatar(player, avatarImage)
            
            -- اسم اللاعب
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = playerFrame
            nameLabel.Size = UDim2.new(1, -55, 0, 18)
            nameLabel.Position = UDim2.new(0, 42, 0, 2)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.DisplayName
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextSize = 12
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
            
            -- يوزرنيم
            local usernameLabel = Instance.new("TextLabel")
            usernameLabel.Parent = playerFrame
            usernameLabel.Size = UDim2.new(1, -55, 0, 16)
            usernameLabel.Position = UDim2.new(0, 42, 0, 20)
            usernameLabel.BackgroundTransparency = 1
            usernameLabel.Text = "@" .. player.Name
            usernameLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            usernameLabel.TextSize = 10
            usernameLabel.Font = Enum.Font.Gotham
            usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
            usernameLabel.TextTruncate = Enum.TextTruncate.AtEnd
            
            -- نقطة التتبع
            if isTarget then
                local trackingDot = Instance.new("Frame")
                trackingDot.Parent = playerFrame
                trackingDot.Size = UDim2.new(0, 8, 0, 8)
                trackingDot.Position = UDim2.new(1, -14, 0, 17)
                trackingDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                
                local dotCorner = Instance.new("UICorner")
                dotCorner.CornerRadius = UDim.new(0, 4)
                dotCorner.Parent = trackingDot
            end
            
            -- زر الضغط (شفاف)
            local clickButton = Instance.new("TextButton")
            clickButton.Parent = playerFrame
            clickButton.Size = UDim2.new(1, 0, 1, 0)
            clickButton.BackgroundTransparency = 1
            clickButton.Text = ""
            clickButton.BorderSizePixel = 0
            
            clickButton.MouseButton1Click:Connect(function()
                if isTarget then
                    stopTracking()
                else
                    startTracking(player)
                end
                updatePlayerList()
            end)
            
            -- تأثير التحويم
            clickButton.MouseEnter:Connect(function()
                if not isTarget then
                    playerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                end
            end)
            
            clickButton.MouseLeave:Connect(function()
                if not isTarget then
                    playerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                end
            end)
        end
    end
    
    PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
    Title.Text = "👥 Players (" .. #players .. ")"
end

-- ========== الأحداث ==========

-- فتح/إغلاق الواجهة
MainButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        updatePlayerList()
    end
end)

-- زر الإغلاق
CloseButton.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = true
end)

-- زر إيقاف التتبع
StopTrackButton.MouseButton1Click:Connect(function()
    if isTracking then
        stopTracking()
        updatePlayerList()
        showNotification("⏹ تم إيقاف التتبع")
    end
end)

-- تأكيد نعم
ConfirmYes.MouseButton1Click:Connect(function()
    stopTracking()
    ScreenGui:Destroy()
end)

-- تأكيد لا
ConfirmNo.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = false
end)

-- إخفاء التأكيد عند النقر خارجه
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        ConfirmFrame.Visible = false
    end
end)

-- تحديث عند دخول لاعب
game.Players.PlayerAdded:Connect(function(player)
    if MainFrame.Visible then
        task.wait(0.5)
        updatePlayerList()
    end
end)

-- تحديث عند خروج لاعب
game.Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        stopTracking()
    end
    if MainFrame.Visible then
        updatePlayerList()
    end
end)

-- مراقبة موت اللاعب المُتابَع
game:GetService("RunService").Heartbeat:Connect(function()
    if isTracking and targetPlayer then
        if not targetPlayer.Character then
            -- انتظار إعادة الولادة
            targetPlayer.CharacterAdded:Wait()
            task.wait(0.5)
            cleanupAll()
            createESP(targetPlayer)
        end
    end
end)

-- تحديث أولي
updatePlayerList()
showNotification("👥 SSV7 جاهز!")
