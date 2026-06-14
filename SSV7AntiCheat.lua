-- ⚡ SSV7 Anti-Cheat Detector Pro v2 - الذكي الخارق ⚡
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
local isScanning = false
local detectedHackers = {}
local hackLogs = {}
local playerData = {}
local scanCount = 0
local totalHacksFound = 0
local confirmationScans = 3 -- عدد مرات التأكيد قبل الإبلاغ

-- إعدادات الشاشة
ScreenGui.Name = "SSV7_AntiCheat"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== الزر الرئيسي ==========
MainButton.Size = UDim2.new(0, 120, 0, 38)
MainButton.Position = UDim2.new(0.5, -60, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(255, 50, 50)
MainButton.Text = "🛡️ Anti-Cheat"
MainButton.TextSize = 12
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 3
MainButton.BorderColor3 = Color3.fromRGB(255, 50, 50)
MainButton.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainButton

-- ========== الواجهة الرئيسية ==========
MainFrame.Size = UDim2.new(0, 290, 0, 400)
MainFrame.Position = UDim2.new(0.5, -145, 0, 52)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
MainFrame.Parent = ScreenGui

UICorner2.CornerRadius = UDim.new(0, 10)
UICorner2.Parent = MainFrame

Title.Size = UDim2.new(1, -40, 0, 26)
Title.Position = UDim2.new(0, 15, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "🛡️ Anti-Cheat Pro"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
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

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(1, -16, 0, 34)
scanBtn.Position = UDim2.new(0, 8, 0, 34)
scanBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.Text = "🔍 بدء الفحص الشامل"
scanBtn.TextSize = 13
scanBtn.Font = Enum.Font.GothamBlack
scanBtn.BorderSizePixel = 0
scanBtn.Parent = MainFrame

local scanCorner = Instance.new("UICorner")
scanCorner.CornerRadius = UDim.new(0, 10)
scanCorner.Parent = scanBtn

ContentFrame.Size = UDim2.new(1, -16, 1, -104)
ContentFrame.Position = UDim2.new(0, 8, 0, 74)
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

StatusBar.Size = UDim2.new(1, -16, 0, 24)
StatusBar.Position = UDim2.new(0, 8, 0, 370)
StatusBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
StatusBar.BorderSizePixel = 1
StatusBar.BorderColor3 = Color3.fromRGB(255, 50, 50)
StatusBar.Parent = MainFrame

UICorner4.CornerRadius = UDim.new(0, 12)
UICorner4.Parent = StatusBar

StatusText.Size = UDim2.new(1, -10, 1, 0)
StatusText.Position = UDim2.new(0, 5, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🔴 متوقف | 0 هاك"
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextSize = 9
StatusText.Font = Enum.Font.GothamBold
StatusText.Parent = StatusBar

Notification.Size = UDim2.new(0, 230, 0, 32)
Notification.Position = UDim2.new(0.5, -115, 0, -38)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(255, 50, 50)
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

-- ========== نظام الكشف الذكي ==========

local function showNotification(text)
    NotificationText.Text = text
    Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -115, 0, -38)
    spawn(function()
        for i = 1, 5 do Notification.Position = UDim2.new(0.5, -115, 0, -38 + (i * 8)); task.wait(0.01) end
        task.wait(2)
        for i = 1, 5 do Notification.Position = UDim2.new(0.5, -115, 0, 2 - (i * 8)); task.wait(0.01) end
        Notification.Visible = false
    end)
end

local function updateStatus()
    StatusText.Text = string.format("%s | 👥%d | 💀%d",
        isScanning and "🟡 يفحص" or "🟢 جاهز",
        #game.Players:GetPlayers(), totalHacksFound
    )
end

-- تهيئة بيانات اللاعب
local function initPlayerData(player)
    if not playerData[player.UserId] then
        playerData[player.UserId] = {
            Player = player,
            Name = player.DisplayName,
            Username = player.Name,
            DetectedHacks = {},
            ConfirmedHacks = {},
            ScanCount = 0,
            SuspicionLevel = 0,
            NormalWalkSpeed = 16,
            NormalJumpPower = 50,
            LastPosition = nil,
            LastCheck = 0,
            FlyCount = 0,
            SpeedCount = 0,
            NoclipCount = 0,
            TeleportCount = 0,
            GodCount = 0,
            IsHacker = false,
            IsGameBoost = false
        }
    end
    return playerData[player.UserId]
end

-- معرفة إذا الماب يعطي سرعة أو قفز
local function detectGameBoosts(player)
    local data = playerData[player.UserId]
    if not data then return end
    
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- إذا كل اللاعبين عندهم نفس السرعة العالية = الماب هو اللي معطيهم
    local allSameSpeed = true
    local speedCount = 0
    local totalPlayers = 0
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= game.Players.LocalPlayer and otherPlayer.Character then
            local otherHumanoid = otherPlayer.Character:FindFirstChild("Humanoid")
            if otherHumanoid then
                totalPlayers = totalPlayers + 1
                if math.abs(otherHumanoid.WalkSpeed - humanoid.WalkSpeed) < 5 then
                    speedCount = speedCount + 1
                end
            end
        end
    end
    
    -- إذا 80% من اللاعبين عندهم نفس السرعة = الماب هو السبب
    if totalPlayers >= 3 and speedCount >= totalPlayers * 0.8 then
        data.IsGameBoost = true
        data.NormalWalkSpeed = humanoid.WalkSpeed
        data.NormalJumpPower = humanoid.JumpPower
    else
        data.IsGameBoost = false
    end
end

-- فحص الطيران الذكي
local function checkFlyHack(player)
    local data = playerData[player.UserId]
    if not data or not player.Character then return false, "" end
    
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false, "" end
    
    local pos = root.Position
    local vel = root.Velocity
    local humanoid = player.Character:FindFirstChild("Humanoid")
    
    if not data.LastPosition then
        data.LastPosition = pos
        data.LastCheck = tick()
        return false, ""
    end
    
    local timeDiff = tick() - data.LastCheck
    if timeDiff < 0.3 then return false, "" end
    
    -- فحص إذا عالي بدون أرض تحتيه
    local rayOrigin = pos
    local rayDirection = Vector3.new(0, -100, 0)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {player.Character}
    
    local rayResult = workspace:Raycast(rayOrigin, rayDirection, rayParams)
    local groundDistance = rayResult and (pos.Y - rayResult.Position.Y) or 999
    
    -- فحص إذا طاير بدون أرض
    if groundDistance > 30 and vel.Y > 10 then
        data.FlyCount = data.FlyCount + 1
        data.LastPosition = pos
        data.LastCheck = tick()
        
        -- نتأكد 3 مرات قبل الإبلاغ
        if data.FlyCount >= confirmationScans then
            data.SuspicionLevel = data.SuspicionLevel + 30
            return true, "✈️ Fly Hack (ارتفاع " .. math.floor(groundDistance) .. "م)"
        end
        return false, ""
    end
    
    -- فحص إذا واقف في الهوا
    if humanoid and humanoid.FloorMaterial == Enum.Material.Air and groundDistance > 10 and math.abs(vel.Y) < 1 then
        data.FlyCount = data.FlyCount + 1
        data.LastPosition = pos
        data.LastCheck = tick()
        
        if data.FlyCount >= confirmationScans then
            data.SuspicionLevel = data.SuspicionLevel + 25
            return true, "✈️ Fly Hack (واقف في الهواء)"
        end
        return false, ""
    end
    
    -- إعادة تعيين إذا على الأرض
    if groundDistance < 5 then
        data.FlyCount = math.max(0, data.FlyCount - 1)
    end
    
    data.LastPosition = pos
    data.LastCheck = tick()
    return false, ""
end

-- فحص السرعة الذكي
local function checkSpeedHack(player)
    local data = playerData[player.UserId]
    if not data or not player.Character then return false, "" end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return false, "" end
    
    -- نتأكد إذا الماب معطي سرعة
    if data.IsGameBoost then
        if humanoid.WalkSpeed > data.NormalWalkSpeed * 1.5 then
            data.SpeedCount = data.SpeedCount + 1
            if data.SpeedCount >= confirmationScans then
                data.SuspicionLevel = data.SuspicionLevel + 20
                return true, "⚡ Speed Hack (" .. math.floor(humanoid.WalkSpeed) .. ")"
            end
        end
        return false, ""
    end
    
    -- السرعة الطبيعية 16
    local maxNormalSpeed = 25
    
    if humanoid.WalkSpeed > maxNormalSpeed then
        data.SpeedCount = data.SpeedCount + 1
        
        if data.SpeedCount >= confirmationScans then
            data.SuspicionLevel = data.SuspicionLevel + 20
            return true, "⚡ Speed Hack (" .. math.floor(humanoid.WalkSpeed) .. ")"
        end
        return false, ""
    else
        data.SpeedCount = math.max(0, data.SpeedCount - 1)
    end
    
    return false, ""
end

-- فحص اختراق الجدران
local function checkNoclipHack(player)
    local data = playerData[player.UserId]
    if not data or not player.Character then return false, "" end
    
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false, "" end
    
    -- نفحص 4 اتجاهات
    local directions = {
        Vector3.new(1, 0, 0),
        Vector3.new(-1, 0, 0),
        Vector3.new(0, 0, 1),
        Vector3.new(0, 0, -1),
    }
    
    local wallCount = 0
    for _, dir in pairs(directions) do
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        rayParams.FilterDescendantsInstances = {player.Character}
        
        local rayResult = workspace:Raycast(root.Position, dir * 0.8, rayParams)
        if rayResult then
            wallCount = wallCount + 1
        end
    end
    
    -- إذا محاط بجدران من كل الجهات = داخل جدار
    if wallCount >= 3 then
        data.NoclipCount = data.NoclipCount + 1
        
        if data.NoclipCount >= confirmationScans then
            data.SuspicionLevel = data.SuspicionLevel + 35
            return true, "🚫 Noclip (داخل جدار)"
        end
        return false, ""
    else
        data.NoclipCount = math.max(0, data.NoclipCount - 1)
    end
    
    return false, ""
end

-- فحص التليبورت
local function checkTeleportHack(player)
    local data = playerData[player.UserId]
    if not data or not player.Character then return false, "" end
    
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false, "" end
    
    if not data.LastPosition then
        data.LastPosition = root.Position
        data.LastCheck = tick()
        return false, ""
    end
    
    local timeDiff = tick() - data.LastCheck
    if timeDiff < 0.5 then return false, "" end
    
    local distance = (root.Position - data.LastPosition).Magnitude
    
    -- إذا تحرك أكثر من 150 متر في أقل من ثانية = تليبورت
    if distance > 150 and timeDiff < 1 then
        data.TeleportCount = data.TeleportCount + 1
        
        if data.TeleportCount >= 2 then
            data.SuspicionLevel = data.SuspicionLevel + 40
            return true, "📍 Teleport (" .. math.floor(distance) .. "م)"
        end
        return false, ""
    else
        data.TeleportCount = math.max(0, data.TeleportCount - 1)
    end
    
    data.LastPosition = root.Position
    data.LastCheck = tick()
    return false, ""
end

-- فحص القود مود
local function checkGodMode(player)
    local data = playerData[player.UserId]
    if not data or not player.Character then return false, "" end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid then return false, "" end
    
    if humanoid.Health > humanoid.MaxHealth * 1.5 and humanoid.Health > 200 then
        data.GodCount = data.GodCount + 1
        
        if data.GodCount >= confirmationScans then
            data.SuspicionLevel = data.SuspicionLevel + 45
            return true, "👑 God Mode (صحة " .. math.floor(humanoid.Health) .. ")"
        end
        return false, ""
    else
        data.GodCount = math.max(0, data.GodCount - 1)
    end
    
    return false, ""
end

-- الفحص الشامل للاعب
local function scanPlayer(player)
    if player == game.Players.LocalPlayer then return end
    
    local data = initPlayerData(player)
    if not player.Character then return end
    
    -- تحديث اسمه
    data.Name = player.DisplayName
    data.Username = player.Name
    
    -- فحص boosts الماب
    detectGameBoosts(player)
    
    data.ScanCount = data.ScanCount + 1
    
    -- كل الفحوصات
    local hacks = {}
    
    local flyResult, flyMsg = checkFlyHack(player)
    if flyResult then table.insert(hacks, flyMsg) end
    
    local speedResult, speedMsg = checkSpeedHack(player)
    if speedResult then table.insert(hacks, speedMsg) end
    
    local noclipResult, noclipMsg = checkNoclipHack(player)
    if noclipResult then table.insert(hacks, noclipMsg) end
    
    local teleportResult, teleportMsg = checkTeleportHack(player)
    if teleportResult then table.insert(hacks, teleportMsg) end
    
    local godResult, godMsg = checkGodMode(player)
    if godResult then table.insert(hacks, godMsg) end
    
    -- تحديث الهاكات المؤكدة
    if #hacks > 0 then
        for _, hack in pairs(hacks) do
            if not table.find(data.ConfirmedHacks, hack) then
                table.insert(data.ConfirmedHacks, hack)
            end
        end
        data.IsHacker = true
    end
    
    -- إذا مستوى الشك عالي جداً
    if data.SuspicionLevel >= 60 and not data.IsHacker then
        data.IsHacker = true
        table.insert(data.ConfirmedHacks, "⚠️ سلوك مشبوه جداً")
    end
    
    return data
end

-- بناء قائمة الهاكرز
local function buildHackerList()
    detectedHackers = {}
    
    for userId, data in pairs(playerData) do
        if data.IsHacker and #data.ConfirmedHacks > 0 then
            table.insert(detectedHackers, data)
        end
    end
    
    -- ترتيب حسب مستوى الخطورة
    table.sort(detectedHackers, function(a, b)
        return a.SuspicionLevel > b.SuspicionLevel
    end)
end

-- عرض النتائج
local function buildResults()
    ContentFrame:ClearAllChildren()
    
    if #detectedHackers == 0 then
        local empty = Instance.new("Frame")
        empty.Size = UDim2.new(1, -2, 0, 55)
        empty.BackgroundColor3 = Color3.fromRGB(10, 30, 10)
        empty.BorderSizePixel = 0
        empty.Parent = ContentFrame
        
        local emptyCorner = Instance.new("UICorner")
        emptyCorner.CornerRadius = UDim.new(0, 8)
        emptyCorner.Parent = empty
        
        local emptyText = Instance.new("TextLabel")
        emptyText.Size = UDim2.new(1, 0, 1, 0)
        emptyText.BackgroundTransparency = 1
        emptyText.Text = "✅ السيرفر آمن تماماً\nلا يوجد هاكات مكتشفة"
        emptyText.TextColor3 = Color3.fromRGB(0, 255, 100)
        emptyText.TextSize = 12
        emptyText.Font = Enum.Font.GothamBold
        emptyText.TextWrapped = true
        emptyText.Parent = empty
        
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 60)
        return
    end
    
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -2, 0, 24)
    section.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    section.BorderSizePixel = 0
    section.Parent = ContentFrame
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 12)
    sectionCorner.Parent = section
    
    local sectionText = Instance.new("TextLabel")
    sectionText.Size = UDim2.new(1, -10, 1, 0)
    sectionText.Position = UDim2.new(0, 5, 0, 0)
    sectionText.BackgroundTransparency = 1
    sectionText.Text = "💀 الهاكرز (" .. #detectedHackers .. ")"
    sectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionText.TextSize = 11
    sectionText.Font = Enum.Font.GothamBlack
    sectionText.TextXAlignment = Enum.TextXAlignment.Left
    sectionText.Parent = section
    
    for _, data in pairs(detectedHackers) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -2, 0, 65)
        card.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
        card.BorderSizePixel = 2
        card.BorderColor3 = Color3.fromRGB(255, 0, 0)
        card.Parent = ContentFrame
        
        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 8)
        cardCorner.Parent = card
        
        local name = Instance.new("TextLabel")
        name.Size = UDim2.new(1, -10, 0, 20)
        name.Position = UDim2.new(0, 5, 0, 4)
        name.BackgroundTransparency = 1
        name.Text = "💀 " .. data.Name .. " (@" .. data.Username .. ") ⚠️" .. data.SuspicionLevel .. "%"
        name.TextColor3 = Color3.fromRGB(255, 100, 100)
        name.TextSize = 11
        name.Font = Enum.Font.GothamBlack
        name.TextXAlignment = Enum.TextXAlignment.Left
        name.TextTruncate = Enum.TextTruncate.AtEnd
        name.Parent = card
        
        local hacks = Instance.new("TextLabel")
        hacks.Size = UDim2.new(1, -10, 0, 35)
        hacks.Position = UDim2.new(0, 5, 0, 26)
        hacks.BackgroundTransparency = 1
        hacks.Text = table.concat(data.ConfirmedHacks, "\n")
        hacks.TextColor3 = Color3.fromRGB(255, 150, 150)
        hacks.TextSize = 9
        hacks.Font = Enum.Font.Gotham
        hacks.TextXAlignment = Enum.TextXAlignment.Left
        hacks.TextWrapped = true
        hacks.Parent = card
    end
    
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)
end

-- الفحص الكامل
local function startFullScan()
    if isScanning then return end
    isScanning = true
    
    scanBtn.Text = "🟡 جاري الفحص..."
    scanBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    
    showNotification("🔍 جاري الفحص الشامل...")
    
    -- تصفير القديم
    detectedHackers = {}
    
    -- فحص كل لاعب
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            scanCount = scanCount + 1
            scanPlayer(player)
            task.wait(0.05)
        end
    end
    
    -- بناء القائمة
    buildHackerList()
    totalHacksFound = 0
    for _, data in pairs(detectedHackers) do
        totalHacksFound = totalHacksFound + #data.ConfirmedHacks
    end
    
    buildResults()
    updateStatus()
    
    scanBtn.Text = "🔍 إعادة الفحص"
    scanBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    isScanning = false
    
    if #detectedHackers > 0 then
        showNotification("💀 تم كشف " .. #detectedHackers .. " هاكر!")
    else
        showNotification("✅ السيرفر آمن")
    end
end

-- ========== الأحداث ==========
MainButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then buildResults() end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

scanBtn.MouseButton1Click:Connect(startFullScan)

game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        initPlayerData(player)
        task.wait(1)
        if isScanning then
            scanPlayer(player)
            buildHackerList()
            buildResults()
            updateStatus()
        end
    end
end)

game.Players.PlayerRemoving:Connect(function(player)
    playerData[player.UserId] = nil
    buildHackerList()
    if MainFrame.Visible then buildResults() end
end)

updateStatus()
showNotification("🛡️ Anti-Cheat Pro جاهز!")
