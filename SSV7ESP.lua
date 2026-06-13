-- ⚡ SSV7 ESP - الإصدار المحمول الأسطوري ⚡
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local ToggleESPButton = Instance.new("TextButton")
local UICorner4 = Instance.new("UICorner")
local GradientToggle = Instance.new("UIGradient")
local ColorSectionLabel = Instance.new("TextLabel")
local RainbowButton = Instance.new("TextButton")
local UICorner5 = Instance.new("UICorner")
local GradientRainbow = Instance.new("UIGradient")
local ColorScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local CustomColorLabel = Instance.new("TextLabel")
local ColorPickerR = Instance.new("TextBox")
local UICorner15 = Instance.new("UICorner")
local ColorPickerG = Instance.new("TextBox")
local UICorner16 = Instance.new("UICorner")
local ColorPickerB = Instance.new("TextBox")
local UICorner17 = Instance.new("UICorner")
local ApplyCustomButton = Instance.new("TextButton")
local UICorner18 = Instance.new("UICorner")
local SettingsLabel = Instance.new("TextLabel")
local ShowNamesToggle = Instance.new("TextButton")
local UICorner19 = Instance.new("UICorner")
local ShowDistanceToggle = Instance.new("TextButton")
local UICorner20 = Instance.new("UICorner")
local ShowHealthToggle = Instance.new("TextButton")
local UICorner21 = Instance.new("UICorner")
local ShowBoxToggle = Instance.new("TextButton")
local UICorner22 = Instance.new("UICorner")
local ShowTracerToggle = Instance.new("TextButton")
local UICorner23 = Instance.new("UICorner")
local ShowTeamToggle = Instance.new("TextButton")
local UICorner24 = Instance.new("UICorner")
local ShowWeaponToggle = Instance.new("TextButton")
local UICorner25 = Instance.new("UICorner")
local ShowSkeletonToggle = Instance.new("TextButton")
local UICorner26 = Instance.new("UICorner")
local ShowChamsToggle = Instance.new("TextButton")
local UICorner27 = Instance.new("UICorner")
local ShowGlowToggle = Instance.new("TextButton")
local UICorner28 = Instance.new("UICorner")
local ShowAimbotDot = Instance.new("TextButton")
local UICorner29 = Instance.new("UICorner")
local ThicknessLabel = Instance.new("TextLabel")
local ThicknessSlider = Instance.new("TextBox")
local UICorner30 = Instance.new("UICorner")
local TransparencyLabel = Instance.new("TextLabel")
local TransparencySlider = Instance.new("TextBox")
local UICorner31 = Instance.new("UICorner")
local MaxDistanceLabel = Instance.new("TextLabel")
local MaxDistanceSlider = Instance.new("TextBox")
local UICorner32 = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")
local PlayerCountLabel = Instance.new("TextLabel")
local Notification = Instance.new("Frame")
local NotificationCorner = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")

-- المتغيرات
local espEnabled = false
local espObjects = {}
local currentColor = Color3.fromRGB(255, 0, 0)
local isRainbow = false
local showNames = true
local showDistance = true
local showHealth = true
local showBox = true
local showTracer = true
local showTeam = false
local showWeapon = false
local showSkeleton = false
local showChams = false
local showGlow = false
local showAimbotDot = false
local lineThickness = 2
local fillTransparency = 0.3
local maxDistance = 500
local rainbowHue = 0
local notificationDebounce = false

-- جميع الألوان
local colorPresets = {
    {Name = "🔴 أحمر", Color = Color3.fromRGB(255, 0, 0)},
    {Name = "🔵 أزرق", Color = Color3.fromRGB(0, 100, 255)},
    {Name = "🟢 أخضر", Color = Color3.fromRGB(0, 255, 0)},
    {Name = "🟣 بنفسجي", Color = Color3.fromRGB(150, 0, 255)},
    {Name = "🟡 أصفر", Color = Color3.fromRGB(255, 255, 0)},
    {Name = "🩵 سماوي", Color = Color3.fromRGB(0, 255, 255)},
    {Name = "⚪ أبيض", Color = Color3.fromRGB(255, 255, 255)},
    {Name = "🟠 برتقالي", Color = Color3.fromRGB(255, 150, 0)},
    {Name = "🩷 وردي", Color = Color3.fromRGB(255, 105, 180)},
    {Name = "🟤 بني", Color = Color3.fromRGB(139, 69, 19)},
    {Name = "🩶 رمادي", Color = Color3.fromRGB(128, 128, 128)},
    {Name = "💚 ليموني", Color = Color3.fromRGB(50, 205, 50)},
    {Name = "💙 نيلي", Color = Color3.fromRGB(75, 0, 130)},
    {Name = "💛 ذهبي", Color = Color3.fromRGB(255, 215, 0)},
    {Name = "🤍 فضي", Color = Color3.fromRGB(192, 192, 192)},
    {Name = "❤️ قرمزي", Color = Color3.fromRGB(220, 20, 60)},
    {Name = "💗 مرجاني", Color = Color3.fromRGB(255, 127, 80)},
    {Name = "💖 فوشيا", Color = Color3.fromRGB(255, 0, 255)},
    {Name = "💜 أرجواني", Color = Color3.fromRGB(128, 0, 128)},
    {Name = "💙 كحلي", Color = Color3.fromRGB(0, 0, 128)},
    {Name = "💚 زيتوني", Color = Color3.fromRGB(128, 128, 0)},
    {Name = "🤎 نحاسي", Color = Color3.fromRGB(184, 115, 51)},
    {Name = "💛 عنبري", Color = Color3.fromRGB(255, 191, 0)},
    {Name = "🧡 ياقوتي", Color = Color3.fromRGB(224, 17, 95)},
    {Name = "💙 فيروزي", Color = Color3.fromRGB(64, 224, 208)},
    {Name = "💚 زمردي", Color = Color3.fromRGB(0, 168, 107)},
    {Name = "🖤 فحمي", Color = Color3.fromRGB(54, 69, 79)},
    {Name = "🤍 لؤلؤي", Color = Color3.fromRGB(240, 234, 214)},
    {Name = "🧡 خوخي", Color = Color3.fromRGB(255, 218, 185)},
    {Name = "💝 سلمون", Color = Color3.fromRGB(250, 128, 114)},
}

-- إعدادات الشاشة
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ========== الزر الرئيسي ==========
MainButton.Name = "MainButton"
MainButton.Parent = ScreenGui
MainButton.Size = UDim2.new(0, 120, 0, 38)
MainButton.Position = UDim2.new(0.5, -60, 0, 15)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "👁️ SSV7 ESP"
MainButton.TextSize = 14
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 2
MainButton.BorderColor3 = Color3.fromRGB(255, 0, 255)

UICorner.CornerRadius = UDim.new(0, 19)
UICorner.Parent = MainButton

-- ========== القائمة الرئيسية (مصغرة للجوال) ==========
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 290, 0, 440)
MainFrame.Position = UDim2.new(0.5, -145, 0, 60)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 255)

UICorner2.CornerRadius = UDim.new(0, 12)
UICorner2.Parent = MainFrame

-- ========== إشعار ==========
Notification.Name = "Notification"
Notification.Parent = ScreenGui
Notification.Size = UDim2.new(0, 260, 0, 50)
Notification.Position = UDim2.new(1, -270, 0, -60)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(255, 0, 255)
Notification.Visible = false

NotificationCorner.CornerRadius = UDim.new(0, 10)
NotificationCorner.Parent = Notification

NotificationText.Parent = Notification
NotificationText.Size = UDim2.new(1, -16, 1, -8)
NotificationText.Position = UDim2.new(0, 8, 0, 4)
NotificationText.BackgroundTransparency = 1
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 13
NotificationText.Font = Enum.Font.GothamBold
NotificationText.TextWrapped = true

-- ========== العنوان ==========
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 32)
Title.Position = UDim2.new(0, 20, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "👁️ SSV7 ESP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left

-- ========== زر الإغلاق ==========
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 26, 0, 26)
CloseButton.Position = UDim2.new(1, -32, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBlack
CloseButton.BorderSizePixel = 0

UICorner3.CornerRadius = UDim.new(0, 13)
UICorner3.Parent = CloseButton

-- ========== زر تشغيل/إيقاف ESP ==========
ToggleESPButton.Parent = MainFrame
ToggleESPButton.Size = UDim2.new(1, -24, 0, 36)
ToggleESPButton.Position = UDim2.new(0, 12, 0, 40)
ToggleESPButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleESPButton.Text = "🔴 ESP متوقف"
ToggleESPButton.TextSize = 14
ToggleESPButton.Font = Enum.Font.GothamBlack
ToggleESPButton.BorderSizePixel = 0

UICorner4.CornerRadius = UDim.new(0, 18)
UICorner4.Parent = ToggleESPButton

GradientToggle.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 0))
})
GradientToggle.Parent = ToggleESPButton

-- ========== قسم الألوان ==========
ColorSectionLabel.Parent = MainFrame
ColorSectionLabel.Size = UDim2.new(1, -24, 0, 16)
ColorSectionLabel.Position = UDim2.new(0, 12, 0, 80)
ColorSectionLabel.BackgroundTransparency = 1
ColorSectionLabel.Text = "🎨 اختر اللون:"
ColorSectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorSectionLabel.TextSize = 11
ColorSectionLabel.Font = Enum.Font.GothamBold
ColorSectionLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ========== زر قوس قزح ==========
RainbowButton.Parent = MainFrame
RainbowButton.Size = UDim2.new(1, -24, 0, 28)
RainbowButton.Position = UDim2.new(0, 12, 0, 100)
RainbowButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
RainbowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RainbowButton.Text = "🌈 قوس قزح"
RainbowButton.TextSize = 12
RainbowButton.Font = Enum.Font.GothamBlack
RainbowButton.BorderSizePixel = 1
RainbowButton.BorderColor3 = Color3.fromRGB(255, 255, 255)

UICorner5.CornerRadius = UDim.new(0, 14)
UICorner5.Parent = RainbowButton

GradientRainbow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})
GradientRainbow.Transparency = NumberSequence.new(0.8)
GradientRainbow.Parent = RainbowButton

-- ========== سكرول الألوان ==========
ColorScrollFrame.Parent = MainFrame
ColorScrollFrame.Size = UDim2.new(1, -24, 0, 85)
ColorScrollFrame.Position = UDim2.new(0, 12, 0, 132)
ColorScrollFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
ColorScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ColorScrollFrame.ScrollBarThickness = 5
ColorScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 255)
ColorScrollFrame.BorderSizePixel = 1
ColorScrollFrame.BorderColor3 = Color3.fromRGB(255, 0, 255)

UICorner30.CornerRadius = UDim.new(0, 8)
UICorner30.Parent = ColorScrollFrame

UIListLayout.Parent = ColorScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

-- إضافة الألوان للسكرول
for _, colorData in pairs(colorPresets) do
    local ColorButton = Instance.new("TextButton")
    ColorButton.Parent = ColorScrollFrame
    ColorButton.Size = UDim2.new(1, -8, 0, 26)
    ColorButton.Position = UDim2.new(0, 4, 0, 0)
    ColorButton.BackgroundColor3 = colorData.Color
    ColorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ColorButton.Text = colorData.Name
    ColorButton.TextSize = 11
    ColorButton.Font = Enum.Font.GothamBold
    ColorButton.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 13)
    btnCorner.Parent = ColorButton
    
    ColorButton.MouseButton1Click:Connect(function()
        isRainbow = false
        currentColor = colorData.Color
        RainbowButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        RainbowButton.Text = "🌈 قوس قزح"
        showNotification("🎨 " .. colorData.Name)
    end)
end

ColorScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 8)

-- ========== لون مخصص ==========
CustomColorLabel.Parent = MainFrame
CustomColorLabel.Size = UDim2.new(1, -24, 0, 14)
CustomColorLabel.Position = UDim2.new(0, 12, 0, 220)
CustomColorLabel.BackgroundTransparency = 1
CustomColorLabel.Text = "🎨 لون RGB:"
CustomColorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CustomColorLabel.TextSize = 10
CustomColorLabel.Font = Enum.Font.GothamBold
CustomColorLabel.TextXAlignment = Enum.TextXAlignment.Left

ColorPickerR.Parent = MainFrame
ColorPickerR.Size = UDim2.new(0.22, 0, 0, 24)
ColorPickerR.Position = UDim2.new(0, 12, 0, 236)
ColorPickerR.BackgroundColor3 = Color3.fromRGB(35, 0, 0)
ColorPickerR.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorPickerR.PlaceholderText = "R"
ColorPickerR.PlaceholderColor3 = Color3.fromRGB(255, 120, 120)
ColorPickerR.Text = ""
ColorPickerR.TextSize = 13
ColorPickerR.Font = Enum.Font.GothamBold
ColorPickerR.BorderSizePixel = 1
ColorPickerR.BorderColor3 = Color3.fromRGB(255, 0, 0)

UICorner15.CornerRadius = UDim.new(0, 6)
UICorner15.Parent = ColorPickerR

ColorPickerG.Parent = MainFrame
ColorPickerG.Size = UDim2.new(0.22, 0, 0, 24)
ColorPickerG.Position = UDim2.new(0.28, 12, 0, 236)
ColorPickerG.BackgroundColor3 = Color3.fromRGB(0, 35, 0)
ColorPickerG.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorPickerG.PlaceholderText = "G"
ColorPickerG.PlaceholderColor3 = Color3.fromRGB(120, 255, 120)
ColorPickerG.Text = ""
ColorPickerG.TextSize = 13
ColorPickerG.Font = Enum.Font.GothamBold
ColorPickerG.BorderSizePixel = 1
ColorPickerG.BorderColor3 = Color3.fromRGB(0, 255, 0)

UICorner16.CornerRadius = UDim.new(0, 6)
UICorner16.Parent = ColorPickerG

ColorPickerB.Parent = MainFrame
ColorPickerB.Size = UDim2.new(0.22, 0, 0, 24)
ColorPickerB.Position = UDim2.new(0.56, 12, 0, 236)
ColorPickerB.BackgroundColor3 = Color3.fromRGB(0, 0, 35)
ColorPickerB.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorPickerB.PlaceholderText = "B"
ColorPickerB.PlaceholderColor3 = Color3.fromRGB(120, 120, 255)
ColorPickerB.Text = ""
ColorPickerB.TextSize = 13
ColorPickerB.Font = Enum.Font.GothamBold
ColorPickerB.BorderSizePixel = 1
ColorPickerB.BorderColor3 = Color3.fromRGB(0, 0, 255)

UICorner17.CornerRadius = UDim.new(0, 6)
UICorner17.Parent = ColorPickerB

ApplyCustomButton.Parent = MainFrame
ApplyCustomButton.Size = UDim2.new(0.18, 0, 0, 24)
ApplyCustomButton.Position = UDim2.new(0.8, 12, 0, 236)
ApplyCustomButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ApplyCustomButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyCustomButton.Text = "✓"
ApplyCustomButton.TextSize = 14
ApplyCustomButton.Font = Enum.Font.GothamBlack
ApplyCustomButton.BorderSizePixel = 0

UICorner18.CornerRadius = UDim.new(0, 12)
UICorner18.Parent = ApplyCustomButton

-- ========== إعدادات ESP ==========
SettingsLabel.Parent = MainFrame
SettingsLabel.Size = UDim2.new(1, -24, 0, 14)
SettingsLabel.Position = UDim2.new(0, 12, 0, 266)
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Text = "⚙️ الإعدادات:"
SettingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsLabel.TextSize = 10
SettingsLabel.Font = Enum.Font.GothamBold
SettingsLabel.TextXAlignment = Enum.TextXAlignment.Left

-- الصف الأول
ShowNamesToggle.Parent = MainFrame
ShowNamesToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowNamesToggle.Position = UDim2.new(0, 12, 0, 282)
ShowNamesToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ShowNamesToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowNamesToggle.Text = "📝 أسماء"
ShowNamesToggle.TextSize = 9
ShowNamesToggle.Font = Enum.Font.GothamBold
ShowNamesToggle.BorderSizePixel = 0

UICorner19.CornerRadius = UDim.new(0, 12)
UICorner19.Parent = ShowNamesToggle

ShowDistanceToggle.Parent = MainFrame
ShowDistanceToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowDistanceToggle.Position = UDim2.new(0.34, 12, 0, 282)
ShowDistanceToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ShowDistanceToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowDistanceToggle.Text = "📏 مسافة"
ShowDistanceToggle.TextSize = 9
ShowDistanceToggle.Font = Enum.Font.GothamBold
ShowDistanceToggle.BorderSizePixel = 0

UICorner20.CornerRadius = UDim.new(0, 12)
UICorner20.Parent = ShowDistanceToggle

ShowHealthToggle.Parent = MainFrame
ShowHealthToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowHealthToggle.Position = UDim2.new(0.68, 12, 0, 282)
ShowHealthToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ShowHealthToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowHealthToggle.Text = "❤️ صحة"
ShowHealthToggle.TextSize = 9
ShowHealthToggle.Font = Enum.Font.GothamBold
ShowHealthToggle.BorderSizePixel = 0

UICorner21.CornerRadius = UDim.new(0, 12)
UICorner21.Parent = ShowHealthToggle

-- الصف الثاني
ShowBoxToggle.Parent = MainFrame
ShowBoxToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowBoxToggle.Position = UDim2.new(0, 12, 0, 310)
ShowBoxToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ShowBoxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowBoxToggle.Text = "📦 صندوق"
ShowBoxToggle.TextSize = 9
ShowBoxToggle.Font = Enum.Font.GothamBold
ShowBoxToggle.BorderSizePixel = 0

UICorner22.CornerRadius = UDim.new(0, 12)
UICorner22.Parent = ShowBoxToggle

ShowTracerToggle.Parent = MainFrame
ShowTracerToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowTracerToggle.Position = UDim2.new(0.34, 12, 0, 310)
ShowTracerToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ShowTracerToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowTracerToggle.Text = "➖ تتبع"
ShowTracerToggle.TextSize = 9
ShowTracerToggle.Font = Enum.Font.GothamBold
ShowTracerToggle.BorderSizePixel = 0

UICorner23.CornerRadius = UDim.new(0, 12)
UICorner23.Parent = ShowTracerToggle

ShowTeamToggle.Parent = MainFrame
ShowTeamToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowTeamToggle.Position = UDim2.new(0.68, 12, 0, 310)
ShowTeamToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ShowTeamToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowTeamToggle.Text = "👥 فريق"
ShowTeamToggle.TextSize = 9
ShowTeamToggle.Font = Enum.Font.GothamBold
ShowTeamToggle.BorderSizePixel = 0

UICorner24.CornerRadius = UDim.new(0, 12)
UICorner24.Parent = ShowTeamToggle

-- الصف الثالث
ShowWeaponToggle.Parent = MainFrame
ShowWeaponToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowWeaponToggle.Position = UDim2.new(0, 12, 0, 338)
ShowWeaponToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ShowWeaponToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowWeaponToggle.Text = "🔫 سلاح"
ShowWeaponToggle.TextSize = 9
ShowWeaponToggle.Font = Enum.Font.GothamBold
ShowWeaponToggle.BorderSizePixel = 0

UICorner25.CornerRadius = UDim.new(0, 12)
UICorner25.Parent = ShowWeaponToggle

ShowSkeletonToggle.Parent = MainFrame
ShowSkeletonToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowSkeletonToggle.Position = UDim2.new(0.34, 12, 0, 338)
ShowSkeletonToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ShowSkeletonToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowSkeletonToggle.Text = "🦴 هيكل"
ShowSkeletonToggle.TextSize = 9
ShowSkeletonToggle.Font = Enum.Font.GothamBold
ShowSkeletonToggle.BorderSizePixel = 0

UICorner26.CornerRadius = UDim.new(0, 12)
UICorner26.Parent = ShowSkeletonToggle

ShowChamsToggle.Parent = MainFrame
ShowChamsToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowChamsToggle.Position = UDim2.new(0.68, 12, 0, 338)
ShowChamsToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ShowChamsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowChamsToggle.Text = "👤 شامز"
ShowChamsToggle.TextSize = 9
ShowChamsToggle.Font = Enum.Font.GothamBold
ShowChamsToggle.BorderSizePixel = 0

UICorner27.CornerRadius = UDim.new(0, 12)
UICorner27.Parent = ShowChamsToggle

-- الصف الرابع
ShowGlowToggle.Parent = MainFrame
ShowGlowToggle.Size = UDim2.new(0.3, 0, 0, 24)
ShowGlowToggle.Position = UDim2.new(0, 12, 0, 366)
ShowGlowToggle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ShowGlowToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowGlowToggle.Text = "✨ توهج"
ShowGlowToggle.TextSize = 9
ShowGlowToggle.Font = Enum.Font.GothamBold
ShowGlowToggle.BorderSizePixel = 0

UICorner28.CornerRadius = UDim.new(0, 12)
UICorner28.Parent = ShowGlowToggle

ShowAimbotDot.Parent = MainFrame
ShowAimbotDot.Size = UDim2.new(0.3, 0, 0, 24)
ShowAimbotDot.Position = UDim2.new(0.34, 12, 0, 366)
ShowAimbotDot.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ShowAimbotDot.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowAimbotDot.Text = "🎯 نقطة"
ShowAimbotDot.TextSize = 9
ShowAimbotDot.Font = Enum.Font.GothamBold
ShowAimbotDot.BorderSizePixel = 0

UICorner29.CornerRadius = UDim.new(0, 12)
UICorner29.Parent = ShowAimbotDot

-- ========== إعدادات إضافية ==========
ThicknessLabel.Parent = MainFrame
ThicknessLabel.Size = UDim2.new(0.28, 0, 0, 16)
ThicknessLabel.Position = UDim2.new(0, 12, 0, 396)
ThicknessLabel.BackgroundTransparency = 1
ThicknessLabel.Text = "📏 سماكة:"
ThicknessLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThicknessLabel.TextSize = 10
ThicknessLabel.Font = Enum.Font.Gotham

ThicknessSlider.Parent = MainFrame
ThicknessSlider.Size = UDim2.new(0.15, 0, 0, 22)
ThicknessSlider.Position = UDim2.new(0.3, 12, 0, 393)
ThicknessSlider.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ThicknessSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
ThicknessSlider.Text = "2"
ThicknessSlider.TextSize = 12
ThicknessSlider.Font = Enum.Font.GothamBold
ThicknessSlider.BorderSizePixel = 1
ThicknessSlider.BorderColor3 = Color3.fromRGB(255, 0, 255)

UICorner31.CornerRadius = UDim.new(0, 6)
UICorner31.Parent = ThicknessSlider

TransparencyLabel.Parent = MainFrame
TransparencyLabel.Size = UDim2.new(0.28, 0, 0, 16)
TransparencyLabel.Position = UDim2.new(0.5, 12, 0, 396)
TransparencyLabel.BackgroundTransparency = 1
TransparencyLabel.Text = "👻 شفافية:"
TransparencyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TransparencyLabel.TextSize = 10
TransparencyLabel.Font = Enum.Font.Gotham

TransparencySlider.Parent = MainFrame
TransparencySlider.Size = UDim2.new(0.15, 0, 0, 22)
TransparencySlider.Position = UDim2.new(0.8, 12, 0, 393)
TransparencySlider.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TransparencySlider.TextColor3 = Color3.fromRGB(255, 255, 255)
TransparencySlider.Text = "0.3"
TransparencySlider.TextSize = 12
TransparencySlider.Font = Enum.Font.GothamBold
TransparencySlider.BorderSizePixel = 1
TransparencySlider.BorderColor3 = Color3.fromRGB(255, 0, 255)

UICorner32.CornerRadius = UDim.new(0, 6)
UICorner32.Parent = TransparencySlider

-- ========== حالة ESP ==========
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, -24, 0, 16)
StatusLabel.Position = UDim2.new(0, 12, 0, 420)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🔴 ESP متوقف"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.GothamBold

-- ========== وظائف ESP ==========
local function getRainbowColor()
    rainbowHue = (rainbowHue + 0.005) % 1
    return Color3.fromHSV(rainbowHue, 1, 1)
end

local function getWeaponName(player)
    if player.Character then
        local tool = player.Character:FindFirstChildOfClass("Tool")
        if tool then return tool.Name end
    end
    return "لا يوجد"
end

local function createESP(player)
    if player == game.Players.LocalPlayer then return end
    if not player.Character then player.CharacterAdded:Wait() end
    
    local character = player.Character
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "SSV7_ESP"
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "SSV7_NameTag"
    billboard.Size = UDim2.new(0, 220, 0, 70)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = character.Head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamBlack
    nameLabel.Parent = billboard
    
    local tracer = Instance.new("Beam")
    tracer.Name = "SSV7_Tracer"
    tracer.Parent = game.Workspace.Terrain
    
    local attach0 = Instance.new("Attachment")
    attach0.Parent = game.Workspace.Terrain
    local attach1 = Instance.new("Attachment")
    attach1.Parent = character.HumanoidRootPart
    
    tracer.Attachment0 = attach0
    tracer.Attachment1 = attach1
    
    table.insert(espObjects, {
        Player = player, Highlight = highlight, Billboard = billboard,
        NameLabel = nameLabel, Tracer = tracer, Attach0 = attach0, Attach1 = attach1
    })
    
    local deathConnection
    deathConnection = player.CharacterAdded:Connect(function()
        if highlight.Parent then highlight:Destroy() end
        if billboard.Parent then billboard:Destroy() end
        if tracer.Parent then tracer:Destroy() end
        if attach0.Parent then attach0:Destroy() end
        if attach1.Parent then attach1:Destroy() end
        task.wait(0.5)
        removeESP(player)
        createESP(player)
    end)
    table.insert(espObjects, {Connection = deathConnection})
end

local function removeESP(player)
    local toRemove = {}
    for i, obj in pairs(espObjects) do
        if obj.Player == player then
            table.insert(toRemove, i)
            if obj.Highlight and obj.Highlight.Parent then obj.Highlight:Destroy() end
            if obj.Billboard and obj.Billboard.Parent then obj.Billboard:Destroy() end
            if obj.Tracer and obj.Tracer.Parent then obj.Tracer:Destroy() end
            if obj.Attach0 and obj.Attach0.Parent then obj.Attach0:Destroy() end
            if obj.Attach1 and obj.Attach1.Parent then obj.Attach1:Destroy() end
        end
        if obj.Connection then obj.Connection:Disconnect() end
    end
    for i = #toRemove, 1, -1 do
        table.remove(espObjects, toRemove[i])
    end
end

local function updateESP()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local localRoot = localPlayer.Character.HumanoidRootPart
    
    for _, obj in pairs(espObjects) do
        if obj.Player and obj.Player.Character and obj.Player.Character:FindFirstChild("HumanoidRootPart") then
            local targetRoot = obj.Player.Character.HumanoidRootPart
            local distance = (localRoot.Position - targetRoot.Position).Magnitude
            
            if distance > maxDistance then
                if obj.Highlight then obj.Highlight.Enabled = false end
                if obj.Billboard then obj.Billboard.Enabled = false end
                if obj.Tracer then obj.Tracer.Enabled = false end
                continue
            end
            
            local color = isRainbow and getRainbowColor() or currentColor
            
            if obj.Highlight and obj.Highlight.Parent then
                obj.Highlight.FillColor = color
                obj.Highlight.OutlineColor = color
                obj.Highlight.FillTransparency = fillTransparency
                obj.Highlight.OutlineTransparency = 0
                obj.Highlight.Enabled = showBox
            end
            
            if obj.Billboard and obj.Billboard.Parent then
                obj.Billboard.Enabled = showNames
                if showNames then
                    local displayText = obj.Player.DisplayName
                    if showDistance then displayText = displayText .. "\n📏 " .. math.floor(distance) .. "m" end
                    if showHealth and obj.Player.Character:FindFirstChild("Humanoid") then
                        displayText = displayText .. " | ❤️ " .. math.floor(obj.Player.Character.Humanoid.Health)
                    end
                    if showWeapon then displayText = displayText .. "\n🔫 " .. getWeaponName(obj.Player) end
                    if showTeam and obj.Player.Team then displayText = displayText .. " | 👥 " .. obj.Player.Team.Name end
                    obj.NameLabel.Text = displayText
                    obj.NameLabel.TextColor3 = color
                end
            end
            
            if obj.Tracer and obj.Tracer.Parent and obj.Attach0 and obj.Attach0.Parent then
                obj.Tracer.Enabled = showTracer
                obj.Attach0.WorldPosition = localRoot.Position
                obj.Tracer.Color = ColorSequence.new(color)
                obj.Tracer.Width0 = lineThickness * 0.1
                obj.Tracer.Width1 = lineThickness * 0.05
            end
        end
    end
end

local function enableESP()
    espEnabled = true
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then createESP(player) end
    end
    game:GetService("RunService").RenderStepped:Connect(function()
        if espEnabled then updateESP() end
    end)
    ToggleESPButton.Text = "🟢 ESP يعمل"
    ToggleESPButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    StatusLabel.Text = "🟢 ESP يعمل"
    MainButton.Text = "👁️ SSV7 ESP ●"
end

local function disableESP()
    espEnabled = false
    for _, player in pairs(game.Players:GetPlayers()) do removeESP(player) end
    espObjects = {}
    ToggleESPButton.Text = "🔴 ESP متوقف"
    ToggleESPButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    StatusLabel.Text = "🔴 ESP متوقف"
    MainButton.Text = "👁️ SSV7 ESP"
end

local function showNotification(text)
    if notificationDebounce then return end
    notificationDebounce = true
    NotificationText.Text = text
    Notification.Visible = true
    Notification.Position = UDim2.new(1, -270, 0, -60)
    for i = 1, 8 do
        Notification.Position = UDim2.new(1, -270, 0, -60 + (i * 7))
        task.wait(0.015)
    end
    task.wait(1.5)
    for i = 1, 8 do
        Notification.Position = UDim2.new(1, -270, 0, -4 - (i * 7))
        task.wait(0.015)
    end
    Notification.Visible = false
    notificationDebounce = false
end

local function toggleButton(button, value, text)
    button.BackgroundColor3 = value and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
    button.Text = text
end

-- الأحداث
MainButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

ToggleESPButton.MouseButton1Click:Connect(function()
    if espEnabled then disableESP() else enableESP() end
end)

RainbowButton.MouseButton1Click:Connect(function()
    isRainbow = not isRainbow
    RainbowButton.BackgroundColor3 = isRainbow and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(25, 25, 25)
    RainbowButton.Text = isRainbow and "🌈 قوس قزح ✓" or "🌈 قوس قزح"
end)

ApplyCustomButton.MouseButton1Click:Connect(function()
    local r = math.clamp(tonumber(ColorPickerR.Text) or 255, 0, 255)
    local g = math.clamp(tonumber(ColorPickerG.Text) or 0, 0, 255)
    local b = math.clamp(tonumber(ColorPickerB.Text) or 0, 0, 255)
    isRainbow = false
    currentColor = Color3.fromRGB(r, g, b)
    RainbowButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    RainbowButton.Text = "🌈 قوس قزح"
end)

ShowNamesToggle.MouseButton1Click:Connect(function() showNames = not showNames; toggleButton(ShowNamesToggle, showNames, "📝 أسماء") end)
ShowDistanceToggle.MouseButton1Click:Connect(function() showDistance = not showDistance; toggleButton(ShowDistanceToggle, showDistance, "📏 مسافة") end)
ShowHealthToggle.MouseButton1Click:Connect(function() showHealth = not showHealth; toggleButton(ShowHealthToggle, showHealth, "❤️ صحة") end)
ShowBoxToggle.MouseButton1Click:Connect(function() showBox = not showBox; toggleButton(ShowBoxToggle, showBox, "📦 صندوق") end)
ShowTracerToggle.MouseButton1Click:Connect(function() showTracer = not showTracer; toggleButton(ShowTracerToggle, showTracer, "➖ تتبع") end)
ShowTeamToggle.MouseButton1Click:Connect(function() showTeam = not showTeam; toggleButton(ShowTeamToggle, showTeam, "👥 فريق") end)
ShowWeaponToggle.MouseButton1Click:Connect(function() showWeapon = not showWeapon; toggleButton(ShowWeaponToggle, showWeapon, "🔫 سلاح") end)
ShowSkeletonToggle.MouseButton1Click:Connect(function() showSkeleton = not showSkeleton; toggleButton(ShowSkeletonToggle, showSkeleton, "🦴 هيكل") end)
ShowChamsToggle.MouseButton1Click:Connect(function() showChams = not showChams; toggleButton(ShowChamsToggle, showChams, "👤 شامز") end)
ShowGlowToggle.MouseButton1Click:Connect(function() showGlow = not showGlow; toggleButton(ShowGlowToggle, showGlow, "✨ توهج") end)
ShowAimbotDot.MouseButton1Click:Connect(function() showAimbotDot = not showAimbotDot; toggleButton(ShowAimbotDot, showAimbotDot, "🎯 نقطة") end)

ThicknessSlider.FocusLost:Connect(function()
    lineThickness = math.clamp(tonumber(ThicknessSlider.Text) or 2, 1, 10)
    ThicknessSlider.Text = tostring(lineThickness)
end)

TransparencySlider.FocusLost:Connect(function()
    fillTransparency = math.clamp(tonumber(TransparencySlider.Text) or 0.3, 0, 1)
    TransparencySlider.Text = tostring(fillTransparency)
end)

game.Players.PlayerAdded:Connect(function(player)
    if espEnabled and player ~= game.Players.LocalPlayer then
        task.wait(1)
        createESP(player)
    end
end)

game.Players.PlayerRemoving:Connect(function(player) removeESP(player) end)

showNotification("👁️ SSV7 ESP جاهز!")
