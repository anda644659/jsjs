local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ===== 全局变量 =====
local speed = 55
local running = false
local bodyVelocity = nil
local loopConn = nil
local subUI = nil
local mainUI = nil
local mainUIVisible = true

-- ===== 清理函数 =====
local function stopAll()
    running = false
    if loopConn then loopConn:Disconnect() loopConn = nil end
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 16
    end
end

-- ===== 核心循环 =====
local function startLoop()
    if loopConn then loopConn:Disconnect() end
    loopConn = game:GetService("RunService").Stepped:Connect(function()
        if not running then
            if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
            return
        end
        
        local charNow = player.Character
        if not charNow then return end
        local rootNow = charNow:FindFirstChild("HumanoidRootPart")
        if not rootNow then return end
        
        if not bodyVelocity or bodyVelocity.Parent ~= rootNow then
            if bodyVelocity then bodyVelocity:Destroy() end
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(1e9, 0, 1e9)
            bodyVelocity.Parent = rootNow
        end
        
        local look = camera.CFrame.LookVector
        look = Vector3.new(look.X, 0, look.Z).Unit
        if look.Magnitude > 0 then
            bodyVelocity.Velocity = look * speed
        end
        
        local humanoid = charNow:FindFirstChild("Humanoid")
        if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

-- ===== 创建副UI（只有按钮） =====
local function createSubUI()
    if subUI then
        subUI:Destroy()
        subUI = nil
    end
    
    subUI = Instance.new("ScreenGui")
    subUI.Name = "冲刺按钮"
    subUI.Parent = game:GetService("CoreGui")
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 160, 0, 55)
    btn.Position = UDim2.new(0.5, -80, 0.5, -27)   -- 屏幕中央
    btn.Text = "▶ 启动冲刺"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    btn.BackgroundTransparency = 0
    btn.BorderSizePixel = 0
    btn.Active = true          -- 必须为true才能拖动
    btn.Draggable = true       -- 启用拖动
    btn.Parent = subUI
    
    -- 圆角
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn
    
    -- 点击切换
    btn.MouseButton1Click:Connect(function()
        running = not running
        if running then
            btn.Text = "⏹ 停止冲刺"
            btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            startLoop()
            print("🚀 冲刺启动，速度 " .. speed)
        else
            btn.Text = "▶ 启动冲刺"
            btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            stopAll()
            print("⏹ 冲刺停止")
        end
    end)
end

-- ===== 创建隐藏按钮（右上角） =====
local function createHideButton()
    local hideGui = Instance.new("ScreenGui")
    hideGui.Name = "隐藏按钮"
    hideGui.Parent = game:GetService("CoreGui")
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 35)
    btn.Position = UDim2.new(1, -90, 0, 10)
    btn.Text = "🟢 隐藏主UI"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    btn.Parent = hideGui
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        mainUIVisible = not mainUIVisible
        if mainUIVisible then
            btn.Text = "🟢 隐藏主UI"
            btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            if mainUI then mainUI.Enabled = true end
        else
            btn.Text = "🔴 显示主UI"
            btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            if mainUI then mainUI.Enabled = false end
        end
    end)
end

-- ===== 创建主UI（右上角） =====
local function createMainUI()
    mainUI = Instance.new("ScreenGui")
    mainUI.Name = "添加UI主菜单"
    mainUI.Parent = game:GetService("CoreGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 180)
    frame.Position = UDim2.new(1, -230, 0, 55)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BackgroundTransparency = 0.2
    frame.Active = true
    frame.Draggable = true
    frame.Parent = mainUI
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.Text = "➕ 添加UI"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Parent = frame
    
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(0, 150, 0, 35)
    inputBox.Position = UDim2.new(0.5, -75, 0, 45)
    inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    inputBox.BackgroundTransparency = 0.3
    inputBox.Text = "55"
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextScaled = true
    inputBox.Font = Enum.Font.GothamBold
    inputBox.PlaceholderText = "速度数值"
    inputBox.ClearTextOnFocus = false
    inputBox.Parent = frame
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = inputBox
    inputBox.FocusLost:Connect(function()
        local val = tonumber(inputBox.Text)
        if val and val > 0 then
            speed = val
            print("⚡ 速度已设置为: " .. speed)
        else
            inputBox.Text = tostring(speed)
        end
    end)
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 160, 0, 45)
    btn.Position = UDim2.new(0.5, -80, 0, 105)
    btn.Text = "📌 生成冲刺按钮"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    btn.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    btn.MouseButton1Click:Connect(createSubUI)
end

-- ===== 启动 =====
createHideButton()
createMainUI()

print("✅ 加载完成")
print("📌 副UI是一个绿色按钮，点击切换红/绿，按住可拖动")
print("📌 隐藏按钮只隐藏主UI")