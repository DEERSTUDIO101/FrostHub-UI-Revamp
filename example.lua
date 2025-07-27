-- FrostHub Library Beispiel Script
-- Wie man die FrostHub UI Library verwendet

-- Library laden (normalerweise über loadstring)
-- local FrostHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/FrostHub-Library/main/source.lua"))()

-- Für dieses Beispiel nehmen wir an, dass die Library bereits geladen ist
local FrostHub = require(script.FrostHubLibrary) -- Falls als ModuleScript

-- Window erstellen
local Window = FrostHub:CreateWindow({
    Title = "FrostHub Universal",
    Version = "v4.7.7", 
    Theme = "Premium Edition",
    Size = {550, 350}
})

-- Home Tab
local HomeTab = Window:CreateTab({
    Name = "Home",
    Icon = "🏠"
})

HomeTab:AddSection({
    Title = "Welcome to FrostHub"
})

HomeTab:AddButton({
    Text = "Join Discord Server",
    Callback = function()
        Window:ShowNotification({
            Title = "Discord",
            Message = "Discord invite copied to clipboard!",
            Duration = 2,
            Icon = "💬"
        })
        setclipboard("https://discord.gg/frosthub") -- Beispiel Discord Link
    end
})

HomeTab:AddButton({
    Text = "Check for Updates",
    Callback = function()
        Window:ShowNotification({
            Title = "Update",
            Message = "You are running the latest version!",
            Duration = 2,
            Icon = "✅"
        })
    end
})

HomeTab:AddSection({
    Title = "User Information"
})

-- Combat Tab
local CombatTab = Window:CreateTab({
    Name = "Combat",
    Icon = "⚔️"
})

CombatTab:AddSection({
    Title = "Aimbot Settings"
})

local AimbotToggle = CombatTab:AddToggle({
    Text = "Enable Aimbot",
    Default = false,
    Callback = function(state)
        Window:ShowNotification({
            Title = "Aimbot",
            Message = "Aimbot " .. (state and "enabled" or "disabled"),
            Duration = 2,
            Icon = "🎯"
        })
        print("Aimbot:", state)
    end
})

local FOVSlider = CombatTab:AddSlider({
    Text = "FOV Size",
    Min = 50,
    Max = 500,
    Default = 200,
    Callback = function(value)
        print("FOV Size:", value)
        -- Hier würde die FOV Logik stehen
    end
})

CombatTab:AddToggle({
    Text = "Visible Check",
    Default = true,
    Callback = function(state)
        print("Visible Check:", state)
    end
})

CombatTab:AddSection({
    Title = "Combat Features"
})

CombatTab:AddButton({
    Text = "Silent Aim",
    Callback = function()
        Window:ShowNotification({
            Title = "Silent Aim",
            Message = "Silent aim activated!",
            Duration = 2,
            Icon = "🔫"
        })
    end
})

CombatTab:AddToggle({
    Text = "Triggerbot",
    Default = false,
    Callback = function(state)
        print("Triggerbot:", state)
    end
})

-- Movement Tab
local MovementTab = Window:CreateTab({
    Name = "Movement",
    Icon = "🏃"
})

MovementTab:AddSection({
    Title = "Movement Enhancement"
})

local WalkSpeedSlider = MovementTab:AddSlider({
    Text = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end
})

local JumpPowerSlider = MovementTab:AddSlider({
    Text = "Jump Power",
    Min = 50,
    Max = 200,
    Default = 50,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end
})

MovementTab:AddSection({
    Title = "Special Abilities"
})

MovementTab:AddToggle({
    Text = "Infinite Jump",
    Default = false,
    Callback = function(state)
        Window:ShowNotification({
            Title = "Infinite Jump",
            Message = "Infinite jump " .. (state and "enabled" or "disabled"),
            Duration = 2,
            Icon = "🦘"
        })
        -- Infinite Jump Logik hier
    end
})

MovementTab:AddToggle({
    Text = "Fly Mode",
    Default = false,
    Callback = function(state)
        Window:ShowNotification({
            Title = "Fly",
            Message = "Fly mode " .. (state and "enabled" or "disabled"),
            Duration = 2,
            Icon = "✈️"
        })
        -- Fly Logik hier
    end
})

MovementTab:AddToggle({
    Text = "No Clip",
    Default = false,
    Callback = function(state)
        Window:ShowNotification({
            Title = "NoClip",
            Message = "No clip " .. (state and "enabled" or "disabled"),
            Duration = 2,
            Icon = "👻"
        })
        -- NoClip Logik hier
    end
})

-- Visual Tab
local VisualTab = Window:CreateTab({
    Name = "Visual",
    Icon = "👁️"
})

VisualTab:AddSection({
    Title = "ESP Settings"
})

VisualTab:AddToggle({
    Text = "Player ESP",
    Default = false,
    Callback = function(state)
        Window:ShowNotification({
            Title = "ESP",
            Message = "Player ESP " .. (state and "enabled" or "disabled"),
            Duration = 2,
            Icon = "👁️"
        })
        -- ESP Logik hier
    end
})

VisualTab:AddToggle({
    Text = "Name ESP",
    Default = false,
    Callback = function(state)
        print("Name ESP:", state)
    end
})

VisualTab:AddToggle({
    Text = "Distance ESP",
    Default = false,
    Callback = function(state)
        print("Distance ESP:", state)
    end
})

VisualTab:AddSection({
    Title = "Visual Effects"
})

VisualTab:AddToggle({
    Text = "Fullbright",
    Default = false,
    Callback = function(state)
        local lighting = game:GetService("Lighting")
        if state then
            lighting.Brightness = 3
            lighting.ClockTime = 14
            lighting.FogEnd = 100000
        else
            lighting.Brightness = 1
            lighting.ClockTime = 12
            lighting.FogEnd = 100000
        end
        Window:ShowNotification({
            Title = "Fullbright",
            Message = "Fullbright " .. (state and "enabled" or "disabled"),
            Duration = 2,
            Icon = "💡"
        })
    end
})

VisualTab:AddButton({
    Text = "Remove Fog",
    Callback = function()
        game:GetService("Lighting").FogEnd = 100000
        Window:ShowNotification({
            Title = "Fog",
            Message = "Fog removed successfully!",
            Duration = 2,
            Icon = "🌫️"
        })
    end
})

-- Misc Tab
local MiscTab = Window:CreateTab({
    Name = "Misc",
    Icon = "🔧"
})

MiscTab:AddSection({
    Title = "Game Features"
})

MiscTab:AddButton({
    Text = "Rejoin Server",
    Callback = function()
        local player = game.Players.LocalPlayer
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
    end
})

MiscTab:AddButton({
    Text = "Server Hop",
    Callback = function()
        Window:ShowNotification({
            Title = "Server Hop",
            Message = "Finding new server...",
            Duration = 2,
            Icon = "🔄"
        })
        -- Server Hop Logik hier
    end
})

MiscTab:AddSection({
    Title = "Settings"
})

local NotificationToggle = MiscTab:AddToggle({
    Text = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications:", state)
    end
})

MiscTab:AddButton({
    Text = "Save Config",
    Callback = function()
        Window:ShowNotification({
            Title = "Config",
            Message = "Configuration saved!",
            Duration = 2,
            Icon = "💾"
        })
        -- Config speichern
    end
})

MiscTab:AddButton({
    Text = "Load Config",
    Callback = function()
        Window:ShowNotification({
            Title = "Config",
            Message = "Configuration loaded!",
            Duration = 2,
            Icon = "📁"
        })
        -- Config laden
    end
})

-- Welcome Notification anzeigen
spawn(function()
    wait(0.8)
    Window:ShowNotification({
        Title = "FrostHub Universal",
        Message = "Welcome " .. game.Players.LocalPlayer.Name .. "! UI loaded successfully.",
        Duration = 4,
        Icon = "🎉"
    })
end)

-- Beispiel für dynamische Werte setzen
spawn(function()
    wait(5) -- Nach 5 Sekunden
    -- Aimbot automatisch aktivieren
    AimbotToggle:SetValue(true)
    
    -- FOV auf 300 setzen
    FOVSlider:SetValue(300)
    
    -- Walk Speed auf 50 setzen
    WalkSpeedSlider:SetValue(50)
end)
