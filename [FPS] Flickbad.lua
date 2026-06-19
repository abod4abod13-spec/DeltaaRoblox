-- ⚡ SSV7 Flicker God Mode - الأسطوري ⚡
local lp = game.Players.LocalPlayer
local Players = game.Players
local Workspace = workspace
local Camera = Workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- المتغيرات
local espEnabled = true
local aimbotEnabled = true
local fovEnabled = true
local fovRadius = 150
local aimbotSmoothness = 1
local aimbotTarget = nil
local highlights = {}
local fovCircle = nil
local espTexts = {}

-- ========== الواجهة ==========
local gui = Instance.new("ScreenGui")
gui.Name = "SSV7_Flicker"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = lp:WaitForChild("PlayerGui")

-- زر فتح الواجهة
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 120, 0, 35)
openBtn.Position = UDim2.new(0.5, -60, 0, 10)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openBtn.BackgroundTransparency = 0.4
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Text = "🎯 Flicker"
openBtn.TextSize = 14
openBtn.Font = Enum.Font.GothamBlack
openBtn.Draggable = true
openBtn.BorderSizePixel = 2
openBtn.BorderColor3 = Color3.fromRGB(255, 100, 0)
openBtn.Parent = gui
local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0, 10); c1.Parent = openBtn

-- الواجهة الرئيسية
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 280)
mainFrame.Position = UDim2.new(0.5, -125, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
local c2 = Instance.new("UICorner"); c2.CornerRadius = UDim.new(0, 12); c2.Parent = mainFrame

-- عنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 28)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🎯 Flicker God"
title.TextColor3 = Color3.fromRGB(255, 100, 0)
title.TextSize = 15
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- زر إغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -28, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "✕"
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.BorderSizePixel = 0
closeBtn.Parent = mainFrame
local c3 = Instance.new("UICorner"); c3.CornerRadius = UDim.new(0, 11); c3.Parent = closeBtn

-- زر ESP
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(1, -30, 0, 40)
espBtn.Position = UDim2.new(0, 15, 0, 45)
espBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
espBtn.BackgroundTransparency = 0.3
espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
espBtn.Text = "👁️ ESP: ON"
espBtn.TextSize = 14
espBtn.Font = Enum.Font.GothamBlack
espBtn.BorderSizePixel = 0
espBtn.Parent = mainFrame
local c4 = Instance.new("UICorner"); c4.CornerRadius = UDim.new(0, 10); c4.Parent = espBtn

-- زر Aimbot
local aimBtn = Instance.new("TextButton")
aimBtn.Size = UDim2.new(1, -30, 0, 40)
aimBtn.Position = UDim2.new(0, 15, 0, 95)
aimBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
aimBtn.BackgroundTransparency = 0.3
aimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aimBtn.Text = "🎯 Aimbot: ON"
aimBtn.TextSize = 14
aimBtn.Font = Enum.Font.GothamBlack
aimBtn.BorderSizePixel = 0
aimBtn.Parent = mainFrame
local c5 = Instance.new("UICorner"); c5.CornerRadius = UDim.new(0, 10); c5.Parent = aimBtn

-- زر FOV
local fovBtn = Instance.new("TextButton")
fovBtn.Size = UDim2.new(1, -30, 0, 40)
fovBtn.Position = UDim2.new(0, 15, 0, 145)
fovBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
fovBtn.BackgroundTransparency = 0.3
fovBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fovBtn.Text = "⭕ FOV: ON | " .. fovRadius
fovBtn.TextSize = 14
fovBtn.Font = Enum.Font.GothamBlack
fovBtn.BorderSizePixel = 0
fovBtn.Parent = mainFrame
local c6 = Instance.new("UICorner"); c6.CornerRadius = UDim.new(0, 10); c6.Parent = fovBtn

-- سلايدر FOV
local fovSlider = Instance.new("TextBox")
fovSlider.Size = UDim2.new(1, -30, 0, 30)
fovSlider.Position = UDim2.new(0, 15, 0, 195)
fovSlider.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fovSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
fovSlider.PlaceholderText = "FOV: 50-300"
fovSlider.Text = tostring(fovRadius)
fovSlider.TextSize = 12
fovSlider.Font = Enum.Font.Gotham
fovSlider.BorderSizePixel = 1
fovSlider.BorderColor3 = Color3.fromRGB(255, 100, 0)
fovSlider.Parent = mainFrame
local c7 = Instance.new("UICorner"); c7.CornerRadius = UDim.new(0, 8); c7.Parent = fovSlider

-- سلايدر السلاسة
local smoothSlider = Instance.new("TextBox")
smoothSlider.Size = UDim2.new(1, -30, 0, 30)
smoothSlider.Position = UDim2.new(0, 15, 0, 235)
smoothSlider.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
smoothSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
smoothSlider.PlaceholderText = "سلاسة: 1-10"
smoothSlider.Text = tostring(aimbotSmoothness)
smoothSlider.TextSize = 12
smoothSlider.Font = Enum.Font.Gotham
smoothSlider.BorderSizePixel = 1
smoothSlider.BorderColor3 = Color3.fromRGB(255, 100, 0)
smoothSlider.Parent = mainFrame
local c8 = Instance.new("UICorner"); c8.CornerRadius = UDim.new(0, 8); c8.Parent = smoothSlider

-- ========== دائرة FOV ==========
fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
fovCircle.Position = UDim2.new(0.5, -fovRadius, 0.5, -fovRadius)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = fovEnabled
fovCircle.Parent = gui
local c9 = Instance.new("UICorner"); c9.CornerRadius = UDim.new(1, 0); c9.Parent = fovCircle

local fovStroke = Instance.new("UIStroke")
fovStroke.Color = Color3.fromRGB(255, 255, 255)
fovStroke.Thickness = 2
fovStroke.Transparency = 0.5
fovStroke.Parent = fovCircle

-- ========== نظام ESP ==========
local function updateESP()
    -- حذف القديم
    for _, data in pairs(espTexts) do
        pcall(function() data.Billboard:Destroy() end)
        pcall(function() data.Highlight:Destroy() end)
    end
    espTexts = {}
    
    if not espEnabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if not head then continue end
            
            -- هايلايت أبيض
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 255, 255)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.FillTransparency = 0.5
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = player.Character
            
            -- Billboard
            local bb = Instance.new("BillboardGui")
            bb.Size = UDim2.new(0, 150, 0, 30)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.Parent = head
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextStrokeTransparency = 0
            label.Text = player.DisplayName
            label.TextSize = 12
            label.Font = Enum.Font.GothamBlack
            label.Parent = bb
            
            -- مسافة
            local distance = "?"
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                local root = lp.Character.HumanoidRootPart
                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    distance = math.floor((root.Position - targetRoot.Position).Magnitude)
                end
            end
            label.Text = player.DisplayName .. " | " .. distance .. "m"
            
            table.insert(espTexts, {Billboard = bb, Highlight = hl, Player = player})
        end
    end
end

-- ========== نظام Aimbot ==========
local function getClosestVisible()
    if not lp.Character then return nil end
    local camPos = Camera.CFrame.Position
    local screenCenter = Camera.ViewportSize / 2
    local closest = nil
    local closestDist = fovRadius
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if not head then continue end
            
            -- فحص إذا في الشاشة
            local screenPos, onScreen = Camera:WorldToScreenPoint(head.Position)
            if not onScreen then continue end
            
            -- فحص المسافة عن مركز الشاشة
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
            if dist < closestDist then
                -- فحص الجدار
                local dir = (head.Position - camPos).Unit * 500
                local rayParams = RaycastParams.new()
                rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                rayParams.FilterDescendantsInstances = {lp.Character}
                local result = Workspace:Raycast(camPos, dir, rayParams)
                
                local blocked = false
                if result then
                    local model = result.Instance:FindFirstAncestorOfClass("Model")
                    if model then
                        local plr = Players:GetPlayerFromCharacter(model)
                        if not plr or plr == lp then blocked = true end
                    else
                        blocked = true
                    end
                end
                
                if not blocked then
                    closestDist = dist
                    closest = player
                end
            end
        end
    end
    
    return closest
end

local function doAimbot()
    if not aimbotEnabled then return end
    
    local target = getClosestVisible()
    if not target or not target.Character then return end
    
    local head = target.Character:FindFirstChild("Head")
    if not head then return end
    
    aimbotTarget = target
    
    -- تصويب
    if Camera then
        local lookAt = CFrame.lookAt(Camera.CFrame.Position, head.Position)
        if aimbotSmoothness > 1 then
            Camera.CFrame = Camera.CFrame:Lerp(lookAt, 0.1 / aimbotSmoothness)
        else
            Camera.CFrame = lookAt
        end
    end
end

-- ========== أحداث الواجهة ==========
openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    espBtn.Text = "👁️ ESP: " .. (espEnabled and "ON" or "OFF")
    if not espEnabled then
        for _, data in pairs(espTexts) do
            pcall(function() data.Billboard:Destroy() end)
            pcall(function() data.Highlight:Destroy() end)
        end
        espTexts = {}
    end
end)

aimBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimBtn.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    aimBtn.Text = "🎯 Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
end)

fovBtn.MouseButton1Click:Connect(function()
    fovEnabled = not fovEnabled
    fovBtn.BackgroundColor3 = fovEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    fovBtn.Text = "⭕ FOV: " .. (fovEnabled and "ON" or "OFF") .. " | " .. fovRadius
    fovCircle.Visible = fovEnabled
end)

fovSlider.FocusLost:Connect(function()
    local val = tonumber(fovSlider.Text)
    if val then
        fovRadius = math.clamp(val, 50, 300)
        fovSlider.Text = tostring(fovRadius)
        fovCircle.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
        fovCircle.Position = UDim2.new(0.5, -fovRadius, 0.5, -fovRadius)
        fovBtn.Text = "⭕ FOV: " .. (fovEnabled and "ON" or "OFF") .. " | " .. fovRadius
    end
end)

smoothSlider.FocusLost:Connect(function()
    local val = tonumber(smoothSlider.Text)
    if val then
        aimbotSmoothness = math.clamp(val, 1, 10)
        smoothSlider.Text = tostring(aimbotSmoothness)
    end
end)

-- ========== حلقات التحديث ==========

-- تحديث ESP كل 0.5 ثانية
spawn(function()
    while task.wait(0.5) do
        if espEnabled then
            pcall(updateESP)
        end
    end
end)

-- Aimbot كل إطار
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        pcall(doAimbot)
    end
end)

-- تحديث ESP عند دخول لاعب جديد
Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        task.wait(0.5)
        pcall(updateESP)
    end
end)

-- حذف ESP عند خروج لاعب
Players.PlayerRemoving:Connect(function(player)
    for i, data in pairs(espTexts) do
        if data.Player == player then
            pcall(function() data.Billboard:Destroy() end)
            pcall(function() data.Highlight:Destroy() end)
            table.remove(espTexts, i)
            break
        end
    end
end)

-- بعد الموت
lp.CharacterAdded:Connect(function()
    if espEnabled then
        task.wait(0.5)
        pcall(updateESP)
    end
end)

-- أول تحديث
task.wait(0.5)
if espEnabled then pcall(updateESP) end

print("🎯 Flicker God جاهز!")
