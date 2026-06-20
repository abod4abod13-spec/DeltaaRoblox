-- ⚡ SSV7 Grab All Tools - بدون واجهة ⚡
local lp = game.Players.LocalPlayer
local backpack = lp:WaitForChild("Backpack")
local grabbed = {}
local totalGrabbed = 0
local isRunning = true

-- دالة سحب الأداة
local function grabTool(tool)
    if not tool or not tool:IsA("Tool") then return false end
    if grabbed[tool] then return false end
    
    -- نتأكد مو موجودة عندي
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name == tool.Name then return false end
    end
    if lp.Character then
        for _, item in pairs(lp.Character:GetChildren()) do
            if item:IsA("Tool") and item.Name == tool.Name then return false end
        end
    end
    
    -- نسخ الأداة
    local success = pcall(function()
        local clone = tool:Clone()
        clone.Parent = backpack
        grabbed[tool] = true
        totalGrabbed = totalGrabbed + 1
        print("🎒 [" .. totalGrabbed .. "] " .. tool.Name)
        
        -- تجهيز الأداة
        task.wait(0.1)
        if lp.Character then
            local hum = lp.Character:FindFirstChild("Humanoid")
            if hum and clone.Parent == backpack then
                hum:EquipTool(clone)
            end
        end
    end)
    
    return success
end

-- فحص كل مكان
local function scanAndGrab()
    local found = 0
    
    -- 1. Workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") then
            if grabTool(obj) then found = found + 1 end
        end
    end
    
    -- 2. ReplicatedStorage
    pcall(function()
        for _, obj in pairs(game.ReplicatedStorage:GetDescendants()) do
            if obj:IsA("Tool") then
                if grabTool(obj) then found = found + 1 end
            end
        end
    end)
    
    -- 3. ServerStorage
    pcall(function()
        for _, obj in pairs(game.ServerStorage:GetDescendants()) do
            if obj:IsA("Tool") then
                if grabTool(obj) then found = found + 1 end
            end
        end
    end)
    
    -- 4. Lighting
    pcall(function()
        for _, obj in pairs(game.Lighting:GetDescendants()) do
            if obj:IsA("Tool") then
                if grabTool(obj) then found = found + 1 end
            end
        end
    end)
    
    -- 5. StarterPack
    pcall(function()
        for _, obj in pairs(game.StarterPack:GetDescendants()) do
            if obj:IsA("Tool") then
                if grabTool(obj) then found = found + 1 end
            end
        end
    end)
    
    -- 6. StarterGui
    pcall(function()
        for _, obj in pairs(game.StarterGui:GetDescendants()) do
            if obj:IsA("Tool") then
                if grabTool(obj) then found = found + 1 end
            end
        end
    end)
    
    -- 7. لاعبين آخرين
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= lp then
            pcall(function()
                if plr.Backpack then
                    for _, tool in pairs(plr.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and grabTool(tool) then found = found + 1 end
                    end
                end
                if plr.Character then
                    for _, tool in pairs(plr.Character:GetDescendants()) do
                        if tool:IsA("Tool") and grabTool(tool) then found = found + 1 end
                    end
                end
            end)
        end
    end
    
    if found > 0 then
        print("✅ تم سحب " .. found .. " أداة جديدة | المجموع: " .. totalGrabbed)
    end
end

-- ========== التشغيل ==========
print("🎒 Grab All Tools بدأ!")
print("⏳ جاري سحب الأدوات...")

-- أول سحب
task.wait(1)
pcall(scanAndGrab)

-- سحب كل 3 ثواني
spawn(function()
    while isRunning do
        task.wait(3)
        pcall(scanAndGrab)
    end
end)

-- عند دخول لاعب جديد (يمكن معه أدوات)
game.Players.PlayerAdded:Connect(function(plr)
    task.wait(1)
    pcall(function()
        if plr.Backpack then
            for _, tool in pairs(plr.Backpack:GetChildren()) do
                if tool:IsA("Tool") then grabTool(tool) end
            end
        end
    end)
end)

-- بعد الموت
lp.CharacterAdded:Connect(function()
    task.wait(0.5)
    pcall(scanAndGrab)
end)

print("✅ جاهز!")
