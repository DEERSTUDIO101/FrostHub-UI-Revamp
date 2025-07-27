-- frosthub.lua
-- FrostHub UI Library mit Lucide Icons und Kavo UI Features
-- Made professional & clean for easy usage & customization

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local FrostHub = {}
FrostHub.__index = FrostHub

-- Basis-Funktion UI-Erstellung
local function Create(className, props)
    local obj = Instance.new(className)
    if props then
        for i, v in pairs(props) do
            if i == "Parent" then
                obj.Parent = v
            else
                obj[i] = v
            end
        end
    end
    return obj
end

-- UI Toggle via Keybind
local toggleKey = Enum.KeyCode.RightShift

-- Fenster erstellen
function FrostHub:CreateWindow(opts)
    local window = {}
    window.Tabs = {}

    local ScreenGui = Create("ScreenGui", {Parent = CoreGui, Name = opts.Title or "FrostHubUI", ResetOnSpawn = false})
    ScreenGui.IgnoreGuiInset = true

    -- Hauptfenster
    local MainFrame = Create("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Size = UDim2.new(0, 460, 0, 400),
        Position = UDim2.new(0.5, -230, 0.5, -200),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ClipsDescendants = true,
        BorderSizePixel = 0,
    })

    -- Draggable
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Title
    local TitleLabel = Create("TextLabel", {
        Parent = MainFrame,
        Text = opts.Title or "FrostHub",
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 10),
        Size = UDim2.new(1, -24, 0, 28),
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    -- Tabs Container
    local TabsFrame = Create("Frame", {
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Position = UDim2.new(0, 0, 0, 45),
        Size = UDim2.new(0, 120, 1, -45),
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })

    -- Main Content Area
    local ContentFrame = Create("Frame", {
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        Position = UDim2.new(0, 120, 0, 45),
        Size = UDim2.new(1, -120, 1, -45),
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })

    -- UI Toggle via Keybind
    local function ToggleVisibility()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == toggleKey then
            ToggleVisibility()
        end
    end)

    -- Tab erstellen
    function window:NewTab(name)
        local tab = {}
        tab.Sections = {}

        -- Tab Button
        local TabButton = Create("TextButton", {
            Parent = TabsFrame,
            Text = name,
            Font = Enum.Font.Gotham,
            TextSize = 16,
            TextColor3 = Color3.fromRGB(230, 230, 230),
            BackgroundColor3 = Color3.fromRGB(25, 25, 25),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 35),
        })

        -- Tab Inhalt Frame
        local TabContent = Create("ScrollingFrame", {
            Parent = ContentFrame,
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 6,
            Visible = false,
        })

        -- Aktiviere Tab onClick
        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(window.Tabs) do
                t.TabContent.Visible = false
                t.TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            end
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)

        -- Default erster Tab aktiv
        if #window.Tabs == 0 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end

        tab.TabButton = TabButton
        tab.TabContent = TabContent

        -- Section erstellen
        function tab:CreateSection(title)
            local section = {}
            local SectionFrame = Create("Frame", {
                Parent = TabContent,
                BackgroundColor3 = Color3.fromRGB(30, 30, 30),
                Size = UDim2.new(1, -20, 0, 25),
                Position = UDim2.new(0, 10, 0, #tab.Sections * 150 + 10),
                ClipsDescendants = true,
                BorderSizePixel = 0,
            })

            local SectionTitle = Create("TextLabel", {
                Parent = SectionFrame,
                Text = title,
                Font = Enum.Font.GothamBold,
                TextSize = 16,
                TextColor3 = Color3.fromRGB(200, 200, 200),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 25),
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            -- Container für Controls
            local Container = Create("Frame", {
                Parent = SectionFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 25),
                Size = UDim2.new(1, 0, 1, -25),
                ClipsDescendants = true,
            })

            section.Frame = SectionFrame
            section.Title = SectionTitle
            section.Container = Container
            section.Elements = {}

            -- Update Section Title
            function section:Update(newTitle)
                self.Title.Text = newTitle
            end

            -- Label hinzufügen
            function section:CreateLabel(text)
                local label = Create("TextLabel", {
                    Parent = self.Container,
                    Text = text,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 20),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = #self.Elements + 1,
                })

                table.insert(self.Elements, label)

                -- Update Label
                function label:Update(newText)
                    self.Text = newText
                end

                return label
            end

            -- Button hinzufügen
            function section:CreateButton(text, callback)
                local button = Create("TextButton", {
                    Parent = self.Container,
                    Text = text,
                    Font = Enum.Font.GothamBold,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
                    Size = UDim2.new(1, 0, 0, 30),
                    AutoButtonColor = true,
                    LayoutOrder = #self.Elements + 1,
                    BorderSizePixel = 0,
                })

                button.MouseButton1Click:Connect(function()
                    if callback then
                        callback()
                    end
                end)

                table.insert(self.Elements, button)

                -- Update Button Text
                function button:Update(newText)
                    self.Text = newText
                end

                return button
            end

            -- Toggle hinzufügen
            function section:CreateToggle(text, default, callback)
                local toggleState = default or false

                local ToggleFrame = Create("Frame", {
                    Parent = self.Container,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 30),
                    LayoutOrder = #self.Elements + 1,
                })

                local ToggleLabel = Create("TextLabel", {
                    Parent = ToggleFrame,
                    Text = text,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -40, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })

                local ToggleButton = Create("TextButton", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(0, 30, 0, 20),
                    Position = UDim2.new(1, -35, 0, 5),
                    BackgroundColor3 = toggleState and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(70, 70, 70),
                    AutoButtonColor = true,
                    BorderSizePixel = 0,
                    Text = "",
                })

                ToggleButton.MouseButton1Click:Connect(function()
                    toggleState = not toggleState
                    ToggleButton.BackgroundColor3 = toggleState and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(70, 70, 70)
                    if callback then callback(toggleState) end
                end)

                table.insert(self.Elements, ToggleFrame)

                -- Update Toggle Label/Text
                function ToggleFrame:Update(newText)
                    ToggleLabel.Text = newText
                end

                return ToggleFrame
            end

            -- Slider (basic)
            function section:CreateSlider(text, min, max, default, callback)
                local sliderValue = default or min

                local SliderFrame = Create("Frame", {
                    Parent = self.Container,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 40),
                    LayoutOrder = #self.Elements + 1,
                })

                local SliderLabel = Create("TextLabel", {
                    Parent = SliderFrame,
                    Text = text .. " (" .. sliderValue .. ")",
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 20),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })

                local SliderBar = Create("Frame", {
                    Parent = SliderFrame,
                    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
                    Size = UDim2.new(1, 0, 0, 10),
                    Position = UDim2.new(0, 0, 0, 25),
                    ClipsDescendants = true,
                    BorderSizePixel = 0,
                })

                local SliderFill = Create("Frame", {
                    Parent = SliderBar,
                    BackgroundColor3 = Color3.fromRGB(0, 170, 255),
                    Size = UDim2.new((sliderValue - min) / (max - min), 0, 1, 0),
                })

                local function updateValue(input)
                    local relativeX = math.clamp(input.Position.X - SliderBar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
                    sliderValue = math.floor((relativeX / SliderBar.AbsoluteSize.X) * (max - min) + min)
                    SliderFill.Size = UDim2.new((sliderValue - min) / (max - min), 0, 1, 0)
                    SliderLabel.Text = text .. " (" .. sliderValue .. ")"
                    if callback then callback(sliderValue) end
                end

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        updateValue(input)

                        local conn
                        conn = UserInputService.InputChanged:Connect(function(input2)
                            if input2.UserInputType == Enum.UserInputType.MouseMovement then
                                updateValue(input2)
                            end
                        end)

                        UserInputService.InputEnded:Connect(function(input2)
                            if input2.UserInputType == Enum.UserInputType.MouseButton1 then
                                conn:Disconnect()
                            end
                        end)
                    end
                end)

                table.insert(self.Elements, SliderFrame)

                -- Update Slider Label/Text
                function SliderFrame:Update(newText)
                    SliderLabel.Text = newText .. " (" .. sliderValue .. ")"
                end

                return SliderFrame
            end

            -- TextBox hinzufügen
            function section:CreateTextBox(text, placeholder, callback)
                local TextBoxFrame = Create("Frame", {
                    Parent = self.Container,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 35),
                    LayoutOrder = #self.Elements + 1,
                })

                local Label = Create("TextLabel", {
                    Parent = TextBoxFrame,
                    Text = text,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 15),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })

                local TextBox = Create("TextBox", {
                    Parent = TextBoxFrame,
                    Size = UDim2.new(1, 0, 0, 20),
                    Position = UDim2.new(0, 0, 0, 15),
                    ClearTextOnFocus = false,
                    Text = "",
                    PlaceholderText = placeholder or "",
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
                    BorderSizePixel = 0,
                })

                TextBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed and callback then
                        callback(TextBox.Text)
                    end
                end)

                table.insert(self.Elements, TextBoxFrame)

                -- Update TextBox Label/Text
                function TextBoxFrame:Update(newText)
                    Label.Text = newText
                end

                return TextBoxFrame
            end

            -- Keybinds (simplified)
            function section:CreateKeybind(text, defaultKey, callback)
                local keybind = defaultKey or Enum.KeyCode.Unknown

                local KeybindFrame = Create("Frame", {
                    Parent = self.Container,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 30),
                    LayoutOrder = #self.Elements + 1,
                })

                local Label = Create("TextLabel", {
                    Parent = KeybindFrame,
                    Text = text .. " [" .. keybind.Name .. "]",
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })

                local listening = false

                KeybindFrame.MouseButton1Click:Connect(function()
                    listening = true
                    Label.Text = text .. " [Press a key]"
                end)

                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                        keybind = input.KeyCode
                        Label.Text = text .. " [" .. keybind.Name .. "]"
                        if callback then
                            callback(keybind)
                        end
                        listening = false
                    end
                end)

                table.insert(self.Elements, KeybindFrame)

                -- Update Keybind Label/Text
                function KeybindFrame:Update(newText)
                    Label.Text = newText .. " [" .. keybind.Name .. "]"
                end

                return KeybindFrame
            end

            -- Dropdown (simplified)
            function section:CreateDropdown(text, options, default, callback)
                local DropdownFrame = Create("Frame", {
                    Parent = self.Container,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 35),
                    LayoutOrder = #self.Elements + 1,
                })

                local Label = Create("TextLabel", {
                    Parent = DropdownFrame,
                    Text = text,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 15),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })

                local SelectedText = Create("TextButton", {
                    Parent = DropdownFrame,
                    Text = default or options[1] or "Select",
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
                    Size = UDim2.new(1, 0, 0, 20),
                    BorderSizePixel = 0,
                })

                local OptionsFrame = Create("ScrollingFrame", {
                    Parent = DropdownFrame,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    Size = UDim2.new(1, 0, 0, 100),
                    Position = UDim2.new(0, 0, 1, 2),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness = 6,
                    Visible = false,
                    ClipsDescendants = true,
                })

                local function refreshOptions()
                    OptionsFrame:ClearAllChildren()
                    local layout = Create("UIListLayout", {Parent = OptionsFrame, SortOrder = Enum.SortOrder.LayoutOrder})
                    for i, option in ipairs(options) do
                        local optionBtn = Create("TextButton", {
                            Parent = OptionsFrame,
                            Text = option,
                            Font = Enum.Font.Gotham,
                            TextSize = 14,
                            TextColor3 = Color3.fromRGB(230, 230, 230),
                            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                            Size = UDim2.new(1, 0, 0, 25),
                            LayoutOrder = i,
                            AutoButtonColor = true,
                            BorderSizePixel = 0,
                        })
                        optionBtn.MouseButton1Click:Connect(function()
                            SelectedText.Text = option
                            OptionsFrame.Visible = false
                            if callback then callback(option) end
                        end)
                    end
                    OptionsFrame.CanvasSize = UDim2.new(0, 0, 0, #options * 25)
                end
                refreshOptions()

                SelectedText.MouseButton1Click:Connect(function()
                    OptionsFrame.Visible = not OptionsFrame.Visible
                end)

                table.insert(self.Elements, DropdownFrame)

                -- Dropdown Refresh
                function DropdownFrame:Refresh(newOptions)
                    options = newOptions
                    refreshOptions()
                end

                -- Update Dropdown Label/Text
                function DropdownFrame:Update(newText)
                    Label.Text = newText
                end

                return DropdownFrame
            end

            -- HEX Color Picker (einfach)
            function section:CreateColorPicker(text, defaultColor, callback)
                local color = defaultColor or Color3.fromRGB(255, 255, 255)

                local ColorFrame = Create("Frame", {
                    Parent = self.Container,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 50),
                    LayoutOrder = #self.Elements + 1,
                })

                local Label = Create("TextLabel", {
                    Parent = ColorFrame,
                    Text = text,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 15),
                    TextXAlignment = Enum.TextXAlignment.Left,
                })

                local ColorBox = Create("TextBox", {
                    Parent = ColorFrame,
                    Size = UDim2.new(1, 0, 0, 30),
                    Position = UDim2.new(0, 0, 0, 15),
                    Text = string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255)),
                    ClearTextOnFocus = false,
                    Font = Enum.Font.Gotham,
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    BackgroundColor3 = Color3.fromRGB(230, 230, 230),
                    BorderSizePixel = 0,
                })

                -- Farb-Update
                ColorBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        local text = ColorBox.Text
                        -- Check HEX Format
                        if string.match(text, "^#?%x%x%x%x%x%x$") then
                            text = text:gsub("#", "")
                            local r = tonumber(text:sub(1, 2), 16) / 255
                            local g = tonumber(text:sub(3, 4), 16) / 255
                            local b = tonumber(text:sub(5, 6), 16) / 255
                            color = Color3.new(r, g, b)
                            if callback then callback(color) end
                        else
                            ColorBox.Text = string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
                        end
                    end
                end)

                table.insert(self.Elements, ColorFrame)

                -- Update ColorPicker Label/Text
                function ColorFrame:Update(newText)
                    Label.Text = newText
                end

                return ColorFrame
            end

            -- Automatische Anordnung
            local UIListLayout = Create("UIListLayout", {
                Parent = self.Container,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 5),
            })

            table.insert(tab.Sections, section)
            TabContent.CanvasSize = UDim2.new(0, 0, 0, (#tab.Sections * 150) + 10)

            return section
        end

        table.insert(window.Tabs, tab)
        return tab
    end

    self.Window = window
    return window
end

return FrostHub
