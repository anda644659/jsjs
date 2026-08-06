-- ===== 强制退出面板（含倒计时） =====
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 160)
frame.Position = UDim2.new(0.5, -150, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 10)
title.Text = "⚠️ 该脚本已过期，请加群获取最新脚本代码"
title.TextColor3 = Color3.fromRGB(255, 200, 50)
title.TextScaled = true
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 160, 0, 40)
btn.Position = UDim2.new(0.5, -80, 0, 60)
btn.Text = "📋 复制QQ群"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextScaled = true
btn.Font = Enum.Font.GothamBold
btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
btn.Parent = frame
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = btn

local qqNumber = "1020592687"
btn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard(qqNumber)
        else
            game:GetService("StarterGui"):SetCore("CopyToClipboard", {Text = qqNumber})
        end
    end)
    btn.Text = "✅ 已复制"
    btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    task.wait(1)
    btn.Text = "📋 复制QQ群"
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
end)

local countdownLabel = Instance.new("TextLabel")
countdownLabel.Size = UDim2.new(1, -20, 0, 30)
countdownLabel.Position = UDim2.new(0, 10, 0, 115)
countdownLabel.Text = "⏳ 10秒后将被踢出"
countdownLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
countdownLabel.TextScaled = true
countdownLabel.BackgroundTransparency = 1
countdownLabel.Font = Enum.Font.GothamBold
countdownLabel.Parent = frame

-- 倒计时逻辑
local seconds = 10
coroutine.wrap(function()
    while seconds > 0 do
        countdownLabel.Text = "⏳ " .. seconds .. "秒后将被踢出"
        task.wait(1)
        seconds = seconds - 1
    end
    countdownLabel.Text = "⏹ 正在退出..."
    task.wait(0.5)
    game:Shutdown()  -- 强制退出游戏
end)()