-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     DELTA EXECUTOR PROFESSIONAL SCRIPT - ROBLOX HUB          ║
-- ║              Advanced GUI with Modern Design                 ║
-- ╚═══════════════════════════════════════════════════════════════╝

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetWorkspace()
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    متغيرات النظام الأساسية                   ║
-- ╚═══════════════════════════════════════════════════════════════╝

local Config = {
    Flying = false,
    FlySpeed = 50,
    MaxFlySpeed = 200,
    MinFlySpeed = 5,
    
    JumpPower = 50,
    MaxJumpPower = 300,
    
    WallBreak = false,
    TargetPlayer = nil,
    AimBot = false,
    AimBotFOV = 150,
    
    LagReduction = false,
    AntiKnockback = false,
    ReverseKnockback = false,
    
    FlungEnabled = false,
    FlungPower = 150,
    
    AdminCommands = true,
    SavedPositions = {},
    
    GUIVisible = true,
    Speed = 50,
    InfiniteStamina = false,
    NoClip = false,
    GodMode = false,
    InvisibleMode = false,
    SpeedBoost = false,
    BhopEnabled = false
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    إنشاء الواجهة الاحترافية                   ║
-- ╚═══════════════════════════════════════════════════════════════╝

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaProGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 600)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.CornerRadius = UDim.new(0, 15)
MainFrame.Parent = ScreenGui

-- إضافة ظل للإطار
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BorderSizePixel = 0
Shadow.CornerRadius = UDim.new(0, 15)
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

-- شريط العنوان
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
TitleBar.BorderSizePixel = 0
TitleBar.CornerRadius = UDim.new(0, 15)
TitleBar.Parent = MainFrame

-- عنوان النص
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ DELTA EXECUTOR PRO"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- زر الإغلاق X
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Text = "✕"
CloseButton.BorderSizePixel = 0
CloseButton.CornerRadius = UDim.new(0, 8)
CloseButton.Parent = TitleBar

CloseButton.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(
        UDim2.new(0, 0, 0, 0),
        Enum.EasingDirection.InOut,
        Enum.EasingStyle.Quad,
        0.3,
        true
    )
    wait(0.3)
    Config.GUIVisible = false
end)

-- منطقة المحتوى
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -50)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 8
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 100)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)
ContentFrame.Parent = MainFrame

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    دوال إنشاء العناصر                         ║
-- ╚═══════════════════════════════════════════════════════════════╝

local function CreateSection(Name, Position)
    local Section = Instance.new("Frame")
    Section.Name = Name
    Section.Size = UDim2.new(1, -20, 0, 40)
    Section.Position = Position
    Section.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Section.BorderSizePixel = 1
    Section.BorderColor3 = Color3.fromRGB(0, 200, 100)
    Section.CornerRadius = UDim.new(0, 8)
    Section.Parent = ContentFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "📌 " .. Name
    Label.TextColor3 = Color3.fromRGB(0, 200, 100)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Section
    
    return Section
end

local function CreateButton(Name, Position, Size, Text, Callback, Parent)
    local Button = Instance.new("TextButton")
    Button.Name = Name
    Button.Position = Position
    Button.Size = Size
    Button.Text = Text
    Button.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.BorderSizePixel = 0
    Button.CornerRadius = UDim.new(0, 6)
    Button.Parent = Parent or ContentFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Button
    
    Button.MouseEnter:Connect(function()
        Button:TweenBackgroundColor3(
            Color3.fromRGB(0, 220, 120),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
    end)
    
    Button.MouseLeave:Connect(function()
        Button:TweenBackgroundColor3(
            Color3.fromRGB(0, 200, 100),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
    end)
    
    Button.MouseButton1Click:Connect(Callback)
    return Button
end

local function CreateToggleButton(Name, Position, Size, Text, Callback, Parent)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = Name
    ToggleFrame.Position = Position
    ToggleFrame.Size = Size
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ToggleFrame.BorderSizePixel = 1
    ToggleFrame.BorderColor3 = Color3.fromRGB(0, 200, 100)
    ToggleFrame.CornerRadius = UDim.new(0, 6)
    ToggleFrame.Parent = Parent or ContentFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.25, 0, 1, 0)
    ToggleButton.Position = UDim2.new(0.7, 0, 0, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 11
    ToggleButton.Text = "OFF"
    ToggleButton.BorderSizePixel = 0
    ToggleButton.CornerRadius = UDim.new(0, 4)
    ToggleButton.Parent = ToggleFrame
    
    local IsOn = false
    
    ToggleButton.MouseButton1Click:Connect(function()
        IsOn = not IsOn
        if IsOn then
            ToggleButton:TweenBackgroundColor3(
                Color3.fromRGB(0, 200, 100),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.2,
                true
            )
            ToggleButton.Text = "ON"
        else
            ToggleButton:TweenBackgroundColor3(
                Color3.fromRGB(255, 50, 50),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.2,
                true
            )
            ToggleButton.Text = "OFF"
        end
        Callback(IsOn)
    end)
    
    return ToggleFrame, ToggleButton, function() return IsOn end
end

local function CreateTextBox(Name, Position, Size, PlaceholderText, Parent)
    local TextBox = Instance.new("TextBox")
    TextBox.Name = Name
    TextBox.Position = Position
    TextBox.Size = Size
    TextBox.PlaceholderText = PlaceholderText
    TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    TextBox.TextColor3 = Color3.fromRGB(0, 200, 100)
    TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    TextBox.BorderSizePixel = 1
    TextBox.BorderColor3 = Color3.fromRGB(0, 200, 100)
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextSize = 12
    TextBox.CornerRadius = UDim.new(0, 6)
    TextBox.Parent = Parent or ContentFrame
    return TextBox
end

local function CreateSlider(Name, Position, Size, MinValue, MaxValue, DefaultValue, Callback, Parent)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = Name
    SliderFrame.Position = Position
    SliderFrame.Size = Size
    SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    SliderFrame.BorderSizePixel = 1
    SliderFrame.BorderColor3 = Color3.fromRGB(0, 200, 100)
    SliderFrame.CornerRadius = UDim.new(0, 6)
    SliderFrame.Parent = Parent or ContentFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 0.4, 0)
    Label.Position = UDim2.new(0, 5, 0, 2)
    Label.BackgroundTransparency = 1
    Label.Text = Name
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, 0, 0.4, 0)
    ValueLabel.Position = UDim2.new(0.65, 0, 0.02, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(DefaultValue)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 200, 100)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 11
    ValueLabel.Parent = SliderFrame
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -10, 0, 6)
    SliderBar.Position = UDim2.new(0, 5, 0.5, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    SliderBar.BorderSizePixel = 0
    SliderBar.CornerRadius = UDim.new(0, 3)
    SliderBar.Parent = SliderFrame
    
    local SliderButton = Instance.new("Frame")
    SliderButton.Size = UDim2.new(0, 12, 0, 16)
    SliderButton.Position = UDim2.new(0, 0, 0.5, -8)
    SliderButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    SliderButton.BorderSizePixel = 0
    SliderButton.CornerRadius = UDim.new(0, 3)
    SliderButton.Parent = SliderBar
    
    local CurrentValue = DefaultValue
    
    local function UpdateSlider(Input)
        local RelativeX = Input.Position.X - SliderBar.AbsolutePosition.X
        local Percentage = math.clamp(RelativeX / SliderBar.AbsoluteSize.X, 0, 1)
        CurrentValue = math.floor(MinValue + (MaxValue - MinValue) * Percentage)
        SliderButton.Position = UDim2.new(Percentage, -6, 0.5, -8)
        ValueLabel.Text = tostring(CurrentValue)
        Callback(CurrentValue)
    end
    
    UserInputService.InputBegan:Connect(function(Input, GameProcessed)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            if SliderButton:FindFirstAncestorOfClass("GuiObject") then
                UpdateSlider(Input)
            end
        end
    end)
    
    UserInputService.InputChanged:Connect(function(Input, GameProcessed)
        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateSlider(Input)
        end
    end)
    
    return SliderFrame
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    نظام الطيران المتقدم                      ║
-- ╚═══════════════════════════════════════════════════════════════╝

local FlyConnection
local BodyVelocity
local BodyGyro

local function StartFlying()
    if Config.Flying then return end
    Config.Flying = true
    
    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BodyVelocity.Parent = RootPart
    
    BodyGyro = Instance.new("BodyGyro")
    BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    BodyGyro.P = 9000
    BodyGyro.Parent = RootPart
    
    FlyConnection = RunService.RenderStepped:Connect(function()
        if not Config.Flying then
            if BodyVelocity then BodyVelocity:Destroy() end
            if BodyGyro then BodyGyro:Destroy() end
            if FlyConnection then FlyConnection:Disconnect() end
            return
        end
        
        local Camera = workspace.CurrentCamera
        local MoveDirection = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            MoveDirection = MoveDirection + Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            MoveDirection = MoveDirection - Camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            MoveDirection = MoveDirection - Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            MoveDirection = MoveDirection + Camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            MoveDirection = MoveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            MoveDirection = MoveDirection - Vector3.new(0, 1, 0)
        end
        
        if MoveDirection.Magnitude > 0 then
            MoveDirection = MoveDirection.Unit
        end
        
        BodyVelocity.Velocity = MoveDirection * Config.FlySpeed
        BodyGyro.CFrame = Camera.CFrame
    end)
end

local function StopFlying()
    Config.Flying = false
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    نظام اختراق الجدران                       ║
-- ╚═══════════════════════════════════════════════════════════════╝

local function EnableNoClip()
    Config.NoClip = true
    
    local NoClipConnection
    NoClipConnection = RunService.Stepped:Connect(function()
        if not Config.NoClip then
            NoClipConnection:Disconnect()
            return
        end
        
        for _, Part in pairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CanCollide = false
            end
        end
    end)
end

local function DisableNoClip()
    Config.NoClip = false
    for _, Part in pairs(Character:GetDescendants()) do
        if Part:IsA("BasePart") then
            Part.CanCollide = true
        end
    end
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    نظام الاستهداف والـ Bang                  ║
-- ╚═══════════════════════════════════════════════════════════════╝

local function FindPlayerByName(Name)
    for _, Player in pairs(Players:GetPlayers()) do
        if Player.Name:lower():find(Name:lower()) or Player.DisplayName:lower():find(Name:lower()) then
            return Player
        end
    end
    return nil
end

local function BangPlayer(TargetPlayer, BangType)
    if not TargetPlayer or not TargetPlayer.Character then return end
    
    local TargetHumanoid = TargetPlayer.Character:FindFirstChild("Humanoid")
    local TargetRootPart = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if TargetHumanoid and TargetRootPart then
        if BangType == "front" then
            local BV = Instance.new("BodyVelocity")
            BV.Velocity = (TargetRootPart.Position - RootPart.Position).Unit * 150
            BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BV.Parent = TargetRootPart
            game:GetService("Debris"):AddItem(BV, 0.15)
        elseif BangType == "back" then
            local BV = Instance.new("BodyVelocity")
            BV.Velocity = (RootPart.Position - TargetRootPart.Position).Unit * 150
            BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BV.Parent = TargetRootPart
            game:GetService("Debris"):AddItem(BV, 0.15)
        elseif BangType == "up" then
            local BV = Instance.new("BodyVelocity")
            BV.Velocity = Vector3.new(0, 200, 0)
            BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BV.Parent = TargetRootPart
            game:GetService("Debris"):AddItem(BV, 0.15)
        elseif BangType == "spin" then
            local BG = Instance.new("BodyGyro")
            BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BG.P = 10000
            BG.Parent = TargetRootPart
            
            for i = 1, 20 do
                BG.CFrame = BG.CFrame * CFrame.Angles(0, math.rad(45), 0)
                wait(0.05)
            end
            BG:Destroy()
        end
    end
end

local function FlungPlayer(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    
    local TargetRootPart = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if TargetRootPart then
        local Flung = Instance.new("BodyVelocity")
        Flung.Velocity = Vector3.new(
            math.random(-Config.FlungPower, Config.FlungPower),
            Config.FlungPower * 3,
            math.random(-Config.FlungPower, Config.FlungPower)
        )
        Flung.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        Flung.Parent = TargetRootPart
        
        game:GetService("Debris"):AddItem(Flung, 1)
    end
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    نظام الأيم بوت                            ║
-- ╚═══════════════════════════════════════════════════════════════╝

local function EnableAimBot(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    
    Config.AimBot = true
    Config.TargetPlayer = TargetPlayer
    
    local AimConnection
    AimConnection = RunService.RenderStepped:Connect(function()
        if not Config.AimBot or not Config.TargetPlayer or not Config.TargetPlayer.Character then
            AimConnection:Disconnect()
            return
        end
        
        local TargetHead = Config.TargetPlayer.Character:FindFirstChild("Head")
        if TargetHead then
            local Camera = workspace.CurrentCamera
            local Direction = (TargetHead.Position - Camera.CFrame.Position).Unit
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Direction)
        end
    end)
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    نظام حفظ المواقع                          ║
-- ╚═══════════════════════════════════════════════════════════════╝

local function SavePosition(Name)
    Config.SavedPositions[Name] = RootPart.Position
end

local function LoadPosition(Name)
    if Config.SavedPositions[Name] then
        RootPart.Position = Config.SavedPositions[Name]
    end
end

local function TeleportToPlayer(TargetPlayer)
    if TargetPlayer and TargetPlayer.Character then
        RootPart.Position = TargetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
    end
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    نظام إضافي (God Mode, Speed)              ║
-- ╚═══════════════════════════════════════════════════════════════╝

local function EnableGodMode()
    Config.GodMode = true
    Humanoid.MaxHealth = math.huge
    Humanoid.Health = math.huge
end

local function EnableSpeedBoost()
    Config.SpeedBoost = true
    Humanoid.WalkSpeed = Config.Speed
end

local function EnableBhop()
    Config.BhopEnabled = true
    
    UserInputService.InputBegan:Connect(function(Input, GameProcessed)
        if GameProcessed then return end
        if Input.KeyCode == Enum.KeyCode.Space and Config.BhopEnabled then
            Humanoid:Jump()
        end
    end)
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    بناء الواجهة الرسومية                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- القسم الأول: الطيران
CreateSection("🚀 الطيران", UDim2.new(0, 10, 0, 10))
CreateButton("تفعيل الطيران", UDim2.new(0, 10, 0, 60), UDim2.new(0.4, -15, 0, 35), "✈️ تفعيل", function()
    if Config.Flying then
        StopFlying()
    else
        StartFlying()
    end
end, ContentFrame)

CreateButton("إيقاف الطيران", UDim2.new(0.5, 5, 0, 60), UDim2.new(0.4, -15, 0, 35), "⛔ إيقاف", function()
    StopFlying()
end, ContentFrame)

CreateSlider("سرعة الطيران", UDim2.new(0, 10, 0, 105), UDim2.new(1, -20, 0, 35), 5, 200, 50, function(Value)
    Config.FlySpeed = Value
end, ContentFrame)

-- القسم الثاني: الحركة والقفز
CreateSection("🏃 الحركة والقفز", UDim2.new(0, 10, 0, 155))
CreateToggleButton("سرعة الجري", UDim2.new(0, 10, 0, 205), UDim2.new(1, -20, 0, 30), "💨 تفعيل سرعة الجري", function(IsOn)
    if IsOn then
        EnableSpeedBoost()
    else
        Humanoid.WalkSpeed = 16
    end
end, ContentFrame)

CreateSlider("سرعة الجري", UDim2.new(0, 10, 0, 245), UDim2.new(1, -20, 0, 35), 16, 150, 50, function(Value)
    Config.Speed = Value
    if Config.SpeedBoost then
        Humanoid.WalkSpeed = Value
    end
end, ContentFrame)

CreateSlider("قوة النط", UDim2.new(0, 10, 0, 290), UDim2.new(1, -20, 0, 35), 20, 300, 50, function(Value)
    Config.JumpPower = Value
    Humanoid.JumpPower = Value
end, ContentFrame)

CreateToggleButton("B-Hop", UDim2.new(0, 10, 0, 335), UDim2.new(1, -20, 0, 30), "🎮 تفعيل B-Hop", function(IsOn)
    if IsOn then
        EnableBhop()
    else
        Config.BhopEnabled = false
    end
end, ContentFrame)

-- القسم الثالث: اختراق الجدران
CreateSection("🧊 اختراق الجدران", UDim2.new(0, 10, 0, 375))
CreateToggleButton("No Clip", UDim2.new(0, 10, 0, 425), UDim2.new(1, -20, 0, 30), "👻 اختراق الجدران", function(IsOn)
    if IsOn then
        EnableNoClip()
    else
        DisableNoClip()
    end
end, ContentFrame)

-- القسم الرابع: الاستهداف
CreateSection("🎯 نظام الاستهداف", UDim2.new(0, 10, 0, 465))
local TargetBox = CreateTextBox("TargetNameBox", UDim2.new(0, 10, 0, 515), UDim2.new(1, -20, 0, 30), "اكتب اسم اللاعب", ContentFrame)

CreateButton("Bang أمامي", UDim2.new(0, 10, 0, 555), UDim2.new(0.45, -12, 0, 30), "💥 أمام", function()
    local Target = FindPlayerByName(TargetBox.Text)
    if Target then
        BangPlayer(Target, "front")
    end
end, ContentFrame)

CreateButton("Bang خلفي", UDim2.new(0.5, 6, 0, 555), UDim2.new(0.45, -12, 0, 30), "💥 خلف", function()
    local Target = FindPlayerByName(TargetBox.Text)
    if Target then
        BangPlayer(Target, "back")
    end
end, ContentFrame)

CreateButton("Bang للأعلى", UDim2.new(0, 10, 0, 595), UDim2.new(0.45, -12, 0, 30), "⬆️ أعلى", function()
    local Target = FindPlayerByName(TargetBox.Text)
    if Target then
        BangPlayer(Target, "up")
    end
end, ContentFrame)

CreateButton("Flung", UDim2.new(0.5, 6, 0, 595), UDim2.new(0.45, -12, 0, 30), "🌪️ Flung", function()
    local Target = FindPlayerByName(TargetBox.Text)
    if Target then
        FlungPlayer(Target)
    end
end, ContentFrame)

CreateButton("Aim Bot", UDim2.new(0, 10, 0, 635), UDim2.new(0.45, -12, 0, 30), "🔫 Aim", function()
    local Target = FindPlayerByName(TargetBox.Text)
    if Target then
        EnableAimBot(Target)
    end
end, ContentFrame)

CreateButton("تنقل للاعب", UDim2.new(0.5, 6, 0, 635), UDim2.new(0.45, -12, 0, 30), "📍 تنقل", function()
    local Target = FindPlayerByName(TargetBox.Text)
    if Target then
        TeleportToPlayer(Target)
    end
end, ContentFrame)

-- القسم الخامس: الحماية
CreateSection("🛡️ الحماية والمميزات", UDim2.new(0, 10, 0, 675))
CreateToggleButton("God Mode", UDim2.new(0, 10, 0, 725), UDim2.new(1, -20, 0, 30), "⚡ وضع الإله", function(IsOn)
    if IsOn then
        EnableGodMode()
    end
end, ContentFrame)

CreateToggleButton("مضاد الضربات", UDim2.new(0, 10, 0, 765), UDim2.new(1, -20, 0, 30), "🛡️ مضاد الضربات", function(IsOn)
    Config.AntiKnockback = IsOn
end, ContentFrame)

CreateToggleButton("ضربة عكسية", UDim2.new(0, 10, 0, 805), UDim2.new(1, -20, 0, 30), "↩️ ضربة عكسية", function(IsOn)
    Config.ReverseKnockback = IsOn
end, ContentFrame)

-- القسم السادس: حفظ المواقع
CreateSection("💾 حفظ المواقع", UDim2.new(0, 10, 0, 845))
local SaveNameBox = CreateTextBox("SaveNameBox", UDim2.new(0, 10, 0, 895), UDim2.new(1, -20, 0, 30), "اسم الموقع", ContentFrame)

CreateButton("حفظ الموقع", UDim2.new(0, 10, 0, 935), UDim2.new(0.45, -12, 0, 30), "💾 حفظ", function()
    if SaveNameBox.Text ~= "" then
        SavePosition(SaveNameBox.Text)
        SaveNameBox.Text = ""
    end
end, ContentFrame)

CreateButton("تحميل الموقع", UDim2.new(0.5, 6, 0, 935), UDim2.new(0.45, -12, 0, 30), "📂 تحميل", function()
    if SaveNameBox.Text ~= "" then
        LoadPosition(SaveNameBox.Text)
    end
end, ContentFrame)

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    اختصارات لوحة المفاتيح                    ║
-- ╚═══════════════════════════════════════════════════════════════╝

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end
    
    if Input.KeyCode == Enum.KeyCode.F then
        if Config.Flying then
            StopFlying()
        else
            StartFlying()
        end
    elseif Input.KeyCode == Enum.KeyCode.G then
        if Config.NoClip then
            DisableNoClip()
        else
            EnableNoClip()
        end
    elseif Input.KeyCode == Enum.KeyCode.X then
        if Config.GUIVisible then
            MainFrame:TweenSize(
                UDim2.new(0, 0, 0, 0),
                Enum.EasingDirection.InOut,
                Enum.EasingStyle.Quad,
                0.3,
                true
            )
            Config.GUIVisible = false
        else
            MainFrame:TweenSize(
                UDim2.new(0, 450, 0, 600),
                Enum.EasingDirection.InOut,
                Enum.EasingStyle.Quad,
                0.3,
                true
            )
            Config.GUIVisible = true
        end
    end
end)

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    نظام مضاد الضربات المتقدم                 ║
-- ╚═══════════════════════════════════════════════════════════════╝

RunService.Heartbeat:Connect(function()
    if Config.AntiKnockback and RootPart then
        RootPart.AssemblyLinearVelocity = Vector3.new(
            RootPart.AssemblyLinearVelocity.X * 0.9,
            RootPart.AssemblyLinearVelocity.Y,
            RootPart.AssemblyLinearVelocity.Z * 0.9
        )
    end
    
    if Config.ReverseKnockback and RootPart and RootPart.AssemblyLinearVelocity.Magnitude > 50 then
        RootPart.AssemblyLinearVelocity = -RootPart.AssemblyLinearVelocity * 0.5
    end
end)

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    إعادة تحميل عند الموت                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    Config.Flying = false
    Config.NoClip = false
end)

print("✅ تم تحميل السكربت بنجاح!")
print("🎮 اضغط X لإظهار/إخفاء الواجهة")
print("⌨️ اضغط F لتفعيل الطيران")
print("⌨️ اضغط G لاختراق الجدران")
