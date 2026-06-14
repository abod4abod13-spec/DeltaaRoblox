-- ⚡ SSV7 Chams System Pro v2 - حقيقي لكل المابات ⚡
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local StatusBar = Instance.new("Frame")
local UICorner4 = Instance.new("UICorner")
local StatusText = Instance.new("TextLabel")
local Notification = Instance.new("Frame")
local UICorner5 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")

-- المتغيرات
local isActive = false
local chamsConnection = nil
local highlights = {}
local billboards = {}
local enemyColor = Color3.fromRGB(255, 0, 0)
local friendColor = Color3.fromRGB(0, 255, 0)
local teamColor = Color3.fromRGB(0, 150, 255)
local fillTransparency = 0.3
local showEnemies = true
local showFriends = true
local showTeam = false
local showNames = true
local showDistance = true
local showHealth = true
local showWeapon = false
local maxDistance = 2000

ScreenGui.Name = "SSV7_Chams"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- زر رئيسي
MainButton.Size = UDim2.new(0, 100, 0, 34)
MainButton.Position = UDim2.new(0.5, -50, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "👁️ Chams"
MainButton.TextSize = 13
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 3
MainButton.BorderColor3 = Color3.fromRGB(255, 150, 0)
MainButton.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainButton

-- واجهة
MainFrame.Size = UDim2.new(0, 260, 0, 300)
MainFrame.Position = UDim2.new(0.5, -130, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 150, 0)
MainFrame.Parent = ScreenGui

UICorner2.CornerRadius = UDim.new(0, 10)
UICorner2.Parent = MainFrame

Title.Size = UDim2.new(1, -40, 0, 22)
Title.Position = UDim2.new(0, 15, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "👁️ Chams System"
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

StatusBar.Size = UDim2.new(1, -16, 0, 24)
StatusBar.Position = UDim2.new(0, 8, 0, 270)
StatusBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
StatusBar.BorderSizePixel = 1
StatusBar.BorderColor3 = Color3.fromRGB(255, 150, 0)
StatusBar.Parent = MainFrame

UICorner4.CornerRadius = UDim.new(0, 12)
UICorner4.Parent = StatusBar

StatusText.Size = UDim2.new(1, -10, 1, 0)
StatusText.Position = UDim2.new(0, 5, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🔴 متوقف"
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextSize = 10
StatusText.Font = Enum.Font.GothamBold
StatusText.Parent = StatusBar

Notification.Size = UDim2.new(0, 200, 0, 28)
Notification.Position = UDim2.new(0.5, -100, 0, -32)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(255, 150, 0)
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

-- ========== الأزرار ==========

-- زر التشغيل
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -16, 0, 32)
toggleBtn.Position = UDim2.new(0, 8, 0, 32)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "▶️ تشغيل Chams"
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.GothamBlack
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = MainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleBtn

-- أنواع اللاعبين
local typeLabel = Instance.new("TextLabel")
typeLabel.Size = UDim2.new(1, -16, 0, 16)
typeLabel.Position = UDim2.new(0, 8, 0, 68)
typeLabel.BackgroundTransparency = 1
typeLabel.Text = "👥 أنواع اللاعبين:"
typeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
typeLabel.TextSize = 10
typeLabel.Font = Enum.Font.GothamBold
typeLabel.TextXAlignment = Enum.TextXAlignment.Left
typeLabel.Parent = MainFrame

-- الأعداء
local enemyFrame = Instance.new("Frame")
enemyFrame.Size = UDim2.new(1, -16, 0, 28)
enemyFrame.Position = UDim2.new(0, 8, 0, 86)
enemyFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
enemyFrame.BorderSizePixel = 1
enemyFrame.BorderColor3 = Color3.fromRGB(35, 35, 35)
enemyFrame.Parent = MainFrame

local enemyCorner = Instance.new("UICorner")
enemyCorner.CornerRadius = UDim.new(0, 6)
enemyCorner.Parent = enemyFrame

local enemyLabel = Instance.new("TextLabel")
enemyLabel.Size = UDim2.new(0.55, -8, 1, 0)
enemyLabel.Position = UDim2.new(0, 8, 0, 0)
enemyLabel.BackgroundTransparency = 1
enemyLabel.Text = "🔴 الأعداء"
enemyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
enemyLabel.TextSize = 10
enemyLabel.Font = Enum.Font.Gotham
enemyLabel.TextXAlignment = Enum.TextXAlignment.Left
enemyLabel.Parent = enemyFrame

local enemyBtn = Instance.new("TextButton")
enemyBtn.Size = UDim2.new(0, 40, 0, 20)
enemyBtn.Position = UDim2.new(1, -46, 0, 4)
enemyBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
enemyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
enemyBtn.Text = "ON"
enemyBtn.TextSize = 9
enemyBtn.Font = Enum.Font.GothamBlack
enemyBtn.BorderSizePixel = 0
enemyBtn.Parent = enemyFrame

local enemyBtnCorner = Instance.new("UICorner")
enemyBtnCorner.CornerRadius = UDim.new(0, 10)
enemyBtnCorner.Parent = enemyBtn

-- الأصدقاء
local friendFrame = Instance.new("Frame")
friendFrame.Size = UDim2.new(1, -16, 0, 28)
friendFrame.Position = UDim2.new(0, 8, 0, 118)
friendFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
friendFrame.BorderSizePixel = 1
friendFrame.BorderColor3 = Color3.fromRGB(35, 35, 35)
friendFrame.Parent = MainFrame

local friendCorner = Instance.new("UICorner")
friendCorner.CornerRadius = UDim.new(0, 6)
friendCorner.Parent = friendFrame

local friendLabel = Instance.new("TextLabel")
friendLabel.Size = UDim2.new(0.55, -8, 1, 0)
friendLabel.Position = UDim2.new(0, 8, 0, 0)
friendLabel.BackgroundTransparency = 1
friendLabel.Text = "⭐ الأصدقاء"
friendLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
friendLabel.TextSize = 10
friendLabel.Font = Enum.Font.Gotham
friendLabel.TextXAlignment = Enum.TextXAlignment.Left
friendLabel.Parent = friendFrame

local friendBtn = Instance.new("TextButton")
friendBtn.Size = UDim2.new(0, 40, 0, 20)
friendBtn.Position = UDim2.new(1, -46, 0, 4)
friendBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
friendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
friendBtn.Text = "ON"
friendBtn.TextSize = 9
friendBtn.Font = Enum.Font.GothamBlack
friendBtn.BorderSizePixel = 0
friendBtn.Parent = friendFrame

local friendBtnCorner = Instance.new("UICorner")
friendBtnCorner.CornerRadius = UDim.new(0, 10)
friendBtnCorner.Parent = friendBtn

-- الفريق
local teamFrame = Instance.new("Frame")
teamFrame.Size = UDim2.new(1, -16, 0, 28)
teamFrame.Position = UDim2.new(0, 8, 0, 150)
teamFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
teamFrame.BorderSizePixel = 1
teamFrame.BorderColor3 = Color3.fromRGB(35, 35, 35)
teamFrame.Parent = MainFrame

local teamCorner = Instance.new("UICorner")
teamCorner.CornerRadius = UDim.new(0, 6)
teamCorner.Parent = teamFrame

local teamLabel = Instance.new("TextLabel")
teamLabel.Size = UDim2.new(0.55, -8, 1, 0)
teamLabel.Position = UDim2.new(0, 8, 0, 0)
teamLabel.BackgroundTransparency = 1
teamLabel.Text = "👥 الفريق"
teamLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
teamLabel.TextSize = 10
teamLabel.Font = Enum.Font.Gotham
teamLabel.TextXAlignment = Enum.TextXAlignment.Left
teamLabel.Parent = teamFrame

local teamBtn = Instance.new("TextButton")
teamBtn.Size = UDim2.new(0, 40, 0, 20)
teamBtn.Position = UDim2.new(1, -46, 0, 4)
teamBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
teamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teamBtn.Text = "OFF"
teamBtn.TextSize = 9
teamBtn.Font = Enum.Font.GothamBlack
teamBtn.BorderSizePixel = 0
teamBtn.Parent = teamFrame

local teamBtnCorner = Instance.new("UICorner")
teamBtnCorner.CornerRadius = UDim.new(0, 10)
teamBtnCorner.Parent = teamBtn

-- ألوان الأعداء
local colorLabel = Instance.new("TextLabel")
colorLabel.Size = UDim2.new(1, -16, 0, 16)
colorLabel.Position = UDim2.new(0, 8, 0, 182)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "🎨 لون الأعداء:"
colorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
colorLabel.TextSize = 10
colorLabel.Font = Enum.Font.GothamBold
colorLabel.TextXAlignment = Enum.TextXAlignment.Left
colorLabel.Parent = MainFrame

local colorRow = Instance.new("Frame")
colorRow.Size = UDim2.new(1, -16, 0, 28)
colorRow.Position = UDim2.new(0, 8, 0, 200)
colorRow.BackgroundTransparency = 1
colorRow.Parent = MainFrame

local colors = {
    {Name = "🔴", Color = Color3.fromRGB(255, 0, 0)},
    {Name = "🔵", Color = Color3.fromRGB(0, 100, 255)},
    {Name = "🟢", Color = Color3.fromRGB(0, 255, 0)},
    {Name = "🟡", Color = Color3.fromRGB(255, 255, 0)},
    {Name = "🟣", Color = Color3.fromRGB(255, 0, 255)},
    {Name = "⚪", Color = Color3.fromRGB(255, 255, 255)},
}

for i, colorData in pairs(colors) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.15, 0, 1, 0)
    btn.Position = UDim2.new((i-1) * 0.165, 0, 0, 0)
    btn.BackgroundColor3 = colorData.Color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = ""
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBlack
    btn.BorderSizePixel = 0
    btn.Parent = colorRow
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 14)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        enemyColor = colorData.Color
        showNotification("🎨 " .. colorData.Name)
    end)
end

-- معلومات
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -16, 0, 16)
infoLabel.Position = UDim2.new(0, 8, 0, 232)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "📋 المعلومات:"
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infoLabel.TextSize = 10
infoLabel.Font = Enum.Font.GothamBold
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = MainFrame

local infoRow = Instance.new("Frame")
infoRow.Size = UDim2.new(1, -16, 0, 28)
infoRow.Position = UDim2.new(0, 8, 0, 250)
infoRow.BackgroundTransparency = 1
infoRow.Parent = MainFrame

local namesBtn = Instance.new("TextButton")
namesBtn.Size = UDim2.new(0.32, 0, 1, 0)
namesBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
namesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
namesBtn.Text = "📝"
namesBtn.TextSize = 12
namesBtn.Font = Enum.Font.GothamBlack
namesBtn.BorderSizePixel = 0
namesBtn.Parent = infoRow

local namesCorner = Instance.new("UICorner")
namesCorner.CornerRadius = UDim.new(0, 14)
namesCorner.Parent = namesBtn

local distBtn = Instance.new("TextButton")
distBtn.Size = UDim2.new(0.32, 0, 1, 0)
distBtn.Position = UDim2.new(0.34, 0, 0, 0)
distBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
distBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
distBtn.Text = "📏"
distBtn.TextSize = 12
distBtn.Font = Enum.Font.GothamBlack
distBtn.BorderSizePixel = 0
distBtn.Parent = infoRow

local distCorner = Instance.new("UICorner")
distCorner.CornerRadius = UDim.new(0, 14)
distCorner.Parent = distBtn

local healthBtn = Instance.new("TextButton")
healthBtn.Size = UDim2.new(0.32, 0, 1, 0)
healthBtn.Position = UDim2.new(0.68, 0, 0, 0)
healthBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
healthBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
healthBtn.Text = "❤️"
healthBtn.TextSize = 12
healthBtn.Font = Enum.Font.GothamBlack
healthBtn.BorderSizePixel = 0
healthBtn.Parent = infoRow

local healthCorner = Instance.new("UICorner")
healthCorner.CornerRadius = UDim.new(0, 14)
healthCorner.Parent = healthBtn

-- ========== نظام Chams الحقيقي ==========

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

local function getPlayerType(player)
    local localPlayer = game.Players.LocalPlayer
    local isFriend = pcall(function() return player:IsFriendsWith(localPlayer.UserId) end) and player:IsFriendsWith(localPlayer.UserId)
    if isFriend then return "Friend" end
    if localPlayer.Team and player.Team and localPlayer.Team == player.Team then return "Team" end
    return "Enemy"
end

local function removeAllChams()
    for _, data in pairs(highlights) do
        pcall(function() data.Highlight:Destroy() end)
        pcall(function() data.Billboard:Destroy() end)
    end
    highlights = {}
    billboards = {}
end

local function addChamsToPlayer(player)
    if player == game.Players.LocalPlayer then return end
    if not player.Character then return end
    
    local playerType = getPlayerType(player)
    if playerType == "Enemy" and not showEnemies then return end
    if playerType == "Friend" and not showFriends then return end
    if playerType == "Team" and not showTeam then return end
    
    -- إزالة القديم
    if highlights[player.UserId] then
        pcall(function() highlights[player.UserId].Highlight:Destroy() end)
        pcall(function() highlights[player.UserId].Billboard:Destroy() end)
    end
    
    local color
    if playerType == "Enemy" then color = enemyColor
    elseif playerType == "Friend" then color = friendColor
    else color = teamColor end
    
    -- إنشاء Highlight (هذا هو Chams الحقيقي - يشوف عبر الجدران)
    local highlight = Instance.new("Highlight")
    highlight.Name = "SSV7_Chams"
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = fillTransparency
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- هذا يخليه يظهر دايم حتى لو ورا جدار
    highlight.Parent = player.Character
    
    -- Billboard للمعلومات
    local head = player.Character:FindFirstChild("Head")
    local billboard = nil
    if head and showNames then
        billboard = Instance.new("BillboardGui")
        billboard.Name = "SSV7_Info"
        billboard.Size = UDim2.new(0, 180, 0, 40)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = head
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextStrokeTransparency = 0
        label.TextColor3 = color
        label.TextSize = 12
        label.Font = Enum.Font.GothamBlack
        label.Parent = billboard
        
        highlights[player.UserId] = {
            Highlight = highlight,
            Billboard = billboard,
            Label = label,
            Type = playerType
        }
    else
        highlights[player.UserId] = {
            Highlight = highlight,
            Billboard = nil,
            Label = nil,
            Type = playerType
        }
    end
end

local function updateAllChams()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character then return end
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
    for userId, data in pairs(highlights) do
        local player = game.Players:GetPlayerByUserId(userId)
        if player and player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local distance = (localRoot.Position - root.Position).Magnitude
                
                -- تحديث اللون
                local color
                if data.Type == "Enemy" then color = enemyColor
                elseif data.Type == "Friend" then color = friendColor
                else color = teamColor end
                
                if data.Highlight and data.Highlight.Parent then
                    data.Highlight.FillColor = color
                    data.Highlight.OutlineColor = color
                end
                
                -- تحديث المعلومات
                if data.Label and data.Billboard and data.Billboard.Parent then
                    local text = player.DisplayName
                    if showDistance then text = text .. " | " .. math.floor(distance) .. "m" end
                    if showHealth and player.Character:FindFirstChild("Humanoid") then
                        text = text .. " | ❤️" .. math.floor(player.Character.Humanoid.Health)
                    end
                    data.Label.Text = text
                    data.Label.TextColor3 = color
                end
            end
        else
            -- اللاعب خرج أو مات
            pcall(function() data.Highlight:Destroy() end)
            pcall(function() data.Billboard:Destroy() end)
            highlights[userId] = nil
        end
    end
end

local function startChams()
    if isActive then return end
    isActive = true
    
    -- إضافة Chams لكل اللاعبين الموجودين
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            addChamsToPlayer(player)
        end
    end
    
    toggleBtn.Text = "⏹ إيقاف Chams"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    StatusText.Text = "🟢 يعمل"
    StatusText.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    showNotification("👁️ Chams شغال")
end

local function stopChams()
    isActive = false
    removeAllChams()
    
    toggleBtn.Text = "▶️ تشغيل Chams"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    StatusText.Text = "🔴 متوقف"
    StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
    
    showNotification("🔴 تم إيقاف Chams")
end

-- ========== الأحداث ==========
MainButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

toggleBtn.MouseButton1Click:Connect(function()
    if isActive then stopChams() else startChams() end
end)

enemyBtn.MouseButton1Click:Connect(function()
    showEnemies = not showEnemies
    enemyBtn.BackgroundColor3 = showEnemies and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(160, 0, 0)
    enemyBtn.Text = showEnemies and "ON" or "OFF"
    if isActive then stopChams(); startChams() end
end)

friendBtn.MouseButton1Click:Connect(function()
    showFriends = not showFriends
    friendBtn.BackgroundColor3 = showFriends and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(160, 0, 0)
    friendBtn.Text = showFriends and "ON" or "OFF"
    if isActive then stopChams(); startChams() end
end)

teamBtn.MouseButton1Click:Connect(function()
    showTeam = not showTeam
    teamBtn.BackgroundColor3 = showTeam and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(160, 0, 0)
    teamBtn.Text = showTeam and "ON" or "OFF"
    if isActive then stopChams(); startChams() end
end)

namesBtn.MouseButton1Click:Connect(function()
    showNames = not showNames
    namesBtn.BackgroundColor3 = showNames and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(160, 0, 0)
    if isActive then stopChams(); startChams() end
end)

distBtn.MouseButton1Click:Connect(function()
    showDistance = not showDistance
    distBtn.BackgroundColor3 = showDistance and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(160, 0, 0)
end)

healthBtn.MouseButton1Click:Connect(function()
    showHealth = not showHealth
    healthBtn.BackgroundColor3 = showHealth and Color3.fromRGB(0, 160, 0) or Color3.fromRGB(160, 0, 0)
end)

-- تحديث مستمر
game:GetService("RunService").RenderStepped:Connect(function()
    if isActive then
        pcall(updateAllChams)
    end
end)

-- لاعب جديد يدخل
game.Players.PlayerAdded:Connect(function(player)
    if isActive and player ~= game.Players.LocalPlayer then
        task.wait(0.5)
        addChamsToPlayer(player)
    end
end)

-- لاعب يخرج
game.Players.PlayerRemoving:Connect(function(player)
    if highlights[player.UserId] then
        pcall(function() highlights[player.UserId].Highlight:Destroy() end)
        pcall(function() highlights[player.UserId].Billboard:Destroy() end)
        highlights[player.UserId] = nil
    end
end)

-- إعادة بعد الموت
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if isActive then
        task.wait(0.3)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                addChamsToPlayer(player)
            end
        end
    end
end)

showNotification("👁️ Chams جاهز!")
