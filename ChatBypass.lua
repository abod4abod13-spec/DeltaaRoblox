-- ⚡ SSV7 Chat Bypass - Delta Edition ⚡
local lp = game.Players.LocalPlayer

-- دالة إرسال الرسالة بكل الطرق الممكنة
local function sendChat(msg)
    -- الطريقة 1: TextChatService (للمابات الجديدة)
    pcall(function()
        local textChat = game:GetService("TextChatService")
        if textChat.ChatInputBarConfiguration then
            local channels = textChat:WaitForChild("TextChannels", 5)
            if channels then
                local general = channels:WaitForChild("RBXGeneral", 5)
                if general then
                    general:SendAsync(msg)
                    return
                end
            end
        end
    end)
    
    -- الطريقة 2: ReplicatedStorage (للمابات القديمة)
    pcall(function()
        local chatEvents = game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if chatEvents then
            local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
            if sayMessage then
                sayMessage:FireServer(msg, "All")
                return
            end
        end
    end)
    
    -- الطريقة 3: Players.Chatted
    pcall(function()
        local chatService = game:GetService("Chat")
        if chatService then
            chatService:Chat(lp.Character.Head, msg, "All")
        end
    end)
    
    -- الطريقة 4: مباشر على TextChannel
    pcall(function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("TextChannel") then
                obj:SendAsync(msg)
                break
            end
        end
    end)
    
    -- الطريقة 5: الإرسال المباشر
    pcall(function()
        lp.Chatted:Fire(msg)
    end)
end

-- إنشاء الواجهة
local gui = Instance.new("ScreenGui")
gui.Name = "SSV7_Chat"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = lp:WaitForChild("PlayerGui")

-- زر فتح الشات
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 180, 0, 50)
openBtn.Position = UDim2.new(0.5, -90, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openBtn.BackgroundTransparency = 0.3
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Text = "💬 اضغط للشات"
openBtn.TextSize = 18
openBtn.Font = Enum.Font.GothamBlack
openBtn.Draggable = true
openBtn.BorderSizePixel = 4
openBtn.BorderColor3 = Color3.fromRGB(0, 255, 255)
openBtn.Parent = gui

local corner1 = Instance.new("UICorner")
corner1.CornerRadius = UDim.new(0, 14)
corner1.Parent = openBtn

-- إطار الشات
local chatFrame = Instance.new("Frame")
chatFrame.Size = UDim2.new(0, 350, 0, 150)
chatFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
chatFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
chatFrame.BorderSizePixel = 3
chatFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)
chatFrame.Visible = false
chatFrame.Parent = gui

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 14)
corner2.Parent = chatFrame

-- عنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "💬 Chat Bypass"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBlack
title.Parent = chatFrame

-- مربع النص
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -40, 0, 40)
textBox.Position = UDim2.new(0, 20, 0, 45)
textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "اكتب رسالتك هنا..."
textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
textBox.Text = ""
textBox.TextSize = 16
textBox.Font = Enum.Font.Gotham
textBox.BorderSizePixel = 2
textBox.BorderColor3 = Color3.fromRGB(0, 255, 255)
textBox.ClearTextOnFocus = false
textBox.Parent = chatFrame

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 8)
corner3.Parent = textBox

-- زر الإرسال
local sendBtn = Instance.new("TextButton")
sendBtn.Size = UDim2.new(1, -40, 0, 40)
sendBtn.Position = UDim2.new(0, 20, 0, 95)
sendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
sendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sendBtn.Text = "📤 إرسال للجميع"
sendBtn.TextSize = 16
sendBtn.Font = Enum.Font.GothamBlack
sendBtn.BorderSizePixel = 0
sendBtn.Parent = chatFrame

local corner4 = Instance.new("UICorner")
corner4.CornerRadius = UDim.new(0, 10)
corner4.Parent = sendBtn

-- زر الإغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "✕"
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.BorderSizePixel = 0
closeBtn.Parent = chatFrame

local corner5 = Instance.new("UICorner")
corner5.CornerRadius = UDim.new(0, 15)
corner5.Parent = closeBtn

-- أحداث
openBtn.MouseButton1Click:Connect(function()
    chatFrame.Visible = not chatFrame.Visible
    if chatFrame.Visible then
        textBox:CaptureFocus()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    chatFrame.Visible = false
end)

sendBtn.MouseButton1Click:Connect(function()
    local msg = textBox.Text
    if msg ~= "" then
        sendChat(msg)
        textBox.Text = ""
    end
end)

-- إرسال مع Enter
textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local msg = textBox.Text
        if msg ~= "" then
            sendChat(msg)
            textBox.Text = ""
        end
    end
end)

print("✅ Chat Bypass جاهز!")
