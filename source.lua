-- FrostHub UI Library (Revamp by Luca)
local FrostHub = {}
FrostHub.__index = FrostHub

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local UIS = game:GetService("UserInputService")

local function createUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FrostHubUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")
    return screenGui
end

local function createMainFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 600, 0, 350)
    frame.Position = UDim2.new(0.5, -300, 0.5, -175)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 0
    frame.Name = "MainFrame"
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = createUI()
    return frame
end

local function createSideMenu(tabNames, parent, switchTab)
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 130, 1, 0)
    tabContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    tabContainer.Parent = parent

    for i, tabName in ipairs(tabNames) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 30)
        button.Position = UDim2.new(0, 0, 0, 10 + (i - 1) * 35)
        button.Text = tabName
        button.TextColor3 = Color3.fromRGB(0, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        button.BorderSizePixel = 0
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 16
        button.Parent = tabContainer

        button.MouseButton1Click:Connect(function()
            switchTab(tabName)
        end)
    end

    return tabContainer
end

local function createTabContentArea(parent)
    local area = Instance.new("Frame")
    area.Name = "TabContent"
    area.Size = UDim2.new(1, -130, 1, 0)
    area.Position = UDim2.new(0, 130, 0, 0)
    area.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    area.BorderSizePixel = 0
    area.Parent = parent
    return area
end

-- API
function FrostHub:Init(tabList)
    local self = setmetatable({}, FrostHub)
    self.MainFrame = createMainFrame()
    self.Tabs = {}
    self.CurrentTab = nil

    self.TabContent = createTabContentArea(self.MainFrame)
    self.SideMenu = createSideMenu(tabList, self.MainFrame, function(tabName)
        self:SwitchTab(tabName)
    end)

    for _, name in ipairs(tabList) do
        local tab = Instance.new("Frame")
        tab.Name = name
        tab.Size = UDim2.new(1, 0, 1, 0)
        tab.BackgroundTransparency = 1
        tab.Visible = false
        tab.Parent = self.TabContent
        self.Tabs[name] = tab
    end

    self:SwitchTab(tabList[1])
    return self
end

function FrostHub:SwitchTab(tabName)
    for name, tab in pairs(self.Tabs) do
        tab.Visible = (name == tabName)
    end
    self.CurrentTab = self.Tabs[tabName]
end

function FrostHub:CreateButton(text, callback)
    if not self.CurrentTab then return end
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 40)
    button.Position = UDim2.new(0, 10, 0, #self.CurrentTab:GetChildren() * 45)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(0, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 16
    button.Text = text
    button.Parent = self.CurrentTab

    button.MouseButton1Click:Connect(callback)
end

return FrostHub
