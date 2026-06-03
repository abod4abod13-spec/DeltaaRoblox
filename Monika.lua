-- Abood Ultimate Pro Hub v7.0 | المطور: عبود
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- [ نظام الإشعارات ]
local function notify(msg)
    game.StarterGui:SetCore("SendNotification", {Title = "Abood Hub", Text = msg, Duration = 3})
end

-- [ الواجهة الرئيسية ]
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "AboodHubFinal"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 480)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

-- [ زر القائمة العائم ]
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0.02, 0, 0.5, 0)
OpenBtn.Text = "AB"
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
OpenBtn.Draggable = true
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- [ محرك الطيران ]
local flying = false
local function toggleFly()
    flying = not flying
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if flying then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "FlyVel"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
    else
        if hrp:FindFirstChild("FlyVel") then hrp.FlyVel:Destroy() end
    end
end

-- [ نظام الحماية (Kill Aura) ]
local protection = false
RunService.Heartbeat:Connect(function()
    if protection then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < 15 then -- إذا اقترب أقل من 15 وحدة
                    p.Character.Humanoid.Health = 0
                    notify("تم التخلص من: " .. p.Name)
                end
            end
        end
    end
end)

-- [ وظيفة إنشاء الأزرار ]
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(0.9, 0, 0.85, 0)
Scroll.Position = UDim2.new(0.05, 0, 0.1, 0)
Scroll.BackgroundTransparency = 1
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

local function addBtn(text, callback)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

-- [ إضافة الأزرار ]
addBtn("طيران حقيقي", toggleFly)
addBtn("اختراق الجدران (Noclip)", function() 
    RunService.Stepped:Connect(function() 
        for _, v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end 
    end) 
end)
addBtn("تفعيل حماية المنطقة", function() protection = not protection notify("الحماية: " .. (protection and "مفعلة" or "متوقفة")) end)
addBtn("إعادة الانضمام للسيرفر", function() TeleportService:Teleport(game.PlaceId, player) end)
addBtn("انتقال لسيرفر عشوائي", function() TeleportService:Teleport(game.PlaceId) end)
addBtn("إعادة الظهور (Respawn)", function() player.Character:BreakJoints() end)

-- [ مدخلات مخصصة ]
local SpeedBox = Instance.new("TextBox", Scroll)
SpeedBox.Size = UDim2.new(1, 0, 0, 40)
SpeedBox.PlaceholderText = "سرعة المشي (رقم)"
SpeedBox.FocusLost:Connect(function() player.Character.Humanoid.WalkSpeed = tonumber(SpeedBox.Text) or 16 end)

local JumpBox = Instance.new("TextBox", Scroll)
JumpBox.Size = UDim2.new(1, 0, 0, 40)
JumpBox.PlaceholderText = "قوة النط (رقم)"
JumpBox.FocusLost:Connect(function() player.Character.Humanoid.JumpPower = tonumber(JumpBox.Text) or 50 end)

local TPBox = Instance.new("TextBox", Scroll)
TPBox.Size = UDim2.new(1, 0, 0, 40)
TPBox.PlaceholderText = "انتقال للاعب (اسم)..."
TPBox.FocusLost:Connect(function() 
    local target = Players:FindFirstChild(TPBox.Text)
    if target then player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame else notify("اللاعب غير موجود") end
end)

-- [ زر إغلاق السكربت ]
local Kill = Instance.new("TextButton", MainFrame)
Kill.Size = UDim2.new(0.2, 0, 0, 30)
Kill.Position = UDim2.new(0.75, 0, 0.02, 0)
Kill.Text = "X"
Kill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Kill.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

