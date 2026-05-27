-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     DELTA EXECUTOR PRO - FINAL VERSION v4.0                 ║
-- ║         Mobile & PC Optimized - No Critical Errors           ║
-- ╚═══════════════════════════════════════════════════════════════╝

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetWorkspace()
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then return end

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    متغيرات النظام الأساسية                   ║
-- ╚═══════════════════════════════════════════════════════════════╝

local Config = {
    Flying = false,
    FlySpeed = 50,
    MaxFlySpeed = 300,
    MinFlySpeed = 5,
    FlyConnection = nil,
    
    JumpPower = 50,
    MaxJumpPower = 500,
    WalkSpeed = 16,
    MaxWalkSpeed = 200,
    
    NoClip = false,
    NoClipConnection = nil,
    SpeedBoost = false,
    
    TargetPlayer = nil,
    AimBot = false,
    AimBotConnection = nil,
    
    AntiKnockback = false,
    AntiKBConnection = nil,
    
    SavedPositions = {},
    GUIVisible = true,
    
    FlungPower = 250,
    BangPower = 150,
    
    IsMobile = false
}

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    كشف نوع الجهاز                            ║
-- ╚═══════════════════════════════════════════════════════════════╝

local function DetectMobile()
    local UserInputType = UserInputService:GetLastInputType()
    if UserInputType == Enum.UserInputType.Touch or 
       UserInputType == Enum.UserInputType.Gamepad1 or
       UserInputType == Enum.UserInputType.Gamepad2 then
        Config.IsMobile = true
        return true
    end
    return false
end

DetectMobile()

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    إنشاء الواجهة الرسومية                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaProGUI_v4"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = CoreGui
end)

if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- الإطار الرئيسي
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 700)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -350)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- شريط العنوان
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- إضافة UICorner فقط للأعلى (تحسين بصري)
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

-- عنوان النص
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ DELTA EXECUTOR PRO"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- زر الإغلاق X (الآن يخفي بدل الحذف)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 45, 0, 45)
CloseButton.Position = UDim2.new(1, -50, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.Text = "✕"
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar
CloseButton.AutoButtonColor = false

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- منطقة المحتوى
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -60)
ContentFrame.Position = UDim2.new(0, 0, 0, 60)
ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 10
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 100)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 2000)
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 15)
ContentCorner.Parent = ContentFrame

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    دوال إنشاء العناصر                         ║
-- ╚═══════════════════════════════════════════════════════════════╝

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
    Button.Parent = Parent or ContentFrame
    Button.AutoButtonColor = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
    end)
    
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    end)
    
    Button.MouseButton1Click:Connect(function()
        pcall(Callback)
    end)
    
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
    ToggleFrame.Parent = Parent or ContentFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.3, 0, 1, 0)
    ToggleButton.Position = UDim2.new(0.65, 0, 0, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 11
    ToggleButton.Text = "OFF"
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = ToggleFrame
    ToggleButton.AutoButtonColor = false
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleButton
    
    local IsOn = false
    
    ToggleButton.MouseButton1Click:Connect(function()
        IsOn = not IsOn
        if IsOn then
            ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            ToggleButton.Text = "ON"
        else
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            ToggleButton.Text = "OFF"
        end
        pcall(function()
            Callback(IsOn)
        end)
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
    TextBox.Parent = Parent or ContentFrame
    TextBox.ClearTextOnFocus = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = TextBox
    
    return TextBox
end

-- السلايدر المحسّن (يعمل مع الموبايل والكمبيوتر)
local function CreateSlider(Name, Position, Size, MinValue, MaxValue, DefaultValue, Callback, Parent)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = Name
    SliderFrame.Position = Position
    SliderFrame.Size = Size
    SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    SliderFrame.BorderSizePixel = 1
    SliderFrame.BorderColor3 = Color3.fromRGB(0, 200, 100)
    SliderFrame.Parent = Parent or ContentFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 0.35, 0)
    Label.Position = UDim2.new(0, 5, 0, 2)
    Label.BackgroundTransparency = 1
    Label.Text = Name
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, 0, 0.35, 0)
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
    SliderBar.Parent = SliderFrame
    
    local SliderBarCorner = Instance.new("UICorner")
    SliderBarCorner.CornerRadius = UDim.new(0, 3)
    SliderBarCorner.Parent = SliderBar
    
    -- TextButton (الصحيح)
    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(0, 14, 0, 18)
    SliderButton.Position = UDim2.new(0, 0, 0.5, -9)
    SliderButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    SliderButton.BorderSizePixel = 0
    SliderButton.Text = ""
    SliderButton.Parent = SliderBar
    SliderButton.AutoButtonColor = false
    
    local SliderButtonCorner = Instance.new("UICorner")
    SliderButtonCorner.CornerRadius = UDim.new(0, 3)
    SliderButtonCorner.Parent = SliderButton
    
    local CurrentValue = DefaultValue
    local Dragging = false
    
    local function UpdateSlider(X)
        local RelativeX = X - SliderBar.AbsolutePosition.X
        local Percentage = math.clamp(RelativeX / SliderBar.AbsoluteSize.X, 0, 1)
        CurrentValue = math.floor(MinValue + (MaxValue - MinValue) * Percentage)
        SliderButton.Position = UDim2.new(Percentage, -7, 0.5, -9)
        ValueLabel.Text = tostring(CurrentValue)
        pcall(function()
            Callback(CurrentValue)
        end)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        Dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(Input, GameProcessed)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or
           Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    -- إصلاح السلايدر للموبايل والكمبيوتر
    UserInputService.InputChanged:Connect(function(Input, GameProcessed)
        if Dragging and (
            Input.UserInputType == Enum.UserInputType.MouseMovement or
            Input.UserInputType == Enum.UserInputType.Touch
        ) then
            UpdateSlider(Input.Position.X)
        end
    end)
    
    SliderBar.InputBegan:Connect(function(Input, GameProcessed)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or
           Input.UserInputType == Enum.UserInputType.Touch then
            UpdateSlider(Input.Position.X)
            Dragging = true
        end
    end)
    
    return SliderFrame
end

local function CreateSection(Name, Position)
    local Section = Instance.new("Frame")
    Section.Name = Name
    Section.Size = UDim2.new(1, -20, 0, 40)
    Section.Position = Position
    Section.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    Section.BorderSizePixel = 0
    Section.Parent = ContentFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Section
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Section
    
    return Section
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    دوال الميزات الأساسية                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

local function FindPlayerByName(Name)
    if not Name or Name == "" then return nil end
    
    for _, Player in pairs(Players:GetPlayers()) do
        if Player.Name:lower():find(Name:lower(), 1, true) then
            return Player
        end
    end
    return nil
end

-- نظام الطيران المحسّن (يعمل مع الموبايل)
local function StartFlying()
    if Config.Flying then return end
    Config.Flying = true
    
    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BodyVelocity.Parent = RootPart
    
    local BodyGyro = Instance.new("BodyGyro")
    BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    BodyGyro.P = 9000
    BodyGyro.Parent = RootPart
    
    Config.FlyConnection = RunService.RenderStepped:Connect(function()
        if not Config.Flying then
            pcall(function() BodyVelocity:Destroy() end)
            pcall(function() BodyGyro:Destroy() end)
            if Config.FlyConnection then Config.FlyConnection:Disconnect() end
            return
        end
        
        if not RootPart then return end
        
        local Camera = workspace.CurrentCamera
        local MoveDirection = Vector3.new(0, 0, 0)
        
        -- دعم الكيبورد
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
        
        -- دعم الموبايل (استخدام Humanoid.MoveDirection)
        if Config.IsMobile and Humanoid then
            local MobileDirection = Humanoid.MoveDirection
            if MobileDirection.Magnitude > 0 then
                MoveDirection = MoveDirection + (MobileDirection * Vector3.new(1, 0, 1)).Unit
            end
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

-- نظام No Clip
local function EnableNoClip()
    if Config.NoClip then return end
    Config.NoClip = true
    
    Config.NoClipConnection = RunService.Stepped:Connect(function()
        if not Config.NoClip then
            if Config.NoClipConnection then Config.NoClipConnection:Disconnect() end
            return
        end
        
        if not Character then return end
        
        for _, Part in pairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CanCollide = false
            end
        end
    end)
end

local function DisableNoClip()
    Config.NoClip = false
    if Config.NoClipConnection then
        Config.NoClipConnection:Disconnect()
    end
    
    if Character then
        for _, Part in pairs(Character:GetDescendants()) do
            if Part:IsA("BasePart") then
                Part.CanCollide = true
            end
        end
    end
end

-- نظام Bang
local function BangPlayer(TargetPlayer, BangType)
    if not TargetPlayer or not TargetPlayer.Character then return end
    
    local TargetRootPart = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not TargetRootPart then return end
    
    if BangType == "front" then
        local BV = Instance.new("BodyVelocity")
        BV.Velocity = (TargetRootPart.Position - RootPart.Position).Unit * Config.BangPower
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Parent = TargetRootPart
        game:GetService("Debris"):AddItem(BV, 0.2)
    elseif BangType == "back" then
        local BV = Instance.new("BodyVelocity")
        BV.Velocity = (RootPart.Position - TargetRootPart.Position).Unit * Config.BangPower
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Parent = TargetRootPart
        game:GetService("Debris"):AddItem(BV, 0.2)
    elseif BangType == "up" then
        local BV = Instance.new("BodyVelocity")
        BV.Velocity = Vector3.new(0, Config.BangPower * 1.5, 0)
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Parent = TargetRootPart
        game:GetService("Debris"):AddItem(BV, 0.2)
    elseif BangType == "down" then
        local BV = Instance.new("BodyVelocity")
        BV.Velocity = Vector3.new(0, -Config.BangPower * 1.5, 0)
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Parent = TargetRootPart
        game:GetService("Debris"):AddItem(BV, 0.2)
    end
end

-- نظام Flung
local function FlungPlayer(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    
    local TargetRootPart = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not TargetRootPart then return end
    
    local Flung = Instance.new("BodyVelocity")
    Flung.Velocity = Vector3.new(
        math.random(-Config.FlungPower, Config.FlungPower),
        Config.FlungPower * 2,
        math.random(-Config.FlungPower, Config.FlungPower)
    )
    Flung.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    Flung.Parent = TargetRootPart
    
    game:GetService("Debris"):AddItem(Flung, 1)
end

-- نظام Aim Bot
local function EnableAimBot(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    
    Config.AimBot = true
    Config.TargetPlayer = TargetPlayer
    
    Config.AimBotConnection = RunService.RenderStepped:Connect(function()
        if not Config.AimBot or not Config.TargetPlayer or not Config.TargetPlayer.Character then
            if Config.AimBotConnection then Config.AimBotConnection:Disconnect() end
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

local function DisableAimBot()
    Config.AimBot = false
    if Config.AimBotConnection then
        Config.AimBotConnection:Disconnect()
    end
end

-- نظام Speed Boost
local function EnableSpeedBoost(Speed)
    Config.SpeedBoost = true
    pcall(function()
        Humanoid.WalkSpeed = Speed
    end)
end

local function DisableSpeedBoost()
    Config.SpeedBoost = false
    pcall(function()
        Humanoid.WalkSpeed = 16
    end)
end

-- نظام Anti Knockback
local function EnableAntiKnockback()
    if Config.AntiKnockback then return end
    Config.AntiKnockback = true
    
    Config.AntiKBConnection = RunService.Heartbeat:Connect(function()
        if not Config.AntiKnockback or not RootPart then
            if Config.AntiKBConnection then Config.AntiKBConnection:Disconnect() end
            return
        end
        
        RootPart.AssemblyLinearVelocity = Vector3.new(
            RootPart.AssemblyLinearVelocity.X * 0.95,
            RootPart.AssemblyLinearVelocity.Y,
            RootPart.AssemblyLinearVelocity.Z * 0.95
        )
    end)
end

local function DisableAntiKnockback()
    Config.AntiKnockback = false
    if Config.AntiKBConnection then
        Config.AntiKBConnection:Disconnect()
    end
end

-- نظام حفظ المواقع
local function SavePosition(Name)
    if not Name or Name == "" then return end
    Config.SavedPositions[Name] = RootPart.Position
end

local function LoadPosition(Name)
    if not Name or Name == "" or not Config.SavedPositions[Name] then return end
    pcall(function()
        RootPart.Position = Config.SavedPositions[Name]
    end)
end

local function TeleportToPlayer(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    pcall(function()
        RootPart.Position = TargetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
    end)
end

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    بناء الواجهة الرسومية                     ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- زر الإغلاق (الآن يخفي بدل الحذف)
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Config.GUIVisible = false
end)

local TargetNameBox = CreateTextBox("TargetNameBox", UDim2.new(0, 10, 0, 70), UDim2.new(1, -20, 0, 30), "اكتب اسم اللاعب", ContentFrame)
local SaveNameBox = CreateTextBox("SaveNameBox", UDim2.new(0, 10, 0, 110), UDim2.new(1, -20, 0, 30), "اسم الموقع", ContentFrame)

-- القسم الأول: الطيران
CreateSection("🚀 الطيران", UDim2.new(0, 10, 0, 150))
CreateButton("✈️ تفعيل الطيران", UDim2.new(0, 10, 0, 200), UDim2.new(0.45, -12, 0, 35), "تفعيل", function()
    if Config.Flying then
        StopFlying()
    else
        StartFlying()
    end
end, ContentFrame)

CreateButton("⛔ إيقاف الطيران", UDim2.new(0.5, 6, 0, 200), UDim2.new(0.45, -12, 0, 35), "إيقاف", function()
    StopFlying()
end, ContentFrame)

CreateSlider("سرعة الطيران", UDim2.new(0, 10, 0, 245), UDim2.new(1, -20, 0, 35), 5, 300, 50, function(Value)
    Config.FlySpeed = Value
end, ContentFrame)

-- القسم الثاني: الحركة والقفز
CreateSection("🏃 الحركة والقفز", UDim2.new(0, 10, 0, 290))
CreateToggleButton("💨 سرعة الجري", UDim2.new(0, 10, 0, 340), UDim2.new(1, -20, 0, 30), "تفعيل سرعة الجري", function(IsOn)
    if IsOn then
        EnableSpeedBoost(50)
    else
        DisableSpeedBoost()
    end
end, ContentFrame)

CreateSlider("سرعة الجري", UDim2.new(0, 10, 0, 380), UDim2.new(1, -20, 0, 35), 16, 200, 50, function(Value)
    Config.WalkSpeed = Value
    if Config.SpeedBoost then
        EnableSpeedBoost(Value)
    end
end, ContentFrame)

CreateSlider("قوة النط", UDim2.new(0, 10, 0, 425), UDim2.new(1, -20, 0, 35), 20, 500, 50, function(Value)
    Config.JumpPower = Value
    pcall(function()
        Humanoid.JumpPower = Value
    end)
end, ContentFrame)

-- القسم الثالث: اختراق الجدران
CreateSection("👻 اختراق الجدران", UDim2.new(0, 10, 0, 470))
CreateToggleButton("No Clip", UDim2.new(0, 10, 0, 520), UDim2.new(1, -20, 0, 30), "اختراق الجدران", function(IsOn)
    if IsOn then
        EnableNoClip()
    else
        DisableNoClip()
    end
end, ContentFrame)

-- القسم الرابع: الاستهداف
CreateSection("🎯 نظام الاستهداف", UDim2.new(0, 10, 0, 560))
CreateButton("💥 Bang أمامي", UDim2.new(0, 10, 0, 620), UDim2.new(0.45, -12, 0, 30), "أمام", function()
    local Target = FindPlayerByName(TargetNameBox.Text)
    if Target then
        BangPlayer(Target, "front")
    end
end, ContentFrame)

CreateButton("💥 Bang خلفي", UDim2.new(0.5, 6, 0, 620), UDim2.new(0.45, -12, 0, 30), "خلف", function()
    local Target = FindPlayerByName(TargetNameBox.Text)
    if Target then
        BangPlayer(Target, "back")
    end
end, ContentFrame)

CreateButton("⬆️ Bang للأعلى", UDim2.new(0, 10, 0, 660), UDim2.new(0.45, -12, 0, 30), "أعلى", function()
    local Target = FindPlayerByName(TargetNameBox.Text)
    if Target then
        BangPlayer(Target, "up")
    end
end, ContentFrame)

CreateButton("⬇️ Bang للأسفل", UDim2.new(0.5, 6, 0, 660), UDim2.new(0.45, -12, 0, 30), "أسفل", function()
    local Target = FindPlayerByName(TargetNameBox.Text)
    if Target then
        BangPlayer(Target, "down")
    end
end, ContentFrame)

CreateButton("🌪️ Flung", UDim2.new(0, 10, 0, 700), UDim2.new(0.45, -12, 0, 30), "Flung", function()
    local Target = FindPlayerByName(TargetNameBox.Text)
    if Target then
        FlungPlayer(Target)
    end
end, ContentFrame)

CreateButton("🔫 Aim Bot", UDim2.new(0.5, 6, 0, 700), UDim2.new(0.45, -12, 0, 30), "Aim", function()
    local Target = FindPlayerByName(TargetNameBox.Text)
    if Target then
        EnableAimBot(Target)
    else
        DisableAimBot()
    end
end, ContentFrame)

CreateButton("📍 تنقل للاعب", UDim2.new(0, 10, 0, 740), UDim2.new(0.45, -12, 0, 30), "تنقل", function()
    local Target = FindPlayerByName(TargetNameBox.Text)
    if Target then
        TeleportToPlayer(Target)
    end
end, ContentFrame)

CreateSlider("قوة Bang", UDim2.new(0, 10, 0, 780), UDim2.new(1, -20, 0, 35), 50, 300, 150, function(Value)
    Config.BangPower = Value
end, ContentFrame)

CreateSlider("قوة Flung", UDim2.new(0, 10, 0, 825), UDim2.new(1, -20, 0, 35), 50, 500, 250, function(Value)
    Config.FlungPower = Value
end, ContentFrame)

-- القسم الخامس: الحماية
CreateSection("🛡️ الحماية", UDim2.new(0, 10, 0, 870))
CreateToggleButton("🛡️ مضاد الضربات", UDim2.new(0, 10, 0, 920), UDim2.new(1, -20, 0, 30), "مضاد الضربات", function(IsOn)
    if IsOn then
        EnableAntiKnockback()
    else
        DisableAntiKnockback()
    end
end, ContentFrame)

-- القسم السادس: حفظ المواقع
CreateSection("💾 حفظ المواقع", UDim2.new(0, 10, 0, 960))
CreateButton("💾 حفظ الموقع", UDim2.new(0, 10, 0, 1020), UDim2.new(0.45, -12, 0, 30), "حفظ", function()
    SavePosition(SaveNameBox.Text)
    SaveNameBox.Text = ""
end, ContentFrame)

CreateButton("📂 تحميل الموقع", UDim2.new(0.5, 6, 0, 1020), UDim2.new(0.45, -12, 0, 30), "تحميل", function()
    LoadPosition(SaveNameBox.Text)
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
            MainFrame.Visible = false
            Config.GUIVisible = false
        else
            MainFrame.Visible = true
            Config.GUIVisible = true
        end
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
    Config.AimBot = false
    Config.SpeedBoost = false
    Config.AntiKnockback = false
    
    if Config.FlyConnection then Config.FlyConnection:Disconnect() end
    if Config.NoClipConnection then Config.NoClipConnection:Disconnect() end
    if Config.AimBotConnection then Config.AimBotConnection:Disconnect() end
    if Config.AntiKBConnection then Config.AntiKBConnection:Disconnect() end
end)

-- ╔═══════════════════════════════════════════════════════════════╗
-- ║                    رسالة التحميل                             ║
-- ╚═══════════════════════════════════════════════════════════════╝

print("✅ تم تحميل السكربت بنجاح!")
print("📱 متوافق مع الهواتف والكمبيوتر")
print("🎮 اضغط X لإظهار/إخفاء الواجهة")
print("⌨️ اضغط F لتفعيل الطيران")
print("⌨️ اضغط G لاختراق الجدران")
print("🚀 السكربت جاهز للاستخدام في Delta!")
