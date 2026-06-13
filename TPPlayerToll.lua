local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local backpack = player:WaitForChild("Backpack")

-- إنشاء الأداة في حقيبة اللاعب
local teleportTool = Instance.new("Tool")
teleportTool.Name = "SSV7TP TOOL"
teleportTool.RequiresHandle = false -- لا تحتاج قطعة (Handle) لتعمل
teleportTool.Parent = backpack

-- وظيفة الانتقال عند الضغط (Activated)
teleportTool.Activated:Connect(function()
    if mouse.Target then
        local targetPos = mouse.Hit.Position + Vector3.new(0, 3, 0) -- الانتقال لمكان ضغطة الماوس + ارتفاع بسيط
        
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
        end
    end
end)
