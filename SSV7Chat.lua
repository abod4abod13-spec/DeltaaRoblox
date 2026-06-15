-- ⚡ SSV7 Chat Pro - Final Delta 100% ⚡
local lp = game.Players.LocalPlayer
local Players = game.Players

-- المتغيرات
local stickers = {
    {Name = "كل تبن", Emoji = "💩"}, {Name = "يا حمار", Emoji = "🐴"}, {Name = "انقلع", Emoji = "👋"},
    {Name = "بس يلا", Emoji = "😒"}, {Name = "ههههه", Emoji = "😂"}, {Name = "ما فهمت", Emoji = "🤔"},
    {Name = "يعمي", Emoji = "🙄"}, {Name = "اسكت", Emoji = "🤫"}, {Name = "يلا بينا", Emoji = "🏃"},
    {Name = "ميت ضحك", Emoji = "💀"}, {Name = "قطة", Emoji = "😹"}, {Name = "كلب", Emoji = "🐶"},
    {Name = "قرد", Emoji = "🐵"}, {Name = "بطريق", Emoji = "🐧"}, {Name = "يونيكورن", Emoji = "🦄"},
    {Name = "ديناصور", Emoji = "🦖"}, {Name = "قلب", Emoji = "❤️"}, {Name = "نار", Emoji = "🔥"},
    {Name = "قوس قزح", Emoji = "🌈"}, {Name = "جمجمة", Emoji = "💀"}, {Name = "أحسنت", Emoji = "👍"},
    {Name = "لا", Emoji = "👎"}, {Name = "قوي", Emoji = "💪"}, {Name = "دماغ", Emoji = "🧠"},
    {Name = "تاج", Emoji = "👑"}, {Name = "صاروخ", Emoji = "🚀"}, {Name = "قنبلة", Emoji = "💣"},
    {Name = "هدية", Emoji = "🎁"}, {Name = "وردة", Emoji = "🌹"}, {Name = "تباً", Emoji = "🤬"},
    {Name = "أسد", Emoji = "🦁"}, {Name = "نمر", Emoji = "🐯"}, {Name = "ذئب", Emoji = "🐺"},
    {Name = "ثعلب", Emoji = "🦊"}, {Name = "باندا", Emoji = "🐼"}, {Name = "أرنب", Emoji = "🐰"},
    {Name = "ضفدع", Emoji = "🐸"}, {Name = "خنزير", Emoji = "🐷"}, {Name = "بقرة", Emoji = "🐮"},
    {Name = "بومة", Emoji = "🦉"}, {Name = "بيتزا", Emoji = "🍕"}, {Name = "برغر", Emoji = "🍔"},
    {Name = "دونات", Emoji = "🍩"}, {Name = "آيس كريم", Emoji = "🍦"}, {Name = "قهوة", Emoji = "☕"},
    {Name = "كرة", Emoji = "⚽"}, {Name = "سيارة", Emoji = "🚗"}, {Name = "طائرة", Emoji = "✈️"},
    {Name = "شمس", Emoji = "☀️"}, {Name = "قمر", Emoji = "🌙"},
}

local messages = {}
local msgId = 0
local myAvatar = ""
local headMessages = {}
local onlinePlayers = {}

spawn(function() pcall(function() myAvatar = Players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) end) end)

-- رسالة فوق الرأس
local function showHeadMsg(text)
    local char = lp.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    
    local msgData = {Text = text, Time = tick(), Billboard = nil}
    table.insert(headMessages, msgData)
    
    while #headMessages > 3 do
        local old = table.remove(headMessages, 1)
        if old.Billboard then old.Billboard:Destroy() end
    end
    
    -- ترتيب من الأحدث للأقدم
    for _, msg in pairs(headMessages) do if msg.Billboard then msg.Billboard:Destroy() end end
    
    local yOffset = 0
    for i = #headMessages, 1, -1 do
        local msg = headMessages[i]
        local textSize = game:GetService("TextService"):GetTextSize(msg.Text, 13, "GothamBlack", Vector2.new(170, math.huge))
        
        local bb = Instance.new("BillboardGui")
        bb.Name = "ChatBubble"
        bb.Size = UDim2.new(0, textSize.X + 24, 0, textSize.Y + 16)
        bb.StudsOffset = Vector3.new(0, 3.5 + yOffset, 0)
        bb.AlwaysOnTop = true
        bb.MaxDistance = 60
        bb.Parent = head
        
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bg.BackgroundTransparency = 0.02
        bg.Parent = bb
        local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = bg
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -12, 1, 0)
        label.Position = UDim2.new(0, 6, 0, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(0, 0, 0)
        label.Text = msg.Text
        label.TextSize = 13
        label.Font = Enum.Font.GothamBlack
        label.TextWrapped = true
        label.Parent = bg
        
        msg.Billboard = bb
        yOffset = yOffset + textSize.Y + 18
        
        local msgRef = msg
        spawn(function()
            task.wait(20)
            if msgRef.Billboard then
                for t = 1, 10 do
                    if msgRef.Billboard then
                        pcall(function() msgRef.Billboard.BackgroundTransparency = t/10 end)
                    end
                    task.wait(0.05)
                end
                if msgRef.Billboard then msgRef.Billboard:Destroy() end
            end
            for j, m in pairs(headMessages) do if m == msgRef then table.remove(headMessages, j); break end end
        end)
    end
end

-- إشعار
local function noti(title, text)
    local nf = Instance.new("Frame")
    nf.Size = UDim2.new(0, 250, 0, 50)
    nf.Position = UDim2.new(1, -260, 0, -60)
    nf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    nf.BackgroundTransparency = 0.3
    nf.BorderSizePixel = 2
    nf.BorderColor3 = Color3.fromRGB(0, 200, 255)
    nf.Parent = gui
    
    local nc = Instance.new("UICorner"); nc.CornerRadius = UDim.new(0, 10); nc.Parent = nf
    
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, -10, 0, 18)
    tl.Position = UDim2.new(0, 5, 0, 5)
    tl.BackgroundTransparency = 1
    tl.Text = title
    tl.TextColor3 = Color3.fromRGB(0, 255, 255)
    tl.TextSize = 12
    tl.Font = Enum.Font.GothamBlack
    tl.TextXAlignment = Enum.TextXAlignment.Left
    tl.Parent = nf
    
    local tx = Instance.new("TextLabel")
    tx.Size = UDim2.new(1, -10, 0, 16)
    tx.Position = UDim2.new(0, 5, 0, 26)
    tx.BackgroundTransparency = 1
    tx.Text = text
    tx.TextColor3 = Color3.fromRGB(255, 255, 255)
    tx.TextSize = 10
    tx.Font = Enum.Font.Gotham
    tx.TextXAlignment = Enum.TextXAlignment.Left
    tx.Parent = nf
    
    -- دخول من اليمين
    spawn(function()
        for i = 1, 10 do
            nf.Position = UDim2.new(1, -260, 0, -60 + i * 8)
            task.wait(0.02)
        end
        task.wait(4)
        for i = 1, 10 do
            nf.Position = UDim2.new(1, -260, 0, 20 - i * 8)
            task.wait(0.02)
        end
        nf:Destroy()
    end)
end

-- واجهة
local gui = Instance.new("ScreenGui")
gui.Name = "SSV7_ChatPro"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = lp:WaitForChild("PlayerGui")

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 100, 0, 30)
openBtn.Position = UDim2.new(0.5, -50, 0.5, -15)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openBtn.BackgroundTransparency = 0.5
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Text = "💬 Chat"
openBtn.TextSize = 12
openBtn.Font = Enum.Font.GothamBlack
openBtn.Draggable = true
openBtn.BorderSizePixel = 2
openBtn.BorderColor3 = Color3.fromRGB(0, 200, 255)
openBtn.Parent = gui
local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0, 9); c1.Parent = openBtn

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 380)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0.85
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
local c2 = Instance.new("UICorner"); c2.CornerRadius = UDim.new(0, 12); c2.Parent = mainFrame

local glassBg = Instance.new("Frame")
glassBg.Size = UDim2.new(1, 0, 1, 0)
glassBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
glassBg.BackgroundTransparency = 0.6
glassBg.Parent = mainFrame
local cg = Instance.new("UICorner"); cg.CornerRadius = UDim.new(0, 12); cg.Parent = glassBg

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.BackgroundTransparency = 0.5
titleBar.Parent = mainFrame
local c3 = Instance.new("UICorner"); c3.CornerRadius = UDim.new(0, 12); c3.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "💬 Chat Pro"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local onlineLabel = Instance.new("TextLabel")
onlineLabel.Size = UDim2.new(0, 40, 1, 0)
onlineLabel.Position = UDim2.new(1, -70, 0, 0)
onlineLabel.BackgroundTransparency = 1
onlineLabel.Text = "🟢0"
onlineLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
onlineLabel.TextSize = 9
onlineLabel.Font = Enum.Font.Gotham
onlineLabel.TextXAlignment = Enum.TextXAlignment.Right
onlineLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -28, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "✕"
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
local c4 = Instance.new("UICorner"); c4.CornerRadius = UDim.new(0, 11); c4.Parent = closeBtn

local chatArea = Instance.new("ScrollingFrame")
chatArea.Size = UDim2.new(1, -16, 1, -88)
chatArea.Position = UDim2.new(0, 8, 0, 32)
chatArea.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
chatArea.BackgroundTransparency = 0.7
chatArea.BorderSizePixel = 1
chatArea.BorderColor3 = Color3.fromRGB(0, 200, 255)
chatArea.ScrollBarThickness = 4
chatArea.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
chatArea.CanvasSize = UDim2.new(0, 0, 0, 0)
chatArea.ScrollingEnabled = true
chatArea.ClipsDescendants = true
chatArea.Parent = mainFrame
local c5 = Instance.new("UICorner"); c5.CornerRadius = UDim.new(0, 6); c5.Parent = chatArea

local chatList = Instance.new("UIListLayout")
chatList.Parent = chatArea
chatList.Padding = UDim.new(0, 4)

local stickerPanel = Instance.new("Frame")
stickerPanel.Size = UDim2.new(1, -16, 0, 0)
stickerPanel.Position = UDim2.new(0, 8, 0, 32)
stickerPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
stickerPanel.BackgroundTransparency = 0.4
stickerPanel.BorderSizePixel = 1
stickerPanel.BorderColor3 = Color3.fromRGB(0, 200, 255)
stickerPanel.Visible = false
stickerPanel.ClipsDescendants = true
stickerPanel.Parent = mainFrame
local c10 = Instance.new("UICorner"); c10.CornerRadius = UDim.new(0, 8); c10.Parent = stickerPanel

local stickerScroll = Instance.new("ScrollingFrame")
stickerScroll.Size = UDim2.new(1, -8, 1, -8)
stickerScroll.Position = UDim2.new(0, 4, 0, 4)
stickerScroll.BackgroundTransparency = 1
stickerScroll.ScrollBarThickness = 4
stickerScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
stickerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
stickerScroll.ScrollingEnabled = true
stickerScroll.Parent = stickerPanel

local stickerGrid = Instance.new("UIGridLayout")
stickerGrid.CellSize = UDim2.new(0, 38, 0, 38)
stickerGrid.CellPadding = UDim2.new(0, 3, 0, 3)
stickerGrid.FillDirection = Enum.FillDirection.Horizontal
stickerGrid.Parent = stickerScroll

for _, sticker in pairs(stickers) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 38, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.5
    btn.Text = sticker.Emoji
    btn.TextSize = 18
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 200, 255)
    btn.Parent = stickerScroll
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = btn
    btn.MouseButton1Click:Connect(function()
        sendMessage(sticker.Emoji .. " " .. sticker.Name, true)
        stickerPanel.Visible = false; stickerPanel.Size = UDim2.new(1, -16, 0, 0)
        chatArea.Position = UDim2.new(0, 8, 0, 32); chatArea.Size = UDim2.new(1, -16, 1, -88)
    end)
end
stickerScroll.CanvasSize = UDim2.new(0, 0, 0, stickerGrid.AbsoluteContentSize.Y + 10)

local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(1, -16, 0, 38)
inputFrame.Position = UDim2.new(0, 8, 1, -56)
inputFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
inputFrame.BackgroundTransparency = 0.5
inputFrame.BorderSizePixel = 1
inputFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)
inputFrame.Parent = mainFrame
local c6 = Instance.new("UICorner"); c6.CornerRadius = UDim.new(0, 19); c6.Parent = inputFrame

local stickerBtn = Instance.new("TextButton")
stickerBtn.Size = UDim2.new(0, 28, 0, 28)
stickerBtn.Position = UDim2.new(0, 5, 0, 5)
stickerBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
stickerBtn.BackgroundTransparency = 0.4
stickerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stickerBtn.Text = "😀"
stickerBtn.TextSize = 13
stickerBtn.Font = Enum.Font.GothamBlack
stickerBtn.BorderSizePixel = 0
stickerBtn.Parent = inputFrame
local c7 = Instance.new("UICorner"); c7.CornerRadius = UDim.new(0, 14); c7.Parent = stickerBtn

local chatInput = Instance.new("TextBox")
chatInput.Size = UDim2.new(1, -68, 0, 28)
chatInput.Position = UDim2.new(0, 38, 0, 5)
chatInput.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
chatInput.BackgroundTransparency = 0.3
chatInput.TextColor3 = Color3.fromRGB(255, 255, 255)
chatInput.PlaceholderText = "اكتب رسالة..."
chatInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
chatInput.Text = ""
chatInput.TextSize = 12
chatInput.Font = Enum.Font.Gotham
chatInput.BorderSizePixel = 0
chatInput.ClearTextOnFocus = false
chatInput.Parent = inputFrame
local c8 = Instance.new("UICorner"); c8.CornerRadius = UDim.new(0, 14); c8.Parent = chatInput

local sendBtn = Instance.new("TextButton")
sendBtn.Size = UDim2.new(0, 28, 0, 28)
sendBtn.Position = UDim2.new(1, -33, 0, 5)
sendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
sendBtn.BackgroundTransparency = 0.3
sendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sendBtn.Text = "📤"
sendBtn.TextSize = 13
sendBtn.Font = Enum.Font.GothamBlack
sendBtn.BorderSizePixel = 0
sendBtn.Parent = inputFrame
local c9 = Instance.new("UICorner"); c9.CornerRadius = UDim.new(0, 14); c9.Parent = sendBtn

-- ========== دوال ==========

function sendMessage(text, isSticker)
    if text == "" then return end
    local msg = {Id = msgId, Player = lp, Text = text, Time = os.date("%I:%M"), IsSticker = isSticker or false, Avatar = myAvatar}
    msgId = msgId + 1
    table.insert(messages, msg)
    showHeadMsg(text)
    chatInput.Text = ""
    updateChat()
    if #messages > 50 then table.remove(messages, 1); updateChat() end
end

function updateChat()
    chatArea:ClearAllChildren()
    for _, msg in pairs(messages) do
        local isMine = (msg.Player == lp)
        local textSize = game:GetService("TextService"):GetTextSize(msg.Text, 11, "Gotham", Vector2.new(200, math.huge))
        
        local msgFrame = Instance.new("Frame")
        msgFrame.Size = UDim2.new(1, -4, 0, textSize.Y + 30)
        msgFrame.BackgroundTransparency = 1
        msgFrame.Parent = chatArea
        
        local avatar = Instance.new("ImageLabel")
        avatar.Size = UDim2.new(0, 26, 0, 26)
        avatar.Position = UDim2.new(0, 3, 0, 2)
        avatar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        avatar.BackgroundTransparency = 0.3
        avatar.Image = msg.Avatar ~= "" and msg.Avatar or "rbxasset://textures/ui/GuiImagePlaceholder.png"
        avatar.Parent = msgFrame
        local ac = Instance.new("UICorner"); ac.CornerRadius = UDim.new(0, 13); ac.Parent = avatar
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -36, 0, 14)
        nameLabel.Position = UDim2.new(0, 34, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = (isMine and "أنت" or msg.Player.DisplayName) .. " • " .. msg.Time
        nameLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        nameLabel.TextSize = 9
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = msgFrame
        
        local bubble = Instance.new("Frame")
        bubble.Size = UDim2.new(0, textSize.X + 16, 0, textSize.Y + 12)
        bubble.Position = UDim2.new(0, 30, 0, 16)
        bubble.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bubble.BackgroundTransparency = 0.5
        bubble.Parent = msgFrame
        local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 8); bc.Parent = bubble
        
        local bubbleText = Instance.new("TextLabel")
        bubbleText.Size = UDim2.new(1, -10, 1, 0)
        bubbleText.Position = UDim2.new(0, 5, 0, 0)
        bubbleText.BackgroundTransparency = 1
        bubbleText.TextColor3 = Color3.fromRGB(255, 255, 255)
        bubbleText.Text = msg.Text
        bubbleText.TextSize = 11
        bubbleText.Font = Enum.Font.Gotham
        bubbleText.TextWrapped = true
        bubbleText.TextXAlignment = Enum.TextXAlignment.Left
        bubbleText.RichText = false
        bubbleText.Parent = bubble
        
        msgFrame.Size = UDim2.new(1, -4, 0, textSize.Y + 32)
        
        local clicked = false; local clickTime = 0
        bubble.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then clicked = true; clickTime = tick() end
        end)
        bubble.InputEnded:Connect(function()
            if clicked and tick() - clickTime > 0.4 and msg.Player == lp then showMsgOptions(msg, bubble) end
            clicked = false
        end)
    end
    chatArea.CanvasSize = UDim2.new(0, 0, 0, chatList.AbsoluteContentSize.Y + 20)
    spawn(function() chatArea.CanvasPosition = Vector2.new(0, 0) end)
end

function showMsgOptions(msg, bubble)
    local old = mainFrame:FindFirstChild("MsgOpts"); if old then old:Destroy() end
    local opt = Instance.new("Frame")
    opt.Name = "MsgOpts"; opt.Size = UDim2.new(0, 110, 0, 24)
    opt.Position = UDim2.new(0, bubble.AbsolutePosition.X - mainFrame.AbsolutePosition.X, 0, bubble.AbsolutePosition.Y - mainFrame.AbsolutePosition.Y - 26)
    opt.BackgroundColor3 = Color3.fromRGB(0, 0, 0); opt.BackgroundTransparency = 0.2
    opt.BorderSizePixel = 1; opt.BorderColor3 = Color3.fromRGB(0, 200, 255)
    opt.Parent = mainFrame
    local oc = Instance.new("UICorner"); oc.CornerRadius = UDim.new(0, 5); oc.Parent = opt
    
    local btns = {
        {"📋", Color3.fromRGB(0, 100, 200), function() pcall(function() setclipboard(msg.Text) end); opt:Destroy() end},
        {"↩️", Color3.fromRGB(0, 150, 0), function() chatInput.Text = "@" .. msg.Player.DisplayName .. " "; chatInput:CaptureFocus(); opt:Destroy() end},
        {"🗑", Color3.fromRGB(200, 0, 0), function() for i, m in pairs(messages) do if m.Id == msg.Id then table.remove(messages, i); break end end; updateChat(); opt:Destroy() end},
    }
    for i, b in pairs(btns) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.32, 0, 1, 0); btn.Position = UDim2.new((i-1)*0.34, 0, 0, 0)
        btn.BackgroundColor3 = b[2]; btn.BackgroundTransparency = 0.3
        btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.Text = b[1]; btn.TextSize = 10
        btn.Font = Enum.Font.GothamBlack; btn.BorderSizePixel = 0; btn.Parent = opt
        local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 3); bc.Parent = btn
        btn.MouseButton1Click:Connect(b[3])
    end
    game.Debris:AddItem(opt, 3)
end

-- ========== أحداث ==========
openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        chatInput:CaptureFocus()
        updateChat()
        -- إشعار فتح
        noti("💬 Chat Pro", "تم فتح الشات!")
    end
end)

closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)
sendBtn.MouseButton1Click:Connect(function() sendMessage(chatInput.Text, false) end)

chatInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and chatInput.Text ~= "" then sendMessage(chatInput.Text, false) end
end)

stickerBtn.MouseButton1Click:Connect(function()
    stickerPanel.Visible = not stickerPanel.Visible
    if stickerPanel.Visible then
        stickerPanel.Size = UDim2.new(1, -16, 0, 135)
        chatArea.Position = UDim2.new(0, 8, 0, 170)
        chatArea.Size = UDim2.new(1, -16, 1, -226)
    else
        stickerPanel.Size = UDim2.new(1, -16, 0, 0)
        chatArea.Position = UDim2.new(0, 8, 0, 32)
        chatArea.Size = UDim2.new(1, -16, 1, -88)
    end
end)

mainFrame.InputBegan:Connect(function() local o = mainFrame:FindFirstChild("MsgOpts"); if o then o:Destroy() end end)

-- إشعار عند دخول لاعب
Players.PlayerAdded:Connect(function(plr)
    if plr ~= lp then
        noti("👋 لاعب دخل", plr.DisplayName .. " دخل السيرفر!")
    end
end)

-- إشعار عند خروج لاعب
Players.PlayerRemoving:Connect(function(plr)
    if plr ~= lp then
        noti("👋 لاعب خرج", plr.DisplayName .. " خرج من السيرفر!")
    end
end)

print("✅ Chat Pro Delta جاهز!")
