-- FrostHub UI Library v2.0 - KOMPLETT NEU GECODED
-- Keine MouseButton1Down Fehler mehr!

local FrostHub = {}
FrostHub.__index = FrostHub

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Utility Functions
local function createInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties or {}) do
        instance[property] = value
    end
    return instance
end

local function addCorner(parent, radius)
    local corner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, radius or 8),
        Parent = parent
    })
    return corner
end

local function addGradient(parent, colors, rotation)
    local gradient = createInstance("UIGradient", {
        Color = ColorSequence.new(colors),
        Rotation = rotation or 0,
        Parent = parent
    })
    return gradient
end

-- Main Library Functions
function FrostHub:CreateNotificationSystem()
    -- Notification Frame
    self.NotificationFrame = createInstance("Frame", {
        Name = "NotificationFrame",
        Size = UDim2.new(0, 350, 0, 100),
        Position = UDim2.new(1, -370, 0, 20),
        BackgroundColor3 = Color3.fromRGB(22, 27, 34),
        BorderSizePixel = 0,
        Visible = false,
        Parent = self.ScreenGui
    })
    addCorner(self.NotificationFrame, 10)
    addGradient(self.NotificationFrame, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 27, 34)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 42, 52))
    }, 45)
    
    -- Notification Icon
    local notifIcon = createInstance("Frame", {
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0, 15, 0, 15),
        BackgroundColor3 = Color3.fromRGB(88, 166, 255),
        BorderSizePixel = 0,
        Parent = self.NotificationFrame
    })
    addCorner(notifIcon, 8)
    
    self.NotifIconText = createInstance("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "i",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        Parent = notifIcon
    })
    
    -- Notification Title
    self.NotifTitle = createInstance("TextLabel", {
        Size = UDim2.new(1, -70, 0, 25),
        Position = UDim2.new(0, 60, 0, 10),
        BackgroundTransparency = 1,
        Text = "Notification",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.NotificationFrame
    })
    
    -- Notification Text
    self.NotifText = createInstance("TextLabel", {
        Size = UDim2.new(1, -70, 0, 50),
        Position = UDim2.new(0, 60, 0, 35),
        BackgroundTransparency = 1,
        Text = "This is a notification message",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = self.NotificationFrame
    })
end

function FrostHub:ShowNotification(config)
    config = config or {}
    local title = config.Title or "Notification"
    local message = config.Message or "Message"
    local duration = config.Duration or 3
    local icon = config.Icon or "i"
    
    self.NotifTitle.Text = title
    self.NotifText.Text = message
    self.NotifIconText.Text = icon
    self.NotificationFrame.Visible = true
    
    -- Slide in animation
    self.NotificationFrame.Position = UDim2.new(1, 20, 0, 20)
    TweenService:Create(self.NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(1, -370, 0, 20)
    }):Play()
    
    -- Auto hide after duration
    task.spawn(function()
        task.wait(duration)
        TweenService:Create(self.NotificationFrame, TweenInfo.new(0.5), {
            Position = UDim2.new(1, 20, 0, 20)
        }):Play()
        task.wait(0.5)
        self.NotificationFrame.Visible = false
    end)
end

function FrostHub:SetupDragging()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    -- Drag Start
    self.TopBar.MouseButton1Down:Connect(function()
        dragging = true
        local mouse = Players.LocalPlayer:GetMouse()
        dragStart = Vector2.new(mouse.X, mouse.Y)
        startPos = self.ShadowFrame.Position
    end)
    
    -- Drag Move
    local heartbeat
    heartbeat = RunService.Heartbeat:Connect(function()
        if dragging then
            local mouse = Players.LocalPlayer:GetMouse()
            local delta = Vector2.new(mouse.X, mouse.Y) - dragStart
            self.ShadowFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Drag End
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

function FrostHub:SetupControlButtons()
    -- Minimize Button
    self.MinimizeBtn.MouseButton1Click:Connect(function()
        self.isMinimized = not self.isMinimized
        
        if self.isMinimized then
            -- Minimize animation
            TweenService:Create(self.ShadowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, self.Config.Size[1] + 6, 0, 51)
            }):Play()
            TweenService:Create(self.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, self.Config.Size[1], 0, 45)
            }):Play()
            
            self.TabFrame.Visible = false
            self.ContentFrame.Visible = false
        else
            -- Restore animation
            TweenService:Create(self.ShadowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, self.Config.Size[1] + 6, 0, self.Config.Size[2] + 6)
            }):Play()
            TweenService:Create(self.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, self.Config.Size[1], 0, self.Config.Size[2])
            }):Play()
            
            task.spawn(function()
                task.wait(0.2)
                self.TabFrame.Visible = true
                self.ContentFrame.Visible = true
            end)
        end
    end)
    
    -- Close Button
    self.CloseBtn.MouseButton1Click:Connect(function()
        self:Close()
    end)
    
    -- Button Hover Effects
    self.MinimizeBtn.MouseEnter:Connect(function()
        TweenService:Create(self.MinimizeBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 213, 27)
        }):Play()
    end)
    
    self.MinimizeBtn.MouseLeave:Connect(function()
        TweenService:Create(self.MinimizeBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 193, 7)
        }):Play()
    end)
    
    self.CloseBtn.MouseEnter:Connect(function()
        TweenService:Create(self.CloseBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(240, 73, 89)
        }):Play()
    end)
    
    self.CloseBtn.MouseLeave:Connect(function()
        TweenService:Create(self.CloseBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        }):Play()
    end)
end

function FrostHub:Close()
    local closeTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
    
    local fadeOutTween = TweenService:Create(self.ShadowFrame, closeTweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    })
    
    local mainFadeTween = TweenService:Create(self.MainFrame, closeTweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    
    fadeOutTween:Play()
    mainFadeTween:Play()
    
    fadeOutTween.Completed:Connect(function()
        if self.ScreenGui and self.ScreenGui.Parent then
            self.ScreenGui:Destroy()
        end
    end)
end

-- Example Usage
--[[
local FrostHub = loadstring(game:HttpGet("path_to_this_script"))()

local window = FrostHub:CreateWindow({
    Title = "FrostHub",
    Version = "v2.0",
    Theme = "Premium Edition",
    Size = {550, 350}
})

local mainTab = window:CreateTab({
    Name = "Main",
    Icon = "🏠"
})

mainTab:AddSection({Title = "Player"})

mainTab:AddButton({
    Text = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
})

mainTab:AddToggle({
    Text = "Auto Farm",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})

mainTab:AddSlider({
    Text = "Speed",
    Min = 1,
    Max = 100,
    Default = 16,
    Callback = function(value)
        print("Slider:", value)
    end
})

window:ShowNotification({
    Title = "FrostHub Loaded!",
    Message = "Welcome to FrostHub v2.0",
    Duration = 5,
    Icon = "✅"
})
--]]

return FrostHub:CreateWindow(config)
    local window = setmetatable({}, FrostHub)
    window.tabs = {}
    window.currentTab = nil
    window.isMinimized = false
    window.isDragging = false
    
    -- Config Setup
    config = config or {}
    config.Title = config.Title or "FrostHub"
    config.Version = config.Version or "v2.0"
    config.Theme = config.Theme or "Premium Edition"
    config.Size = config.Size or {550, 350}
    
    -- Create ScreenGui
    window.ScreenGui = createInstance("ScreenGui", {
        Name = "FrostHubUI_" .. math.random(1000, 9999),
        Parent = CoreGui,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    -- Shadow Frame
    window.ShadowFrame = createInstance("Frame", {
        Name = "ShadowFrame",
        Size = UDim2.new(0, config.Size[1] + 6, 0, config.Size[2] + 6),
        Position = UDim2.new(0.5, -(config.Size[1] + 6)/2, 0.5, -(config.Size[2] + 6)/2),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = window.ScreenGui
    })
    addCorner(window.ShadowFrame, 12)
    
    -- Main Frame
    window.MainFrame = createInstance("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, config.Size[1], 0, config.Size[2]),
        Position = UDim2.new(0, 3, 0, 3),
        BackgroundColor3 = Color3.fromRGB(22, 27, 34),
        BorderSizePixel = 0,
        Parent = window.ShadowFrame
    })
    addCorner(window.MainFrame, 10)
    addGradient(window.MainFrame, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 27, 34)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 22, 28))
    }, 45)
    
    -- Store config for later use
    window.Config = config
    
    -- Create UI Components
    window:CreateTopBar()
    window:CreateTabSystem()
    window:CreateNotificationSystem()
    window:SetupDragging()
    window:SetupControlButtons()
    
    return window
end

function FrostHub:CreateTopBar()
    local config = self.Config
    
    -- Top Bar (Using TextButton for proper event handling)
    self.TopBar = createInstance("TextButton", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 45),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(15, 20, 25),
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = self.MainFrame
    })
    addCorner(self.TopBar, 10)
    addGradient(self.TopBar, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 20, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 45))
    }, 90)
    
    -- Logo Frame
    local logoFrame = createInstance("Frame", {
        Size = UDim2.new(0, 35, 0, 35),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundColor3 = Color3.fromRGB(88, 166, 255),
        BorderSizePixel = 0,
        Parent = self.TopBar
    })
    addCorner(logoFrame, 8)
    addGradient(logoFrame, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 166, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 120, 192))
    }, 45)
    
    -- Logo Text
    createInstance("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = string.sub(config.Title, 1, 1):upper(),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        Parent = logoFrame
    })
    
    -- Title Label
    createInstance("TextLabel", {
        Size = UDim2.new(0, 280, 0, 20),
        Position = UDim2.new(0, 55, 0, 5),
        BackgroundTransparency = 1,
        Text = config.Title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.TopBar
    })
    
    -- Version Label
    createInstance("TextLabel", {
        Size = UDim2.new(0, 280, 0, 15),
        Position = UDim2.new(0, 55, 0, 22),
        BackgroundTransparency = 1,
        Text = config.Version .. " • " .. config.Theme,
        TextColor3 = Color3.fromRGB(88, 166, 255),
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.TopBar
    })
    
    -- Control Buttons Container
    self.ControlFrame = createInstance("Frame", {
        Size = UDim2.new(0, 80, 0, 30),
        Position = UDim2.new(1, -90, 0, 7.5),
        BackgroundTransparency = 1,
        Parent = self.TopBar
    })
    
    -- Minimize Button
    self.MinimizeBtn = createInstance("TextButton", {
        Size = UDim2.new(0, 35, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 193, 7),
        Text = "−",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = self.ControlFrame
    })
    addCorner(self.MinimizeBtn, 6)
    
    -- Close Button
    self.CloseBtn = createInstance("TextButton", {
        Size = UDim2.new(0, 35, 0, 30),
        Position = UDim2.new(0, 40, 0, 0),
        BackgroundColor3 = Color3.fromRGB(220, 53, 69),
        Text = "✕",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = self.ControlFrame
    })
    addCorner(self.CloseBtn, 6)
end

function FrostHub:CreateTabSystem()
    -- Tab Frame
    self.TabFrame = createInstance("Frame", {
        Name = "TabFrame",
        Size = UDim2.new(0, 120, 1, -55),
        Position = UDim2.new(0, 10, 0, 50),
        BackgroundColor3 = Color3.fromRGB(18, 23, 28),
        BorderSizePixel = 0,
        Parent = self.MainFrame
    })
    addCorner(self.TabFrame, 8)
    
    -- Content Frame
    self.ContentFrame = createInstance("Frame", {
        Name = "ContentFrame",
        Size = UDim2.new(0, 400, 1, -55),
        Position = UDim2.new(0, 140, 0, 50),
        BackgroundColor3 = Color3.fromRGB(18, 23, 28),
        BorderSizePixel = 0,
        Parent = self.MainFrame
    })
    addCorner(self.ContentFrame, 8)
end

function FrostHub:CreateTab(config)
    config = config or {}
    local name = config.Name or "Tab"
    local icon = config.Icon or "📄"
    
    local tab = {}
    local order = #self.tabs
    
    -- Tab Button (Using TextButton for proper clicking)
    tab.Button = createInstance("TextButton", {
        Name = name .. "Tab",
        Size = UDim2.new(1, -10, 0, 40),
        Position = UDim2.new(0, 5, 0, 10 + (order * 45)),
        BackgroundColor3 = Color3.fromRGB(25, 30, 35),
        Text = "",
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Parent = self.TabFrame
    })
    addCorner(tab.Button, 6)
    
    -- Tab Icon
    tab.Icon = createInstance("TextLabel", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0, 8, 0, 5),
        BackgroundTransparency = 1,
        Text = icon,
        TextColor3 = Color3.fromRGB(150, 150, 150),
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        Parent = tab.Button
    })
    
    -- Tab Label
    tab.Label = createInstance("TextLabel", {
        Size = UDim2.new(1, -45, 1, 0),
        Position = UDim2.new(0, 40, 0, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Color3.fromRGB(150, 150, 150),
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = tab.Button
    })
    
    -- Tab Content (ScrollingFrame)
    tab.Content = createInstance("ScrollingFrame", {
        Name = name .. "Content",
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(88, 166, 255),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Visible = false,
        BorderSizePixel = 0,
        Parent = self.ContentFrame
    })
    
    -- Layout for tab content
    local layout = createInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10),
        Parent = tab.Content
    })
    
    -- Auto-resize canvas
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    
    tab.Name = name
    tab.Window = self
    
    -- Tab Events
    tab.Button.MouseButton1Click:Connect(function()
        self:SelectTab(tab)
    end)
    
    -- Hover Effects
    tab.Button.MouseEnter:Connect(function()
        if tab ~= self.currentTab then
            TweenService:Create(tab.Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(30, 35, 40)
            }):Play()
        end
    end)
    
    tab.Button.MouseLeave:Connect(function()
        if tab ~= self.currentTab then
            TweenService:Create(tab.Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(25, 30, 35)
            }):Play()
        end
    end)
    
    -- Tab Methods
    function tab:AddSection(sectionConfig)
        return self.Window:CreateSection(self.Content, sectionConfig)
    end
    
    function tab:AddButton(buttonConfig)
        return self.Window:CreateButton(self.Content, buttonConfig)
    end
    
    function tab:AddToggle(toggleConfig)
        return self.Window:CreateToggle(self.Content, toggleConfig)
    end
    
    function tab:AddSlider(sliderConfig)
        return self.Window:CreateSlider(self.Content, sliderConfig)
    end
    
    table.insert(self.tabs, tab)
    
    -- Auto-select first tab
    if #self.tabs == 1 then
        self:SelectTab(tab)
    end
    
    return tab
end

function FrostHub:SelectTab(tab)
    -- Deselect current tab
    if self.currentTab then
        TweenService:Create(self.currentTab.Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(25, 30, 35)
        }):Play()
        TweenService:Create(self.currentTab.Icon, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(150, 150, 150)
        }):Play()
        TweenService:Create(self.currentTab.Label, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(150, 150, 150)
        }):Play()
        self.currentTab.Content.Visible = false
    end
    
    -- Select new tab
    self.currentTab = tab
    TweenService:Create(tab.Button, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(88, 166, 255)
    }):Play()
    TweenService:Create(tab.Icon, TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
    TweenService:Create(tab.Label, TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
    tab.Content.Visible = true
end

function FrostHub:CreateSection(parent, config)
    config = config or {}
    local title = config.Title or "Section"
    local order = config.Order or 0
    
    local section = createInstance("Frame", {
        Name = title .. "Section",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(35, 42, 52),
        BorderSizePixel = 0,
        LayoutOrder = order,
        Parent = parent
    })
    addCorner(section, 6)
    
    createInstance("TextLabel", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Color3.fromRGB(88, 166, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = section
    })
    
    return section
end

function FrostHub:CreateButton(parent, config)
    config = config or {}
    local text = config.Text or "Button"
    local callback = config.Callback or function() end
    local order = config.Order or 0
    
    local button = createInstance("TextButton", {
        Name = "Button" .. order,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(35, 42, 52),
        Text = "",
        BorderSizePixel = 0,
        LayoutOrder = order,
        AutoButtonColor = false,
        Parent = parent
    })
    addCorner(button, 8)
    addGradient(button, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 42, 52)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 52, 62))
    }, 90)
    
    -- Button Text
    local buttonText = createInstance("TextLabel", {
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = button
    })
    
    -- Button Icon
    local buttonIcon = createInstance("Frame", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -35, 0, 5),
        BackgroundColor3 = Color3.fromRGB(88, 166, 255),
        BorderSizePixel = 0,
        Parent = button
    })
    addCorner(buttonIcon, 15)
    
    createInstance("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "▶",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        Parent = buttonIcon
    })
    
    -- Events
    button.MouseEnter:Connect(function()
        TweenService:Create(button.UIGradient, TweenInfo.new(0.2), {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 52, 62)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 62, 72))
            })
        }):Play()
        TweenService:Create(buttonIcon, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(108, 186, 255)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button.UIGradient, TweenInfo.new(0.2), {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 42, 52)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 52, 62))
            })
        }):Play()
        TweenService:Create(buttonIcon, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(88, 166, 255)
        }):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

function FrostHub:CreateToggle(parent, config)
    config = config or {}
    local text = config.Text or "Toggle"
    local callback = config.Callback or function() end
    local default = config.Default or false
    local order = config.Order or 0
    
    local toggleFrame = createInstance("Frame", {
        Name = "ToggleFrame" .. order,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(35, 42, 52),
        BorderSizePixel = 0,
        LayoutOrder = order,
        Parent = parent
    })
    addCorner(toggleFrame, 8)
    
    -- Toggle Label
    createInstance("TextLabel", {
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggleFrame
    })
    
    -- Toggle Container
    local toggleContainer = createInstance("Frame", {
        Size = UDim2.new(0, 60, 0, 30),
        Position = UDim2.new(1, -75, 0, 7.5),
        BackgroundColor3 = default and Color3.fromRGB(88, 166, 255) or Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        Parent = toggleFrame
    })
    addCorner(toggleContainer, 15)
    
    -- Toggle Button
    local toggleButton = createInstance("Frame", {
        Size = UDim2.new(0, 26, 0, 26),
        Position = default and UDim2.new(0, 32, 0, 2) or UDim2.new(0, 2, 0, 2),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = toggleContainer
    })
    addCorner(toggleButton, 13)
    
    -- Click Area
    local clickArea = createInstance("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        Parent = toggleContainer
    })
    
    local isToggled = default
    
    clickArea.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        
        if isToggled then
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(88, 166, 255)
            }):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                Position = UDim2.new(0, 32, 0, 2)
            }):Play()
        else
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            }):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                Position = UDim2.new(0, 2, 0, 2)
            }):Play()
        end
        
        callback(isToggled)
    end)
    
    local toggle = {}
    function toggle:SetValue(value)
        isToggled = value
        if isToggled then
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(88, 166, 255)
            }):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                Position = UDim2.new(0, 32, 0, 2)
            }):Play()
        else
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            }):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {
                Position = UDim2.new(0, 2, 0, 2)
            }):Play()
        end
    end
    
    return toggle
end

function FrostHub:CreateSlider(parent, config)
    config = config or {}
    local text = config.Text or "Slider"
    local min = config.Min or 0
    local max = config.Max or 100
    local default = config.Default or min
    local callback = config.Callback or function() end
    local order = config.Order or 0
    
    local sliderFrame = createInstance("Frame", {
        Name = "SliderFrame" .. order,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Color3.fromRGB(35, 42, 52),
        BorderSizePixel = 0,
        LayoutOrder = order,
        Parent = parent
    })
    addCorner(sliderFrame, 8)
    
    -- Slider Label
    local sliderLabel = createInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.new(0, 15, 0, 8),
        BackgroundTransparency = 1,
        Text = text .. ": " .. default,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sliderFrame
    })
    
    -- Slider Track
    local sliderTrack = createInstance("TextButton", {
        Size = UDim2.new(1, -30, 0, 8),
        Position = UDim2.new(0, 15, 0, 35),
        BackgroundColor3 = Color3.fromRGB(60, 67, 77),
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = sliderFrame
    })
    addCorner(sliderTrack, 4)
    
    -- Slider Fill
    local sliderFill = createInstance("Frame", {
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(88, 166, 255),
        BorderSizePixel = 0,
        Parent = sliderTrack
    })
    addCorner(sliderFill, 4)
    
    -- Slider Knob
    local sliderKnob = createInstance("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(1, -8, 0, -4),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = sliderFill
    })
    addCorner(sliderKnob, 8)
    
    local currentValue = default
    local dragging = false
    
    local function updateSlider()
        local percentage = (currentValue - min) / (max - min)
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderLabel.Text = text .. ": " .. math.floor(currentValue)
        callback(currentValue)
    end
    
    local function handleInput(input)
        if dragging then
            local relativeX = math.clamp(input.Position.X - sliderTrack.AbsolutePosition.X, 0, sliderTrack.AbsoluteSize.X)
            local percentage = relativeX / sliderTrack.AbsoluteSize.X
            currentValue = min + (max - min) * percentage
            updateSlider()
        end
    end
    
    sliderTrack.MouseButton1Down:Connect(function()
        dragging = true
        local mouse = Players.LocalPlayer:GetMouse()
        local relativeX = math.clamp(mouse.X - sliderTrack.AbsolutePosition.X, 0, sliderTrack.AbsoluteSize.X)
        local percentage = relativeX / sliderTrack.AbsoluteSize.X
        currentValue = min + (max - min) * percentage
        updateSlider()
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            handleInput(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    updateSlider()
    
    local slider = {}
    function slider:SetValue(value)
        currentValue = math.clamp(value, min, max)
        updateSlider()
    end
    
    return slider
end

function FrostHub
