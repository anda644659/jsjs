local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local isRunning = false
local speed = 55  -- 默认值，可由输入框修改

-- 创建UI（右上角 + 可拖动 + 输入框）
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 190)      -- 高度增加，容纳输入框
frame.Position = UDim2.new(1, -210, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🚀 视角冲刺"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = frame

local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(1, 0, 0, 25)
speedText.Position = UDim2.new(0, 0, 0, 38)
speedText.Text = "当前速度: " .. speed
speedText.TextColor3 = Color3.fromRGB(255, 200, 50)
speedText.TextScaled = true
speedText.BackgroundTransparency = 1
speedText.Font = Enum.Font.GothamBold
speedText.Parent = frame

-- ===== 速度输入框（新增） =====
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0, 140, 0, 30)
inputBox.Position = UDim2.new(0.5, -70, 0, 68)
inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
inputBox.BackgroundTransparency = 0.3
inputBox.Text = "55"
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextScaled = true
inputBox.Font = Enum.Font.GothamBold
inputBox.PlaceholderText = "输入速度数值"
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = inputBox

-- 输入框失去焦点时更新速度
inputBox.FocusLost:Connect(function(enterPressed)
    local val = tonumber(inputBox.Text)
    if val and val > 0 then
        speed = val
        speedText.Text = "当前速度: " .. speed
        print("⚡ 速度已设置为: " .. speed)
        -- 如果正在运行，实时更新bodyVelocity速度
        if isRunning and bodyVelocity then
            -- 不需要额外操作，循环中会读取speed变量
        end
    else
        inputBox.Text = tostring(speed)  -- 恢复原值
    end
end)

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 140, 0, 40)
btn.Position = UDim2.new(0.5, -70, 0, 108)   -- 下移，给输入框让位
btn.Text = "开启"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextScaled = true
btn.Font = Enum.Font.GothamBold
btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
btn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = btn

local bodyVelocity = nil
local loopConn = nil

-- 开关
btn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    
    if isRunning then
        btn.Text = "关闭"
        btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        speedText.Text = "当前速度: " .. speed .. " (冲刺)"
        print("🚀 开启：视角方向冲刺，速度" .. speed)
        
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e9, 0, 1e9)
        bodyVelocity.Parent = root
        
        if loopConn then loopConn:Disconnect() end
        loopConn = game:GetService("RunService").Stepped:Connect(function()
            if not isRunning or not bodyVelocity then
                if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
                return
            end
            
            local charNow = player.Character
            if not charNow then return end
            local rootNow = charNow:FindFirstChild("HumanoidRootPart")
            if not rootNow or rootNow ~= bodyVelocity.Parent then
                bodyVelocity.Parent = rootNow
            end
            
            local look = camera.CFrame.LookVector
            look = Vector3.new(look.X, 0, look.Z).Unit
            if look.Magnitude > 0 then
                bodyVelocity.Velocity = look * speed   -- 使用当前speed变量
            end
            
            local humanoid = charNow:FindFirstChild("Humanoid")
            if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        btn.Text = "开启"
        btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        speedText.Text = "当前速度: " .. speed
        if loopConn then loopConn:Disconnect() loopConn = nil end
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
        print("❌ 已关闭")
    end
end)

print("✅ 加载完成 | 速度可调，输入数字后自动生效")
print("📌 点「开启」视角实时控制冲刺方向")