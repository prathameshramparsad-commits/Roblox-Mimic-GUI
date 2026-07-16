-- Mimic Game Custom GUI Framework
-- No Key System - Fully Open
-- Features: Tabs, Buttons, Toggles, Inputs, Notifications, Draggable Windows, Themes

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local Config = {
	HubName = "Mimic Hub",
	MainColor = Color3.fromRGB(0, 150, 255),
	SecondaryColor = Color3.fromRGB(25, 25, 35),
	AccentColor = Color3.fromRGB(255, 100, 0),
	TextColor = Color3.fromRGB(255, 255, 255),
}

-- Theme Presets
local Themes = {
	Default = {
		Primary = Color3.fromRGB(0, 150, 255),
		Secondary = Color3.fromRGB(25, 25, 35),
		Accent = Color3.fromRGB(255, 100, 0),
		Text = Color3.fromRGB(255, 255, 255),
	},
	DarkMode = {
		Primary = Color3.fromRGB(20, 20, 30),
		Secondary = Color3.fromRGB(10, 10, 15),
		Accent = Color3.fromRGB(100, 200, 255),
		Text = Color3.fromRGB(200, 200, 200),
	},
	NeonPurple = {
		Primary = Color3.fromRGB(138, 43, 226),
		Secondary = Color3.fromRGB(75, 0, 130),
		Accent = Color3.fromRGB(255, 20, 147),
		Text = Color3.fromRGB(255, 255, 255),
	},
	Forest = {
		Primary = Color3.fromRGB(34, 139, 34),
		Secondary = Color3.fromRGB(25, 100, 25),
		Accent = Color3.fromRGB(144, 238, 144),
		Text = Color3.fromRGB(255, 255, 255),
	},
}

local currentTheme = Themes.Default

-- UI Library
local UILib = {}
UILib.Windows = {}
UILib.Notifications = {}

-- Create Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MimicHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = playerGui

-- Create Notification Container
local NotificationContainer = Instance.new("Frame")
NotificationContainer.Name = "NotificationContainer"
NotificationContainer.Size = UDim2.new(0, 300, 0, 400)
NotificationContainer.Position = UDim2.new(1, -320, 0, 20)
NotificationContainer.BackgroundTransparency = 1
NotificationContainer.Parent = ScreenGui

-- Notification System
function UILib:Notify(title, message, duration)
	duration = duration or 3
	
	local notif = Instance.new("Frame")
	notif.Name = "Notification"
	notif.Size = UDim2.new(1, 0, 0, 80)
	notif.BackgroundColor3 = currentTheme.Secondary
	notif.BorderSizePixel = 0
	notif.Parent = NotificationContainer
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = notif
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = currentTheme.Accent
	stroke.Thickness = 2
	stroke.Parent = notif
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(1, -20, 0, 25)
	titleLabel.Position = UDim2.new(0, 10, 0, 5)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = currentTheme.Accent
	titleLabel.TextSize = 14
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = notif
	
	local messageLabel = Instance.new("TextLabel")
	messageLabel.Name = "Message"
	messageLabel.Size = UDim2.new(1, -20, 0, 45)
	messageLabel.Position = UDim2.new(0, 10, 0, 30)
	messageLabel.BackgroundTransparency = 1
	messageLabel.Text = message
	messageLabel.TextColor3 = currentTheme.Text
	messageLabel.TextSize = 12
	messageLabel.Font = Enum.Font.Gotham
	messageLabel.TextWrapped = true
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.TextYAlignment = Enum.TextYAlignment.Top
	messageLabel.Parent = notif
	
	-- Auto layout notifications
	local padding = Instance.new("UIPadding")
	padding.PaddingBottom = UDim.new(0, 10)
	padding.Parent = notif
	
	local layout = NotificationContainer:FindFirstChild("UIListLayout")
	if not layout then
		layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 10)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.VerticalAlignment = Enum.VerticalAlignment.Top
		layout.Parent = NotificationContainer
	end
	
	-- Remove notification after duration
	task.delay(duration, function()
		if notif and notif.Parent then
			notif:Destroy()
		end
	end)
end

-- Draggable Window Function
function UILib:MakeDraggable(frame)
	local dragging = false
	local dragInput
	local dragStart
	local startPos
	
	frame.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)
	
	frame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			frame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
		end
	end)
end

-- Create Main Window
function UILib:CreateWindow(title, size, position)
	local window = Instance.new("Frame")
	window.Name = title
	window.Size = size
	window.Position = position
	window.BackgroundColor3 = currentTheme.Secondary
	window.BorderSizePixel = 0
	window.Parent = ScreenGui
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = window
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = currentTheme.Primary
	stroke.Thickness = 2
	stroke.Parent = window
	
	-- Title Bar
	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, 40)
	titleBar.BackgroundColor3 = currentTheme.Primary
	titleBar.BorderSizePixel = 0
	titleBar.Parent = window
	
	local titleCorner = Instance.new("UICorner")
	titleCorner.CornerRadius = UDim.new(0, 12)
	titleCorner.Parent = titleBar
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, -50, 1, 0)
	titleLabel.Position = UDim2.new(0, 15, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = currentTheme.Text
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = titleBar
	
	-- Close Button
	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "CloseBtn"
	closeBtn.Size = UDim2.new(0, 35, 0, 35)
	closeBtn.Position = UDim2.new(1, -40, 0, 2)
	closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	closeBtn.TextColor3 = currentTheme.Text
	closeBtn.Text = "X"
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 14
	closeBtn.BorderSizePixel = 0
	closeBtn.Parent = titleBar
	
	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 6)
	closeCorner.Parent = closeBtn
	
	closeBtn.MouseButton1Click:Connect(function()
		window:Destroy()
	end)
	
	-- Content Frame
	local content = Instance.new("Frame")
	content.Name = "Content"
	content.Size = UDim2.new(1, 0, 1, -40)
	content.Position = UDim2.new(0, 0, 0, 40)
	content.BackgroundTransparency = 1
	content.Parent = window
	
	-- Scrolling Frame
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "ScrollFrame"
	scrollFrame.Size = UDim2.new(1, 0, 1, 0)
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	scrollFrame.ScrollBarThickness = 6
	scrollFrame.ScrollBarImageColor3 = currentTheme.Accent
	scrollFrame.BackgroundTransparency = 1
	scrollFrame.BorderSizePixel = 0
	scrollFrame.Parent = content
	
	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 10)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Parent = scrollFrame
	
	local padding = Instance.new("UIPadding")
	padding.PaddingBottom = UDim.new(0, 10)
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)
	padding.PaddingTop = UDim.new(0, 10)
	padding.Parent = scrollFrame
	
	-- Make draggable
	UILib:MakeDraggable(titleBar)
	
	table.insert(UILib.Windows, window)
	
	return window, scrollFrame
end

-- Create Tab System
function UILib:CreateTabs(window, scrollFrame)
	local tabSystem = {}
	local tabs = {}
	
	local tabBar = Instance.new("Frame")
	tabBar.Name = "TabBar"
	tabBar.Size = UDim2.new(1, 0, 0, 35)
	tabBar.Position = UDim2.new(0, 0, 0, 0)
	tabBar.BackgroundColor3 = currentTheme.Secondary
	tabBar.BorderSizePixel = 0
	tabBar.Parent = scrollFrame
	
	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0, 5)
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.FillDirection = Enum.FillDirection.Horizontal
	tabLayout.Parent = tabBar
	
	local tabPadding = Instance.new("UIPadding")
	tabPadding.PaddingLeft = UDim.new(0, 5)
	tabPadding.PaddingTop = UDim.new(0, 5)
	tabPadding.Parent = tabBar
	
	local contentArea = Instance.new("Frame")
	contentArea.Name = "ContentArea"
	contentArea.Size = UDim2.new(1, 0, 1, -45)
	contentArea.Position = UDim2.new(0, 0, 0, 40)
	contentArea.BackgroundTransparency = 1
	contentArea.Parent = scrollFrame
	
	function tabSystem:CreateTab(tabName)
		local tabButton = Instance.new("TextButton")
		tabButton.Name = tabName
		tabButton.Size = UDim2.new(0, 100, 0, 25)
		tabButton.BackgroundColor3 = currentTheme.Primary
		tabButton.TextColor3 = currentTheme.Text
		tabButton.Text = tabName
		tabButton.Font = Enum.Font.GothamBold
		tabButton.TextSize = 12
		tabButton.BorderSizePixel = 0
		tabButton.Parent = tabBar
		
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 6)
		btnCorner.Parent = tabButton
		
		local tabContent = Instance.new("Frame")
		tabContent.Name = tabName .. "Content"
		tabContent.Size = UDim2.new(1, 0, 1, 0)
		tabContent.BackgroundTransparency = 1
		tabContent.Visible = false
		tabContent.Parent = contentArea
		
		local tabContentLayout = Instance.new("UIListLayout")
		tabContentLayout.Padding = UDim.new(0, 8)
		tabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		tabContentLayout.Parent = tabContent
		
		local tabContentPadding = Instance.new("UIPadding")
		tabContentPadding.PaddingBottom = UDim.new(0, 10)
		tabContentPadding.PaddingLeft = UDim.new(0, 10)
		tabContentPadding.PaddingRight = UDim.new(0, 10)
		tabContentPadding.PaddingTop = UDim.new(0, 10)
		tabContentPadding.Parent = tabContent
		
		tabButton.MouseButton1Click:Connect(function()
			for _, tab in pairs(tabs) do
				tab.Content.Visible = false
				tab.Button.BackgroundColor3 = currentTheme.Primary
			end
			tabContent.Visible = true
			tabButton.BackgroundColor3 = currentTheme.Accent
		end)
		
		tabs[tabName] = {Button = tabButton, Content = tabContent}
		
		if not next(tabs, nil) or tabName == "Home" then
			tabContent.Visible = true
			tabButton.BackgroundColor3 = currentTheme.Accent
		end
		
		return tabContent
	end
	
	return tabSystem
end

-- Create Button
function UILib:CreateButton(parent, text, callback)
	local button = Instance.new("TextButton")
	button.Name = text
	button.Size = UDim2.new(1, 0, 0, 35)
	button.BackgroundColor3 = currentTheme.Accent
	button.TextColor3 = currentTheme.Text
	button.Text = text
	button.Font = Enum.Font.GothamBold
	button.TextSize = 13
	button.BorderSizePixel = 0
	button.Parent = parent
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button
	
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromHSV(
			currentTheme.Accent:GetHue(),
			currentTheme.Accent:GetSaturation() * 0.7,
			currentTheme.Accent:GetValue() * 1.2
		)
	end)
	
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = currentTheme.Accent
	end)
	
	button.MouseButton1Click:Connect(callback)
	
	return button
end

-- Create Toggle
function UILib:CreateToggle(parent, text, callback)
	local container = Instance.new("Frame")
	container.Name = text .. "Toggle"
	container.Size = UDim2.new(1, 0, 0, 40)
	container.BackgroundTransparency = 1
	container.Parent = parent
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -60, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = currentTheme.Text
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container
	
	local toggle = Instance.new("TextButton")
	toggle.Name = "Toggle"
	toggle.Size = UDim2.new(0, 50, 0, 25)
	toggle.Position = UDim2.new(1, -55, 0.5, -12)
	toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	toggle.Text = ""
	toggle.BorderSizePixel = 0
	toggle.Parent = container
	
	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(1, 0)
	toggleCorner.Parent = toggle
	
	local toggleCircle = Instance.new("Frame")
	toggleCircle.Name = "Circle"
	toggleCircle.Size = UDim2.new(0, 21, 0, 21)
	toggleCircle.Position = UDim2.new(0, 2, 0.5, -10)
	toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	toggleCircle.BorderSizePixel = 0
	toggleCircle.Parent = toggle
	
	local circleCorner = Instance.new("UICorner")
	circleCorner.CornerRadius = UDim.new(1, 0)
	circleCorner.Parent = toggleCircle
	
	local isOn = false
	
	toggle.MouseButton1Click:Connect(function()
		isOn = not isOn
		if isOn then
			toggle.BackgroundColor3 = currentTheme.Accent
			toggleCircle:TweenPosition(UDim2.new(0, 27, 0.5, -10), "Out", "Quad", 0.2, true)
		else
			toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			toggleCircle:TweenPosition(UDim2.new(0, 2, 0.5, -10), "Out", "Quad", 0.2, true)
		end
		callback(isOn)
	end)
	
	return container, toggle
end

-- Create Text Input
function UILib:CreateInput(parent, placeholder, callback)
	local container = Instance.new("Frame")
	container.Name = placeholder .. "Input"
	container.Size = UDim2.new(1, 0, 0, 40)
	container.BackgroundTransparency = 1
	container.Parent = parent
	
	local inputBox = Instance.new("TextBox")
	inputBox.Name = "InputBox"
	inputBox.Size = UDim2.new(1, 0, 1, 0)
	inputBox.BackgroundColor3 = currentTheme.Secondary
	inputBox.TextColor3 = currentTheme.Text
	inputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
	inputBox.PlaceholderText = placeholder
	inputBox.Font = Enum.Font.Gotham
	inputBox.TextSize = 12
	inputBox.BorderSizePixel = 0
	inputBox.Parent = container
	
	local inputCorner = Instance.new("UICorner")
	inputCorner.CornerRadius = UDim.new(0, 8)
	inputCorner.Parent = inputBox
	
	local inputStroke = Instance.new("UIStroke")
	inputStroke.Color = currentTheme.Accent
	inputStroke.Thickness = 1
	inputStroke.Parent = inputBox
	
	local inputPadding = Instance.new("UIPadding")
	inputPadding.PaddingLeft = UDim.new(0, 10)
	inputPadding.PaddingRight = UDim.new(0, 10)
	inputPadding.Parent = inputBox
	
	inputBox.FocusLost:Connect(function()
		if inputBox.Text ~= "" then
			callback(inputBox.Text)
		end
	end)
	
	return container, inputBox
end

-- Create Label
function UILib:CreateLabel(parent, text)
	local label = Instance.new("TextLabel")
	label.Name = text
	label.Size = UDim2.new(1, 0, 0, 30)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = currentTheme.Text
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = parent
	
	return label
end

-- Create Divider
function UILib:CreateDivider(parent)
	local divider = Instance.new("Frame")
	divider.Name = "Divider"
	divider.Size = UDim2.new(1, 0, 0, 2)
	divider.BackgroundColor3 = currentTheme.Accent
	divider.BorderSizePixel = 0
	divider.Parent = parent
	
	return divider
end

-- Update Theme
function UILib:SetTheme(themeName)
	currentTheme = Themes[themeName] or Themes.Default
	UILib:Notify("Theme", "Changed to " .. themeName, 2)
end

-- Create Script Execution Area
function UILib:CreateScriptExecutor(parent)
	local executor = Instance.new("Frame")
	executor.Name = "ScriptExecutor"
	executor.Size = UDim2.new(1, 0, 0, 100)
	executor.BackgroundTransparency = 1
	executor.Parent = parent
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = "Execute Script:"
	label.TextColor3 = currentTheme.Text
	label.Font = Enum.Font.GothamBold
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = executor
	
	local codeBox = Instance.new("TextBox")
	codeBox.Name = "CodeBox"
	codeBox.Size = UDim2.new(1, 0, 0, 60)
	codeBox.Position = UDim2.new(0, 0, 0, 22)
	codeBox.BackgroundColor3 = currentTheme.Secondary
	codeBox.TextColor3 = currentTheme.Text
	codeBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
	codeBox.PlaceholderText = "Paste Lua code here..."
	codeBox.Font = Enum.Font.Code
	codeBox.TextSize = 10
	codeBox.TextWrapped = true
	codeBox.ClipsDescendants = true
	codeBox.MultiLine = true
	codeBox.BorderSizePixel = 0
	codeBox.Parent = executor
	
	local codeCorner = Instance.new("UICorner")
	codeCorner.CornerRadius = UDim.new(0, 6)
	codeCorner.Parent = codeBox
	
	local execBtn = UILib:CreateButton(executor, "Execute", function()
		if codeBox.Text ~= "" then
			local success, err = pcall(function()
				loadstring(codeBox.Text)()
			end)
			if success then
				UILib:Notify("Executor", "Script executed successfully!", 2)
			else
				UILib:Notify("Error", "Script error: " .. tostring(err), 3)
			end
		end
	end)
	
	execBtn.Position = UDim2.new(0, 0, 1, 5)
	execBtn.Size = UDim2.new(1, 0, 0, 25)
	
	return executor
end

-- ===================== BUILD THE HUB =====================

-- Main Window
local mainWindow, mainScrollFrame = UILib:CreateWindow(Config.HubName, UDim2.new(0, 500, 0, 600), UDim2.new(0.5, -250, 0.5, -300))

-- Tab System
local tabSystem = UILib:CreateTabs(mainWindow, mainScrollFrame)

-- HOME TAB
local homeTab = tabSystem:CreateTab("Home")
UILib:CreateLabel(homeTab, "Welcome to Mimic Hub!")
UILib:CreateDivider(homeTab)
UILib:CreateLabel(homeTab, "Features:")
UILib:CreateButton(homeTab, "Teleport", function()
	UILib:Notify("Teleport", "Click to teleport", 2)
end)
UILib:CreateButton(homeTab, "Anti-Lag", function()
	UILib:Notify("Anti-Lag", "Enabled", 2)
end)
UILib:CreateButton(homeTab, "Settings", function()
	UILib:Notify("Settings", "Opening settings...", 1)
end)

-- SCRIPTS TAB
local scriptsTab = tabSystem:CreateTab("Scripts")
UILib:CreateLabel(scriptsTab, "Script Manager")
UILib:CreateDivider(scriptsTab)
UILib:CreateButton(scriptsTab, "Load Script 1", function()
	UILib:Notify("Scripts", "Script 1 loaded", 2)
end)
UILib:CreateButton(scriptsTab, "Load Script 2", function()
	UILib:Notify("Scripts", "Script 2 loaded", 2)
end)
UILib:CreateButton(scriptsTab, "Load Script 3", function()
	UILib:Notify("Scripts", "Script 3 loaded", 2)
end)
UILib:CreateScriptExecutor(scriptsTab)

-- SETTINGS TAB
local settingsTab = tabSystem:CreateTab("Settings")
UILib:CreateLabel(settingsTab, "Customization")
UILib:CreateDivider(settingsTab)
UILib:CreateToggle(settingsTab, "Notifications", function(state)
	UILib:Notify("Settings", "Notifications: " .. (state and "ON" or "OFF"), 1)
end)
UILib:CreateToggle(settingsTab, "Auto Update", function(state)
	UILib:Notify("Settings", "Auto Update: " .. (state and "ON" or "OFF"), 1)
end)
UILib:CreateLabel(settingsTab, "Select Theme:")
UILib:CreateButton(settingsTab, "Default Theme", function()
	UILib:SetTheme("Default")
end)
UILib:CreateButton(settingsTab, "Dark Mode", function()
	UILib:SetTheme("DarkMode")
end)
UILib:CreateButton(settingsTab, "Neon Purple", function()
	UILib:SetTheme("NeonPurple")
end)
UILib:CreateButton(settingsTab, "Forest", function()
	UILib:SetTheme("Forest")
end)

-- ABOUT TAB
local aboutTab = tabSystem:CreateTab("About")
UILib:CreateLabel(aboutTab, "Mimic Hub v1.0")
UILib:CreateDivider(aboutTab)
UILib:CreateLabel(aboutTab, "Custom GUI Framework")
UILib:CreateLabel(aboutTab, "Features:")
UILib:CreateLabel(aboutTab, "✓ No Key System")
UILib:CreateLabel(aboutTab, "✓ Draggable Windows")
UILib:CreateLabel(aboutTab, "✓ Custom Themes")
UILib:CreateLabel(aboutTab, "✓ Script Executor")
UILib:CreateLabel(aboutTab, "✓ Notifications")

-- Initial Notification
UILib:Notify("Welcome", "Mimic Hub loaded successfully!", 3)

print("✓ Mimic Hub GUI loaded successfully!")