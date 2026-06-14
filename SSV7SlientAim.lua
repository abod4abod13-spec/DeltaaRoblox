-- 🤫 SSV7 Silent Aim - حقيقي 100%
-- الفكرة: بدل ما تحرك الكاميرا للهدف (Aimbot عادي)،
-- Silent Aim يغير مسار الرصاصة مباشرة للهدف
-- يعني الكاميرا تبقى في مكانها والرصاصة تروح للهدف
-- الهدف: تصويب دقيق بدون ما أحد يدري عنك

local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local ContentFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local StatusBar = Instance.new("Frame")
local UICorner4 = Instance.new("UICorner")
local StatusText = Instance.new("TextLabel")
local Notification = Instance.new("Frame")
local UICorner5 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")

-- المتغيرات
local isActive = false
local aimConnection = nil
local targetPlayer = nil
local aimPart = "Head"
local fovRadius = 150
local hitChance = 100
local showFOV = true
local fovCircle = nil
local highlight = nil
local kills = 0

-- إعدادات الشاشة
ScreenGui.Name = "SSV7_SilentAim"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== الزر الرئيسي ==========
MainButton.Size = UDim2.new(0, 110, 0, 36)
MainButton.Position = UDim2.new(0.5, -55, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "🤫 Silent Aim"
MainButton.TextSize = 12
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 3
MainButton.BorderColor3 = Color3.fromRGB(200, 50, 255)
MainButton.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainButton

-- ========== الواجهة ==========
MainFrame.Size = UDim2.new(0, 270, 0, 340)
MainFrame.Position = UDim2.new(0.5, -135, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(200, 50, 255)
MainFrame.Parent = ScreenGui

UICorner2.CornerRadius = UDim.new(0, 10)
UICorner2.Parent = MainFrame

Title.Size = UDim2.new(1, -40, 0, 24)
Title.Position = UDim2.new(0, 15, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "🤫 Silent Aim"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -26, 0, 6)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.GothamBlack
CloseButton.BorderSizePixel = 0
CloseButton.Parent = MainFrame

UICorner3.CornerRadius = UDim.new(0, 10)
UICorner3.Parent = CloseButton

-- زر التشغيل
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -16, 0, 34)
toggleBtn.Position = UDim2.new(0, 8, 0, 32)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "▶️ تشغيل Silent Aim"
toggleBtn.TextSize = 13
toggleBtn.Font = Enum.Font.GothamBlack
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = MainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleBtn

-- جزء الجسم
local partLabel = Instance.new("TextLabel")
partLabel.Size = UDim2.new(1, -16, 0, 18)
partLabel.Position = UDim2.new(0, 8, 0, 70)
partLabel.BackgroundTransparency = 1
partLabel.Text = "🎯 جزء الجسم: الرأس"
partLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
partLabel.TextSize = 11
partLabel.Font = Enum.Font.GothamBold
partLabel.TextXAlignment = Enum.TextXAlignment.Left
partLabel.Parent = MainFrame

local partRow = Instance.new("Frame")
partRow.Size = UDim2.new(1, -16, 0, 30)
partRow.Position = UDim2.new(0, 8, 0, 90)
partRow.BackgroundTransparency = 1
partRow.Parent = MainFrame

local headBtn = Instance.new("TextButton")
headBtn.Size = UDim2.new(0.32, 0, 1, 0)
headBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 200)
headBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
headBtn.Text = "🎯 رأس"
headBtn.TextSize = 10
headBtn.Font = Enum.Font.GothamBlack
headBtn.BorderSizePixel = 0
headBtn.Parent = partRow

local headCorner = Instance.new("UICorner")
headCorner.CornerRadius = UDim.new(0, 8)
headCorner.Parent = headBtn

local torsoBtn = Instance.new("TextButton")
torsoBtn.Size = UDim2.new(0.32, 0, 1, 0)
torsoBtn.Position = UDim2.new(0.34, 0, 0, 0)
torsoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
torsoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
torsoBtn.Text = "🫁 صدر"
torsoBtn.TextSize = 10
torsoBtn.Font = Enum.Font.GothamBlack
torsoBtn.BorderSizePixel = 0
torsoBtn.Parent = partRow

local torsoCorner = Instance.new("UICorner")
torsoCorner.CornerRadius = UDim.new(0, 8)
torsoCorner.Parent = torsoBtn

local legBtn = Instance.new("TextButton")
legBtn.Size = UDim2.new(0.32, 0, 1, 0)
legBtn.Position = UDim2.new(0.68, 0, 0, 0)
legBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
legBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
legBtn.Text = "🦵 بطن"
legBtn.TextSize = 10
legBtn.Font = Enum.Font.GothamBlack
legBtn.BorderSizePixel = 0
legBtn.Parent = partRow

local legCorner = Instance.new("UICorner")
legCorner.CornerRadius = UDim.new(0, 8)
legCorner.Parent = legBtn

-- FOV
local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.new(1, -16, 0, 18)
fovLabel.Position = UDim2.new(0, 8, 0, 124)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "👁️ FOV: " .. fovRadius
fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fovLabel.TextSize = 11
fovLabel.Font = Enum.Font.GothamBold
fovLabel.TextXAlignment = Enum.TextXAlignment.Left
fovLabel.Parent = MainFrame

local fovInput = Instance.new("TextBox")
fovInput.Size = UDim2.new(1, -16, 0, 26)
fovInput.Position = UDim2.new(0, 8, 0, 142)
fovInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
fovInput.TextColor3 = Color3.fromRGB(255, 255, 255)
fovInput.Text = tostring(fovRadius)
fovInput.TextSize = 11
fovInput.Font = Enum.Font.Gotham
fovInput.BorderSizePixel = 1
fovInput.BorderColor3 = Color3.fromRGB(200, 50, 255)
fovInput.Parent = MainFrame

local fovCorner2 = Instance.new("UICorner")
fovCorner2.CornerRadius = UDim.new(0, 6)
fovCorner2.Parent = fovInput

-- نسبة الإصابة
local hitLabel = Instance.new("TextLabel")
hitLabel.Size = UDim2.new(1, -16, 0, 18)
hitLabel.Position = UDim2.new(0, 8, 0, 172)
hitLabel.BackgroundTransparency = 1
hitLabel.Text = "🎲 نسبة الإصابة: " .. hitChance .. "%"
hitLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hitLabel.TextSize = 11
hitLabel.Font = Enum.Font.GothamBold
hitLabel.TextXAlignment = Enum.TextXAlignment.Left
hitLabel.Parent = MainFrame

local hitInput = Instance.new("TextBox")
hitInput.Size = UDim2.new(1, -16, 0, 26)
hitInput.Position = UDim2.new(0, 8, 0, 190)
hitInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
hitInput.TextColor3 = Color3.fromRGB(255, 255, 255)
hitInput.Text = tostring(hitChance)
hitInput.TextSize = 11
hitInput.Font = Enum.Font.Gotham
hitInput.BorderSizePixel = 1
hitInput.BorderColor3 = Color3.fromRGB(200, 50, 255)
hitInput.Parent = MainFrame

local hitCorner = Instance.new("UICorner")
hitCorner.CornerRadius = UDim.new(0, 6)
hitCorner.Parent = hitInput

-- أزرار FOV و Kills
local bottomRow = Instance.new("Frame")
bottomRow.Size = UDim2.new(1, -16, 0, 30)
bottomRow.Position = UDim2.new(0, 8, 0, 220)
bottomRow.BackgroundTransparency = 1
bottomRow.Parent = MainFrame

local fovToggleBtn = Instance.new("TextButton")
fovToggleBtn.Size = UDim2.new(0.48, 0, 1, 0)
fovToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
fovToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fovToggleBtn.Text = "👁️ FOV ON"
fovToggleBtn.TextSize = 10
fovToggleBtn.Font = Enum.Font.GothamBlack
fovToggleBtn.BorderSizePixel = 0
fovToggleBtn.Parent = bottomRow

local fovToggleCorner = Instance.new("UICorner")
fovToggleCorner.CornerRadius = UDim.new(0, 8)
fovToggleCorner.Parent = fovToggleBtn

local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.48, 0, 1, 0)
resetBtn.Position = UDim2.new(0.52, 0, 0, 0)
resetBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.Text = "🔄 تصفير"
resetBtn.TextSize = 10
resetBtn.Font = Enum.Font.GothamBlack
resetBtn.BorderSizePixel = 0
resetBtn.Parent = bottomRow

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 8)
resetCorner.Parent = resetBtn

-- قائمة اللاعبين
ContentFrame.Size = UDim2.new(1, -16, 1, -290)
ContentFrame.Position = UDim2.new(0, 8, 0, 256)
ContentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.ScrollBarThickness = 5
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 255)
ContentFrame.BorderSizePixel = 1
ContentFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.ScrollingEnabled = true
ContentFrame.Parent = MainFrame

UIListLayout.Parent = ContentFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

StatusBar.Size = UDim2.new(1, -16, 0, 22)
StatusBar.Position = UDim2.new(0, 8, 0, 314)
StatusBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
StatusBar.BorderSizePixel = 1
StatusBar.BorderColor3 = Color3.fromRGB(200, 50, 255)
StatusBar.Parent = MainFrame

UICorner4.CornerRadius = UDim.new(0, 11)
UICorner4.Parent = StatusBar

StatusText.Size = UDim2.new(1, -10, 1, 0)
StatusText.Position = UDim2.new(0, 5, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🔴 متوقف | 💀0"
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextSize = 9
StatusText.Font = Enum.Font.GothamBold
StatusText.Parent = StatusBar

Notification.Size = UDim2.new(0, 200, 0, 28)
Notification.Position = UDim2.new(0.5, -100, 0, -32)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(200, 50, 255)
Notification.Visible = false
Notification.Parent = ScreenGui

UICorner5.CornerRadius = UDim.new(0, 8)
UICorner5.Parent = Notification

NotificationText.Size = UDim2.new(1, -10, 1, 0)
NotificationText.Position = UDim2.new(0, 5, 0, 0)
NotificationText.BackgroundTransparency = 1
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 11
NotificationText.Font = Enum.Font.GothamBold
NotificationText.Parent = Notification

-- ========== دائرة FOV ==========
fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
fovCircle.Position = UDim2.new(0.5, -fovRadius, 0.5, -fovRadius)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = showFOV
fovCircle.Parent = ScreenGui

local fovCorner3 = Instance.new("UICorner")
fovCorner3.CornerRadius = UDim.new(1, 0)
fovCorner3.Parent = fovCircle

local fovStroke2 = Instance.new("UIStroke")
fovStroke2.Color = Color3.fromRGB(200, 50, 255)
fovStroke2.Thickness = 1.5
fovStroke2.Transparency = 0.5
fovStroke2.Parent = fovCircle

-- ========== نظام Silent Aim الحقيقي ==========

local function showNotification(text)
    NotificationText.Text = text
    Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -100, 0, -32)
    spawn(function()
        for i = 1, 5 do Notification.Position = UDim2.new(0.5, -100, 0, -32 + (i * 7)); task.wait(0.01) end
        task.wait(1.5)
        for i = 1, 5 do Notification.Position = UDim2.new(0.5, -100, 0, 3 - (i * 7)); task.wait(0.01) end
        Notification.Visible = false
    end)
end

local function getClosestPlayer()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return nil end
    
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    
    local screenCenter = camera.ViewportSize / 2
    local closest = nil
    local closestDist = fovRadius
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local targetPart = player.Character:FindFirstChild(aimPart) or player.Character:FindFirstChild("Head")
            if targetPart then
                local screenPos, onScreen = camera:WorldToScreenPoint(targetPart.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = player
                    end
                end
            end
        end
    end
    
    return closest
end

local function createHighlight(player)
    if highlight then highlight:Destroy() end
    if not player or not player.Character then return end
    
    highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 0, 255)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.3
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = player.Character
end

-- الفكرة الأساسية: Silent Aim يغير مكان إطلاق الرصاصة
-- بدل ما يطلق من مكان السلاح، يطلق من مكان قريب من الهدف
-- أو يغير هدف الرصاصة مباشرة للجزء المطلوب
local function silentAimFire(targetPlayer)
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return end
    
    -- نجيب السلاح
    local tool = localPlayer.Character:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    -- نبحث عن الـ RemoteEvent اللي يطلق الرصاص
    local fireRemote = nil
    for _, child in pairs(tool:GetDescendants()) do
        if child:IsA("RemoteEvent") and (child.Name:lower():find("fire") or child.Name:lower():find("shoot") or child.Name:lower():find("bullet") or child.Name:lower():find("gun")) then
            fireRemote = child
            break
        end
    end
    
    if not fireRemote then
        -- ما لقينا Remote، نجرب نضغط على الشاشة (Mouse Click)
        pcall(function()
            local mouse = localPlayer:GetMouse()
            if mouse then
                mouse1click()
            end
        end)
        return
    end
    
    -- Silent Aim: نغير الإحداثيات اللي نرسلها للـ Remote
    local targetPart = targetPlayer.Character:FindFirstChild(aimPart) or targetPlayer.Character:FindFirstChild("Head")
    if not targetPart then return end
    
    local targetPos = targetPart.Position
    
    pcall(function()
        -- نجرب نرسل الإحداثيات الجديدة
        fireRemote:FireServer(targetPos, targetPart, targetPlayer.Character)
    end)
end

local function aimbotLoop()
    if not isActive then return end
    
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return end
    
    -- إيجاد أقرب لاعب في FOV
    targetPlayer = getClosestPlayer()
    
    if targetPlayer and targetPlayer.Character then
        createHighlight(targetPlayer)
        
        -- Silent Aim: نطلق النار تلقائياً إذا في هدف
        local randomChance = math.random(1, 100)
        if randomChance <= hitChance then
            silentAimFire(targetPlayer)
            
            -- إذا مات الهدف نزيد العداد
            if targetPlayer.Character:FindFirstChild("Humanoid") and targetPlayer.Character.Humanoid.Health <= 0 then
                kills = kills + 1
                StatusText.Text = "🟢 يعمل | 💀" .. kills
                targetPlayer = nil
                if highlight then highlight:Destroy(); highlight = nil end
            end
        end
    else
        if highlight then highlight:Destroy(); highlight = nil end
    end
end

local function startAimbot()
    if isActive then return end
    isActive = true
    
    toggleBtn.Text = "⏹ إيقاف Silent Aim"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    StatusText.Text = "🟢 يعمل | 💀" .. kills
    StatusText.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    aimConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if isActive then
            pcall(aimbotLoop)
        end
    end)
    
    showNotification("🤫 Silent Aim شغال")
end

local function stopAimbot()
    isActive = false
    targetPlayer = nil
    
    if aimConnection then aimConnection:Disconnect(); aimConnection = nil end
    if highlight then highlight:Destroy(); highlight = nil end
    
    toggleBtn.Text = "▶️ تشغيل Silent Aim"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    StatusText.Text = "🔴 متوقف | 💀" .. kills
    StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
    
    showNotification("🔴 تم إيقاف Silent Aim")
end

-- ========== بناء قائمة اللاعبين ==========

local function buildPlayerList()
    ContentFrame:ClearAllChildren()
    
    local localPlayer = game.Players.LocalPlayer
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer then
            local isTarget = (player == targetPlayer)
            
            local card = Instance.new("Frame")
            card.Size = UDim2.new(1, -2, 0, 32)
            card.BackgroundColor3 = isTarget and Color3.fromRGB(50, 10, 50) or Color3.fromRGB(16, 16, 16)
            card.BorderSizePixel = 1
            card.BorderColor3 = isTarget and Color3.fromRGB(200, 50, 255) or Color3.fromRGB(35, 35, 35)
            card.Parent = ContentFrame
            
            local cardCorner = Instance.new("UICorner")
            cardCorner.CornerRadius = UDim.new(0, 6)
            cardCorner.Parent = card
            
            local name = Instance.new("TextLabel")
            name.Size = UDim2.new(0.6, -8, 1, 0)
            name.Position = UDim2.new(0, 8, 0, 0)
            name.BackgroundTransparency = 1
            name.Text = (isTarget and "🎯 " or "👤 ") .. player.DisplayName
            name.TextColor3 = isTarget and Color3.fromRGB(255, 100, 255) or Color3.fromRGB(255, 255, 255)
            name.TextSize = 11
            name.Font = Enum.Font.GothamBold
            name.TextXAlignment = Enum.TextXAlignment.Left
            name.TextTruncate = Enum.TextTruncate.AtEnd
            name.Parent = card
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 45, 0, 22)
            btn.Position = UDim2.new(1, -52, 0, 5)
            btn.BackgroundColor3 = isTarget and Color3.fromRGB(200, 50, 255) or Color3.fromRGB(0, 180, 0)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = isTarget and "✅" or "🎯"
            btn.TextSize = 11
            btn.Font = Enum.Font.GothamBlack
            btn.BorderSizePixel = 0
            btn.Parent = card
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 11)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                if isTarget then
                    targetPlayer = nil
                    if highlight then highlight:Destroy(); highlight = nil end
                else
                    targetPlayer = player
                    createHighlight(player)
                    if not isActive then startAimbot() end
                end
                buildPlayerList()
            end)
        end
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

-- ========== الأحداث ==========
MainButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then buildPlayerList() end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

toggleBtn.MouseButton1Click:Connect(function()
    if isActive then stopAimbot() else startAimbot() end
    buildPlayerList()
end)

headBtn.MouseButton1Click:Connect(function()
    aimPart = "Head"
    headBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 200)
    torsoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    legBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    partLabel.Text = "🎯 جزء الجسم: الرأس"
end)

torsoBtn.MouseButton1Click:Connect(function()
    aimPart = "UpperTorso"
    headBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    torsoBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 200)
    legBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    partLabel.Text = "🎯 جزء الجسم: الصدر"
end)

legBtn.MouseButton1Click:Connect(function()
    aimPart = "LowerTorso"
    headBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    torsoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    legBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 200)
    partLabel.Text = "🎯 جزء الجسم: البطن"
end)

fovInput.FocusLost:Connect(function()
    fovRadius = math.clamp(tonumber(fovInput.Text) or 150, 30, 500)
    fovInput.Text = tostring(fovRadius)
    fovLabel.Text = "👁️ FOV: " .. fovRadius
    fovCircle.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
    fovCircle.Position = UDim2.new(0.5, -fovRadius, 0.5, -fovRadius)
end)

hitInput.FocusLost:Connect(function()
    hitChance = math.clamp(tonumber(hitInput.Text) or 100, 1, 100)
    hitInput.Text = tostring(hitChance)
    hitLabel.Text = "🎲 نسبة الإصابة: " .. hitChance .. "%"
end)

fovToggleBtn.MouseButton1Click:Connect(function()
    showFOV = not showFOV
    fovCircle.Visible = showFOV
    fovToggleBtn.BackgroundColor3 = showFOV and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    fovToggleBtn.Text = showFOV and "👁️ FOV ON" or "👁️ FOV OFF"
end)

resetBtn.MouseButton1Click:Connect(function()
    kills = 0
    StatusText.Text = (isActive and "🟢 يعمل" or "🔴 متوقف") .. " | 💀0"
    showNotification("🔄 تم تصفير القتلى")
end)

game.Players.PlayerAdded:Connect(function()
    if MainFrame.Visible then buildPlayerList() end
end)

game.Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        targetPlayer = nil
        if highlight then highlight:Destroy(); highlight = nil end
    end
    if MainFrame.Visible then buildPlayerList() end
end)

buildPlayerList()
showNotification("🤫 Silent Aim جاهز!")
