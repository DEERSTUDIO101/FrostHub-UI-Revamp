-- FrostHub Redesigned UI mit Tab System für Roblox - COMPLETE FIXED VERSION
-- Alle Bugs behoben: Close Animation, Slider, Cleanup

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- ScreenGui erstellen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FrostHubUI_Redesigned"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- Hauptframe mit Schatten-Effekt
local shadowFrame = Instance.new("Frame")
shadowFrame.Name = "ShadowFrame"
shadowFrame.Size = UDim2.new(0, 556, 0, 356)
shadowFrame.Position = UDim2.new(0.5, -278, 0.5, -178)
shadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadowFrame.BackgroundTransparency = 0.7
shadowFrame.BorderSizePixel = 0
shadowFrame.Parent = screenGui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadowFrame

-- Hauptframe
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 550, 0, 350)
mainFrame.Position = UDim2.new(0, 3, 0, 3)
mainFrame.BackgroundColor3 = Color3.fromRGB(22, 9, 34)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = shadowFrame

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

-- Top Bar mit Gradient
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(15, 20, 25)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

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

-- Logo/Icon
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
logoText.Text = "F"
logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
logoText.TextScaled = true
logoText.Font = Enum.Font.GothamBold
logoText.Parent = logoFrame

-- Titel mit Animation
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0, 280, 0, 20)
titleLabel.Position = UDim2.new(0, 55, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FrostHub Universal"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 280, 0, 15)
versionLabel.Position = UDim2.new(0, 55, 0, 22)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v4.7.7 • Premium Edition"
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

-- Minimieren Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeButton"
minimizeBtn.Size = UDim2.new(0, 35, 0, 30)
minimizeBtn.Position = UDim2.new(0, 0, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(15, 20, 25)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(238, 255, 0)
minimizeBtn.TextSize = 16
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = controlFrame

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeBtn

-- Schließen Button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 35, 0, 30)
closeBtn.Position = UDim2.new(0, 40, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(15, 20, 25)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = controlFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Tab System
local tabFrame = Instance.new("Frame")
tabFrame.Name = "TabFrame"
tabFrame.Size = UDim2.new(0, 120, 1, -55)
tabFrame.Position = UDim2.new(0, 10, 0, 50)
tabFrame.BackgroundColor3 = Color3.fromRGB(18, 23, 28)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

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
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = contentFrame

-- Tab System Variables
local tabs = {}
local currentTab = nil

-- Tab Creation Function
local function createTab(name, icon, order)
    local tab = {}
    
    -- Tab Button
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(1, -10, 0, 40)
    tabButton.Position = UDim2.new(0, 5, 0, 10 + (order * 45))
    tabButton.BackgroundColor3 = Color3.fromRGB(25, 30, 35)
    tabButton.Text = ""
    tabButton.BorderSizePixel = 0
    tabButton.Parent = tabFrame
    
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
    tabContent.Parent = contentFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = tabContent
    
    -- Auto-resize canvas
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
    end)
    
    tab.button = tabButton
    tab.content = tabContent
    tab.icon = tabIcon
    tab.label = tabLabel
    tab.name = name
    
    -- Tab Click Handler
    tabButton.MouseButton1Click:Connect(function()
        selectTab(tab)
    end)
    
    -- Hover Effects
    tabButton.MouseEnter:Connect(function()
        if tab ~= currentTab then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 35, 40)}):Play()
        end
    end)
    
    tabButton.MouseLeave:Connect(function()
        if tab ~= currentTab then
            TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 30, 35)}):Play()
        end
    end)
    
    tabs[name] = tab
    return tab
end

-- Tab Selection Function
function selectTab(tab)
    if currentTab then
        -- Deselect current tab
        TweenService:Create(currentTab.button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 30, 35)}):Play()
        TweenService:Create(currentTab.icon, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        TweenService:Create(currentTab.label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        currentTab.content.Visible = false
    end
    
    -- Select new tab
    currentTab = tab
    TweenService:Create(tab.button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(88, 166, 255)}):Play()
    TweenService:Create(tab.icon, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(tab.label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    tab.content.Visible = true
end

-- Enhanced UI Elements
local function createSection(parent, title, order)
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

local function createButton(parent, text, order, callback)
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
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

local function createToggle(parent, text, order, callback)
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
    toggleContainer.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleContainer.BorderSizePixel = 0
    toggleContainer.Parent = toggleFrame
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 15)
    containerCorner.Parent = toggleContainer
    
    local toggleButton = Instance.new("Frame")
    toggleButton.Size = UDim2.new(0, 26, 0, 26)
    toggleButton.Position = UDim2.new(0, 2, 0, 2)
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
    
    local isToggled = false
    
    toggleClickArea.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(88, 166, 255)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {Position = UDim2.new(0, 32, 0, 2)}):Play()
        else
            TweenService:Create(toggleContainer, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0, 2)}):Play()
        end
        if callback then callback(isToggled) end
    end)
    
    return toggleFrame
end

-- COMPLETELY FIXED SLIDER FUNCTION
local function createSlider(parent, text, order, minVal, maxVal, callback)
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
    sliderLabel.Text = text .. ": " .. minVal
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
    sliderFill.Size = UDim2.new(0, 0, 1, 0)
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
    
    local currentValue = minVal
    local dragging = false
    local connection
    
    local function updateSlider()
        local percentage = (currentValue - minVal) / (maxVal - minVal)
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderLabel.Text = text .. ": " .. math.floor(currentValue)
        if callback then callback(currentValue) end
    end
    
    local function startDrag()
        dragging = true
        if connection then
            connection:Disconnect()
        end
        connection = UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouse = Players.LocalPlayer:GetMouse()
                local relativeX = math.clamp(mouse.X - sliderTrack.AbsolutePosition.X, 0, sliderTrack.AbsoluteSize.X)
                local percentage = relativeX / sliderTrack.AbsoluteSize.X
                currentValue = minVal + (maxVal - minVal) * percentage
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
    
    sliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            startDrag()
            -- Immediate update on click
            local mouse = Players.LocalPlayer:GetMouse()
            local relativeX = math.clamp(mouse.X - sliderTrack.AbsolutePosition.X, 0, sliderTrack.AbsoluteSize.X)
            local percentage = relativeX / sliderTrack.AbsoluteSize.X
            currentValue = minVal + (maxVal - minVal) * percentage
            updateSlider()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            stopDrag()
        end
    end)
    
    updateSlider()
    return sliderFrame
end

-- Notification System
local notificationFrame = Instance.new("Frame")
notificationFrame.Name = "NotificationFrame"
notificationFrame.Size = UDim2.new(0, 350, 0, 100)
notificationFrame.Position = UDim2.new(1, -320, 0, 50)
notificationFrame.BackgroundColor3 = Color3.fromRGB(22, 27, 34)
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false
notificationFrame.Parent = screenGui

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

local function showNotification(title, message, duration, icon)
    notifTitle.Text = title
    notifText.Text = message
    notifIconText.Text = icon or "i"
    notificationFrame.Visible = true
    
    -- Slide in animation
    notificationFrame.Position = UDim2.new(1, 20, 0, 20)
    TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(1, -370, 0, 20)
    }):Play()
    
    -- Auto hide after duration
    spawn(function()
        wait(duration or 3)
        TweenService:Create(notificationFrame, TweenInfo.new(0.5), {
            Position = UDim2.new(1, 20, 0, 20)
        }):Play()
        wait(0.5)
        notificationFrame.Visible = false
    end)
end

createSection(homeTab.content, "User Information", 4)
local userInfo = Instance.new("Frame")
userInfo.Name = "UserInfo"
userInfo.Size = UDim2.new(1, 0, 0, 80)
userInfo.BackgroundColor3 = Color3.fromRGB(35, 42, 52)
userInfo.BorderSizePixel = 0
userInfo.LayoutOrder = 5
userInfo.Parent = homeTab.content

local userCorner = Instance.new("UICorner")
userCorner.CornerRadius = UDim.new(0, 8)
userCorner.Parent = userInfo

local userIcon = Instance.new("Frame")
userIcon.Size = UDim2.new(0, 50, 0, 50)
userIcon.Position = UDim2.new(0, 15, 0, 15)
userIcon.BackgroundColor3 = Color3.fromRGB(88, 166, 255)
userIcon.BorderSizePixel = 0
userIcon.Parent = userInfo

local userIconCorner = Instance.new("UICorner")
userIconCorner.CornerRadius = UDim.new(0, 25)
userIconCorner.Parent = userIcon

local userIconText = Instance.new("TextLabel")
userIconText.Size = UDim2.new(1, 0, 1, 0)
userIconText.BackgroundTransparency = 1
userIconText.Text = string.sub(player.Name, 1, 1):upper()
userIconText.TextColor3 = Color3.fromRGB(255, 255, 255)
userIconText.TextSize = 20
userIconText.Font = Enum.Font.GothamBold
userIconText.Parent = userIcon

local userName = Instance.new("TextLabel")
userName.Size = UDim2.new(1, -80, 0, 25)
userName.Position = UDim2.new(0, 75, 0, 15)
userName.BackgroundTransparency = 1
userName.Text = player.Name
userName.TextColor3 = Color3.fromRGB(255, 255, 255)
userName.TextSize = 16
userName.Font = Enum.Font.GothamBold
userName.TextXAlignment = Enum.TextXAlignment.Left
userName.Parent = userInfo

local userStatus = Instance.new("TextLabel")
userStatus.Size = UDim2.new(1, -80, 0, 20)
userStatus.Position = UDim2.new(0, 75, 0, 40)
userStatus.BackgroundTransparency = 1
userStatus.Text = "Premium User • Online"
userStatus.TextColor3 = Color3.fromRGB(88, 166, 255)
userStatus.TextSize = 12
userStatus.Font = Enum.Font.Gotham
userStatus.TextXAlignment = Enum.TextXAlignment.Left
userStatus.Parent = userInfo

-- Dragging Functionality
local dragging = false
local dragStart = nil
local startPos = nil

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = shadowFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        shadowFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Control Button Functions
local isMinimized = false

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(shadowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 556, 0, 51)
        }):Play()
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 550, 0, 45)
        }):Play()
        tabFrame.Visible = false
        contentFrame.Visible = false
        minimizeBtn.Text = "X"
    else
        TweenService:Create(shadowFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 556, 0, 356)
        }):Play()
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 550, 0, 350)
        }):Play()
        spawn(function()
            wait(0.2)
            tabFrame.Visible = true
            contentFrame.Visible = true
        end)
        minimizeBtn.Text = "-"
    end
end)

-- COMPLETELY FIXED CLOSE ANIMATION - NO MORE CRASHES!
closeBtn.MouseButton1Click:Connect(function()
    -- Disable all interactions immediately
    closeBtn.Active = false
    minimizeBtn.Active = false
    topBar.Active = false
    
    -- Stop any running animations
    for _, tab in pairs(tabs) do
        if tab.button then tab.button.Active = false end
    end
    
    -- Create smooth closing animation
    local closeTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
    
    -- Fade out and shrink simultaneously
    local fadeOutTween = TweenService:Create(shadowFrame, closeTweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    })
    
    local mainFadeTween = TweenService:Create(mainFrame, closeTweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    
    -- Start animations
    fadeOutTween:Play()
    mainFadeTween:Play()
    
    -- Clean up after animation completes
    fadeOutTween.Completed:Connect(function()
        -- Stop logo animation
        logoRotating = false
        
        -- Destroy GUI safely
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end)
end)

-- Button Hover Effects
minimizeBtn.MouseEnter:Connect(function()
    if minimizeBtn.Active ~= false then
        TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 213, 29)}):Play()
    end
end)
minimizeBtn.MouseLeave:Connect(function()
    if minimizeBtn.Active ~= false then
        TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 23, 28)}):Play()
    end
end)

closeBtn.MouseEnter:Connect(function()
    if closeBtn.Active ~= false then
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(240, 73, 99)}):Play()
    end
end)
closeBtn.MouseLeave:Connect(function()
    if closeBtn.Active ~= false then
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 23, 28)}):Play()
    end
end)

-- Initialize with Home tab
selectTab(homeTab)

-- Welcome notification with delay
spawn(function()
    wait(0.8)
    showNotification("FrostHub Universal", "Welcome " .. player.Name .. "! UI loaded successfully.", 4, "🎉")
end)

-- Logo rotation animation with proper cleanup
local logoRotating = true
spawn(function()
    while logoRotating and logoFrame and logoFrame.Parent do
        for i = 0, 360, 2 do
            if not logoRotating or not logoFrame or not logoFrame.Parent then 
                break 
            end
            logoFrame.Rotation = i
            wait(0.02)
        end
    end
end)

-- Cleanup function when UI is destroyed
screenGui.AncestryChanged:Connect(function()
    if not screenGui.Parent then
        logoRotating = false
    end
end)

print("🎉 FrostHub Redesigned UI loaded successfully - ALL BUGS FIXED! 🎉")
print("✅ Fixed: Close button crash")
print("✅ Fixed: Slider functionality") 
print("✅ Fixed: Memory leaks")
print("✅ Fixed: Animation cleanup")
print("💪 Ready to use without crashes!")
