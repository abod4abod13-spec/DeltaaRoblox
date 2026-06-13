-- إنشاء واجهة التحكم المحمية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateRedESP"
ScreenGui.Parent = game.CoreGui

-- المربع الرئيسي (أحمر لامع وقابل للسحب)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 110)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true -- سحب وتحريك القائمة بالماوس

-- تأثير لمعان القائمة الرئيسية
local UIGradient = Instance.new("UIGradient", Frame)
UIGradient.Color = ColorSequence.new({
 ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 120)),
 ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)),
 ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 0, 0))
})
UIGradient.Rotation = 45

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

-- تعديل النص إلى LYCAN 🔴
local Label = Instance.new("TextLabel", Frame)
Label.Size = UDim2.new(1, 0, 0.4, 0)
Label.BackgroundTransparency = 1
Label.Text = "ESP SSV7" -- تم التغيير هنا
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextSize = 24
Label.Font = Enum.Font.GothamBold

-- زر التشغيل
local StartBtn = Instance.new("TextButton", Frame)
StartBtn.Size = UDim2.new(0.4, 0, 0.35, 0)
StartBtn.Position = UDim2.new(0.08, 0, 0.5, 0)
StartBtn.Text = "تشغيل"
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
StartBtn.Font = Enum.Font.GothamBold

local StartCorner = Instance.new("UICorner", StartBtn)
StartCorner.CornerRadius = UDim.new(0, 6)

-- زر الإيقاف
local StopBtn = Instance.new("TextButton", Frame)
StopBtn.Size = UDim2.new(0.4, 0, 0.35, 0)
StopBtn.Position = UDim2.new(0.52, 0, 0.5, 0)
StopBtn.Text = "إيقاف"
StopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
StopBtn.Font = Enum.Font.GothamBold

local StopCorner = Instance.new("UICorner", StopBtn)
StopCorner.CornerRadius = UDim.new(0, 6)

--- سورس الكشف المزدوج (خطوط + أجساد حمراء لامعة) ---

local espEnabled = false
local tracers = {}
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- دالة لتحديث الهالة الحمراء اللامعة حول الجسد
local function updateBodyHighlight(player, character)
    local highlight = character:FindFirstChild("ESPHighlight")
    if espEnabled then
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "ESPHighlight"
            highlight.Parent = character
        end
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- لون أحمر لامع للجسد
        highlight.FillTransparency = 0.3 -- حشو أحمر واضح
        highlight.OutlineColor = Color3.fromRGB(255, 50, 50) -- حواف حمراء مضيئة
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- تظهر من خلف الجدران
    else
        if highlight then
            highlight:Destroy()
        end
    end
end

-- دالة إنشاء الخطوط لكل لاعب
local function createESP(player)
    if player == LocalPlayer then return end
    
    -- إنشاء الخط
    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Color3.fromRGB(255, 0, 0) -- خط أحمر
    line.Thickness = 2
    tracers[player] = line

    -- مراقبة رسبون الشخصية لتطبيق اللون الأحمر اللامع عليها
    player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if espEnabled then updateBodyHighlight(player, char) end
    end)
    
    if player.Character then
        updateBodyHighlight(player, player.Character)
    end
end

-- تفعيل للاعبين الحاليين والجدد
for _, player in pairs(Players:GetPlayers()) do createESP(player) end
Players.PlayerAdded:Connect(createESP)

-- تنظيف عند خروج اللاعب
Players.PlayerRemoving:Connect(function(player)
    if tracers[player] then
        tracers[player]:Destroy()
        tracers[player] = nil
    end
end)

-- التحديث المستمر (كل فريم)
RunService.RenderStepped:Connect(function()
    for player, line in pairs(tracers) do
        if espEnabled and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            
            -- تحديث الخطوط
            if onScreen then
                line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                line.To = Vector2.new(headPos.X, headPos.Y)
                line.Visible = true
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end)

-- أزرار التشغيل والإيقاف
StartBtn.MouseButton1Click:Connect(function() 
    espEnabled = true 
    StartBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    StopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    
    -- تشغيل إضاءة الأجساد فوراً للجميع
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then updateBodyHighlight(player, player.Character) end
    end
end)

StopBtn.MouseButton1Click:Connect(function() 
    espEnabled = false 
    StartBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    StopBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    -- إيقاف إضاءة الأجساد فوراً للجميع
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then updateBodyHighlight(player, player.Character) end
    end
end)
