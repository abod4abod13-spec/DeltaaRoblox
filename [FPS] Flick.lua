-- ⚡ SSV7 Flicker God - Final Legendary ⚡
local lp = game.Players.LocalPlayer
local Players = game.Players
local Workspace = workspace
local Camera = Workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- المتغيرات
local espEnabled = true
local aimbotEnabled = true
local fovEnabled = true
local fovRadius = 200
local aimbotSmoothness = 1
local aimbotTarget = nil
local isKillingAll = false
local kills = 0
local killDelay = 5
local currentKillTarget = nil
local espTexts = {}
local tracers = {}
local boxes = {}

-- واجهة
local gui = Instance.new("ScreenGui")
gui.Name = "SSV7_Flicker"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = lp:WaitForChild("PlayerGui")

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 130, 0, 38)
openBtn.Position = UDim2.new(0.5, -65, 0, 10)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openBtn.BackgroundTransparency = 0.4
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Text = "🎯 Flicker God"
openBtn.TextSize = 14
openBtn.Font = Enum.Font.GothamBlack
openBtn.Draggable = true
openBtn.BorderSizePixel = 3
openBtn.BorderColor3 = Color3.fromRGB(255, 100, 0)
openBtn.Parent = gui
local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0, 12); c1.Parent = openBtn

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 270, 0, 310)
mainFrame.Position = UDim2.new(0.5, -135, 0, 52)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255, 100, 0)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
local c2 = Instance.new("UICorner"); c2.CornerRadius = UDim.new(0, 14); c2.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 30)
title.Position = UDim2.new(0, 18, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🎯 Flicker God"
title.TextColor3 = Color3.fromRGB(255, 100, 0)
title.TextSize = 16
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "✕"
closeBtn.TextSize = 13
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.BorderSizePixel = 0
closeBtn.Parent = mainFrame
local c3 = Instance.new("UICorner"); c3.CornerRadius = UDim.new(0, 12); c3.Parent = closeBtn

-- دوال الأزرار
local function makeBtn(y, text, onColor, offColor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 38)
    btn.Position = UDim2.new(0, 15, 0, y)
    btn.BackgroundColor3 = onColor
    btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBlack
    btn.BorderSizePixel = 0
    btn.Parent = mainFrame
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 12); c.Parent = btn
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function makeSlider(y, placeholder, default, callback)
    local s = Instance.new("TextBox")
    s.Size = UDim2.new(1, -30, 0, 30)
    s.Position = UDim2.new(0, 15, 0, y)
    s.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    s.TextColor3 = Color3.fromRGB(255, 255, 255)
    s.PlaceholderText = placeholder
    s.Text = tostring(default)
    s.TextSize = 12
    s.Font = Enum.Font.Gotham
    s.BorderSizePixel = 2
    s.BorderColor3 = Color3.fromRGB(255, 100, 0)
    s.Parent = mainFrame
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 8); c.Parent = s
    s.FocusLost:Connect(function()
        local v = tonumber(s.Text)
        if v then v = math.clamp(v, 1, 999); s.Text = tostring(v); callback(v) end
    end)
    return s
end

-- أزرار
local espBtn = makeBtn(42, "👁️ ESP: ON", Color3.fromRGB(0, 200, 0), Color3.fromRGB(200, 0, 0), function()
    espEnabled = not espEnabled
    espBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    espBtn.Text = "👁️ ESP: " .. (espEnabled and "ON" or "OFF")
    if not espEnabled then
        for _, d in pairs(espTexts) do pcall(function() d.Billboard:Destroy() end); pcall(function() d.Highlight:Destroy() end) end
        for _, d in pairs(boxes) do pcall(function() d:Destroy() end) end
        for _, t in pairs(tracers) do pcall(function() t.Beam:Destroy() end); pcall(function() t.Attach0:Destroy() end); pcall(function() t.Attach1:Destroy() end) end
        espTexts = {}; boxes = {}; tracers = {}
    end
end)

local aimBtn = makeBtn(86, "🎯 Aimbot: ON", Color3.fromRGB(0, 200, 0), Color3.fromRGB(200, 0, 0), function()
    aimbotEnabled = not aimbotEnabled
    aimBtn.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    aimBtn.Text = "🎯 Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
end)

local fovBtn = makeBtn(130, "⭕ FOV: ON | " .. fovRadius, Color3.fromRGB(0, 200, 0), Color3.fromRGB(200, 0, 0), function()
    fovEnabled = not fovEnabled
    fovBtn.BackgroundColor3 = fovEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    fovBtn.Text = "⭕ FOV: " .. (fovEnabled and "ON" or "OFF") .. " | " .. fovRadius
    fovCircle.Visible = fovEnabled
end)

local killBtn = makeBtn(174, "💀 Kill All: OFF", Color3.fromRGB(200, 0, 0), Color3.fromRGB(0, 200, 0), function()
    isKillingAll = not isKillingAll
    killBtn.BackgroundColor3 = isKillingAll and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    killBtn.Text = "💀 Kill All: " .. (isKillingAll and "ON" or "OFF")
    if isKillingAll then spawn(function() while isKillingAll do pcall(autoKillLoop); task.wait(0.1) end end) end
end)

-- سلايدرات
local fovSlider = makeSlider(220, "FOV: 50-500", fovRadius, function(v) fovRadius = v; fovBtn.Text = "⭕ FOV: " .. (fovEnabled and "ON" or "OFF") .. " | " .. fovRadius; fovCircle.Size = UDim2.new(0, fovRadius*2, 0, fovRadius*2); fovCircle.Position = UDim2.new(0.5, -fovRadius, 0.5, -fovRadius) end)
local smoothSlider = makeSlider(256, "سلاسة: 1-10", aimbotSmoothness, function(v) aimbotSmoothness = v end)

-- عداد القتلى
local killLabel = Instance.new("TextLabel")
killLabel.Size = UDim2.new(1, -30, 0, 22)
killLabel.Position = UDim2.new(0, 15, 0, 290)
killLabel.BackgroundTransparency = 1
killLabel.Text = "💀 القتلى: 0"
killLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
killLabel.TextSize = 12
killLabel.Font = Enum.Font.GothamBlack
killLabel.TextXAlignment = Enum.TextXAlignment.Left
killLabel.Parent = mainFrame

-- FOV Circle
local fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.new(0, fovRadius*2, 0, fovRadius*2)
fovCircle.Position = UDim2.new(0.5, -fovRadius, 0.5, -fovRadius)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = fovEnabled
fovCircle.Parent = gui
local c4 = Instance.new("UICorner"); c4.CornerRadius = UDim.new(1, 0); c4.Parent = fovCircle
local stroke = Instance.new("UIStroke"); stroke.Color = Color3.fromRGB(255, 255, 255); stroke.Thickness = 2; stroke.Transparency = 0.5; stroke.Parent = fovCircle

-- ========== ESP ==========
local function updateESP()
    for _, d in pairs(espTexts) do pcall(function() d.Billboard:Destroy() end); pcall(function() d.Highlight:Destroy() end) end
    for _, d in pairs(boxes) do pcall(function() d:Destroy() end) end
    for _, t in pairs(tracers) do pcall(function() t.Beam:Destroy() end); pcall(function() t.Attach0:Destroy() end); pcall(function() t.Attach1:Destroy() end) end
    espTexts = {}; boxes = {}; tracers = {}
    if not espEnabled then return end
    if not lp.Character then return end
    local myRoot = lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            local tr = plr.Character:FindFirstChild("HumanoidRootPart")
            if not head then continue end
            
            -- هايلايت
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 255, 255); hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.FillTransparency = 0.5; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = plr.Character
            
            -- صندوق حول اللاعب
            if tr then
                local box = Instance.new("Part")
                box.Size = Vector3.new(4, 5, 4); box.Position = tr.Position + Vector3.new(0, 2.5, 0)
                box.Anchored = true; box.CanCollide = false; box.Transparency = 0.8
                box.Color = Color3.fromRGB(255, 255, 255); box.Material = Enum.Material.Neon; box.Parent = Workspace
                table.insert(boxes, box)
            end
            
            -- Billboard
            local bb = Instance.new("BillboardGui")
            bb.Size = UDim2.new(0, 150, 0, 25); bb.StudsOffset = Vector3.new(0, 3.5, 0); bb.AlwaysOnTop = true; bb.Parent = head
            local lb = Instance.new("TextLabel"); lb.Size = UDim2.new(1, 0, 1, 0); lb.BackgroundTransparency = 1
            lb.TextColor3 = Color3.fromRGB(255, 255, 255); lb.TextStrokeTransparency = 0; lb.TextSize = 12; lb.Font = Enum.Font.GothamBlack; lb.Parent = bb
            local dist = tr and math.floor((myRoot.Position - tr.Position).Magnitude) or "?"
            local health = plr.Character:FindFirstChild("Humanoid") and math.floor(plr.Character.Humanoid.Health) or "?"
            lb.Text = plr.DisplayName .. " | " .. dist .. "m | ❤️" .. health
            
            -- خط تتبع
            if tr then
                local beam = Instance.new("Beam"); beam.Parent = Workspace.Terrain
                local a0 = Instance.new("Attachment"); a0.Parent = Workspace.Terrain; a0.WorldPosition = myRoot.Position
                local a1 = Instance.new("Attachment"); a1.Parent = tr
                beam.Attachment0 = a0; beam.Attachment1 = a1
                beam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)); beam.Width0 = 0.15; beam.Width1 = 0.1; beam.Transparency = NumberSequence.new(0.4)
                table.insert(tracers, {Beam = beam, Attach0 = a0, Attach1 = a1, Player = plr})
            end
            
            table.insert(espTexts, {Billboard = bb, Highlight = hl, Player = plr})
        end
    end
end

-- ========== Aimbot ==========
local function isVisible(targetPos)
    if not lp.Character then return false end
    local camPos = Camera.CFrame.Position
    local dir = (targetPos - camPos).Unit * 500
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {lp.Character}
    local result = Workspace:Raycast(camPos, dir, rayParams)
    if not result then return true end
    local model = result.Instance:FindFirstAncestorOfClass("Model")
    if model then
        local plr = Players:GetPlayerFromCharacter(model)
        if plr and plr ~= lp then return true end
    end
    return false
end

local function getBestTarget()
    if not lp.Character then return nil end
    local myRoot = lp.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    
    local best = nil; local bestScore = math.huge
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            local tr = plr.Character:FindFirstChild("HumanoidRootPart")
            if not head or not tr then continue end
            
            -- لازم يكون ظاهر (مو خلف جدار)
            if not isVisible(head.Position) then continue end
            
            -- المسافة
            local worldDist = (myRoot.Position - tr.Position).Magnitude
            
            -- نقاط إضافية: نفضل الأقرب
            local score = worldDist
            
            if score < bestScore then bestScore = score; best = plr end
        end
    end
    
    return best
end

local function doAimbot()
    if not aimbotEnabled then return end
    local target = getBestTarget()
    if not target or not target.Character then return end
    local head = target.Character:FindFirstChild("Head")
    if not head then return end
    aimbotTarget = target
    if Camera then
        local lookAt = CFrame.lookAt(Camera.CFrame.Position, head.Position)
        if aimbotSmoothness > 1 then Camera.CFrame = Camera.CFrame:Lerp(lookAt, 0.2 / aimbotSmoothness)
        else Camera.CFrame = lookAt end
    end
end

-- ========== Kill All ==========
local function autoKillLoop()
    if not isKillingAll then return end
    if not lp.Character then return end
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- إذا الهدف مات، نجيب غيره
    if not currentKillTarget or not currentKillTarget.Character then
        currentKillTarget = nil
    else
        local hum = currentKillTarget.Character:FindFirstChild("Humanoid")
        if hum and hum.Health <= 0 then currentKillTarget = nil end
    end
    
    -- نجيب أقرب هدف حي
    if not currentKillTarget then
        local closest = nil; local cd = math.huge
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= lp and plr.Character then
                local hum = plr.Character:FindFirstChild("Humanoid")
                local tr = plr.Character:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and tr then
                    local d = (root.Position - tr.Position).Magnitude
                    if d < cd then cd = d; closest = plr end
                end
            end
        end
        if closest then currentKillTarget = closest else isKillingAll = false; return end
    end
    
    local tr = currentKillTarget.Character:FindFirstChild("HumanoidRootPart")
    local hum = currentKillTarget.Character:FindFirstChild("Humanoid")
    if not tr or not hum then return end
    
    -- نقف خلفه بشوي
    root.CFrame = tr.CFrame * CFrame.new(0, 0, -4)
    
    -- نقتله
    pcall(function() if hum.Health > 0 then hum.Health = 0 end end)
    
    -- إذا مات ننتظر ونروح للتالي
    if hum.Health <= 0 then
        kills = kills + 1
        killLabel.Text = "💀 القتلى: " .. kills
        currentKillTarget = nil
        task.wait(killDelay)
    end
end

-- ========== أحداث ==========
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

-- حلقات التحديث
spawn(function() while task.wait(0.5) do if espEnabled then pcall(updateESP) end end end)
RunService.RenderStepped:Connect(function() if aimbotEnabled then pcall(doAimbot) end end)

Players.PlayerAdded:Connect(function(p) if espEnabled then task.wait(0.5); pcall(updateESP) end end)
Players.PlayerRemoving:Connect(function(p) for i, d in pairs(espTexts) do if d.Player == p then pcall(function() d.Billboard:Destroy() end); pcall(function() d.Highlight:Destroy() end); table.remove(espTexts, i); break end end end)

lp.CharacterAdded:Connect(function() if espEnabled then task.wait(0.5); pcall(updateESP) end end)

task.wait(0.5); if espEnabled then pcall(updateESP) end
print("🎯 Flicker God Final جاهز!")
