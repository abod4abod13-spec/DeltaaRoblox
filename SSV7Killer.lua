-- 💀 SSV7 Script Destroyer v5 - كاشف الهاكات الذكي النهائي 💀
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local ScriptListFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local StatusLabel = Instance.new("TextLabel")
local KillAllButton = Instance.new("TextButton")
local UICorner4 = Instance.new("UICorner")
local RefreshButton = Instance.new("TextButton")
local UICorner5 = Instance.new("UICorner")
local ConfirmFrame = Instance.new("Frame")
local UICorner6 = Instance.new("UICorner")
local ConfirmText = Instance.new("TextLabel")
local ConfirmYes = Instance.new("TextButton")
local UICorner7 = Instance.new("UICorner")
local ConfirmNo = Instance.new("TextButton")
local UICorner8 = Instance.new("UICorner")
local Notification = Instance.new("Frame")
local UICorner9 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")
local ProgressFrame = Instance.new("Frame")
local UICorner10 = Instance.new("UICorner")
local ProgressBar = Instance.new("Frame")
local UICorner11 = Instance.new("UICorner")
local ProgressText = Instance.new("TextLabel")
local StatsLabel = Instance.new("TextLabel")
local DetailFrame = Instance.new("Frame")
local UICorner12 = Instance.new("UICorner")
local DetailTitle = Instance.new("TextLabel")
local DetailInfo = Instance.new("TextLabel")
local DetailClose = Instance.new("TextButton")
local UICorner13 = Instance.new("UICorner")

-- المتغيرات
local killedCount = 0
local totalScripts = 0
local isKilling = false
local allScripts = {}
local detectedScripts = {}
local scriptTimestamps = {}

-- الأنظمة المحمية فقط (أنظمة Roblox الحيوية)
local PROTECTED_SYSTEMS = {
    "Animate",
    "Health",
    "Respawn",
    "Sound",
    "ControlScript",
    "CameraScript", 
    "ChatScript",
    "PlayerScriptsLoader",
    "RbxCharacterSounds",
    "AnimateLocal",
}

-- إعدادات الشاشة
ScreenGui.Name = "SSV7_Killer_Main"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== الزر الرئيسي ==========
MainButton.Name = "MainButton"
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 110, 0, 34)
MainButton.Position = UDim2.new(0.5, -55, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "💀 SSV7 Killer"
MainButton.TextSize = 12
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 2
MainButton.BorderColor3 = Color3.fromRGB(255, 50, 50)

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = MainButton

-- ========== الواجهة الرئيسية ==========
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 300, 0, 430)
MainFrame.Position = UDim2.new(0.5, -150, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)

UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = MainFrame

-- ========== العنوان ==========
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -80, 0, 30)
Title.Position = UDim2.new(0, 15, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "💀 Script Destroyer v5"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left

-- ========== زر الإغلاق ==========
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -32, 0, 8)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"
CloseButton.TextSize = 13
CloseButton.Font = Enum.Font.GothamBlack
CloseButton.BorderSizePixel = 0

UICorner3.CornerRadius = UDim.new(0, 4)
UICorner3.Parent = CloseButton

-- ========== شريط الحالة ==========
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, -20, 0, 18)
StatusLabel.Position = UDim2.new(0, 10, 0, 40)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🔍 جاهز للفحص..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ========== الإحصائيات ==========
StatsLabel.Parent = MainFrame
StatsLabel.Size = UDim2.new(1, -20, 0, 14)
StatsLabel.Position = UDim2.new(0, 10, 0, 56)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = ""
StatsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatsLabel.TextSize = 9
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ========== أزرار التحكم ==========
KillAllButton.Parent = MainFrame
KillAllButton.Size = UDim2.new(0.55, 0, 0, 32)
KillAllButton.Position = UDim2.new(0, 10, 0, 73)
KillAllButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
KillAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KillAllButton.Text = "💀 إغلاق الكل"
KillAllButton.TextSize = 12
KillAllButton.Font = Enum.Font.GothamBlack
KillAllButton.BorderSizePixel = 0

UICorner4.CornerRadius = UDim.new(0, 6)
UICorner4.Parent = KillAllButton

RefreshButton.Parent = MainFrame
RefreshButton.Size = UDim2.new(0.35, 0, 0, 32)
RefreshButton.Position = UDim2.new(0.6, 10, 0, 73)
RefreshButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
RefreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshButton.Text = "🔄 فحص"
RefreshButton.TextSize = 11
RefreshButton.Font = Enum.Font.GothamBlack
RefreshButton.BorderSizePixel = 0

UICorner5.CornerRadius = UDim.new(0, 6)
UICorner5.Parent = RefreshButton

-- ========== قائمة السكربتات ==========
ScriptListFrame.Parent = MainFrame
ScriptListFrame.Size = UDim2.new(1, -20, 1, -200)
ScriptListFrame.Position = UDim2.new(0, 10, 0, 112)
ScriptListFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ScriptListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptListFrame.ScrollBarThickness = 4
ScriptListFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
ScriptListFrame.BorderSizePixel = 1
ScriptListFrame.BorderColor3 = Color3.fromRGB(30, 30, 30)

UIListLayout.Parent = ScriptListFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

-- ========== نافذة التفاصيل ==========
DetailFrame.Parent = MainFrame
DetailFrame.Size = UDim2.new(1, -20, 0, 120)
DetailFrame.Position = UDim2.new(0, 10, 0.5, -60)
DetailFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
DetailFrame.Visible = false
DetailFrame.BorderSizePixel = 2
DetailFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)
DetailFrame.ZIndex = 25

UICorner12.CornerRadius = UDim.new(0, 8)
UICorner12.Parent = DetailFrame

DetailTitle.Parent = DetailFrame
DetailTitle.Size = UDim2.new(1, -40, 0, 25)
DetailTitle.Position = UDim2.new(0, 10, 0, 5)
DetailTitle.BackgroundTransparency = 1
DetailTitle.Text = "📋 تفاصيل"
DetailTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
DetailTitle.TextSize = 12
DetailTitle.Font = Enum.Font.GothamBlack
DetailTitle.TextXAlignment = Enum.TextXAlignment.Left

DetailClose.Parent = DetailFrame
DetailClose.Size = UDim2.new(0, 20, 0, 20)
DetailClose.Position = UDim2.new(1, -25, 0, 7)
DetailClose.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
DetailClose.TextColor3 = Color3.fromRGB(255, 255, 255)
DetailClose.Text = "✕"
DetailClose.TextSize = 10
DetailClose.Font = Enum.Font.GothamBlack
DetailClose.BorderSizePixel = 0

UICorner13.CornerRadius = UDim.new(0, 4)
UICorner13.Parent = DetailClose

DetailInfo.Parent = DetailFrame
DetailInfo.Size = UDim2.new(1, -20, 1, -40)
DetailInfo.Position = UDim2.new(0, 10, 0, 35)
DetailInfo.BackgroundTransparency = 1
DetailInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
DetailInfo.TextSize = 10
DetailInfo.Font = Enum.Font.Gotham
DetailInfo.TextWrapped = true
DetailInfo.TextXAlignment = Enum.TextXAlignment.Left
DetailInfo.TextYAlignment = Enum.TextYAlignment.Top

-- ========== شريط التقدم ==========
ProgressFrame.Parent = MainFrame
ProgressFrame.Size = UDim2.new(1, -20, 0, 8)
ProgressFrame.Position = UDim2.new(0, 10, 0, 388)
ProgressFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ProgressFrame.Visible = false
ProgressFrame.BorderSizePixel = 0

UICorner10.CornerRadius = UDim.new(0, 4)
UICorner10.Parent = ProgressFrame

ProgressBar.Parent = ProgressFrame
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ProgressBar.BorderSizePixel = 0

UICorner11.CornerRadius = UDim.new(0, 4)
UICorner11.Parent = ProgressBar

ProgressText.Parent = MainFrame
ProgressText.Size = UDim2.new(1, -20, 0, 16)
ProgressText.Position = UDim2.new(0, 10, 0, 400)
ProgressText.BackgroundTransparency = 1
ProgressText.Text = ""
ProgressText.TextColor3 = Color3.fromRGB(255, 255, 255)
ProgressText.TextSize = 9
ProgressText.Font = Enum.Font.Gotham
ProgressText.Visible = false

-- ========== نافذة التأكيد ==========
ConfirmFrame.Parent = MainFrame
ConfirmFrame.Size = UDim2.new(1, -30, 0, 100)
ConfirmFrame.Position = UDim2.new(0, 15, 0.5, -50)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ConfirmFrame.Visible = false
ConfirmFrame.BorderSizePixel = 2
ConfirmFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
ConfirmFrame.ZIndex = 20

UICorner6.CornerRadius = UDim.new(0, 10)
UICorner6.Parent = ConfirmFrame

ConfirmText.Parent = ConfirmFrame
ConfirmText.Size = UDim2.new(1, -20, 0, 35)
ConfirmText.Position = UDim2.new(0, 10, 0, 10)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "⚠️ تحذير!\nسيتم تدمير السكربتات المكتشفة!"
ConfirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmText.TextSize = 11
ConfirmText.Font = Enum.Font.GothamBold
ConfirmText.TextWrapped = true

ConfirmYes.Parent = ConfirmFrame
ConfirmYes.Size = UDim2.new(0.4, 0, 0, 30)
ConfirmYes.Position = UDim2.new(0.08, 0, 0, 55)
ConfirmYes.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
ConfirmYes.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmYes.Text = "✅ تدمير"
ConfirmYes.TextSize = 10
ConfirmYes.Font = Enum.Font.GothamBlack
ConfirmYes.BorderSizePixel = 0

UICorner7.CornerRadius = UDim.new(0, 6)
UICorner7.Parent = ConfirmYes

ConfirmNo.Parent = ConfirmFrame
ConfirmNo.Size = UDim2.new(0.4, 0, 0, 30)
ConfirmNo.Position = UDim2.new(0.52, 0, 0, 55)
ConfirmNo.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ConfirmNo.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmNo.Text = "❌ إلغاء"
ConfirmNo.TextSize = 10
ConfirmNo.Font = Enum.Font.GothamBlack
ConfirmNo.BorderSizePixel = 0

UICorner8.CornerRadius = UDim.new(0, 6)
UICorner8.Parent = ConfirmNo

-- ========== إشعار ==========
Notification.Parent = ScreenGui
Notification.Size = UDim2.new(0, 250, 0, 40)
Notification.Position = UDim2.new(0.5, -125, 0, -45)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(255, 50, 50)
Notification.Visible = false

UICorner9.CornerRadius = UDim.new(0, 8)
UICorner9.Parent = Notification

NotificationText.Parent = Notification
NotificationText.Size = UDim2.new(1, -16, 1, 0)
NotificationText.Position = UDim2.new(0, 8, 0, 0)
NotificationText.BackgroundTransparency = 1
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 12
NotificationText.Font = Enum.Font.GothamBold
NotificationText.TextWrapped = true

-- ========== الوظائف الذكية ==========

-- تحليل السكربت (هل هو هاك أم آمن)
local function analyzeScript(scriptObj, scriptName)
    local name = scriptObj.Name:lower()
    local parentName = scriptObj.Parent and scriptObj.Parent.Name:lower() or ""
    
    -- علامات الهاك
    local hackKeywords = {
        "hack", "cheat", "exploit", "inject", "bypass", "aimbot", "esp",
        "wallhack", "speedhack", "fly", "noclip", "teleport", "autofarm",
        "killaura", "triggerbot", "bunnyhop", "spinbot", "godmode",
        "infinite", "unlock", "crack", "premium", "free", "ssv7",
        "vr7", "v7", "ssv", "ss", "vx", "zen", "kyro", "nexus",
        "phantom", "eclipse", "venom", "cobra", "viper", "dragon",
        "shadow", "ghost", "hacker", "mod", "menu", "script",
        "gui", "ui", "panel", "hub", "ware", "tool", "op",
        "pro", "mega", "ultra", "super", "alpha", "omega",
        "lycan", "inje", "tp", "kill", "aura", "esp",
        "nametag", "tracer", "chams", "glow", "skeleton",
    }
    
    -- علامات الأمان
    local safeKeywords = {
        "animate", "health", "respawn", "sound", "camera",
        "chat", "control", "player", "character", "starter",
        "rbx", "roblox", "official", "system", "core",
        "movement", "physics", "terrain", "lighting",
        "hd admin", "admin", "mod", "adonis", "kohls",
    }
    
    local isHack = false
    local isSafe = false
    local confidence = 0
    
    -- فحص الاسم
    for _, keyword in pairs(hackKeywords) do
        if name:find(keyword) or parentName:find(keyword) then
            isHack = true
            confidence = confidence + 20
        end
    end
    
    for _, keyword in pairs(safeKeywords) do
        if name:find(keyword) or parentName:find(keyword) then
            isSafe = true
            confidence = confidence - 15
        end
    end
    
    -- فحص النوع
    if scriptObj:IsA("ScreenGui") then
        if name:find("roblox") or name:find("core") then
            isSafe = true
        else
            confidence = confidence + 10
        end
    end
    
    if scriptObj:IsA("LocalScript") and scriptObj.Parent == game.Players.LocalPlayer:FindFirstChild("PlayerScripts") then
        if not isSafe then
            confidence = confidence + 15
        end
    end
    
    -- الأنظمة المحمية
    for _, sysName in pairs(PROTECTED_SYSTEMS) do
        if scriptObj.Name == sysName then
            isSafe = true
            isHack = false
            confidence = -100
            break
        end
    end
    
    -- تحديد النتيجة
    local status = "🟡 مشبوه"
    if isSafe and confidence <= 0 then
        status = "🟢 آمن"
    elseif isHack and confidence >= 30 then
        status = "🔴 هاك"
    elseif confidence >= 20 then
        status = "🟠 خطر"
    end
    
    return status, confidence
end

-- الحصول على وقت الاكتشاف
local function getDetectionTime(scriptObj)
    local key = scriptObj.Name .. "_" .. (scriptObj.ClassName or "")
    if scriptTimestamps[key] then
        return scriptTimestamps[key]
    else
        local currentTime = os.date("%H:%M:%S")
        scriptTimestamps[key] = currentTime
        return currentTime
    end
end

-- فحص شامل لكل شيء
local function deepScan()
    local scripts = {}
    local localPlayer = game.Players.LocalPlayer
    
    -- فحص PlayerGui
    local playerGui = localPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, child in pairs(playerGui:GetChildren()) do
            if child:IsA("ScreenGui") and child ~= ScreenGui then
                local status, conf = analyzeScript(child, child.Name)
                local scriptCount = 0
                for _, sub in pairs(child:GetDescendants()) do
                    if sub:IsA("LocalScript") or sub:IsA("Script") then
                        scriptCount = scriptCount + 1
                    end
                end
                table.insert(scripts, {
                    Name = child.Name,
                    Object = child,
                    Type = "🖥 ScreenGui",
                    Status = status,
                    Confidence = conf,
                    ScriptCount = scriptCount,
                    Time = getDetectionTime(child),
                    Parent = "PlayerGui",
                    Size = #child:GetChildren() .. " عناصر"
                })
            end
        end
    end
    
    -- فحص PlayerScripts
    local playerScripts = localPlayer:FindFirstChild("PlayerScripts")
    if playerScripts then
        for _, child in pairs(playerScripts:GetChildren()) do
            if child:IsA("LocalScript") or child:IsA("Script") or child:IsA("ModuleScript") then
                if not isSystemScript(child) then
                    local status, conf = analyzeScript(child, child.Name)
                    local scriptType = child:IsA("ModuleScript") and "📦 Module" or "📜 Script"
                    table.insert(scripts, {
                        Name = child.Name,
                        Object = child,
                        Type = scriptType,
                        Status = status,
                        Confidence = conf,
                        ScriptCount = 1,
                        Time = getDetectionTime(child),
                        Parent = "PlayerScripts",
                        Size = child:GetFullName()
                    })
                end
            end
        end
    end
    
    -- فحص Character
    local character = localPlayer.Character
    if character then
        for _, child in pairs(character:GetChildren()) do
            if (child:IsA("LocalScript") or child:IsA("Script") or child:IsA("ScreenGui")) and not isSystemScript(child) then
                local status, conf = analyzeScript(child, child.Name)
                table.insert(scripts, {
                    Name = child.Name,
                    Object = child,
                    Type = "👤 Character",
                    Status = status,
                    Confidence = conf,
                    ScriptCount = 1,
                    Time = getDetectionTime(child),
                    Parent = "Character",
                    Size = child.ClassName
                })
            end
        end
    end
    
    -- فحص Backpack
    local backpack = localPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, tool in pairs(backpack:GetChildren()) do
            for _, child in pairs(tool:GetDescendants()) do
                if (child:IsA("LocalScript") or child:IsA("Script")) and not isSystemScript(child) then
                    local status, conf = analyzeScript(child, child.Name)
                    table.insert(scripts, {
                        Name = tool.Name .. " > " .. child.Name,
                        Object = child,
                        Type = "🎒 Tool",
                        Status = status,
                        Confidence = conf,
                        ScriptCount = 1,
                        Time = getDetectionTime(child),
                        Parent = "Backpack",
                        Size = tool.Name
                    })
                end
            end
        end
    end
    
    -- ترتيب حسب الخطورة
    table.sort(scripts, function(a, b)
        if a.Status == "🔴 هاك" and b.Status ~= "🔴 هاك" then return true end
        if a.Status == "🟠 خطر" and b.Status ~= "🔴 هاك" and b.Status ~= "🟠 خطر" then return true end
        return a.Confidence > b.Confidence
    end)
    
    return scripts
end

-- التحقق من النظام
function isSystemScript(scriptObj)
    for _, sysName in pairs(PROTECTED_SYSTEMS) do
        if scriptObj.Name == sysName then
            return true
        end
    end
    return false
end

-- تدمير سكربت
local function destroyScript(scriptData)
    local success = pcall(function()
        if scriptData.Object and scriptData.Object.Parent then
            scriptData.Object:Destroy()
            return true
        end
    end)
    return success
end

-- إظهار التفاصيل
local function showDetails(scriptData)
    DetailTitle.Text = "📋 " .. scriptData.Name
    DetailInfo.Text = "📌 الاسم: " .. scriptData.Name .. "\n"
    DetailInfo.Text = DetailInfo.Text .. "📦 النوع: " .. scriptData.Type .. "\n"
    DetailInfo.Text = DetailInfo.Text .. "⚡ الحالة: " .. scriptData.Status .. "\n"
    DetailInfo.Text = DetailInfo.Text .. "📊 الثقة: " .. scriptData.Confidence .. "%\n"
    DetailInfo.Text = DetailInfo.Text .. "🕐 وقت الاكتشاف: " .. scriptData.Time .. "\n"
    DetailInfo.Text = DetailInfo.Text .. "📍 الموقع: " .. scriptData.Parent .. "\n"
    DetailInfo.Text = DetailInfo.Text .. "📏 الحجم: " .. scriptData.Size .. "\n"
    DetailInfo.Text = DetailInfo.Text .. "🔢 السكربتات: " .. scriptData.ScriptCount
    DetailFrame.Visible = true
end

-- تحديث قائمة السكربتات
local function updateScriptList()
    for _, child in pairs(ScriptListFrame:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    allScripts = deepScan()
    totalScripts = #allScripts
    
    local hackCount = 0
    local safeCount = 0
    local suspiciousCount = 0
    
    for _, s in pairs(allScripts) do
        if s.Status == "🔴 هاك" then hackCount = hackCount + 1
        elseif s.Status == "🟢 آمن" then safeCount = safeCount + 1
        else suspiciousCount = suspiciousCount + 1 end
    end
    
    StatsLabel.Text = "🔴 هاكات: " .. hackCount .. " | 🟡 مشبوه: " .. suspiciousCount .. " | 🟢 آمن: " .. safeCount
    StatusLabel.Text = totalScripts > 0 and "🔍 تم اكتشاف " .. totalScripts .. " عنصر" or "✅ لا توجد عناصر"
    StatusLabel.TextColor3 = hackCount > 0 and Color3.fromRGB(255, 80, 80) or (totalScripts > 0 and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 255, 100))
    
    if totalScripts == 0 then
        local emptyFrame = Instance.new("Frame")
        emptyFrame.Parent = ScriptListFrame
        emptyFrame.Size = UDim2.new(1, -6, 0, 50)
        emptyFrame.Position = UDim2.new(0, 3, 0, 0)
        emptyFrame.BackgroundColor3 = Color3.fromRGB(20, 35, 20)
        emptyFrame.BorderSizePixel = 0
        
        local emptyCorner = Instance.new("UICorner")
        emptyCorner.CornerRadius = UDim.new(0, 4)
        emptyCorner.Parent = emptyFrame
        
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Parent = emptyFrame
        emptyLabel.Size = UDim2.new(1, 0, 1, 0)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.Text = "✅ لا توجد عناصر مكتشفة"
        emptyLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        emptyLabel.TextSize = 12
        emptyLabel.Font = Enum.Font.GothamBold
        emptyLabel.TextWrapped = true
        
        ScriptListFrame.CanvasSize = UDim2.new(0, 0, 0, 55)
        return
    end
    
    for _, scriptData in pairs(allScripts) do
        local bgColor = Color3.fromRGB(25, 25, 25)
        local borderColor = Color3.fromRGB(60, 60, 60)
        
        if scriptData.Status == "🔴 هاك" then
            bgColor = Color3.fromRGB(40, 10, 10)
            borderColor = Color3.fromRGB(255, 30, 30)
        elseif scriptData.Status == "🟠 خطر" then
            bgColor = Color3.fromRGB(40, 25, 0)
            borderColor = Color3.fromRGB(255, 150, 0)
        elseif scriptData.Status == "🟢 آمن" then
            bgColor = Color3.fromRGB(10, 35, 10)
            borderColor = Color3.fromRGB(0, 200, 0)
        elseif scriptData.Status == "🟡 مشبوه" then
            bgColor = Color3.fromRGB(35, 35, 0)
            borderColor = Color3.fromRGB(200, 200, 0)
        end
        
        local scriptFrame = Instance.new("Frame")
        scriptFrame.Parent = ScriptListFrame
        scriptFrame.Size = UDim2.new(1, -6, 0, 50)
        scriptFrame.Position = UDim2.new(0, 3, 0, 0)
        scriptFrame.BackgroundColor3 = bgColor
        scriptFrame.BorderSizePixel = 1
        scriptFrame.BorderColor3 = borderColor
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 4)
        frameCorner.Parent = scriptFrame
        
        -- أيقونة الحالة
        local statusIcon = Instance.new("TextLabel")
        statusIcon.Parent = scriptFrame
        statusIcon.Size = UDim2.new(0, 30, 0, 30)
        statusIcon.Position = UDim2.new(0, 5, 0, 10)
        statusIcon.BackgroundTransparency = 1
        statusIcon.Text = scriptData.Status
        statusIcon.TextSize = 16
        statusIcon.Font = Enum.Font.Gotham
        
        -- اسم السكربت
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = scriptFrame
        nameLabel.Size = UDim2.new(1, -80, 0, 16)
        nameLabel.Position = UDim2.new(0, 40, 0, 4)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = scriptData.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 11
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        
        -- معلومات
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Parent = scriptFrame
        infoLabel.Size = UDim2.new(1, -80, 0, 12)
        infoLabel.Position = UDim2.new(0, 40, 0, 20)
        infoLabel.BackgroundTransparency = 1
        infoLabel.Text = scriptData.Type .. " | 🕐 " .. scriptData.Time .. " | " .. scriptData.ScriptCount .. " عناصر"
        infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        infoLabel.TextSize = 8
        infoLabel.Font = Enum.Font.Gotham
        infoLabel.TextXAlignment = Enum.TextXAlignment.Left
        infoLabel.TextTruncate = Enum.TextTruncate.AtEnd
        
        -- معلومات إضافية
        local detailLabel = Instance.new("TextLabel")
        detailLabel.Parent = scriptFrame
        detailLabel.Size = UDim2.new(1, -80, 0, 12)
        detailLabel.Position = UDim2.new(0, 40, 0, 33)
        detailLabel.BackgroundTransparency = 1
        detailLabel.Text = "📍 " .. scriptData.Parent .. " | ثقة: " .. scriptData.Confidence .. "%"
        detailLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
        detailLabel.TextSize = 8
        detailLabel.Font = Enum.Font.Gotham
        detailLabel.TextXAlignment = Enum.TextXAlignment.Left
        detailLabel.TextTruncate = Enum.TextTruncate.AtEnd
        
        -- زر التفاصيل
        local infoButton = Instance.new("TextButton")
        infoButton.Parent = scriptFrame
        infoButton.Size = UDim2.new(0, 28, 0, 20)
        infoButton.Position = UDim2.new(1, -88, 0, 15)
        infoButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        infoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        infoButton.Text = "ℹ️"
        infoButton.TextSize = 12
        infoButton.Font = Enum.Font.GothamBold
        infoButton.BorderSizePixel = 0
        
        local infoBtnCorner = Instance.new("UICorner")
        infoBtnCorner.CornerRadius = UDim.new(0, 4)
        infoBtnCorner.Parent = infoButton
        
        infoButton.MouseButton1Click:Connect(function()
            showDetails(scriptData)
        end)
        
        -- زر التدمير
        local killButton = Instance.new("TextButton")
        killButton.Parent = scriptFrame
        killButton.Size = UDim2.new(0, 50, 0, 20)
        killButton.Position = UDim2.new(1, -56, 0, 15)
        killButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        killButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        killButton.Text = "🗑 حذف"
        killButton.TextSize = 9
        killButton.Font = Enum.Font.GothamBold
        killButton.BorderSizePixel = 0
        
        local killCorner = Instance.new("UICorner")
        killCorner.CornerRadius = UDim.new(0, 4)
        killCorner.Parent = killButton
        
        killButton.MouseButton1Click:Connect(function()
            local success = destroyScript(scriptData)
            if success then
                killedCount = killedCount + 1
                showNotification("🗑 تم حذف: " .. scriptData.Name)
            else
                showNotification("⚠️ فشل حذف: " .. scriptData.Name)
            end
            task.wait(0.3)
            updateScriptList()
        end)
        
        -- تأثيرات التحويم
        infoButton.MouseEnter:Connect(function()
            infoButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        end)
        infoButton.MouseLeave:Connect(function()
            infoButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        end)
        
        killButton.MouseEnter:Connect(function()
            killButton.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
        end)
        killButton.MouseLeave:Connect(function()
            killButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        end)
    end
    
    ScriptListFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

-- تدمير جميع السكربتات
local function killAllScripts()
    if isKilling then return end
    isKilling = true
    
    allScripts = deepScan()
    totalScripts = #allScripts
    killedCount = 0
    
    if totalScripts == 0 then
        showNotification("✅ لا توجد عناصر للتدمير")
        isKilling = false
        return
    end
    
    ProgressFrame.Visible = true
    ProgressText.Visible = true
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    KillAllButton.Interactable = false
    RefreshButton.Interactable = false
    
    for i, scriptData in pairs(allScripts) do
        destroyScript(scriptData)
        killedCount = killedCount + 1
        
        local progress = i / totalScripts
        ProgressBar.Size = UDim2.new(progress, 0, 1, 0)
        ProgressText.Text = "💀 جاري التدمير... " .. i .. "/" .. totalScripts
        StatusLabel.Text = "💀 جاري التدمير... " .. i .. "/" .. totalScripts
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        
        task.wait(0.02)
    end
    
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    
    local resultText = "✅ تم تدمير " .. killedCount .. " عنصر"
    ProgressText.Text = resultText
    StatusLabel.Text = resultText
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    
    showNotification(resultText)
    
    task.wait(3)
    ProgressFrame.Visible = false
    ProgressText.Visible = false
    ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    KillAllButton.Interactable = true
    RefreshButton.Interactable = true
    isKilling = false
    
    updateScriptList()
end

-- إظهار إشعار
local function showNotification(text)
    NotificationText.Text = text
    Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -125, 0, -45)
    
    spawn(function()
        for i = 1, 8 do
            Notification.Position = UDim2.new(0.5, -125, 0, -45 + (i * 6))
            task.wait(0.01)
        end
        task.wait(1.5)
        for i = 1, 8 do
            Notification.Position = UDim2.new(0.5, -125, 0, 3 - (i * 6))
            task.wait(0.01)
        end
        Notification.Visible = false
    end)
end

-- ========== الأحداث ==========
MainButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then updateScriptList() end
end)

CloseButton.MouseButton1Click:Connect(function()
    ConfirmText.Text = "⚠️ هل تريد إغلاق أداة SSV7 Killer؟"
    ConfirmFrame.Visible = true
end)

DetailClose.MouseButton1Click:Connect(function()
    DetailFrame.Visible = false
end)

KillAllButton.MouseButton1Click:Connect(function()
    local scripts = deepScan()
    if #scripts == 0 then
        showNotification("✅ لا توجد عناصر")
        return
    end
    ConfirmText.Text = "⚠️ سيتم تدمير " .. #scripts .. " عنصر!"
    ConfirmFrame.Visible = true
end)

RefreshButton.MouseButton1Click:Connect(function()
    updateScriptList()
    showNotification("🔄 فحص شامل اكتمل - " .. totalScripts .. " عنصر")
end)

ConfirmYes.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = false
    if ConfirmText.Text:find("إغلاق أداة") then
        showNotification("👋 تم إغلاق SSV7 Killer")
        task.wait(0.5)
        ScreenGui:Destroy()
    else
        killAllScripts()
    end
end)

ConfirmNo.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = false
end)

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        if ConfirmFrame.Visible then ConfirmFrame.Visible = false end
        if DetailFrame.Visible then DetailFrame.Visible = false end
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if MainFrame.Visible then
        task.wait(0.5)
        updateScriptList()
    end
end)

updateScriptList()
showNotification("💀 SSV7 Killer v5 جاهز!")
