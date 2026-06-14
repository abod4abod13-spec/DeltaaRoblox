-- ⚡ SSV7 Aimbot Pro v2 - منظم ومرتب ⚡
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local TabFrame = Instance.new("Frame")
local UICorner4 = Instance.new("UICorner")
local TabMain = Instance.new("TextButton")
local UICorner5 = Instance.new("UICorner")
local TabPlayers = Instance.new("TextButton")
local UICorner6 = Instance.new("UICorner")
local TabHelp = Instance.new("TextButton")
local UICorner7 = Instance.new("UICorner")
local ContentFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local StatusBar = Instance.new("Frame")
local UICorner8 = Instance.new("UICorner")
local StatusText = Instance.new("TextLabel")
local Notification = Instance.new("Frame")
local UICorner9 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")
local Crosshair = Instance.new("Frame")
local UICorner10 = Instance.new("UICorner")
local CrosshairDot = Instance.new("Frame")
local UICorner11 = Instance.new("UICorner")

-- المتغيرات
local currentTab = "Main"
local isAimbotting = false
local aimbotConnection = nil
local targetPlayer = nil
local aimPart = "Head"
local highlight = nil
local smoothness = 3
local showCrosshair = true

-- إعدادات الشاشة
ScreenGui.Name = "SSV7_Aimbot"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== كروس هير ==========
Crosshair.Size = UDim2.new(0, 4, 0, 4)
Crosshair.Position = UDim2.new(0.5, -2, 0.5, -2)
Crosshair.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Crosshair.Visible = showCrosshair
Crosshair.BorderSizePixel = 0
Crosshair.Parent = ScreenGui

UICorner10.CornerRadius = UDim.new(0, 2)
UICorner10.Parent = Crosshair

-- ========== الزر الرئيسي ==========
MainButton.Size = UDim2.new(0, 100, 0, 30)
MainButton.Position = UDim2.new(0.5, -50, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "🎯 Aimbot"
MainButton.TextSize = 12
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 2
MainButton.BorderColor3 = Color3.fromRGB(255, 50, 50)
MainButton.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainButton

-- ========== الواجهة الرئيسية ==========
MainFrame.Size = UDim2.new(0, 250, 0, 350)
MainFrame.Position = UDim2.new(0.5, -125, 0, 45)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
MainFrame.Parent = ScreenGui

UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = MainFrame

-- ========== العنوان ==========
Title.Size = UDim2.new(1, -40, 0, 22)
Title.Position = UDim2.new(0, 15, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "🎯 Aimbot Pro v2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- ========== زر الإغلاق ==========
CloseButton.Size = UDim2.new(0, 18, 0, 18)
CloseButton.Position = UDim2.new(1, -24, 0, 6)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"
CloseButton.TextSize = 10
CloseButton.Font = Enum.Font.GothamBlack
CloseButton.BorderSizePixel = 0
CloseButton.Parent = MainFrame

UICorner3.CornerRadius = UDim.new(0, 9)
UICorner3.Parent = CloseButton

-- ========== تبويبات ==========
TabFrame.Size = UDim2.new(1, -16, 0, 26)
TabFrame.Position = UDim2.new(0, 8, 0, 30)
TabFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
TabFrame.BorderSizePixel = 1
TabFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
TabFrame.Parent = MainFrame

UICorner4.CornerRadius = UDim.new(0, 13)
UICorner4.Parent = TabFrame

TabMain.Size = UDim2.new(0.32, 0, 1, 0)
TabMain.Position = UDim2.new(0.01, 0, 0, 0)
TabMain.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
TabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
TabMain.Text = "🎯 رئيسي"
TabMain.TextSize = 9
TabMain.Font = Enum.Font.GothamBlack
TabMain.BorderSizePixel = 0
TabMain.Parent = TabFrame

UICorner5.CornerRadius = UDim.new(0, 13)
UICorner5.Parent = TabMain

TabPlayers.Size = UDim2.new(0.32, 0, 1, 0)
TabPlayers.Position = UDim2.new(0.34, 0, 0, 0)
TabPlayers.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabPlayers.TextColor3 = Color3.fromRGB(255, 255, 255)
TabPlayers.Text = "👥 لاعبين"
TabPlayers.TextSize = 9
TabPlayers.Font = Enum.Font.GothamBlack
TabPlayers.BorderSizePixel = 0
TabPlayers.Parent = TabFrame

UICorner6.CornerRadius = UDim.new(0, 13)
UICorner6.Parent = TabPlayers

TabHelp.Size = UDim2.new(0.32, 0, 1, 0)
TabHelp.Position = UDim2.new(0.67, 0, 0, 0)
TabHelp.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabHelp.TextColor3 = Color3.fromRGB(255, 255, 255)
TabHelp.Text = "❓ تعليمات"
TabHelp.TextSize = 9
TabHelp.Font = Enum.Font.GothamBlack
TabHelp.BorderSizePixel = 0
TabHelp.Parent = TabFrame

UICorner7.CornerRadius = UDim.new(0, 13)
UICorner7.Parent = TabHelp

-- ========== المحتوى ==========
ContentFrame.Size = UDim2.new(1, -16, 1, -90)
ContentFrame.Position = UDim2.new(0, 8, 0, 60)
ContentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.ScrollBarThickness = 5
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
ContentFrame.BorderSizePixel = 1
ContentFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.ScrollingEnabled = true
ContentFrame.Parent = MainFrame

UIListLayout.Parent = ContentFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

-- ========== شريط الحالة ==========
StatusBar.Size = UDim2.new(1, -16, 0, 22)
StatusBar.Position = UDim2.new(0, 8, 0, 322)
StatusBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
StatusBar.BorderSizePixel = 1
StatusBar.BorderColor3 = Color3.fromRGB(255, 50, 50)
StatusBar.Parent = MainFrame

UICorner8.CornerRadius = UDim.new(0, 11)
UICorner8.Parent = StatusBar

StatusText.Size = UDim2.new(1, -10, 1, 0)
StatusText.Position = UDim2.new(0, 5, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🔴 متوقف"
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextSize = 9
StatusText.Font = Enum.Font.GothamBold
StatusText.Parent = StatusBar

-- ========== إشعار ==========
Notification.Size = UDim2.new(0, 180, 0, 28)
Notification.Position = UDim2.new(0.5, -90, 0, -32)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(255, 50, 50)
Notification.Visible = false
Notification.Parent = ScreenGui

UICorner9.CornerRadius = UDim.new(0, 6)
UICorner9.Parent = Notification

NotificationText.Size = UDim2.new(1, -8, 1, 0)
NotificationText.Position = UDim2.new(0, 4, 0, 0)
NotificationText.BackgroundTransparency = 1
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 10
NotificationText.Font = Enum.Font.GothamBold
NotificationText.Parent = Notification

-- ========== وظائف مساعدة ==========

local function createSection(text, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -2, 0, 22)
    frame.BackgroundColor3 = color or Color3.fromRGB(200, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 11)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 10
    label.Font = Enum.Font.GothamBlack
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    return frame
end

local function createButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -2, 0, 30)
    btn.BackgroundColor3 = color or Color3.fromRGB(200, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBlack
    btn.BorderSizePixel = 0
    btn.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createToggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -2, 0, 30)
    frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.fromRGB(35, 35, 35)
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.55, -6, 1, 0)
    lbl.Position = UDim2.new(0, 6, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 10
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 36, 0, 18)
    btn.Position = UDim2.new(1, -42, 0, 6)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = default and "ON" or "OFF"
    btn.TextSize = 9
    btn.Font = Enum.Font.GothamBlack
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 9)
    btnCorner.Parent = btn
    
    local isOn = default
    btn.MouseButton1Click:Connect(function()
        isOn = not isOn
        btn.BackgroundColor3 = isOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
        btn.Text = isOn and "ON" or "OFF"
        callback(isOn)
    end)
    
    return frame
end

local function createSlider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -2, 0, 38)
    frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.fromRGB(35, 35, 35)
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, -6, 0, 16)
    lbl.Position = UDim2.new(0, 6, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. default
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 9
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.4, 0, 0, 18)
    input.Position = UDim2.new(0.55, 0, 0, 2)
    input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Text = tostring(default)
    input.TextSize = 10
    input.Font = Enum.Font.Gotham
    input.BorderSizePixel = 1
    input.BorderColor3 = Color3.fromRGB(255, 50, 50)
    input.Parent = frame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 4)
    inputCorner.Parent = input
    
    local range = Instance.new("TextLabel")
    range.Size = UDim2.new(1, -6, 0, 12)
    range.Position = UDim2.new(0, 6, 0, 22)
    range.BackgroundTransparency = 1
    range.Text = "من " .. min .. " إلى " .. max
    range.TextColor3 = Color3.fromRGB(130, 130, 130)
    range.TextSize = 8
    range.Font = Enum.Font.Gotham
    range.TextXAlignment = Enum.TextXAlignment.Left
    range.Parent = frame
    
    input.FocusLost:Connect(function()
        local val = math.clamp(tonumber(input.Text) or default, min, max)
        input.Text = tostring(val)
        lbl.Text = text .. ": " .. val
        callback(val)
    end)
    
    return frame
end

-- ========== نظام الايمبوت ==========

local function createHighlight(player)
    if highlight then highlight:Destroy() end
    if not player or not player.Character then return end
    
    highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.3
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = player.Character
end

local function getTargetPosition(player)
    if not player or not player.Character then return nil end
    
    -- نبحث عن الجزء المطلوب
    local part = player.Character:FindFirstChild(aimPart)
    if not part then
        -- إذا ما لقينا الجزء نستخدم الرأس
        part = player.Character:FindFirstChild("Head")
    end
    
    if part then
        return part.Position
    end
    
    return nil
end

local function smoothAim(targetPos)
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    -- نحسب الاتجاه للهدف
    local lookAt = CFrame.lookAt(camera.CFrame.Position, targetPos)
    
    -- تصويب سلس
    if smoothness > 1 then
        local t = 0.15 / smoothness
        camera.CFrame = camera.CFrame:Lerp(lookAt, t)
    else
        camera.CFrame = lookAt
    end
end

local function findClosestTarget()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return nil end
    
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    local closest = nil
    local closestDist = math.huge
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local targetPos = getTargetPosition(player)
            if targetPos then
                -- نتأكد إن الهدف في مجال الرؤية
                local screenPos, onScreen = camera:WorldToScreenPoint(targetPos)
                if onScreen then
                    local screenCenter = camera.ViewportSize / 2
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    
                    -- نعطي أولوية للاعبين الأقرب في المسافة
                    local worldDist = (localRoot.Position - targetPos).Magnitude
                    local combinedDist = dist + worldDist * 0.1
                    
                    if combinedDist < closestDist then
                        closestDist = combinedDist
                        closest = player
                    end
                end
            end
        end
    end
    
    return closest
end

local function aimbotLoop()
    if not isAimbotting then return end
    
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return end
    
    -- إذا الهدف مات أو خرج
    if targetPlayer then
        if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Head") then
            targetPlayer = nil
            if highlight then highlight:Destroy(); highlight = nil end
        end
    end
    
    -- إذا ما فيه هدف نلاقي أقرب واحد
    if not targetPlayer then
        targetPlayer = findClosestTarget()
        if targetPlayer then
            createHighlight(targetPlayer)
        end
    end
    
    -- تصويب على الهدف
    if targetPlayer and targetPlayer.Character then
        local targetPos = getTargetPosition(targetPlayer)
        if targetPos then
            -- تصويب فقط إذا الهدف في الشاشة
            local camera = workspace.CurrentCamera
            if camera then
                local screenPos, onScreen = camera:WorldToScreenPoint(targetPos)
                if onScreen then
                    smoothAim(targetPos)
                end
            end
            
            -- تجديد الهايلايت إذا اختفى
            if not highlight or not highlight.Parent then
                createHighlight(targetPlayer)
            end
        end
    end
end

function startAimbot()
    isAimbotting = true
    
    StatusText.Text = "🟢 يعمل"
    StatusText.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    aimbotConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if isAimbotting then
            pcall(aimbotLoop)
        end
    end)
    
    showNotification("🎯 تم تشغيل الايمبوت")
end

function stopAimbot()
    isAimbotting = false
    targetPlayer = nil
    
    if aimbotConnection then
        aimbotConnection:Disconnect()
        aimbotConnection = nil
    end
    
    if highlight then
        highlight:Destroy()
        highlight = nil
    end
    
    StatusText.Text = "🔴 متوقف"
    StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
    
    showNotification("🔴 تم إيقاف الايمبوت")
end

-- ========== بناء التبويبات ==========

local function buildMainTab()
    ContentFrame:ClearAllChildren()
    
    createSection("🎯 التحكم", Color3.fromRGB(200, 30, 30))
    
    createButton(isAimbotting and "⏹ إيقاف الايمبوت" or "▶️ تشغيل الايمبوت",
        isAimbotting and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(0, 180, 0),
        function()
            if isAimbotting then stopAimbot() else startAimbot() end
            buildMainTab()
        end
    )
    
    createSection("🎯 جزء الجسم", Color3.fromRGB(200, 30, 30))
    
    local parts = {
        {Name = "🎯 الرأس", Value = "Head"},
        {Name = "🫁 الصدر", Value = "UpperTorso"},
        {Name = "🦵 البطن", Value = "LowerTorso"},
    }
    
    for _, part in pairs(parts) do
        local isSelected = (aimPart == part.Value)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -2, 0, 28)
        btn.BackgroundColor3 = isSelected and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(16, 16, 16)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Text = part.Name .. (isSelected and " ✓" or "")
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(35, 35, 35)
        btn.Parent = ContentFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 14)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            aimPart = part.Value
            showNotification("🎯 " .. part.Name)
            buildMainTab()
        end)
    end
    
    createSection("⚙️ الإعدادات", Color3.fromRGB(200, 30, 30))
    
    createToggle("👁️ كروس هير", showCrosshair, function(val)
        showCrosshair = val
        Crosshair.Visible = val
    end)
    
    createSlider("🔄 سلاسة التصويب", 1, 20, smoothness, function(val)
        smoothness = val
    end)
    
    createSection("🎯 الهدف الحالي", Color3.fromRGB(100, 30, 30))
    
    if targetPlayer then
        local info = Instance.new("Frame")
        info.Size = UDim2.new(1, -2, 0, 30)
        info.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        info.BorderSizePixel = 1
        info.BorderColor3 = Color3.fromRGB(255, 0, 0)
        info.Parent = ContentFrame
        
        local infoCorner = Instance.new("UICorner")
        infoCorner.CornerRadius = UDim.new(0, 6)
        infoCorner.Parent = info
        
        local infoText = Instance.new("TextLabel")
        infoText.Size = UDim2.new(1, -10, 1, 0)
        infoText.Position = UDim2.new(0, 5, 0, 0)
        infoText.BackgroundTransparency = 1
        infoText.Text = "🎯 " .. targetPlayer.DisplayName .. "\n@" .. targetPlayer.Name
        infoText.TextColor3 = Color3.fromRGB(255, 255, 255)
        infoText.TextSize = 10
        infoText.Font = Enum.Font.Gotham
        infoText.TextXAlignment = Enum.TextXAlignment.Left
        infoText.Parent = info
    else
        local noTarget = Instance.new("Frame")
        noTarget.Size = UDim2.new(1, -2, 0, 24)
        noTarget.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        noTarget.BorderSizePixel = 0
        noTarget.Parent = ContentFrame
        
        local noTargetCorner = Instance.new("UICorner")
        noTargetCorner.CornerRadius = UDim.new(0, 6)
        noTargetCorner.Parent = noTarget
        
        local noTargetText = Instance.new("TextLabel")
        noTargetText.Size = UDim2.new(1, 0, 1, 0)
        noTargetText.BackgroundTransparency = 1
        noTargetText.Text = "لا يوجد هدف - تلقائي"
        noTargetText.TextColor3 = Color3.fromRGB(150, 150, 150)
        noTargetText.TextSize = 9
        noTargetText.Font = Enum.Font.Gotham
        noTargetText.Parent = noTarget
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)
end

local function buildPlayersTab()
    ContentFrame:ClearAllChildren()
    
    createSection("👥 جميع اللاعبين", Color3.fromRGB(200, 30, 30))
    
    local localPlayer = game.Players.LocalPlayer
    local players = game.Players:GetPlayers()
    
    -- ترتيب
    table.sort(players, function(a, b)
        return a.DisplayName:lower() < b.DisplayName:lower()
    end)
    
    for _, player in pairs(players) do
        if player ~= localPlayer then
            local isTarget = (player == targetPlayer)
            
            local card = Instance.new("Frame")
            card.Size = UDim2.new(1, -2, 0, 36)
            card.BackgroundColor3 = isTarget and Color3.fromRGB(40, 8, 8) or Color3.fromRGB(16, 16, 16)
            card.BorderSizePixel = 1
            card.BorderColor3 = isTarget and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(35, 35, 35)
            card.Parent = ContentFrame
            
            local cardCorner = Instance.new("UICorner")
            cardCorner.CornerRadius = UDim.new(0, 5)
            cardCorner.Parent = card
            
            -- أفاتار
            local avatar = Instance.new("ImageLabel")
            avatar.Size = UDim2.new(0, 24, 0, 24)
            avatar.Position = UDim2.new(0, 5, 0, 6)
            avatar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            avatar.BorderSizePixel = 1
            avatar.BorderColor3 = Color3.fromRGB(50, 50, 50)
            avatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            avatar.Parent = card
            
            local avCorner = Instance.new("UICorner")
            avCorner.CornerRadius = UDim.new(0, 12)
            avCorner.Parent = avatar
            
            spawn(function()
                pcall(function()
                    avatar.Image = game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                end)
            end)
            
            -- اسم
            local name = Instance.new("TextLabel")
            name.Size = UDim2.new(0.5, -34, 0, 20)
            name.Position = UDim2.new(0, 34, 0, 2)
            name.BackgroundTransparency = 1
            name.Text = player.DisplayName
            name.TextColor3 = isTarget and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255)
            name.TextSize = 10
            name.Font = Enum.Font.GothamBold
            name.TextXAlignment = Enum.TextXAlignment.Left
            name.TextTruncate = Enum.TextTruncate.AtEnd
            name.Parent = card
            
            -- يوزرنيم
            local user = Instance.new("TextLabel")
            user.Size = UDim2.new(0.5, -34, 0, 12)
            user.Position = UDim2.new(0, 34, 0, 21)
            user.BackgroundTransparency = 1
            user.Text = "@" .. player.Name
            user.TextColor3 = Color3.fromRGB(150, 150, 150)
            user.TextSize = 8
            user.Font = Enum.Font.Gotham
            user.TextXAlignment = Enum.TextXAlignment.Left
            user.Parent = card
            
            -- زر
            local aimBtn = Instance.new("TextButton")
            aimBtn.Size = UDim2.new(0, 40, 0, 20)
            aimBtn.Position = UDim2.new(1, -46, 0, 8)
            aimBtn.BackgroundColor3 = isTarget and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 20, 20)
            aimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            aimBtn.Text = isTarget and "✓" or "🎯"
            aimBtn.TextSize = 11
            aimBtn.Font = Enum.Font.GothamBlack
            aimBtn.BorderSizePixel = 0
            aimBtn.Parent = card
            
            local aimBtnCorner = Instance.new("UICorner")
            aimBtnCorner.CornerRadius = UDim.new(0, 10)
            aimBtnCorner.Parent = aimBtn
            
            aimBtn.MouseButton1Click:Connect(function()
                if isTarget then
                    stopAimbot()
                else
                    targetPlayer = player
                    createHighlight(player)
                    if not isAimbotting then startAimbot() end
                end
                buildPlayersTab()
                buildMainTab()
            end)
        end
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

local function buildHelpTab()
    ContentFrame:ClearAllChildren()
    
    createSection("❓ كيف تستخدم الايمبوت", Color3.fromRGB(0, 150, 200))
    
    local helpTexts = {
        "1️⃣ اضغط 🎯 Aimbot لفتح الواجهة",
        "2️⃣ تبويب 🎯 رئيسي للتحكم",
        "3️⃣ تبويب 👥 لاعبين لاختيار هدف",
        "4️⃣ اختر لاعب واضغط 🎯",
        "5️⃣ اختر جزء الجسم (رأس/صدر/بطن)",
        "6️⃣ الايمبوت يصوب تلقائياً",
        "7️⃣ الكروس هير الأحمر للتصويب",
        "8️⃣ السلاسة تجعل التصويب طبيعي",
        "9️⃣ الهدف يظهر بحدود حمراء",
        "🔟 الايمبوت يستمر حتى بعد موتك",
    }
    
    for _, text in pairs(helpTexts) do
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -2, 0, 26)
        frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        frame.BorderSizePixel = 1
        frame.BorderColor3 = Color3.fromRGB(35, 35, 35)
        frame.Parent = ContentFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 1, 0)
        label.Position = UDim2.new(0, 5, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 10
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
    end
    
    createSection("⚙️ معلومات", Color3.fromRGB(0, 150, 200))
    
    local info = Instance.new("Frame")
    info.Size = UDim2.new(1, -2, 0, 40)
    info.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    info.BorderSizePixel = 1
    info.BorderColor3 = Color3.fromRGB(35, 35, 35)
    info.Parent = ContentFrame
    
    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 6)
    infoCorner.Parent = info
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -10, 1, 0)
    infoLabel.Position = UDim2.new(0, 5, 0, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "⚡ SSV7 Aimbot Pro v2\n📱 يعمل على جميع الأجهزة\n🎮 يدعم جميع المابات\n✅ مضمون 100%"
    infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoLabel.TextSize = 9
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.Parent = info
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)
end

-- ========== تبديل التبويب ==========
local function switchTab(tab)
    currentTab = tab
    
    TabMain.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabPlayers.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabHelp.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    if tab == "Main" then
        TabMain.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        buildMainTab()
    elseif tab == "Players" then
        TabPlayers.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        buildPlayersTab()
    elseif tab == "Help" then
        TabHelp.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        buildHelpTab()
    end
end

function showNotification(text)
    NotificationText.Text = text
    Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -90, 0, -32)
    
    spawn(function()
        for i = 1, 5 do
            Notification.Position = UDim2.new(0.5, -90, 0, -32 + (i * 6))
            task.wait(0.01)
        end
        task.wait(1.5)
        for i = 1, 5 do
            Notification.Position = UDim2.new(0.5, -90, 0, -2 - (i * 6))
            task.wait(0.01)
        end
        Notification.Visible = false
    end)
end

-- ========== الأحداث ==========
MainButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then switchTab(currentTab) end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

TabMain.MouseButton1Click:Connect(function() switchTab("Main") end)
TabPlayers.MouseButton1Click:Connect(function() switchTab("Players") end)
TabHelp.MouseButton1Click:Connect(function() switchTab("Help") end)

game.Players.PlayerAdded:Connect(function()
    if MainFrame.Visible then switchTab(currentTab) end
end)

game.Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        targetPlayer = nil
        if highlight then highlight:Destroy(); highlight = nil end
    end
    if MainFrame.Visible then switchTab(currentTab) end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if isAimbotting and targetPlayer then
        task.wait(0.3)
        createHighlight(targetPlayer)
    end
end)

switchTab("Main")
showNotification("🎯 Aimbot Pro v2 جاهز!")
