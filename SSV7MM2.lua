-- ⚡ SSV7 MM2 Pro - Final v2 ⚡
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local StatusText = Instance.new("TextLabel")
local Notification = Instance.new("Frame")
local UICorner4 = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")

local myRole = "Unknown"
local isFarmActive = false
local coinsCollected = 0
local isAimbotActive = false
local isFlying = false
local isNoclip = false
local walkSpeed = 16
local jumpPower = 50
local isKilling = false
local kills = 0
local highlights = {}
local farmSpeed = 0.01
local teleportRange = 200

ScreenGui.Name = "SSV7_MM2"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainButton.Size = UDim2.new(0, 100, 0, 34)
MainButton.Position = UDim2.new(0.5, -50, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Text = "🔪 MM2"
MainButton.TextSize = 13
MainButton.Font = Enum.Font.GothamBlack
MainButton.Draggable = true
MainButton.Active = true
MainButton.BorderSizePixel = 3
MainButton.BorderColor3 = Color3.fromRGB(255, 50, 50)
MainButton.Parent = ScreenGui
UICorner.CornerRadius = UDim.new(0, 10); UICorner.Parent = MainButton

MainFrame.Size = UDim2.new(0, 260, 0, 370)
MainFrame.Position = UDim2.new(0.5, -130, 0, 48)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
MainFrame.Visible = false; MainFrame.Active = true; MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2; MainFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
MainFrame.Parent = ScreenGui
UICorner2.CornerRadius = UDim.new(0, 10); UICorner2.Parent = MainFrame

Title.Size = UDim2.new(1, -40, 0, 22); Title.Position = UDim2.new(0, 15, 0, 4)
Title.BackgroundTransparency = 1; Title.Text = "🔪 MM2 Pro v2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.TextSize = 13
Title.Font = Enum.Font.GothamBlack; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.Parent = MainFrame

CloseButton.Size = UDim2.new(0, 20, 0, 20); CloseButton.Position = UDim2.new(1, -26, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 40, 40); CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "✕"; CloseButton.TextSize = 12; CloseButton.Font = Enum.Font.GothamBlack
CloseButton.BorderSizePixel = 0; CloseButton.Parent = MainFrame
UICorner3.CornerRadius = UDim.new(0, 10); UICorner3.Parent = CloseButton

StatusText.Size = UDim2.new(1, -16, 0, 22); StatusText.Position = UDim2.new(0, 8, 0, 342)
StatusText.BackgroundColor3 = Color3.fromRGB(12, 12, 12); StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.Text = "🔴 جاهز"; StatusText.TextSize = 10; StatusText.Font = Enum.Font.GothamBold
StatusText.BorderSizePixel = 1; StatusText.BorderColor3 = Color3.fromRGB(255, 50, 50); StatusText.Parent = MainFrame
local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(0, 11); sc.Parent = StatusText

Notification.Size = UDim2.new(0, 200, 0, 28); Notification.Position = UDim2.new(0.5, -100, 0, -32)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0); Notification.BorderSizePixel = 2
Notification.BorderColor3 = Color3.fromRGB(255, 50, 50); Notification.Visible = false; Notification.Parent = ScreenGui
UICorner4.CornerRadius = UDim.new(0, 8); UICorner4.Parent = Notification
NotificationText.Size = UDim2.new(1, -10, 1, 0); NotificationText.Position = UDim2.new(0, 5, 0, 0)
NotificationText.BackgroundTransparency = 1; NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextSize = 11; NotificationText.Font = Enum.Font.GothamBold; NotificationText.Parent = Notification

local function noti(msg)
    NotificationText.Text = msg; Notification.Visible = true
    Notification.Position = UDim2.new(0.5, -100, 0, -32)
    spawn(function() for i=1,5 do Notification.Position=UDim2.new(0.5,-100,0,-32+i*7); task.wait(0.01) end
    task.wait(1.5); for i=1,5 do Notification.Position=UDim2.new(0.5,-100,0,3-i*7); task.wait(0.01) end
    Notification.Visible=false end)
end

local function detectRole(plr)
    if not plr then return "Unknown" end
    local function check(p) if not p then return nil end
        for _,it in pairs(p:GetChildren()) do if it:IsA("Tool") then local n=it.Name:lower()
            if n:find("gun") or n:find("pistol") or n:find("sheriff") or n:find("revolver") or n:find("deagle") then return "Sheriff" end
            if n:find("knife") or n:find("blade") or n:find("dagger") or n:find("sword") or n:find("murder") or n:find("butcher") or n:find("cleaver") then return "Murderer" end
        end end return nil end
    local r=check(plr:FindFirstChild("Backpack")); if r then return r end
    if plr.Character then r=check(plr.Character); if r then return r end end
    return "Innocent"
end

local function updateMyRole() myRole=detectRole(game.Players.LocalPlayer); StatusText.Text="🟢 "..myRole end

local function updateESP()
    for _,plr in pairs(game.Players:GetPlayers()) do if plr~=game.Players.LocalPlayer then
        if highlights[plr.UserId] then pcall(function() highlights[plr.UserId]:Destroy() end) end
        if plr.Character then local role=detectRole(plr)
            local color=role=="Sheriff" and Color3.fromRGB(0,100,255) or (role=="Murderer" and Color3.fromRGB(255,0,0) or Color3.fromRGB(0,255,0))
            local hl=Instance.new("Highlight"); hl.FillColor=color; hl.OutlineColor=color; hl.FillTransparency=0.2
            hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent=plr.Character; highlights[plr.UserId]=hl
        end
    end end
end

-- ========== فارم سريع ==========
local function findCoin()
    local lp=game.Players.LocalPlayer; if not lp.Character then return nil end
    local root=lp.Character:FindFirstChild("HumanoidRootPart"); if not root then return nil end
    local nearest,nd=nil,teleportRange
    for _,obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and obj.Name:lower():find("coin") then
        local d=(root.Position-obj.Position).Magnitude; if d<nd then nd=d; nearest=obj end
    end end
    return nearest,nd
end

local function toggleFarm()
    isFarmActive=not isFarmActive
    if isFarmActive then
        if myRole=="Murderer" then isFarmActive=false; noti("⚠️ القاتل ما يحتاج فارم"); return end
        noti("💰 فارم مفعل | سرعة "..farmSpeed.."s")
        spawn(function() while isFarmActive do
            local coin,dist=findCoin()
            if coin then local lp=game.Players.LocalPlayer; if lp.Character then
                local root=lp.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    if dist>5 then root.CFrame=CFrame.new(coin.Position+Vector3.new(0,2,0)) end
                    pcall(function() firetouchinterest(root,coin,0); firetouchinterest(root,coin,1) end)
                    coinsCollected=coinsCollected+1
                end
            end end
            task.wait(farmSpeed)
        end end)
    else noti("🔴 فارم متوقف | 💰"..coinsCollected) end
end

-- ========== إيمبوت مطور ==========
local function toggleAimbot()
    if isAimbotActive then isAimbotActive=false; noti("🔴 إيمبوت متوقف"); return end
    if myRole~="Sheriff" then noti("⚠️ فقط الشريف"); return end
    isAimbotActive=true; noti("🎯 إيمبوت مفعل")
    spawn(function() while isAimbotActive do
        local cam=workspace.CurrentCamera; if not cam then task.wait(); continue end
        local best=nil; local bestDist=math.huge; local camPos=cam.CFrame.Position
        for _,plr in pairs(game.Players:GetPlayers()) do if plr~=game.Players.LocalPlayer and detectRole(plr)=="Murderer" and plr.Character then
            local head=plr.Character:FindFirstChild("Head"); if head then local d=(camPos-head.Position).Magnitude; if d<bestDist then bestDist=d; best=plr end end
        end end
        if best and best.Character then local head=best.Character:FindFirstChild("Head")
            if head then cam.CFrame=cam.CFrame:Lerp(CFrame.lookAt(camPos,head.Position),0.25) end
        end
        task.wait()
    end end)
end

-- ========== طيران ==========
local function toggleFly()
    isFlying=not isFlying; local lp=game.Players.LocalPlayer
    if not lp.Character then return end; local root=lp.Character:FindFirstChild("HumanoidRootPart"); local hum=lp.Character:FindFirstChild("Humanoid")
    if not root or not hum then return end
    if isFlying then noti("✈️ طيران مفعل")
        local gyro=Instance.new("BodyGyro"); gyro.MaxTorque=Vector3.new(400000,400000,400000); gyro.P=3000; gyro.CFrame=root.CFrame; gyro.Parent=root
        local vel=Instance.new("BodyVelocity"); vel.MaxForce=Vector3.new(400000,400000,400000); vel.Velocity=Vector3.zero; vel.Parent=root
        hum.PlatformStand=true
        spawn(function() while isFlying and lp.Character do local r=lp.Character:FindFirstChild("HumanoidRootPart")
            if r and gyro and vel then local uis=game:GetService("UserInputService"); local cam=workspace.CurrentCamera; local move=Vector3.zero
                if cam then gyro.CFrame=cam.CFrame
                    if uis:IsKeyDown(Enum.KeyCode.W) then move=move+cam.CFrame.LookVector end
                    if uis:IsKeyDown(Enum.KeyCode.S) then move=move-cam.CFrame.LookVector end
                    if uis:IsKeyDown(Enum.KeyCode.A) then move=move-cam.CFrame.RightVector end
                    if uis:IsKeyDown(Enum.KeyCode.D) then move=move+cam.CFrame.RightVector end
                    if uis:IsKeyDown(Enum.KeyCode.E) then move=move+Vector3.new(0,1,0) end
                    if uis:IsKeyDown(Enum.KeyCode.Q) then move=move-Vector3.new(0,1,0) end
                end
                vel.Velocity=move.Magnitude>0 and move.Unit*60 or Vector3.zero
            end; task.wait() end
            if gyro then gyro:Destroy() end; if vel then vel:Destroy() end
            if lp.Character then local h=lp.Character:FindFirstChild("Humanoid"); if h then h.PlatformStand=false end end
        end)
    else if hum then hum.PlatformStand=false end; noti("🔴 طيران متوقف") end
end

-- ========== نوكلب ==========
local function toggleNoclip()
    isNoclip=not isNoclip
    if isNoclip then noti("🚫 نوكلب مفعل")
        spawn(function() while isNoclip do local lp=game.Players.LocalPlayer; if lp.Character then for _,p in pairs(lp.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end; task.wait() end end)
    else noti("🔴 نوكلب متوقف") end
end

-- ========== سرعة وقفز ==========
local function setSpeed(s) walkSpeed=s; local lp=game.Players.LocalPlayer; if lp.Character then local h=lp.Character:FindFirstChild("Humanoid"); if h then h.WalkSpeed=s end end; noti("⚡ سرعة: "..s) end
local function setJump(p) jumpPower=p; local lp=game.Players.LocalPlayer; if lp.Character then local h=lp.Character:FindFirstChild("Humanoid"); if h then h.JumpPower=p end end; noti("🦘 قفز: "..p) end

-- ========== قتل الكل مطور ==========
local function toggleKillAll()
    if isKilling then isKilling=false; noti("🔴 توقف | 💀"..kills); return end
    if myRole~="Murderer" then noti("⚠️ فقط القاتل"); return end
    isKilling=true; kills=0; noti("💀 قتل الكل مفعل")
    spawn(function() while isKilling do local lp=game.Players.LocalPlayer
        if not lp.Character then break end; local root=lp.Character:FindFirstChild("HumanoidRootPart"); if not root then break end
        -- تجهيز السكين
        local knife=lp.Character:FindFirstChildOfClass("Tool")
        if not knife then local bp=lp:FindFirstChild("Backpack"); if bp then for _,t in pairs(bp:GetChildren()) do if t:IsA("Tool") then local n=t.Name:lower(); if n:find("knife") or n:find("blade") then lp.Character:FindFirstChild("Humanoid"):EquipTool(t); knife=t; break end end end end end
        local target=nil; local td=math.huge
        for _,plr in pairs(game.Players:GetPlayers()) do if plr~=lp and plr.Character then local h=plr.Character:FindFirstChild("Humanoid"); local tr=plr.Character:FindFirstChild("HumanoidRootPart")
            if h and h.Health>0 and tr then local d=(root.Position-tr.Position).Magnitude; if d<td then td=d; target=plr end end
        end end
        if not target then isKilling=false; noti("✅ تم قتل الجميع! 💀"..kills); break end
        local tr=target.Character:FindFirstChild("HumanoidRootPart"); local th=target.Character:FindFirstChild("Humanoid")
        if tr and th and th.Health>0 then root.CFrame=tr.CFrame+Vector3.new(0,2,0); task.wait(0.03)
            if knife and knife:FindFirstChild("Handle") then local handle=knife.Handle
                for _,part in pairs(target.Character:GetChildren()) do if part:IsA("BasePart") then pcall(function() firetouchinterest(handle,part,0); firetouchinterest(handle,part,1) end) end end
            end; task.wait(0.03)
            if th.Health>0 then pcall(function() th.Health=0 end) end
            if th.Health<=0 then kills=kills+1; StatusText.Text="🟢 "..myRole.." | 💀"..kills end
        end; task.wait(0.08)
    end end)
end

-- ========== بناء الواجهة ==========
local function buildUI()
    for _,child in pairs(MainFrame:GetChildren()) do if child:IsA("TextButton") and child~=CloseButton then child:Destroy() end; if child:IsA("Frame") and child~=StatusBar then child:Destroy() end end
    updateMyRole(); updateESP()
    local y=30
    local rc=myRole=="Sheriff" and Color3.fromRGB(0,100,255) or (myRole=="Murderer" and Color3.fromRGB(255,0,0) or Color3.fromRGB(0,255,0))
    
    local rf=Instance.new("Frame"); rf.Size=UDim2.new(1,-16,0,22); rf.Position=UDim2.new(0,8,0,y); rf.BackgroundColor3=rc; rf.BorderSizePixel=0; rf.Parent=MainFrame
    local rcc=Instance.new("UICorner"); rcc.CornerRadius=UDim.new(0,11); rcc.Parent=rf
    local rl=Instance.new("TextLabel"); rl.Size=UDim2.new(1,-10,1,0); rl.Position=UDim2.new(0,5,0,0); rl.BackgroundTransparency=1; rl.Text="🎭 "..myRole; rl.TextColor3=Color3.fromRGB(255,255,255); rl.TextSize=11; rl.Font=Enum.Font.GothamBlack; rl.TextXAlignment=Enum.TextXAlignment.Left; rl.Parent=rf; y=y+26
    
    local btns={
        {isFarmActive and "⏹ إيقاف الفارم | 💰"..coinsCollected or "💰 تشغيل فارم العملات (سريع)", isFarmActive and Color3.fromRGB(255,50,50) or Color3.fromRGB(255,200,0), toggleFarm},
        {isAimbotActive and "⏹ إيقاف الإيمبوت" or "🎯 تشغيل إيمبوت القاتل", isAimbotActive and Color3.fromRGB(255,50,50) or Color3.fromRGB(255,150,0), toggleAimbot},
        {isKilling and "⏹ إيقاف القتل | 💀"..kills or "💀 تشغيل قتل الكل (للقاتل)", isKilling and Color3.fromRGB(255,50,50) or Color3.fromRGB(200,0,0), toggleKillAll},
        {"👁️ تحديث كشف الأدوار", Color3.fromRGB(100,100,255), function() updateMyRole(); updateESP(); noti("🔄 تم") end},
        {"⚙️ سرعة الفارم: "..farmSpeed.."s", Color3.fromRGB(200,150,0), function() if farmSpeed==0.01 then farmSpeed=0.05 elseif farmSpeed==0.05 then farmSpeed=0.1 elseif farmSpeed==0.1 then farmSpeed=0.5 else farmSpeed=0.01 end; buildUI(); noti("⏱ سرعة الفارم: "..farmSpeed.."s") end},
    }
    for _,b in pairs(btns) do
        local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,-16,0,30); btn.Position=UDim2.new(0,8,0,y); btn.BackgroundColor3=b[2]; btn.TextColor3=Color3.fromRGB(255,255,255); btn.Text=b[1]; btn.TextSize=10; btn.Font=Enum.Font.GothamBlack; btn.BorderSizePixel=0; btn.Parent=MainFrame
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,10); c.Parent=btn; btn.MouseButton1Click:Connect(b[3]); y=y+34
    end
    
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,-16,0,28); row.Position=UDim2.new(0,8,0,y); row.BackgroundTransparency=1; row.Parent=MainFrame
    for i,data in pairs({{"✈️ طيران",isFlying,toggleFly},{"🚫 نوكلب",isNoclip,toggleNoclip}}) do
        local b=Instance.new("TextButton"); b.Size=UDim2.new(0.48,0,1,0); b.Position=UDim2.new((i-1)*0.52,0,0,0); b.BackgroundColor3=data[2] and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,50); b.TextColor3=Color3.fromRGB(255,255,255); b.Text=data[1]..(data[2] and " ON" or ""); b.TextSize=10; b.Font=Enum.Font.GothamBlack; b.BorderSizePixel=0; b.Parent=row
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,10); c.Parent=b; b.MouseButton1Click:Connect(data[3])
    end; y=y+32
    
    local spdRow=Instance.new("Frame"); spdRow.Size=UDim2.new(1,-16,0,26); spdRow.Position=UDim2.new(0,8,0,y); spdRow.BackgroundTransparency=1; spdRow.Parent=MainFrame
    for i,spd in pairs({16,30,50,100}) do
        local b=Instance.new("TextButton"); b.Size=UDim2.new(0.23,0,1,0); b.Position=UDim2.new((i-1)*0.256,0,0,0); b.BackgroundColor3=walkSpeed==spd and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,50); b.TextColor3=Color3.fromRGB(255,255,255); b.Text="⚡"..spd; b.TextSize=10; b.Font=Enum.Font.GothamBlack; b.BorderSizePixel=0; b.Parent=spdRow
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=b; b.MouseButton1Click:Connect(function() setSpeed(spd); buildUI() end)
    end; y=y+30
    
    local jmpRow=Instance.new("Frame"); jmpRow.Size=UDim2.new(1,-16,0,26); jmpRow.Position=UDim2.new(0,8,0,y); jmpRow.BackgroundTransparency=1; jmpRow.Parent=MainFrame
    for i,jmp in pairs({50,100,200,500}) do
        local b=Instance.new("TextButton"); b.Size=UDim2.new(0.23,0,1,0); b.Position=UDim2.new((i-1)*0.256,0,0,0); b.BackgroundColor3=jumpPower==jmp and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,50); b.TextColor3=Color3.fromRGB(255,255,255); b.Text="🦘"..jmp; b.TextSize=10; b.Font=Enum.Font.GothamBlack; b.BorderSizePixel=0; b.Parent=jmpRow
        local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,8); c.Parent=b; b.MouseButton1Click:Connect(function() setJump(jmp); buildUI() end)
    end
end

-- ========== الأحداث ==========
MainButton.MouseButton1Click:Connect(function() MainFrame.Visible=not MainFrame.Visible; if MainFrame.Visible then buildUI() end end)
CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible=false end)

spawn(function() while task.wait(2) do if MainFrame.Visible then updateESP(); updateMyRole() end end end)

game.Players.PlayerAdded:Connect(function(p) task.wait(0.5); if MainFrame.Visible then updateESP() end end)
game.Players.PlayerRemoving:Connect(function(p) if highlights[p.UserId] then pcall(function() highlights[p.UserId]:Destroy() end); highlights[p.UserId]=nil end end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(c) task.wait(1); updateMyRole()
    local hum=c:FindFirstChild("Humanoid"); if hum then hum.WalkSpeed=walkSpeed; hum.JumpPower=jumpPower end
    if isNoclip then spawn(function() while isNoclip do if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end; task.wait() end end) end
    if MainFrame.Visible then updateESP(); buildUI() end
end)

updateMyRole(); updateESP(); buildUI()
noti("🔪 MM2 Pro v2 جاهز!")
