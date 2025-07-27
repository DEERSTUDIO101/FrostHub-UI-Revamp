-- FrostHub UI Library v1.0 - FIXED VERSION
-- Modulare UI Library für Roblox Scripts

local FrostHub = {}
FrostHub.__index = FrostHub

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Library Functions
function FrostHub:CreateWindow(config)
    local window = {}
    window.tabs = {}
    window.currentTab = nil
    
    -- Default config
    config = config or {}
    config.Title = config.Title or "FrostHub"
    config.Version = config.Version or "v1.0"
    config.Theme = config.Theme or "Premium Edition"
    config.Size = config.Size or {550, 350}
    
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FrostHubUI_" .. math.random(1000, 9999)
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false
    window.ScreenGui = screenGui
    
    -- Shadow Frame
    local shadowFrame = Instance.new("Frame")
    shadowFrame.Name = "ShadowFrame"
    shadowFrame.Size = UDim2.new(0, config.Size[1] + 6, 0, config.Size[2] + 6)
    shadowFrame.Position = UDim2.new(0.5, -(config.Size[1] + 6)/2, 0.5, -(config.Size[2] + 6)/2)
    shadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadowFrame.BackgroundTransparency = 0.7
    shadowFrame.BorderSizePixel = 0
    shadowFrame.Parent = screenGui
    window.ShadowFrame = shadowFrame
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 12)
    shadowCorner.Parent = shadowFrame
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, config.Size[1], 0, config.Size[2])
    mainFrame.Position = UDim2.new(0, 3, 0, 3)
    mainFrame.BackgroundColor3 = Color3.fromRGB(22, 27, 34)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = shadowFrame
    window.MainFrame = mainFrame
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame
    
    -- Gradient Background
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 27, 34)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 22, 28))
    })
    gradient.Rotation = 45
    gradient.Parent = mainFrame
    
    -- Copy all FrostHub methods to window
    for key, value in pairs(FrostHub) do
        if type(value) == "function" and key ~= "CreateWindow" then
            window[key] = value
        end
    end
    
    -- Create Top Bar
    window:CreateTopBar(config)
    
    -- Create Tab System
    window:CreateTabSystem()
    
    -- Create Notification System
    window:CreateNotificationSystem()
    
    -- Setup Dragging
    window:SetupDragging()
    
    -- Setup Control Buttons
    window:SetupControlButtons()
    
    return window
end

function FrostHub:CreateTopBar(config)
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 45)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(15, 20, 25)
    topBar.BorderSizePixel = 0
    topBar.Parent = self.MainFrame
    self.TopBar = topBar
    
    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 10)
    topCorner.Parent = topBar
    
    local topGradient = Instance.new("UIGradient")
    topGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 20, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 45))
    })
    topGradient.Rotation = 90
    topGradient.Parent = topBar
    
    -- Logo
    local logoFrame = Instance.new("Frame")
    logoFrame.Size = UDim2.new(0, 35, 0, 35)
    logoFrame.Position = UDim2.new(0, 10, 0, 5)
    logoFrame.BackgroundColor3 = Color3.fromRGB(88, 166, 255)
    logoFrame.BorderSizePixel = 0
    logoFrame.Parent = topBar
    
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(0, 8)
    logoCorner.Parent = logoFrame
    
    local logoGradient = Instance.new("UIGradient")
    logoGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 166, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 120, 192))
    })
    logoGradient.Rotation = 45
    logoGradient.Parent = logoFrame
    
    local logoText = Instance.new("TextLabel")
    logoText.Size = UDim2.new(1, 0, 1, 0)
    logoText.BackgroundTransparency = 1
    logoText.Text = string.sub(config.Title, 1, 1):upper()
    logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    logoText.TextScaled = true
    logoText.Font = Enum.Font.GothamBold
    logoText.Parent = logoFrame
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 280, 0, 20)
    titleLabel.Position = UDim2.new(0, 55, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.Title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar
    
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(0, 280, 0, 15)
    versionLabel.Position = UDim2.new(0, 55, 0, 22)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = config.Version .. " • " .. config.Theme
    versionLabel.TextColor3 = Color3.fromRGB(88, 166, 255)
    versionLabel.TextSize = 11
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.TextXAlignment = Enum.TextXAlignment.Left
    versionLabel.Parent = topBar
    
    -- Control Buttons
    local controlFrame = Instance.new("Frame")
    controlFrame.Size = UDim2.new(0, 80, 0, 30)
    controlFrame.Position = UDim2.new(1, -90, 0, 7.5)
    controlFrame.BackgroundTransparency = 1
    controlFrame.Parent = topBar
    self.ControlFrame = controlFrame
    
    -- Minimize Button
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 35, 0, 30)
    minimizeBtn.Position = UDim2.new(0, 0, 0, 0)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
    minimizeBtn.Text = "−"
    minimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    minimizeBtn.TextSize = 16
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = controlFrame
    self.MinimizeBtn = minimizeBtn
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 6)
    minimizeCorner.Parent = minimizeBtn
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 30)
    closeBtn.Position = UDim2.new(0, 40, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 14
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = controlFrame
    self.CloseBtn = closeBtn
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn
end

function FrostHub:CreateTabSystem()
    -- Tab Frame
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = "TabFrame"
    tabFrame.Size = UDim2.new(0, 120, 1, -55)
    tabFrame.Position = UDim2.new(0, 10, 0, 50)
    tabFrame.BackgroundColor3 = Color3.fromRGB(18, 23, 28)
    tabFrame.BorderSizePixel = 0
    tabFrame.Parent = self.MainFrame
    self.TabFrame = tabFrame
    
    local tabFrameCorner = Instance.new("UICorner")
    tabFrameCorner.CornerRadius = UDim.new(0, 8)
    tabFrameCorner.Parent = tabFrame
    
    -- Content Frame
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(0, 400, 1, -55)
    contentFrame.Position = UDim2.new(0, 140, 0, 50)
    contentFrame.BackgroundColor3 = Color3.fromRGB(18, 23, 28)
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = self.MainFrame
    self.ContentFrame = contentFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = contentFrame
end

function FrostHub:CreateTab(config)
    config = config or {}
    local name = config.Name or "Tab"
    local icon = config.Icon or "📄"
    
    local tab = {}
    local order = #self.tabs
    
    -- Tab Button
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(1, -10, 0, 40)
    tabButton.Position = UDim2.new(0, 5, 0, 10 + (order * 45))
    tabButton.BackgroundColor3 = Color3.fromRGB(25, 30, 35)
    tabButton.Text = ""
    tabButton.BorderSizePixel = 0
    tabButton.Parent = self.TabFrame
    
    local tabButtonCorner = Instance.new("UICorner")
    tabButtonCorner.CornerRadius = UDim.new(0, 6)
    tabButtonCorner.Parent = tabButton
    
    -- Tab Icon
    local tabIcon = Instance.new("TextLabel")
    tabIcon.Size = UDim2.new(0, 30, 0, 30)
    tabIcon.Position = UDim2.new(0, 8, 0, 5)
    tabIcon.BackgroundTransparency = 1
    tabIcon.Text = icon
    tabIcon.TextColor3 = Color3.fromRGB(150, 150, 150)
    tabIcon.TextSize = 16
    tabIcon.Font = Enum.Font.GothamBold
    tabIcon.Parent = tabButton
    
    -- Tab Label
    local tabLabel = Instance.new("TextLabel")
    tabLabel.Size = UDim2.new(1, -45, 1, 0)
    tabLabel.Position = UDim2.new(0, 40, 0, 0)
    tabLabel.BackgroundTransparency = 1
    tabLabel.Text = name
    tabLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    tabLabel.TextSize = 12
    tabLabel.Font = Enum.Font.Gotham
    tabLabel.TextXAlignment = Enum.TextXAlignment.Left
    tabLabel.Parent = tabButton
    
    -- Tab Content
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = name .. "Content"
    tabContent.Size = UDim2.new(1, -20, 1, -20)
    tabContent.Position = UDim2.new(0, 10, 0, 10)
    tabContent.BackgroundTransparency = 1
    tabContent.ScrollBarThickness = 4
    tabContent.ScrollBarImageColor3 = Color3.fromRGB(88, 166, 255)
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.Visible = false
    tabContent.Parent = self.ContentFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = tabContent
    
    -- Auto-resize canvas
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
    end)
    
    tab.Button = tabButton
    tab.Content = tabContent
    tab.Icon = tabIcon
    tab.Label = tabLabel
    tab.Name = name
    tab.Window = self
    
    -- Tab Click Handler
    tabButton.MouseButton1Click:Connect(function()
        self:SelectTab(tab)
    end)
    
    -- Hover Effects
    tabButton.MouseEnter:Connect(function()
        if tab ~= self.currentTab then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 35, 40)}):Play()
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if tab ~= self.currentTab then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 30, 35)}):Play()
        end
    end)
    
    table.insert(self.tabs, tab)
    
    -- Auto-select first tab
    if #self.tabs == 1 then
        self:SelectTab(tab)
    end
    
    -- Add tab methods
    function tab:AddSection(config)
        return self.Window:CreateSection(self.Content, config)
    end
    
    function tab:AddButton(config)
        return self.Window:CreateButton(self.Content, config)
    end
    
    function tab:AddToggle(config)
        return self.Window:CreateToggle(self.Content, config)
    end
    
    function tab:AddSlider(config)
        return self.Window:CreateSlider(self.Content, config)
    end
    
    return tab
end

function FrostHub:SelectTab(tab)
    if self.currentTab then
        -- Deselect current tab
        TweenService:Create(self.currentTab.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 30, 35)}):Play()
        TweenService:Create(self.currentTab.Icon, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        TweenService:Create(self.currentTab.Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        self.currentTab.Content.Visible = false
    end
    
    -- Select new tab
    self.currentTab = tab
    TweenService:Create(tab.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(88, 166, 255)}):Play()
    TweenService:Create(tab.Icon, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(tab.Label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    tab.Content.Visible = true
end

function FrostHub:CreateSection(parent, config)
    config = config or {}
    local title = config.Title or "Section"
    local order = config.Order or 0
    
    local section = Instance.new("Frame")
    section.Name = title .. "Section"
    section.Size = UDim2.new(1, 0, 0, 30)
    section.BackgroundColor3 = Color3.fromRGB(35, 42, 52)
    section.BorderSizePixel = 0
    section.LayoutOrder = order
    section.Parent = parent
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 6)
    sectionCorner.Parent = section
    
    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Size = UDim2.new(1, -20, 1, 0)
    sectionLabel.Position = UDim2.new(0, 15, 0, 0)
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.Text = title
    sectionLabel.TextColor3 = Color3.fromRGB(88, 166, 255)
    sectionLabel.TextSize = 14
    sectionLabel.Font = Enum.Font.GothamBold
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.Parent = section
    
    return section
end

function FrostHub:CreateButton(parent, config)
    config = config or {}
    local text = config.Text or "Button"
    local callback = config.Callback or function() end
    local order = config.Order or 0
    
    local button = Instance.new("TextButton")
    button.Name = "Button" .. order
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(35, 42, 52)
    button.Text = ""
    button.BorderSizePixel = 0
    button.LayoutOrder = order
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 42, 52)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 52, 62))
    })
    buttonGradient.Rotation = 90
    buttonGradient.Parent = button
    
    local buttonText = Instance.new("TextLabel")
    buttonText.Size = UDim2.new(1, -20, 1, 0)
    buttonText.Position = UDim2.new(0, 10, 0, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = text
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextSize = 14
    buttonText.Font = Enum.Font.Gotham
    buttonText.TextXAlignment = Enum.TextXAlignment.Left
    buttonText.Parent = button
    
    local buttonIcon = Instance.new("TextLabel")
    buttonIcon.Size = UDim2.new(0, 30, 0, 30)
    buttonIcon.Position = UDim2.new(1, -35, 0, 5)
    buttonIcon.BackgroundColor3 = Color3.fromRGB(88, 166, 255)
    buttonIcon.Text = "▶"
    buttonIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonIcon.TextSize = 12
    buttonIcon.Font = Enum.Font.GothamBold
    buttonIcon.BorderSizePixel = 0
    buttonIcon.Parent = button
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 15)
    iconCorner.Parent = buttonIcon
    
    -- Hover Effects
    button.MouseEnter:Connect(function()
        TweenService:Create(buttonGradient, TweenInfo.new(0.2), {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 52, 62)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 62, 72))
            })
        }):Play()
        TweenService:Create(buttonIcon, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(108, 186, 255)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(buttonGradient, TweenInfo.new(0.2), {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 42, 52)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 52, 62))
            })
        }):Play()
        TweenService:Create(buttonIcon, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(88, 166, 255)}):Play()
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
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "ToggleFrame" .. order
    toggleFrame.Size = UDim2.new(1, 0, 0, 45)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 42, 52)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.LayoutOrder = order
    toggleFrame.Parent = parent
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleFrame
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(1, -100, 1, 0)
    toggleLabel.Position = UDim2.new(0, 15, 0, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = text
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.TextSize = 14
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleFrame
    
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Size = UDim2.new(0, 60, 0, 30)
    toggleContainer.Position = UDim2.new(1, -75, 0, 7.5)
    toggleContainer.BackgroundColor3 = default and Color3.fromRGB(88, 166, 255) or Color3.fromRGB(60, 60, 60)
    toggleContainer.BorderSizePixel = 0
    toggleContainer.Parent = toggleFrame
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 15)
    containerCorner.Parent = toggleContainer
    
    local toggleButton = Instance.new("Frame")
    toggleButton.Size = UDim2.new(0, 26, 0, 26)
    toggleButton.Position = default and UDim2.new(0, 32, 0, 2) or UDim2.new(0, 2, 0, 2)
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = toggleContainer
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 13)
    buttonCorner.Parent = toggleButton
    
    local toggleClickArea = Instance.new("TextButton")
    toggleClickArea.Size = UDim2.new(1, 0, 1, 0)
    toggleClickArea.BackgroundTransparency = 1
    toggleClickArea.Text = ""
    toggleClickArea.Parent = toggleContainer
    
    local isToggled = default
    
    toggleClickArea.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(88, 166, 255)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {Position = UDim2.new(0, 32, 0, 2)}):Play()
        else
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0, 2)}):Play()
        end
        callback(isToggled)
    end)
    
    local toggle = {}
    function toggle:SetValue(value)
        isToggled = value
        if isToggled then
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(88, 166, 255)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {Position = UDim2.new(0, 32, 0, 2)}):Play()
        else
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0, 2)}):Play()
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
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "SliderFrame" .. order
    sliderFrame.Size = UDim2.new(1, 0, 0, 60)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 42, 52)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.LayoutOrder = order
    sliderFrame.Parent = parent
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = sliderFrame
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, -20, 0, 25)
    sliderLabel.Position = UDim2.new(0, 15, 0, 8)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = text .. ": " .. default
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.TextSize = 14
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderFrame
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Size = UDim2.new(1, -30, 0, 8)
    sliderTrack.Position = UDim2.new(0, 15, 0, 35)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(60, 67, 77)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = sliderFrame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 4)
    trackCorner.Parent = sliderTrack
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(88, 166, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = sliderFill
    
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
    sliderKnob.Position = UDim2.new(1, -8, 0, -4)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.BorderSizePixel = 0
    sliderKnob.Parent = sliderFill
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0, 8)
    knobCorner.Parent = sliderKnob
    
    local currentValue = default
    local dragging = false
    local connection
    
    local function updateSlider()
        local percentage = (currentValue - min) / (max - min)
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderLabel.Text = text .. ": " .. math.floor(currentValue)
        callback(currentValue)
    end
    
    local function startDrag()
        dragging = true
        if connection then
            connection:Disconnect()
        end
        connection = Players.LocalPlayer:GetMouse().Move:Connect(function()
            if dragging then
                local mouse = Players.LocalPlayer:GetMouse()
                local relativeX = math.clamp(mouse.X - sliderTrack.AbsolutePosition.X, 0, sliderTrack.AbsoluteSize.X)
                local percentage = relativeX / sliderTrack.AbsoluteSize.X
                currentValue = min + (max - min) * percentage
                updateSlider()
            end
        end)
    end
    
    local function stopDrag()
        dragging = false
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
    
    -- FIXED: Use MouseButton1Down instead of InputBegan
    sliderTrack.MouseButton1Down:Connect(function()
        startDrag()
        local mouse = Players.LocalPlayer:GetMouse()
        local relativeX = math.clamp(mouse.X - sliderTrack.AbsolutePosition.X, 0, sliderTrack.AbsoluteSize.X)
        local percentage = relativeX / sliderTrack.AbsoluteSize.X
        currentValue = min + (max - min) * percentage
        updateSlider()
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            stopDrag()
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

function FrostHub:CreateNotificationSystem()
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "NotificationFrame"
    notificationFrame.Size = UDim2.new(0, 350, 0, 100)
    notificationFrame.Position = UDim2.new(1, -370, 0, 20)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(22, 27, 34)
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Visible = false
    notificationFrame.Parent = self.ScreenGui
    self.NotificationFrame = notificationFrame
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 10)
    notifCorner.Parent = notificationFrame
    
    local notifGradient = Instance.new("UIGradient")
    notifGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 27, 34)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 42, 52))
    })
    notifGradient.Rotation = 45
    notifGradient.Parent = notificationFrame
    
    local notifIcon = Instance.new("Frame")
    notifIcon.Size = UDim2.new(0, 40, 0, 40)
    notifIcon.Position = UDim2.new(0, 15, 0, 15)
    notifIcon.BackgroundColor3 = Color3.fromRGB(88, 166, 255)
    notifIcon.BorderSizePixel = 0
    notifIcon.Parent = notificationFrame
    
    local notifIconCorner = Instance.new("UICorner")
    notifIconCorner.CornerRadius = UDim.new(0, 8)
    notifIconCorner.Parent = notifIcon
    
    local notifIconText = Instance.new("TextLabel")
    notifIconText.Size = UDim2.new(1, 0, 1, 0)
    notifIconText.BackgroundTransparency = 1
    notifIconText.Text = "i"
    notifIconText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifIconText.TextSize = 20
    notifIconText.Font = Enum.Font.GothamBold
    notifIconText.Parent = notifIcon
    self.NotifIconText = notifIconText
    
    local notifTitle = Instance.new("TextLabel")
    notifTitle.Size = UDim2.new(1, -70, 0, 25)
    notifTitle.Position = UDim2.new(0, 60, 0, 10)
    notifTitle.BackgroundTransparency = 1
    notifTitle.Text = "Notification"
    notifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifTitle.TextSize = 16
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextXAlignment = Enum.TextXAlignment.Left
    notifTitle.Parent = notificationFrame
    self.NotifTitle = notifTitle
    
    local notifText = Instance.new("TextLabel")
    notifText.Size = UDim2.new(1, -70, 0, 50)
    notifText.Position = UDim2.new(0, 60, 0, 35)
    notifText.BackgroundTransparency = 1
    notifText.Text = "This is a notification message"
    notifText.TextColor3 = Color3.fromRGB(200, 200, 200)
    notifText.TextSize = 12
    notifText.Font = Enum.Font.Gotham
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.TextWrapped = true
    notifText.Parent = notificationFrame
    self.NotifText = notifText
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
    spawn(function()
        wait(duration)
        TweenService:Create(self.NotificationFrame, TweenInfo.new(0.5), {
            Position = UDim2.new(1, 20, 0, 20)
        }):Play()
        wait(0.5)
        self.NotificationFrame.Visible = false
    end)
end

-- FIXED: Complete SetupDragging function with proper mouse handling
function FrostHub:SetupDragging()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    -- FIXED: Use MouseButton1Down instead of InputBegan
    self.TopBar.MouseButton1Down:Connect(function()
        dragging = true
        local mouse = Players.LocalPlayer:GetMouse()
        dragStart = Vector2.new(mouse.X, mouse.Y)
        startPos = self.ShadowFrame.Position
    end)
    
    -- FIXED: Use Mouse.Move instead of InputChanged
    Players.LocalPlayer:GetMouse().Move:Connect(function()
        if dragging then
            local mouse = Players.LocalPlayer:GetMouse()
            local delta = Vector2.new(mouse.X, mouse.Y) - dragStart
            self.ShadowFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

function FrostHub:SetupControlButtons()
    local isMinimized = false
    
    -- Minimize Button
    self.MinimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            TweenService:Create(self.ShadowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 556, 0, 51)
            }):Play()
            TweenService:Create(self.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 550, 0, 45)
            }):Play()
            self.TabFrame.Visible = false
            self.ContentFrame.Visible = false
        else
            TweenService:Create(self.ShadowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 556, 0, 356)
            }):Play()
            TweenService:Create(self.MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 550, 0, 350)
            }):Play()
            spawn(function()
                wait(0.2)
                self.TabFrame.Visible = true
                self.ContentFrame.Visible = true
            end)
        end
    end)
    
    -- Close Button
    self.CloseBtn.MouseButton1Click:Connect(function()
        self:Close()
    end)
    
    -- Hover Effects
    self.MinimizeBtn.MouseEnter:Connect(function()
        TweenService:Create(self.MinimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 213, 27)}):Play()
    end)
    self.MinimizeBtn.MouseLeave:Connect(function()
        TweenService:Create(self.MinimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 193, 7)}):Play()
    end)
    
    self.CloseBtn.MouseEnter:Connect(function()
        TweenService:Create(self.CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(240, 73, 89)}):Play()
    end)
    self.CloseBtn.MouseLeave:Connect(function()
        TweenService:Create(self.CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 53, 69)}):Play()
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

return FrostHub
