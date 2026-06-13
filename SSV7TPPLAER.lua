-- إنشاء الواجهة الرسومية (UI)
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local PlayerListFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- إعدادات الشاشة
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- زر فتح/إغلاق القائمة (في أعلى اليسار)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 90, 0, 35)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "SSV7🔰TP"
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.SourceSansBold

-- القائمة الرئيسية
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 280)
MainFrame.Position = UDim2.new(0, 10, 0, 55)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

-- العنوان
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "LYCAN PLAYERS TP"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold

-- قائمة التمرير لعرض اللاعبين (Inventory Style)
PlayerListFrame.Parent = MainFrame
PlayerListFrame.Size = UDim2.new(1, -20, 1, -55)
PlayerListFrame.Position = UDim2.new(0, 10, 0, 45)
PlayerListFrame.BackgroundTransparency = 1
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.ScrollBarThickness = 6

-- ترتيب الأزرار تلقائياً تحت بعضها
UIListLayout.Parent = PlayerListFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

--- البرمجة والوظائف ---

-- إخفاء وإظهار القائمة
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- وظيفة الانتقال إلى لاعب محدد
local function teleportToPlayer(targetPlayer)
    local localPlayer = game.Players.LocalPlayer
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            -- الانتقال فوق رأس اللاعب بقليل لتجنب العلوق داخله
            localPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end

-- تحديث قائمة اللاعبين بشكل تلقائي
local function updatePlayerList()
    -- تنظيف القائمة القديمة
    for _, child in pairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    -- إضافة اللاعبين الحاليين في السيرفر
    for _, player in pairs(game.Players:GetPlayers()) do
        -- تخطي اسمك الشخصي حتى لا تنتقل لنفسك
        if player ~= game.Players.LocalPlayer then
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Parent = PlayerListFrame
            PlayerButton.Size = UDim2.new(1, 0, 0, 35)
            PlayerButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            PlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayerButton.Text = player.DisplayName .. " (@" .. player.Name .. ")"
            PlayerButton.TextSize = 12
            PlayerButton.Font = Enum.Font.SourceSans

            -- عند الضغط على زر اللاعب يتم الانتقال إليه فوراً
            PlayerButton.MouseButton1Click:Connect(function()
                teleportToPlayer(player)
            end)
        end
    end
    
    -- تحديث حجم مساحة التمرير بناءً على عدد اللاعبين
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

-- تشغيل التحديث عند فتح السكربت وعند دخول أو خروج أي لاعب
updatePlayerList()
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
