local Atlas = loadstring(game:HttpGet(('https://raw.githubusercontent.com/hiptodude2/the-opness-of-island-tribes/main/AtlasNewVers.lua')))()
local AtlasUi = Atlas.new({
    Name = "Universal Oblitorator";
    Credit = "Credits: zvvpe TheRealGamer903#7339";
    Color = Color3.fromRGB(0, 255, 0);
    UseLoader = false;
    Bind = "LeftBracket";
    FullName = "Universal Oblitorator";

    Discord = "https://discord.gg/Hh5gUpcUpd";
})
getgenv().configs = {
    Bypassing = false;
    AutoPickup2 = false;
    InfJump = false;
    ClickTp = false;
    AutoEat = false;
    MineAura = false;
    MobAura = false;
    CheaterDetector = false;
    KillAura = false;
    PlayerLock = false;
    Pumpkins = false;
    Hitbox = false;
    SafeDeath = false;
    OpKillAura = false;
	PredictOpKillAura = false;
    AutoRepairClub = false;
    ConiferFarm = false;
    UseSoulKeys = false;
    ObsidianBoss = false;
    ZenLuckBoss = false;
    SpiritBoss = false;
    LuckySlime = false;
    EvilSkeleton = false;
    Ogre = false;
    Squid = false;
    JumpPower = false;
    AntiRagDoll = false;
    ExtraSpeed = false;
    AmountToLoopDrop = false;
    PlayerEsp = false;
    EatingType = 'AFK';
    TrapType = 'Stone Trap';
    LevelCheck = 'True';
    ChestType = 'Any';
}
--Services
Workspace = game:GetService('Workspace')
Players = game:GetService('Players')
ReplicatedStorage = game:GetService('ReplicatedStorage')
UserInputService = game:GetService('UserInputService')
TweenService = game:GetService("TweenService")
RunService = game:GetService('RunService')
Lighting  = game:GetService('Lighting')
VirtualUser = game:GetService("VirtualUser")
HttpService = game:GetService('HttpService')
TeleportService = game:GetService("TeleportService")

--Globals
LocalPlayer = Players.LocalPlayer
Mouse = LocalPlayer:GetMouse()
Camera = Workspace.CurrentCamera

--Island tribes shit
--RemoteEvents
RemoteEvents = {
    ToolAction = ReplicatedStorage:WaitForChild('References'):WaitForChild('Comm'):WaitForChild('Events'):WaitForChild('ToolAction');
    InventoryInteraction =  ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("InventoryInteraction");
    UpdateStorageChest =  ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("UpdateStorageChest");
    SetSettings = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("SetSettings");
    BuyWorldEvent =  ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("BuyWorldEvent");
    ItemInteracted =  ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("ItemInteracted");
    CraftItem =  ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("CraftItem");
    TradeTrader =  ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("TradeTrader");
    KeyDoor = ReplicatedStorage:WaitForChild("References"):WaitForChild("Comm"):WaitForChild("Events"):WaitForChild("KeyDoor");
    Sonar =  ReplicatedStorage:WaitForChild('References'):WaitForChild('Comm'):WaitForChild('Events'):WaitForChild('Sonar');
}
--Important locals
local message = require(LocalPlayer:WaitForChild('PlayerScripts'):WaitForChild('Main'):WaitForChild('Message'))
local MyInventory = LocalPlayer:WaitForChild('PlayerGui'):FindFirstChild('Menus'):FindFirstChild('Inventory'):FindFirstChild('Inventory'):FindFirstChild('List')
local Whitelist_table = {};
local OpKillAuraTable = {};
local realgameadmins = {849400193, 134488231, 146733116, 27865601}
local MoonstoneSet = {363, 364, 365, 366}
local ObsidianSet = {225, 226, 227, 228}
local AllShields = {206, 207, 208, 209, 210, 211, 219, 235, 367, 379}
local AllSwords = {173, 205, 230, 369, 255, 254, 253}
local AllBows = {174, 197, 198, 199, 376}
local AllBooks = {281, 282, 283, 284, 285, 286, 287, 296, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 323, 362}
local AllStaffs = {293, 292, 291, 290, 162, 289}

--Safe Death Connections
local TimeTped
local TimeBetweenTps
local TeleportHappened = false
local SafeDeathHealthChecker = nil

--Boss Death connections
local AutoPickupOnObsidianDeath
local AutoPickupOnZenLuckBossDeath
local AutoPickupOnSpiritBossDeath
local AutoPickuponLuckySlimeDeath
local AutoPickupOnSkeletonDeath
local AutoPickupOnOgreDeath
local AutoPickupOnSquidDeath

--Dupe locals
local ItemIndexed
local ItemIndexedNumber






--Aimbot locals
local CurrentlyLocked
local Aiming = false

function IsPlayerAlive(player)
    if player.Character and player.Character:FindFirstChild('Humanoid') and player.Character:FindFirstChild('HumanoidRootPart') and player.Character:FindFirstChild('Humanoid').Health > 0 then
        return true
    end
    return false
end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local Camera = game:GetService("Workspace").Camera
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Mouse = LocalPlayer:GetMouse()
local Aiming = false
local currentlyLocked = nil

local function wallCheck(target)
    local ray = Ray.new(Camera.CFrame.Position, (target.Position - Camera.CFrame.Position).Unit * 1000)
    local part, position = game:GetService('Workspace'):FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character}, false, true)
    if part then
        local humanoid = part.Parent:FindFirstChildOfClass('Humanoid')
        if not humanoid then
            humanoid = part.Parent.Parent:FindFirstChildOfClass('Humanoid')
        end
        if humanoid and target and humanoid.Parent == target.Parent then
            local _, visible = Camera:WorldToScreenPoint(target.Position)
            if visible then
                return true
            end
        end
    end
    return false
end

local function getClosestPlayerToMouse()
    local dist = 200
    local closest = nil

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                local plrPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(plrPos.X, plrPos.Y)).Magnitude
                    if distance < dist and (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 150 then
                        if wallCheck(rootPart) then
                            dist = distance
                            closest = character
                        end
                    end
                end
            end
        end
    end

    return closest
end

local function initiatePlayerLock()
    -- Connect InputBegan for aiming
    local inputBeganConnection = UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            Aiming = true
            -- Lock on to a player only when you start aiming
            if not currentlyLocked then
                currentlyLocked = getClosestPlayerToMouse()
                print("Locked onto player:", currentlyLocked and currentlyLocked.Name or "None")
            end
        end
    end)
    
    -- Connect InputEnded for stopping aiming
    local inputEndedConnection = UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            Aiming = false
            currentlyLocked = nil -- Clear the lock when right-click is released
            print("Stopped aiming, unlocked player")
        end
    end)
    
    -- Connect RenderStepped for smoothly following the currently locked player
    local renderSteppedConnection = RunService.RenderStepped:Connect(function()
        if Aiming and currentlyLocked then
            local rootPart = currentlyLocked:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local tween = TweenService:Create(Camera, TweenInfo.new(0.01, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, rootPart.Position)})
                tween:Play()
            end
        end
    end)
    
    -- Function to disconnect all events and cleanup
    local function cleanup()
        if inputBeganConnection then
            inputBeganConnection:Disconnect()
            inputBeganConnection = nil
        end
        
        if inputEndedConnection then
            inputEndedConnection:Disconnect()
            inputEndedConnection = nil
        end
        
        if renderSteppedConnection then
            renderSteppedConnection:Disconnect()
            renderSteppedConnection = nil
        end
        
        Aiming = false
        currentlyLocked = nil
    end
    
    -- Return the cleanup function to be called when PlayerLock is disabled
    return cleanup
end

local playerLockCleanup

function toggleCallback(value)
    if value then
        print("Player lock enabled.")
        -- Enable player lock and set up cleanup function
        playerLockCleanup = initiatePlayerLock()
    else
        print("Player lock disabled.")
        -- Clean up when disabling player lock
        if playerLockCleanup then
            playerLockCleanup()
            playerLockCleanup = nil
        end
    end
end

local ChrAddedFunc
function PlayerEsp()
    if getgenv().configs.PlayerEsp then
        function EspOnPlayer(target)
            local EspRenderStepped
            local Boxoutline = Drawing.new('Square')
            Boxoutline.Thickness = 1
            Boxoutline.Filled = false
            Boxoutline.Transparency = 1
            Boxoutline.Color = Color3.new(0, 0, 0)
            
            local Box = Drawing.new('Square')
            Box.Thickness = 1
            Box.Transparency = 1
            Box.Filled = false
            Box.Color = Color3.fromRGB(0, 255, 0)
            
            local Healthbaroutline = Drawing.new('Square')
            Healthbaroutline.Thickness = 1
            Healthbaroutline.Filled = false
            Healthbaroutline.Transparency = 1
            Healthbaroutline.Color = Color3.new(0, 0, 0)
            
            local Healthbar = Drawing.new('Square')
            Healthbar.Thickness = 1
            Healthbar.Filled = false
            Healthbar.Transparency = 1
            Healthbar.Color = Color3.fromRGB(0, 255, 0)
            EspRenderStepped = RunService.RenderStepped:Connect(function()
                if getgenv().configs.PlayerEsp == false then
                    if Boxoutline then
                        Boxoutline:Remove()
                    end
                    if Box then
                        Box:Remove()
                    end
                    if Healthbaroutline then
                        Healthbaroutline:Remove()
                    end
                    if Healthbar then
                        Healthbar:Remove()
                    end
                    if EspRenderStepped then
                        EspRenderStepped:Disconnect()
                    end
                return end
                if target then
                    if IsPlayerAlive(target) then
                        local HumPos, onScreen = Camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position)
                        if onScreen then
                            local headpos = Camera:WorldToViewportPoint(target.Character.Head.Position + Vector3.new(0, 0.5, 0))
                            local LegPosition = Camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position - Vector3.new(0, 4.5, 0))
                            
                            Boxoutline.Size = Vector2.new(1050 / HumPos.Z, headpos.Y - LegPosition.Y)
                            Boxoutline.Position = Vector2.new(HumPos.X - Boxoutline.Size.X / 2, HumPos.Y - Boxoutline.Size.Y / 2)
                            Boxoutline.Visible = true
                            
                            Box.Size = Vector2.new(1050 / HumPos.Z, headpos.Y - LegPosition.Y)
                            Box.Position = Vector2.new(HumPos.X - Box.Size.X / 2, HumPos.Y - Box.Size.Y / 2 )
                            Box.Visible = true
                            
                            Healthbaroutline.Size = Vector2.new(2, headpos.Y - LegPosition.Y)
                            Healthbaroutline.Position = Boxoutline.Position - Vector2.new(8, 0)
                            Healthbaroutline.Visible = true
                            
                            Healthbar.Size = Vector2.new(2, (headpos.Y - LegPosition.Y) / (target.Character:FindFirstChildOfClass('Humanoid').MaxHealth / math.clamp(target.Character:FindFirstChildOfClass('Humanoid').Health, 0, target.Character:FindFirstChildOfClass('Humanoid').MaxHealth)))
                            Healthbar.Position = Vector2.new(Box.Position.X - 8, Box.Position.Y + (1/Healthbar.Size.Y))
                            Healthbar.Color = Color3.fromRGB(255, 0, 0):lerp(Color3.fromRGB(0, 255, 0), target.Character:FindFirstChildOfClass('Humanoid').Health / target.Character:FindFirstChildOfClass('Humanoid').MaxHealth)
                            Healthbar.Visible = true
                        else
                            Boxoutline.Visible = false
                            Box.Visible = false
                            Healthbaroutline.Visible = false
                            Healthbar.Visible = false
                        end
                    else
                        Boxoutline.Visible = false
                        Box.Visible = false
                        Healthbaroutline.Visible = false
                        Healthbar.Visible = false
                    end
                end
            end)
        end
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                EspOnPlayer(plr)
            end
        end
        if not ChrAddedFunc then
            ChrAddedFunc = Players.PlayerAdded:Connect(function(plr)
                if not getgenv().configs.PlayerEsp then
                    ChrAddedFunc:Disconnect()
                    ChrAddedFunc = nil
                end
                EspOnPlayer(plr)
            end)
        end
    end
end


local Main = AtlasUi:CreatePage("Main")
local LPlayer = AtlasUi:CreatePage("LocalPlayer")
local Visuals = AtlasUi:CreatePage("Visuals")
local ITScriptDupe = AtlasUi:CreatePage("Dupe")

local MainSection = Main:CreateSection("Main")


MainSection:CreateInteractable({
    Name = 'Infinite Yield',
    ActionText = 'Execute',
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source', true))()
    end
})

MainSection:CreateToggle({
    Name = 'Player Lock (Aimbot)',
    Default = false,
    Flag = 'PlayerLock',
    Callback = toggleCallback
})

MainSection:CreateToggle({
    Name = "Esp",
    Default = false,
    Flag = 'PlayerEsp',
    Callback = function(Value)
        getgenv().configs.PlayerEsp = Value
        PlayerEsp()
    end
})
local PlayerModificationsSection = LPlayer:CreateSection('Player Modifications')

PlayerModificationsSection:CreateSlider({
    Name = 'WalkSpeed',
    Min = 16,
    Max = 999,
    Default = 16,
    Digits = 0,
    Flag = 'WalkSpeed',
    Callback = function(value)
        -- Set the player's WalkSpeed to the selected value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
            print("WalkSpeed set to:", value)
        else
            print("No player character or Humanoid found.")
        end
    end     
})

local VisualSection = Visuals:CreateSection('Visuals')


-- Create a Brightness slider
VisualSection:CreateSlider({
    Name = 'Brightness',
    Min = 0,
    Max = 200,
    Default = 1,
    Digits = 2,
    Callback = function(value)
        game.Lighting.Brightness = value
        print("Brightness set to:", value)
    end
})

-- Create a slider to adjust the Ambient lighting
VisualSection:CreateColorPicker({
    Name = 'Ambient',
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        game.Lighting.Ambient = color
        print("Ambient color set to:", color)
    end
})

-- Create a slider to adjust the top color shift of the sky
VisualSection:CreateColorPicker({
    Name = 'ColorShiftTop',
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        game.Lighting.ColorShiftTop = color
        print("ColorShiftTop set to:", color)
    end
})

-- Create a slider to adjust the bottom color shift of the sky
VisualSection:CreateColorPicker({
    Name = 'ColorShiftBottom',
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        game.Lighting.ColorShiftBottom = color
        print("ColorShiftBottom set to:", color)
    end
})

-- Create a slider to control the ClockTime (time of day)
VisualSection:CreateSlider({
    Name = 'ClockTime',
    Min = 0,
    Max = 24,
    Default = 12,
    Digits = 2,
    Callback = function(value)
        game.Lighting.ClockTime = value
        print("ClockTime set to:", value)
    end
})

