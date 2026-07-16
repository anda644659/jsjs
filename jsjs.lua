-- ===== 加载 WindUI =====
if not WindUI then
    local success, err = pcall(function()
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    end)
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "错误",
            Text = "WindUI 加载失败: " .. tostring(err),
            Duration = 5
        })
        return
    end
end

-- ===== 创建主窗口（黑色主题） =====
local Window = WindUI:CreateWindow({
    Title = "脚本中心合集",
    Icon = "zap",
    Theme = "Dark"
})

-- ============================================================
-- Tab1：脚本列表
-- ============================================================
local MainTab = Window:Tab({
    Title = "脚本列表",
    Icon = "code"
})

MainTab:Button({
    Title = "皮脚本",
    Callback = function()
        getgenv().XiaoPi = "皮脚本QQ群1002100032"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
    end
})

MainTab:Button({
    Title = "叶脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))()
    end
})

MainTab:Button({
    Title = "BS脚本",
    Callback = function()
        loadstring(game:HttpGet("https://gitee.com/BS_script/script/raw/master/BS_Script.Luau"))()
    end
})

MainTab:Button({
    Title = "情云脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ChinaQY/-/main/%E6%83%85%E4%BA%91"))()
    end
})

MainTab:Button({
    Title = "Aero栽赃脚本卡密（Yisan）",
    Callback = function()
        getgenv().SCRIPT_KEY = "Yisan"
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d975bd4e6385076888cb440390a8a53d8763b5e17f23f15a66516cd2f87974f7/download"))()
    end
})

MainTab:Button({
    Title = "窗脚本（卡密：何意味）",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/pl11451481mvcxz/-3-/refs/heads/main/%E7%AA%97%E8%84%9A%E6%9C%AC%E5%8A%A0%E8%BD%BD%E5%99%A8"))()
    end
})

MainTab:Button({
    Title = "刘某脚本",
    Callback = function()
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
    end
})

MainTab:Button({
    Title = "弑脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-X/_Hub_/refs/heads/X/sha.lua"))()
    end
})

MainTab:Button({
    Title = "XK脚本",
    Callback = function()
        getgenv().XK = "XK脚本中心"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoXuAnZang/XKscript/refs/heads/main/XUAN.lua"))()
    end
})

MainTab:Button({
    Title = "ROB脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zyb150933/ROB/refs/heads/main/ROB.V2"))()
    end
})

MainTab:Button({
    Title = "YI HUB",
    Callback = function()
        getgenv().YI_HUB = "YI_HUB群979312897"
        loadstring(game:HttpGet('http://YI-Script.top'))("")
    end
})

-- ============================================================
-- Tab2：LC脚本
-- ============================================================
local LCTab = Window:Tab({
    Title = "LC脚本",
    Icon = "terminal"
})

LCTab:Button({
    Title = "lc合集",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/SpHM7OAK/raw"))()
    end
})

LCTab:Button({
    Title = "lcNEX脚本",
    Callback = function()
        loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/6bd5c94e9da68dce4a2bdf5abd1f6fb9a1379f41faaadbc0354b98d543066f58/download"))()
    end
})

-- ============================================================
-- Tab3：死铁轨
-- ============================================================
local DeadTab = Window:Tab({
    Title = "死铁轨",
    Icon = "alert-triangle"
})

DeadTab:Button({
    Title = "死铁轨本熊脚本",
    Callback = function()
        loadstring(game:HttpGet(('https://raw.%s/%s/%s'):format('githubusercontent.com','jbu7666gvv/BHBUO/refs/heads/main','loader')))()
    end
})

DeadTab:Button({
    Title = "死铁轨杀戮光环",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HeadHarse/Dusty/refs/heads/main/OPAUTOSWINGV2"))()
    end
})

DeadTab:Button({
    Title = "死铁轨通用脚本",
    Callback = function()
        loadstring(game:HttpGet("https://getnative.cc/script/loader"))()
    end
})

-- ============================================================
-- Tab4：内脏与黑火药
-- ============================================================
local OrganTab = Window:Tab({
    Title = "内脏与黑火药",
    Icon = "flame"
})

OrganTab:Button({
    Title = "skin阉割版",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wzhxll/2/refs/heads/main/%E9%98%89%E5%89%B2%E7%89%88.lua"))()
    end
})

OrganTab:Button({
    Title = "鲨鱼清水脚本",
    Callback = function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\102\121\46\97\112\112\47\65\51\78\113\122\52\78\112\47\114\97\119"))()
    end
})

-- ============================================================
-- Tab5：tsb
-- ============================================================
local TSBtab = Window:Tab({
    Title = "tsb",
    Icon = "target"
})

TSBtab:Button({
    Title = "侧闪脚本",
    Callback = function()
        loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/94a29c6b88bfe8c49ea221eaa9225398790c1b7436b0f08caf7517c3002e8782.lua"))()
    end
})

TSBtab:Button({
    Title = "tsb中心脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Games/TSB.lua"))()
    end
})

TSBtab:Button({
    Title = "dovi中心（自己解卡）",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/needanewphone32-eng/tsbfiles/refs/heads/main/Main1.lua"))()
    end
})

TSBtab:Button({
    Title = "隐身脚本",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-SION-ELTNAM-ATLASIA-61168"))()
    end
})

-- ============================================================
-- Tab6：doors
-- ============================================================
local DoorsTab = Window:Tab({
    Title = "doors",
    Icon = "door-open"
})

DoorsTab:Button({
    Title = "Abysall Hub脚本（免卡）",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XxwanhexxX/doors-zh/refs/heads/main/Abysall.Hub"))()
    end
})

DoorsTab:Button({
    Title = "ms脚本（最强绕过，功能最多，要解卡）",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/002c19202c9946e6047b0c6e0ad51f84.lua"))()
    end
})

-- ============================================================
-- Tab7：暴力区
-- ============================================================
local ViolenceTab = Window:Tab({
    Title = "暴力区",
    Icon = "zap"
})

ViolenceTab:Button({
    Title = "暴力区",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Pandu-Hub12/rosblox/refs/heads/main/violence"))()
    end
})

-- ============================================================
-- Tab8：evade
-- ============================================================
local EvadeTab = Window:Tab({
    Title = "evade",
    Icon = "shield"
})

EvadeTab:Button({
    Title = "evade",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sccv8/Whakizashix/refs/heads/main/old%20whakizashi.txt"))()
    end
})

-- ============================================================
-- Tab9：被遗弃
-- ============================================================
local AbandonedTab = Window:Tab({
    Title = "被遗弃",
    Icon = "trash"
})

AbandonedTab:Button({
    Title = "被遗弃（最强绕过）",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/aibabylaugh/catsaken-real-script-not-assets/refs/heads/main/obfuscated-1448974601077002340.lua"))()
    end
})

AbandonedTab:Button({
    Title = "被遗弃脚本（修机延迟改5，不然会被踢）",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/project/refs/heads/main/AutoBLOCKKKWAHV1"))()
    end
})

-- ============================================================
-- Tab10：监狱人生
-- ============================================================
local PrisonTab = Window:Tab({
    Title = "监狱人生",
    Icon = "prison"
})

PrisonTab:Button({
    Title = "监狱人生脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zenss555a/script/refs/heads/main/Prison-Life.lua"))()
    end
})

-- ============================================================
-- Tab11：血与铁
-- ============================================================
local BloodTab = Window:Tab({
    Title = "血与铁",
    Icon = "sword"
})

BloodTab:Button({
    Title = "血与铁静默自瞄脚本",
    Callback = function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\115\108\101\101\110\110\100\110\47\77\97\116\100\115\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\98\105\50\46\48"))()
    end
})

-- ============================================================
-- Tab12：墨水游戏
-- ============================================================
local InkTab = Window:Tab({
    Title = "墨水游戏",
    Icon = "droplet"
})

InkTab:Button({
    Title = "墨水游戏1",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/OK/refs/heads/main/sb"))()
    end
})

InkTab:Button({
    Title = "墨水游戏2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/QQ161475237/IDK/main/HX%E6%B1%89%E5%8C%96.txt"))()
    end
})

InkTab:Button({
    Title = "墨水游戏2永久卡密",
    Callback = function()
        local card = "HSX-7562-3194-0835-4981-2470-1488-1029-6967"
        local success, err = pcall(function()
            if setclipboard then
                setclipboard(card)
            else
                game:GetService("StarterGui"):SetCore("CopyToClipboard", {Text = card})
            end
        end)
        if success then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "复制成功",
                Text = "卡密已复制到剪切板",
                Duration = 2
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "复制失败",
                Text = "请手动复制: " .. card,
                Duration = 4
            })
        end
    end
})

-- ============================================================
-- Tab13：表情页FE动作
-- ============================================================
local EmoteTab = Window:Tab({
    Title = "表情页FE动作",
    Icon = "smile"
})

EmoteTab:Button({
    Title = "动作脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
    end
})

-- ============================================================
-- Tab14：娱乐
-- ============================================================
local EntertainmentTab = Window:Tab({
    Title = "娱乐",
    Icon = "gamepad"
})

EntertainmentTab:Button({
    Title = "ws仿真按键",
    Callback = function()
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
    end
})

-- ===== 启动通知 =====
local function SendNotif(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
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
SendNotif("脚本中心", "经过实测脚本中心", 1.5)
wait(1.5)
SendNotif("脚本中心", "完全可以使用", 1.5)
wait(1.5)
SendNotif("脚本中心", "🤫🤔😍😋😭🤑🤯😫😣😳🤔☠️", 1.5)

-- ===== 欢迎用户通知（右下角） =====
task.wait(0.5)
local player = game.Players.LocalPlayer
SendNotif("👤 欢迎", "欢迎 " .. player.Name .. " 使用本脚本", 2.5)
