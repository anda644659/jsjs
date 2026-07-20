-- ===== 自制UI（星途综合脚本 + 右上角白色时间） =====
local Player = game:GetService("Players").LocalPlayer
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- ============================================================
-- 全局传送函数
-- ============================================================
function TeleportTo(position)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then
        StarterGui:SetCore("SendNotification", {
            Title = "传送失败",
            Text = "角色不存在，请重生后重试",
            Duration = 3
        })
        return false
    end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        StarterGui:SetCore("SendNotification", {
            Title = "传送失败",
            Text = "未找到 HumanoidRootPart",
            Duration = 3
        })
        return false
    end
    pcall(function()
        rootPart.CFrame = CFrame.new(position)
        StarterGui:SetCore("SendNotification", {
            Title = "传送成功",
            Text = "已传送至目标位置",
            Duration = 2
        })
    end)
    return true
end

-- ============================================================
-- 通用功能函数定义（从第二个脚本移植）
-- ============================================================
local function openFlyGUI()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua"))()
end

local noclipConnection
local function enNoclip()
    noclipConnection = game:GetService("RunService").Stepped:Connect(function()
        if Player.Character then
            for _, part in ipairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end
local function disNoclip()
    if noclipConnection then noclipConnection:Disconnect() end
end

local function setWS(v)
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v
    end
end

local ijConnection
local function enIJ()
    ijConnection = UserInputService.JumpRequest:Connect(function()
        if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
            Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end
local function disIJ()
    if ijConnection then ijConnection:Disconnect() end
end

local function enFrozen()
    if Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
            end
        end
    end
end
local function disFrozen()
    if Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = false
            end
        end
    end
end

local godConnection
local function enGod()
    godConnection = Player.CharacterAdded:Connect(function(char)
        local hum = char:WaitForChild("Humanoid")
        hum:GetPropertyChangedSignal("Health"):Connect(function()
            if hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end)
    end)
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        local hum = Player.Character:FindFirstChildOfClass("Humanoid")
        hum.Health = hum.MaxHealth
    end
end
local function disGod()
    if godConnection then godConnection:Disconnect() end
end

local function enInvisible()
    if Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0.7
            end
        end
    end
end
local function disInvisible()
    if Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
end

local espObjects = {}
local function enESP()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Head") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = plr.Character
            highlight.FillTransparency = 1
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            espObjects[plr] = highlight
        end
    end
    game.Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function(char)
            local highlight = Instance.new("Highlight")
            highlight.Parent = char
            highlight.FillTransparency = 1
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            espObjects[plr] = highlight
        end)
    end)
end
local function disESP()
    for _, hl in pairs(espObjects) do
        hl:Destroy()
    end
    espObjects = {}
end

local function killAll()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character:FindFirstChildOfClass("Humanoid").Health = 0
        end
    end
end

local function suicide()
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid").Health = 0
    end
end

local function stealItems()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local root = Player.Character.HumanoidRootPart
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                for _, item in ipairs(workspace:GetDescendants()) do
                    if item:IsA("Tool") and (item.Parent == plr.Character or item.Parent == plr.Backpack) then
                        item.Parent = Player.Backpack
                    end
                end
            end
        end
    end
end

local spinConnection
local spinSpeed = 10
local function enSpin()
    spinConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
        end
    end)
end
local function disSpin()
    if spinConnection then spinConnection:Disconnect() end
end
local function setSpinSpeed(v)
    spinSpeed = v
end

local function enNV()
    game.Lighting.Brightness = 2
    game.Lighting.ClockTime = 14
end
local function disNV()
    game.Lighting.Brightness = 1
    game.Lighting.ClockTime = 14
end

local pjnConnection
local function enPJN()
    pjnConnection = game.Players.PlayerAdded:Connect(function(plr)
        StarterGui:SetCore("SendNotification", {
            Title = "玩家进入",
            Text = plr.Name .. " 加入了游戏",
            Duration = 3
        })
    end)
end
local function disPJN()
    if pjnConnection then pjnConnection:Disconnect() end
end

local function setGravity(v)
    workspace.Gravity = v
end

local aimRange = 500
local aimbotConnection
local function enAimbot()
    local camera = workspace.CurrentCamera
    aimbotConnection = game:GetService("RunService").RenderStepped:Connect(function()
        local closest = nil
        local shortest = aimRange
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Head") then
                local pos, onScreen = camera:WorldToScreenPoint(plr.Character.Head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - camera.ViewportSize / 2).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = plr.Character.Head
                    end
                end
            end
        end
        if closest then
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, closest.Position)
        end
    end)
end
local function disAimbot()
    if aimbotConnection then aimbotConnection:Disconnect() end
end

local afkConnection
local function enAFK()
    local vu = game:GetService("VirtualUser")
    afkConnection = game:GetService("RunService").Heartbeat:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(0.1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end
local function disAFK()
    if afkConnection then afkConnection:Disconnect() end
end

local function rejoin()
    local ts = game:GetService("TeleportService")
    ts:Teleport(game.PlaceId, Player)
end

local function leave()
    game:Shutdown()
end

local trackConnection
local function startTrack(v)
    if trackConnection then trackConnection:Disconnect() end
    local target = nil
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Name == v and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            target = plr
            break
        end
    end
    if target then
        trackConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
            end
        end)
    end
end
local function stopTrack()
    if trackConnection then trackConnection:Disconnect() end
end

-- ============================================================
-- 定义所有标签页和按钮的数据
-- ============================================================
local tabsData = {
    {
        name = "信息",
        buttons = {
            {name = "作者：B站蒸饺巡捕", callback = function() end},
            {name = "作者b站号", callback = function()
                local id = "3546917738908337"
                pcall(function()
                    if setclipboard then setclipboard(id)
                    else StarterGui:SetCore("CopyToClipboard", {Text = id}) end
                end)
                StarterGui:SetCore("SendNotification", {
                    Title = "复制成功",
                    Text = "已复制B站号: " .. id,
                    Duration = 2
                })
            end},
            {name = "复制QQ群聊", callback = function()
                local qq = "1020592687"
                pcall(function()
                    if setclipboard then setclipboard(qq)
                    else StarterGui:SetCore("CopyToClipboard", {Text = qq}) end
                end)
                StarterGui:SetCore("SendNotification", {
                    Title = "复制成功",
                    Text = "已复制QQ群号: " .. qq,
                    Duration = 2
                })
            end}
        }
    },
    {
        name = "脚本列表",
        buttons = {
            {name = "皮脚本", callback = function()
                getgenv().XiaoPi = "皮脚本QQ群1002100032"
                loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
            end},
            {name = "叶脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))()
            end},
            {name = "BS脚本", callback = function()
                loadstring(game:HttpGet("https://gitee.com/BS_script/script/raw/master/BS_Script.Luau"))()
            end},
            {name = "情云脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/ChinaQY/-/main/%E6%83%85%E4%BA%91"))()
            end},
            {name = "Aero栽赃脚本卡密（Yisan）", callback = function()
                getgenv().SCRIPT_KEY = "Yisan"
                loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d975bd4e6385076888cb440390a8a53d8763b5e17f23f15a66516cd2f87974f7/download"))()
            end},
            {name = "窗脚本（卡密：何意味）", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/pl11451481mvcxz/-3-/refs/heads/main/%E7%AA%97%E8%84%9A%E6%9C%AC%E5%8A%A0%E8%BD%BD%E5%99%A8"))()
            end},
            {name = "刘某脚本", callback = function()
                local data = {
                    {1,"h"},{2,"t"},{3,"t"},{4,"p"},{5,"s"},{6,":"},{7,"/"},{8,"/"},
                    {9,"p"},{10,"a"},{11,"s"},{12,"t"},{13,"e"},{14,"f"},{15,"y"},
                    {16,"."},{17,"a"},{18,"p"},{19,"p"},{20,"/"},{21,"T"},{22,"1"},
                    {23,"O"},{24,"T"},{25,"v"},{26,"x"},{27,"Z"},{28,"y"},{29,"/"},
                    {30,"r"},{31,"a"},{32,"w"}
                }
                local url = ""
                for i = 1, #data do
                    url = url .. data[i][2]
                end
                loadstring(game:HttpGet(url))()
            end},
            {name = "弑脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/_Hub_/refs/heads/X/sha.lua"))()
            end},
            {name = "XK脚本", callback = function()
                getgenv().XK = "XK脚本中心"
                loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoXuAnZang/XKscript/refs/heads/main/XUAN.lua"))()
            end},
            {name = "ROB脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyb150933/ROB/refs/heads/main/ROB.V2"))()
            end},
            {name = "YI HUB", callback = function()
                getgenv().YI_HUB = "YI_HUB群979312897"
                loadstring(game:HttpGet('http://YI-Script.top'))("")
            end},
            {name = "林脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/linnblin/lin/main/lin"))()
            end}
        }
    },
    {
        name = "LC脚本",
        buttons = {
            {name = "lc合集", callback = function()
                loadstring(game:HttpGet("https://pastefy.app/SpHM7OAK/raw"))()
            end},
            {name = "lcNEX脚本", callback = function()
                loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/6bd5c94e9da68dce4a2bdf5abd1f6fb9a1379f41faaadbc0354b98d543066f58/download"))()
            end}
        }
    },
    {
        name = "死铁轨",
        buttons = {
            {name = "死铁轨本熊脚本", callback = function()
                loadstring(game:HttpGet(('https://raw.%s/%s/%s'):format('githubusercontent.com','jbu7666gvv/BHBUO/refs/heads/main','loader')))()
            end},
            {name = "死铁轨杀戮光环", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/HeadHarse/Dusty/refs/heads/main/OPAUTOSWINGV2"))()
            end},
            {name = "死铁轨通用脚本", callback = function()
                loadstring(game:HttpGet("https://getnative.cc/script/loader"))()
            end}
        }
    },
    {
        name = "内脏与黑火药",
        buttons = {
            {name = "skin阉割版", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/wzhxll/2/refs/heads/main/%E9%98%89%E5%89%B2%E7%89%88.lua"))()
            end},
            {name = "鲨鱼清水脚本", callback = function()
                loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\102\121\46\97\112\112\47\65\51\78\113\122\52\78\112\47\114\97\119"))()
            end}
        }
    },
    {
        name = "tsb",
        buttons = {
            {name = "侧闪脚本", callback = function()
                loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/94a29c6b88bfe8c49ea221eaa9225398790c1b7436b0f08caf7517c3002e8782.lua"))()
            end},
            {name = "tsb中心脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Games/TSB.lua"))()
            end},
            {name = "dovi中心（自己解卡）", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/needanewphone32-eng/tsbfiles/refs/heads/main/Main1.lua"))()
            end},
            {name = "隐身脚本", callback = function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-SION-ELTNAM-ATLASIA-61168"))()
            end},
            {name = "垃圾桶战神", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man", true))()
            end},
            {name = "镜头灵敏度操纵", callback = function()
                loadstring(game:HttpGet("https://pastebin.com/raw/UQE2KDxV"))()
            end}
        }
    },
    {
        name = "doors",
        buttons = {
            {name = "Abysall Hub脚本（免卡）", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/XxwanhexxX/doors-zh/refs/heads/main/Abysall.Hub"))()
            end},
            {name = "ms脚本（最强绕过，功能最多，要解卡）", callback = function()
                loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/002c19202c9946e6047b0c6e0ad51f84.lua"))()
            end},
            {name = "rehax", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cucumber190/roblox-/refs/heads/main/rehax%20Qcumber.lua"))()
            end},
            {name = "bob", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/notzanocoddz4/bobdoors/main/main.lua"))()
            end}
        }
    },
    {
        name = "暴力区",
        buttons = {
            {name = "暴力区", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Pandu-Hub12/rosblox/refs/heads/main/violence"))()
            end}
        }
    },
    {
        name = "evade",
        buttons = {
            {name = "evade", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/sccv8/Whakizashix/refs/heads/main/old%20whakizashi.txt"))()
            end}
        }
    },
    {
        name = "被遗弃",
        buttons = {
            {name = "被遗弃（最强绕过）", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/aibabylaugh/catsaken-real-script-not-assets/refs/heads/main/obfuscated-1448974601077002340.lua"))()
            end},
            {name = "被遗弃脚本（修机延迟改5，不然会被踢）", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/project/refs/heads/main/AutoBLOCKKKWAHV1"))()
            end}
        }
    },
    {
        name = "监狱人生",
        buttons = {
            {name = "监狱人生脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/zenss555a/script/refs/heads/main/Prison-Life.lua"))()
            end}
        }
    },
    {
        name = "血与铁",
        buttons = {
            {name = "血与铁静默自瞄脚本", callback = function()
                loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\115\108\101\101\110\110\100\110\47\77\97\116\100\115\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\98\105\50\46\48"))()
            end}
        }
    },
    {
        name = "墨水游戏",
        buttons = {
            {name = "墨水游戏1", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/OK/refs/heads/main/sb"))()
            end},
            {name = "墨水游戏2", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/QQ161475237/IDK/main/HX%E6%B1%89%E5%8C%96.txt"))()
            end},
            {name = "墨水游戏2永久卡密", callback = function()
                local card = "HSX-7562-3194-0835-4981-2470-1488-1029-6967"
                local success, err = pcall(function()
                    if setclipboard then
                        setclipboard(card)
                    else
                        StarterGui:SetCore("CopyToClipboard", {Text = card})
                    end
                end)
                if success then
                    StarterGui:SetCore("SendNotification", {
                        Title = "复制成功",
                        Text = "卡密已复制到剪切板",
                        Duration = 2
                    })
                else
                    StarterGui:SetCore("SendNotification", {
                        Title = "复制失败",
                        Text = "请手动复制: " .. card,
                        Duration = 4
                    })
                end
            end}
        }
    },
    {
        name = "表情页FE动作",
        buttons = {
            {name = "动作脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
            end}
        }
    },
    {
        name = "娱乐",
        buttons = {
            {name = "ws仿真按键", callback = function()
                -- 原 WS 模拟功能（独立创建 GUI）
                do
                    local player = game.Players.LocalPlayer
                    local gui = Instance.new("ScreenGui")
                    gui.Name = "移动控制中心"
                    gui.Parent = player:WaitForChild("PlayerGui")
                    gui.ResetOnSpawn = false

                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(0, 240, 0, 180)
                    frame.Position = UDim2.new(0.5, -120, 0.5, -90)
                    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
                    frame.BackgroundTransparency = 0.15
                    frame.BorderColor3 = Color3.fromRGB(60, 60, 70)
                    frame.Parent = gui
                    frame.Active = true
                    frame.Draggable = true

                    local title = Instance.new("TextLabel")
                    title.Size = UDim2.new(1, 0, 0, 30)
                    title.Text = "🎮 移动控制 (速度版)"
                    title.TextColor3 = Color3.new(1, 1, 1)
                    title.BackgroundTransparency = 1
                    title.Font = Enum.Font.SourceSansBold
                    title.TextSize = 18
                    title.Parent = frame

                    local wsToggle = Instance.new("TextButton")
                    wsToggle.Size = UDim2.new(0, 200, 0, 35)
                    wsToggle.Position = UDim2.new(0.5, -100, 0, 40)
                    wsToggle.Text = "🔴 WS模拟 (关)"
                    wsToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                    wsToggle.TextColor3 = Color3.new(1, 1, 1)
                    wsToggle.BorderColor3 = Color3.fromRGB(80, 80, 90)
                    wsToggle.Font = Enum.Font.SourceSans
                    wsToggle.TextSize = 16
                    wsToggle.Parent = frame

                    local lockToggle = Instance.new("TextButton")
                    lockToggle.Size = UDim2.new(0, 200, 0, 35)
                    lockToggle.Position = UDim2.new(0.5, -100, 0, 85)
                    lockToggle.Text = "🔒 视角锁定 (关)"
                    lockToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                    lockToggle.TextColor3 = Color3.new(1, 1, 1)
                    lockToggle.BorderColor3 = Color3.fromRGB(80, 80, 90)
                    lockToggle.Font = Enum.Font.SourceSans
                    lockToggle.TextSize = 16
                    lockToggle.Parent = frame

                    local closeBtn = Instance.new("TextButton")
                    closeBtn.Size = UDim2.new(0, 30, 0, 30)
                    closeBtn.Position = UDim2.new(1, -35, 0, 0)
                    closeBtn.Text = "✕"
                    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
                    closeBtn.TextColor3 = Color3.new(1, 1, 1)
                    closeBtn.Font = Enum.Font.SourceSans
                    closeBtn.TextSize = 16
                    closeBtn.Parent = frame

                    local wsEnabled = false
                    local lockEnabled = false
                    local runningWS = false

                    local character = nil
                    local rootPart = nil
                    local humanoid = nil

                    local RunService = game:GetService("RunService")
                    local camera = workspace.CurrentCamera
                    local UserInputService = game:GetService("UserInputService")

                    local function updateChar()
                        character = player.Character
                        if character then
                            rootPart = character:FindFirstChild("HumanoidRootPart")
                            humanoid = character:FindFirstChildOfClass("Humanoid")
                        end
                    end
                    updateChar()
                    player.CharacterAdded:Connect(function(newChar)
                        character = newChar
                        rootPart = newChar:FindFirstChild("HumanoidRootPart")
                        humanoid = newChar:FindFirstChildOfClass("Humanoid")
                        if lockEnabled and humanoid then
                            humanoid.AutoRotate = false
                        end
                    end)

                    local function wsLoop()
                        local direction = 1
                        local speed = 30
                        while runningWS and wsEnabled do
                            if rootPart then
                                local lookVec = camera.CFrame.LookVector
                                lookVec = Vector3.new(lookVec.X, 0, lookVec.Z).Unit
                                if lookVec.Magnitude < 0.01 then
                                    lookVec = Vector3.new(1, 0, 0)
                                end
                                rootPart.Velocity = lookVec * direction * speed
                                direction = direction * -1
                            end
                            task.wait(0.1)
                        end
                        if rootPart then
                            rootPart.Velocity = Vector3.new(0, 0, 0)
                        end
                    end

                    RunService.RenderStepped:Connect(function()
                        if not lockEnabled then return end
                        if not rootPart or not humanoid then return end
                        local lookVec = camera.CFrame.LookVector
                        lookVec = Vector3.new(lookVec.X, 0, lookVec.Z).Unit
                        if lookVec.Magnitude > 0.01 then
                            rootPart.CFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + lookVec)
                        end
                    end)

                    wsToggle.MouseButton1Click:Connect(function()
                        wsEnabled = not wsEnabled
                        wsToggle.Text = wsEnabled and "🟢 WS模拟 (开)" or "🔴 WS模拟 (关)"
                        if wsEnabled then
                            if not runningWS then
                                runningWS = true
                                task.spawn(wsLoop)
                            end
                        else
                            runningWS = false
                        end
                    end)

                    lockToggle.MouseButton1Click:Connect(function()
                        lockEnabled = not lockEnabled
                        lockToggle.Text = lockEnabled and "🔓 视角锁定 (开)" or "🔒 视角锁定 (关)"
                        if lockEnabled then
                            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
                            if humanoid then
                                humanoid.AutoRotate = false
                            end
                        else
                            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                            if humanoid then
                                humanoid.AutoRotate = true
                            end
                        end
                    end)

                    closeBtn.MouseButton1Click:Connect(function()
                        runningWS = false
                        wsEnabled = false
                        lockEnabled = false
                        if rootPart then
                            rootPart.Velocity = Vector3.new(0, 0, 0)
                        end
                        if humanoid then
                            humanoid.AutoRotate = true
                        end
                        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                        gui:Destroy()
                    end)

                    player.CameraMode = Enum.CameraMode.Classic
                    player.CharacterAdded:Connect(function()
                        task.wait(0.5)
                        local char = player.Character
                        if char then
                            local hum = char:FindFirstChildOfClass("Humanoid")
                            if hum then
                                hum.AutoRotate = lockEnabled and false or true
                            end
                        end
                    end)
                end
            end}
        }
    },
    -- ============================================================
    -- 标签页：自制骚乱之城（传送）——所有坐标Y+2，拿AK除外
    -- ============================================================
    {
        name = "自制骚乱之城（传送）",
        buttons = {
            {name = "银行金库", callback = function()
                TeleportTo(Vector3.new(669.76, -6.35, -1252.18))
            end},
            {name = "破解银行", callback = function()
                TeleportTo(Vector3.new(682.79, -30.30, -1219.21))
            end},
            {name = "武器店", callback = function()
                TeleportTo(Vector3.new(-155.51, -30.14, -1266.23))
            end},
            {name = "监狱", callback = function()
                TeleportTo(Vector3.new(17.51, -7.90, -0.22))
            end},
            {name = "囚犯老巢", callback = function()
                TeleportTo(Vector3.new(281.07, 14.60, -2948.30))
            end},
            {name = "加油站", callback = function()
                TeleportTo(Vector3.new(823.37, -30.01, -433.86))
            end},
            {name = "珠宝店", callback = function()
                TeleportTo(Vector3.new(307.63, -20.12, -1624.80))
            end},
            {name = "豪宅", callback = function()
                TeleportTo(Vector3.new(382.42, 1.71, -2415.86))
            end},
            -- ===== 拿AK 坐标保持不变 =====
            {name = "拿AK", callback = function()
                TeleportTo(Vector3.new(-1517.32, 14.89, -2850.98))
            end}
        }
    },
    -- ============================================================
    -- 标签页：合成一个核弹
    -- ============================================================
    {
        name = "合成一个核弹",
        buttons = {
            {name = "YI_HUB合成一个核弹脚本", callback = function()
                getgenv().YI_HUB = "YI_HUB群979312897"
                loadstring(game:HttpGet('http://YI-Script.top'))("")
            end}
        }
    },
    -- ============================================================
    -- 标签页：幸运方块战争（从第二个脚本移植）
    -- ============================================================
    {
        name = "幸运方块战争",
        buttons = {
            {name = "执行自动获取一个彩虹物品", callback = function()
                local Event = game:GetService("ReplicatedStorage").SpawnRainbowBlock
                Event:FireServer()
            end}
        }
    },
    -- ============================================================
    -- 标签页：通用（从第二个脚本移植并整合）
    -- ============================================================
    {
        name = "通用",
        buttons = {
            {name = "飞行", callback = openFlyGUI},
            {name = "穿墙", callback = function()
                if noclipConnection and noclipConnection.Connected then
                    disNoclip()
                else
                    enNoclip()
                end
            end, isToggle = true},
            {name = "走路速度", callback = function() end, isSlider = true},
            {name = "无限跳", callback = function()
                if ijConnection and ijConnection.Connected then
                    disIJ()
                else
                    enIJ()
                end
            end, isToggle = true},
            {name = "无法移动", callback = function()
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character.HumanoidRootPart.Anchored then
                    disFrozen()
                else
                    enFrozen()
                end
            end, isToggle = true},
            {name = "无敌", callback = function()
                if godConnection and godConnection.Connected then
                    disGod()
                else
                    enGod()
                end
            end, isToggle = true},
            {name = "隐身", callback = function()
                if Player.Character then
                    local head = Player.Character:FindFirstChild("Head")
                    if head and head.Transparency > 0 then
                        disInvisible()
                    else
                        enInvisible()
                    end
                end
            end, isToggle = true},
            {name = "ESP透视", callback = function()
                if next(espObjects) ~= nil then
                    disESP()
                else
                    enESP()
                end
            end, isToggle = true},
            {name = "击杀所有人", callback = killAll},
            {name = "自杀", callback = suicide},
            {name = "偷走玩家物品道具", callback = stealItems},
            {name = "静默甩飞所有人", callback = function()
                loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
            end},
            {name = "雷欧飞踢", callback = function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-THE-REAL-dropkick-177199"))()
            end},
            {name = "铁拳甩飞", callback = function()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
            end},
            {name = "FPS（变流畅）", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/gclich/FPS-X-GUI/main/FPS_X.lua"))()
            end},
            {name = "获取管理员", callback = function()
                loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
            end},
            {name = "死亡笔记", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
            end},
            {name = "飞车", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/vb/main/%E9%A3%9E%E8%BD%A6.lua"))()
            end},
            {name = "假延迟脚本", callback = function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Egor-simple-ui-91106"))()
            end},
            {name = "操人脚本", callback = function()
                loadstring(game:HttpGet("https://pastefy.app/BkeffrT5/raw"))()
            end},
            {name = "防甩飞（可开关）", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Linux6699/DaHubRevival/main/AntiFling.lua"))()
            end},
            {name = "r15无敌少侠飞行脚本", callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua"))()
            end},
            {name = "r6无敌少侠飞行脚本", callback = function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invincible-Mark-42041"))()
            end},
            {name = "r6鹿管脚本", callback = function()
                loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
            end},
            {name = "r15鹿管脚本", callback = function()
                loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
            end},
            {name = "旋转", callback = function()
                if spinConnection and spinConnection.Connected then
                    disSpin()
                else
                    enSpin()
                end
            end, isToggle = true},
            {name = "旋转速度", callback = function() end, isSlider = true},
            {name = "夜视", callback = function()
                if game.Lighting.Brightness > 1 then
                    disNV()
                else
                    enNV()
                end
            end, isToggle = true},
            {name = "玩家进入通知", callback = function()
                if pjnConnection and pjnConnection.Connected then
                    disPJN()
                else
                    enPJN()
                end
            end, isToggle = true},
            {name = "重力设置", callback = function() end, isSlider = true},
            {name = "自瞄范围", callback = function() end, isSlider = true},
            {name = "自瞄", callback = function()
                if aimbotConnection and aimbotConnection.Connected then
                    disAimbot()
                else
                    enAimbot()
                end
            end, isToggle = true},
            {name = "反挂机", callback = function()
                if afkConnection and afkConnection.Connected then
                    disAFK()
                else
                    enAFK()
                end
            end, isToggle = true},
            {name = "重新加入", callback = rejoin},
            {name = "离开游戏", callback = leave},
            {name = "关闭脚本", callback = function()
                MainGui:Destroy()
                TopGui:Destroy()
                TimeGui:Destroy()
            end},
            {name = "显示fps和延迟", callback = function()
                loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FPS-And-Ping-Display-23120"))()
            end},
            {name = "转圈", callback = function()
                StarterGui:SetCore("SendNotification", {
                    Title = "提示",
                    Text = "转圈功能已启用（简化版）",
                    Duration = 2
                })
            end, isToggle = true}
        }
    }
}

-- ============================================================
-- 构建自制UI
-- ============================================================
local WINDOW_WIDTH = 600
local WINDOW_HEIGHT = 400
local TAB_WIDTH = 120

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "星途综合脚本"
MainGui.Parent = Player:WaitForChild("PlayerGui")
MainGui.ResetOnSpawn = false
MainGui.Enabled = true

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, WINDOW_WIDTH, 0, WINDOW_HEIGHT)
MainFrame.Position = UDim2.new(0.5, -WINDOW_WIDTH/2, 0.5, -WINDOW_HEIGHT/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
MainFrame.BorderColor3 = Color3.fromRGB(55, 55, 65)
MainFrame.Parent = MainGui
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 32)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "星途综合脚本"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- 左侧标签栏
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, TAB_WIDTH, 1, -40)
LeftPanel.Position = UDim2.new(0, 0, 0, 40)
LeftPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
LeftPanel.BorderSizePixel = 0
LeftPanel.Parent = MainFrame

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Size = UDim2.new(1, 0, 1, 0)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.ScrollBarThickness = 4
TabScroll.Parent = LeftPanel

local TabLayout = Instance.new("UIListLayout")
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 4)
TabLayout.Parent = TabScroll

-- 右侧内容区域
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(1, -TAB_WIDTH - 8, 1, -40)
RightPanel.Position = UDim2.new(0, TAB_WIDTH + 4, 0, 40)
RightPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
RightPanel.BorderSizePixel = 0
RightPanel.Parent = MainFrame

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.Position = UDim2.new(0, 0, 0, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 4
ContentScroll.Parent = RightPanel

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 6)
ContentLayout.Parent = ContentScroll

-- ============================================================
-- 核心逻辑
-- ============================================================
local tabButtons = {}
local currentTabIndex = 1
local allBtnInstances = {}
local toggleStates = {}

local function refreshContent()
    for _, btn in pairs(allBtnInstances) do
        btn:Destroy()
    end
    allBtnInstances = {}

    local tabData = tabsData[currentTabIndex]
    if not tabData then return end

    for _, btnData in ipairs(tabData.buttons) do
        if btnData.isSlider then
            -- 创建滑块控件
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(1, -16, 0, 50)
            sliderFrame.BackgroundTransparency = 1
            sliderFrame.Parent = ContentScroll
            table.insert(allBtnInstances, sliderFrame)

            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(1, 0, 0, 20)
            sliderLabel.Text = btnData.name
            sliderLabel.TextColor3 = Color3.new(1, 1, 1)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Font = Enum.Font.SourceSans
            sliderLabel.TextSize = 14
            sliderLabel.Parent = sliderFrame

            local sliderBar = Instance.new("Frame")
            sliderBar.Size = UDim2.new(1, 0, 0, 6)
            sliderBar.Position = UDim2.new(0, 0, 0, 25)
            sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 66)
            sliderBar.BorderSizePixel = 0
            sliderBar.Parent = sliderFrame

            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
            sliderFill.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
            sliderFill.BorderSizePixel = 0
            sliderFill.Parent = sliderBar

            local sliderKnob = Instance.new("TextButton")
            sliderKnob.Size = UDim2.new(0, 16, 0, 16)
            sliderKnob.Position = UDim2.new(0.5, -8, 0, 20)
            sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sliderKnob.BorderSizePixel = 0
            sliderKnob.Text = ""
            sliderKnob.Parent = sliderFrame
            Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1, 0)

            local sliderValue = Instance.new("TextLabel")
            sliderValue.Size = UDim2.new(0, 50, 0, 20)
            sliderValue.Position = UDim2.new(1, -50, 0, 0)
            sliderValue.Text = "50"
            sliderValue.TextColor3 = Color3.new(1, 1, 1)
            sliderValue.BackgroundTransparency = 1
            sliderValue.Font = Enum.Font.SourceSans
            sliderValue.TextSize = 14
            sliderValue.Parent = sliderFrame

            local minVal = 0
            local maxVal = 100
            local defaultVal = 50
            if btnData.name == "走路速度" then
                minVal = 16; maxVal = 500; defaultVal = 16
            elseif btnData.name == "旋转速度" then
                minVal = 1; maxVal = 50; defaultVal = 10
            elseif btnData.name == "重力设置" then
                minVal = 0; maxVal = 500; defaultVal = workspace.Gravity
            elseif btnData.name == "自瞄范围" then
                minVal = 100; maxVal = 1000; defaultVal = 500
            end

            local currentVal = defaultVal
            sliderValue.Text = tostring(currentVal)

            local function updateSlider(input)
                local barPos = sliderBar.AbsolutePosition
                local barSize = sliderBar.AbsoluteSize
                local mousePos = input.Position
                local relativeX = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
                sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
                sliderKnob.Position = UDim2.new(relativeX, -8, 0, 20)
                currentVal = math.floor(minVal + (maxVal - minVal) * relativeX)
                sliderValue.Text = tostring(currentVal)
            end

            sliderKnob.MouseButton1Down:Connect(function()
                local connection
                connection = UserInputService.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSlider(input)
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        connection:Disconnect()
                        -- 执行回调
                        if btnData.name == "走路速度" then setWS(currentVal)
                        elseif btnData.name == "旋转速度" then setSpinSpeed(currentVal)
                        elseif btnData.name == "重力设置" then setGravity(currentVal)
                        elseif btnData.name == "自瞄范围" then aimRange = currentVal end
                    end
                end)
            end)

            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    updateSlider(input)
                end
            end)

        elseif btnData.isToggle then
            -- 创建开关控件
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, -16, 0, 30)
            toggleFrame.BackgroundTransparency = 1
            toggleFrame.Parent = ContentScroll
            table.insert(allBtnInstances, toggleFrame)

            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            toggleLabel.Text = btnData.name
            toggleLabel.TextColor3 = Color3.new(1, 1, 1)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Font = Enum.Font.SourceSans
            toggleLabel.TextSize = 14
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame

            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(0, 50, 0, 24)
            toggleBtn.Position = UDim2.new(1, -55, 0.5, -12)
            toggleBtn.Text = "关"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 86)
            toggleBtn.TextColor3 = Color3.new(1, 1, 1)
            toggleBtn.BorderSizePixel = 0
            toggleBtn.Font = Enum.Font.SourceSans
            toggleBtn.TextSize = 14
            toggleBtn.Parent = toggleFrame
            Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 12)

            local isOn = false
            toggleBtn.MouseButton1Click:Connect(function()
                isOn = not isOn
                toggleBtn.Text = isOn and "开" or "关"
                toggleBtn.BackgroundColor3 = isOn and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(80, 80, 86)
                if btnData.callback then btnData.callback(isOn) end
            end)
        else
            -- 普通按钮
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -16, 0, 30)
            btn.Text = btnData.name
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 56)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BorderColor3 = Color3.fromRGB(70, 70, 76)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 15
            btn.Parent = ContentScroll
            btn.MouseButton1Click:Connect(btnData.callback or function()
                print("按钮点击: " .. btnData.name)
            end)
            table.insert(allBtnInstances, btn)
        end
    end

    local count = #tabData.buttons
    local height = count * 45 + 10
    if height < ContentScroll.Size.Y.Offset then
        height = ContentScroll.Size.Y.Offset
    end
    ContentScroll.CanvasSize = UDim2.new(0, 0, 0, height)
end

local function addTab(index, name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -8, 0, 28)
    tabBtn.Text = name
    tabBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 43)
    tabBtn.TextColor3 = Color3.new(1, 1, 1)
    tabBtn.BorderColor3 = Color3.fromRGB(55, 55, 60)
    tabBtn.Font = Enum.Font.SourceSans
    tabBtn.TextSize = 14
    tabBtn.Parent = TabScroll
    tabBtn.MouseButton1Click:Connect(function()
        currentTabIndex = index
        for _, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(38, 38, 43)
        end
        tabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
        refreshContent()
    end)
    table.insert(tabButtons, tabBtn)
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, #tabsData * 32 + 10)
end

for i, tab in ipairs(tabsData) do
    addTab(i, tab.name)
end

if #tabButtons > 0 then
    tabButtons[1].BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    currentTabIndex = 1
    refreshContent()
end 

-- ============================================================
-- 圆形隐藏按钮（点击隐藏/恢复主UI，按住拖动）
-- ============================================================
local TopGui = Instance.new("ScreenGui")
TopGui.Name = "TopControl"
TopGui.Parent = Player:WaitForChild("PlayerGui")
TopGui.ResetOnSpawn = false
TopGui.DisplayOrder = 998

local CircleBtn = Instance.new("TextButton")
CircleBtn.Size = UDim2.new(0, 50, 0, 50)
CircleBtn.Position = UDim2.new(1, -60, 0, 50)
CircleBtn.Text = "隐藏"
CircleBtn.TextColor3 = Color3.new(1, 1, 1)
CircleBtn.TextScaled = true
CircleBtn.Font = Enum.Font.SourceSansBold
CircleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CircleBtn.BorderSizePixel = 0
CircleBtn.Parent = TopGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1, 0)
Corner.Parent = CircleBtn

local isHidden = false
local isDragging = false
local dragStartPos = nil
local btnStartPos = nil

CircleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
        dragStartPos = input.Position
        btnStartPos = CircleBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragStartPos and btnStartPos then
        local delta = input.Position - dragStartPos
        if delta.Magnitude > 5 then
            isDragging = true
        end
        if isDragging then
            CircleBtn.Position = UDim2.new(
                btnStartPos.X.Scale,
                btnStartPos.X.Offset + delta.X,
                btnStartPos.Y.Scale,
                btnStartPos.Y.Offset + delta.Y
            )
        end
    end
end)

UserInputService.TouchMoved:Connect(function(touch)
    if dragStartPos and btnStartPos then
        local delta = touch.Position - dragStartPos
        if delta.Magnitude > 5 then
            isDragging = true
        end
        if isDragging then
            CircleBtn.Position = UDim2.new(
                btnStartPos.X.Scale,
                btnStartPos.X.Offset + delta.X,
                btnStartPos.Y.Scale,
                btnStartPos.Y.Offset + delta.Y
            )
        end
    end
end)

CircleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if not isDragging then
            isHidden = not isHidden
            MainGui.Enabled = not isHidden
            if isHidden then
                CircleBtn.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
                CircleBtn.Text = "恢复"
            else
                CircleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
                CircleBtn.Text = "隐藏"
            end
        end
        isDragging = false
        dragStartPos = nil
        btnStartPos = nil
    end
end)

-- ============================================================
-- 启动通知
-- ============================================================
local function SendNotif(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 1.5,
            Button1 = "确定"
        })
    end)
end

SendNotif("脚本中心", "欢迎使用ai脚本合集", 1.5)
wait(1.5)
SendNotif("脚本中心", "此脚本完全免费", 1.5)
wait(1.5)
SendNotif("脚本中心", "脚本非常的多", 1.5)
wait(1.5)

task.wait(0.5)
local player = game.Players.LocalPlayer
SendNotif("👤 欢迎", "欢迎 " .. player.Name .. " 使用本脚本", 2.5)

print("✅ 星途综合脚本已加载，右上角白色时间已开启！")