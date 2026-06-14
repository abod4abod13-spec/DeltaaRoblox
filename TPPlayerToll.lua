-- ⚡ SSV7 TP Tool - أداة تيليبورت دائمة ⚡
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local backpack = player:WaitForChild("Backpack")

-- دالة إنشاء الأداة
local function createTool()
    -- إذا الأداة موجودة، نحذفها أولاً
    local oldTool = player.Backpack:FindFirstChild("SSV7TP TOOL")
    if oldTool then oldTool:Destroy() end
    if player.Character then
        local charTool = player.Character:FindFirstChild("SSV7TP TOOL")
        if charTool then charTool:Destroy() end
    end
    
    -- إنشاء الأداة في حقيبة اللاعب
    local teleportTool = Instance.new("Tool")
    teleportTool.Name = "SSV7TP TOOL"
    teleportTool.RequiresHandle = false -- لا تحتاج قطعة (Handle) لتعمل
    teleportTool.Parent = backpack
    
    -- وظيفة الانتقال عند الضغط (Activated)
    teleportTool.Activated:Connect(function()
        if mouse.Target then
            local targetPos = mouse.Hit.Position + Vector3.new(0, 3, 0)
            
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
            end
        end
    end)
    
    -- تجهيز الأداة تلقائياً
    task.wait(0.2)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:EquipTool(teleportTool)
    end
end

-- إنشاء الأداة أول مرة
createTool()

-- إعادة إنشاء الأداة بعد الموت أو تغيير الشخصية
player.CharacterAdded:Connect(function(character)
    task.wait(0.5)
    createTool()
end)

-- إعادة تجهيز الأداة إذا انحذفت من اليد
player.Backpack.ChildAdded:Connect(function(child)
    if child.Name == "SSV7TP TOOL" and child:IsA("Tool") then
        task.wait(0.2)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:EquipTool(child)
        end
    end
end)
