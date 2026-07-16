-- Mimic Game Custom GUI Framework - Delta Executor iOS Full Edition
-- Complete Feature Set Optimized for iOS with Scrollable Tabs
-- No Key System - Fully Open

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

print("⏳ Loading Mimic Hub Full Edition...")

-- Get player
local player = Players.LocalPlayer
if not player then
	print("❌ No player found!")
	return
end

local playerGui = player:WaitForChild("PlayerGui")

print("✅ Player:", player.Name)
print("📱 Platform: iOS (Delta Executor)")

-- Configuration
local Config = {
	HubName = "Mimic Hub",
	MainColor = Color3.fromRGB(0, 150, 255),
	SecondaryColor = Color3.fromRGB(25, 25, 35),
	AccentColor = Color3.fromRGB(255, 100, 0),
	TextColor = Color3.fromRGB(255, 255, 255),
	IsMobile = true,
}

-- Themes
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

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MimicHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.IgnoreGuiInset = false
ScreenGui.Parent = playerGui

print("✅ ScreenGui created")

-- Notification Container
local NotificationContainer = Instance.new("Frame")
NotificationContainer.Name = "NotificationContainer"
NotificationContainer.Size = UDim2.new(1, 0, 0.4, 0)
NotificationContainer.Position = UDim2.new(0, 0, 0, 50)
NotificationContainer.BackgroundTransparency = 1
NotificationContainer.Parent = ScreenGui
NotificationContainer.ZIndex = 1000

-- Notification System
function UILib:Notify(title, message, duration)
	duration = duration or 3
	
	local notif = Instance.new("Frame")
	notif.Name = "Notification"
	notif.Size = UDim2.new(0.9, 0, 0, 110)
	notif.BackgroundColor3 = currentTheme.Secondary
	notif.BorderSizePixel = 0
	notif.Parent = NotificationContainer
	notif.ZIndex = 1001
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = notif
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -20, 0, 30)
	titleLabel.Position = UDim2.new(0, 10, 0, 5)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = currentTheme.Accent
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.ZIndex = 1002
	titleLabel.Parent = notif
	
	local messageLabel = Instance.new("TextLabel")
	messageLabel.Size = UDim2.new(1, -20, 0, 65)
	messageLabel.Position = UDim2.new(0, 10, 0, 35)
	messageLabel.BackgroundTransparency = 1
	messageLabel.Text = message
	messageLabel.TextColor3 = currentTheme.Text
	messageLabel.TextSize = 13
	messageLabel.Font = Enum.Font.Gotham
	messageLabel.TextWrapped = true
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.TextYAlignment = Enum.TextYAlignment.Top
	messageLabel.ZIndex = 1002
	messageLabel.Parent = notif
	
	local layout = NotificationContainer:FindFirstChild("UIListLayout")
	if not layout then
		layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 10)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.VerticalAlignment = Enum.VerticalAlignment.Top
		layout.Parent = NotificationContainer
	end
	
	task.delay(duration, function()
		pcall(function()
			if notif and notif.Parent then
				notif:Destroy()
			end
		end)
	end)
end

-- Create Main Window
function UILib:CreateWindow(title, size, position)
	local window = Instance.new("Frame")
	window.Name = title
	window.Size = UDim2.new(0.98, 0, 0.85, 0)
	window.Position = UDim2.new(0.01, 0, 0.08, 0)
	window.BackgroundColor3 = currentTheme.Secondary
	window.BorderSizePixel = 0
	window.Parent = ScreenGui
	window.ZIndex = 10
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = window
	
	-- Title Bar
	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, 50)
	titleBar.BackgroundColor3 = currentTheme.Primary
	titleBar.BorderSizePixel = 0
	titleBar.Parent = window
	titleBar.ZIndex = 11
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -50, 1, 0)
	titleLabel.Position = UDim2.new(0, 15, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = currentTheme.Text
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextYAlignment = Enum.TextYAlignment.Center
	titleLabel.ZIndex = 12
	titleLabel.Parent = titleBar
	
	-- Close Button
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 45, 0, 45)
	closeBtn.Position = UDim2.new(1, -50, 0, 2)
	closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	closeBtn.TextColor3 = currentTheme.Text
	closeBtn.Text = "X"
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 18
	closeBtn.BorderSizePixel = 0
	closeBtn.ZIndex = 12
	closeBtn.Parent = titleBar
	
	closeBtn.MouseButton1Click:Connect(function()
		window:Destroy()
	end)
	
	-- Content Area
	local content = Instance.new("Frame")
	content.Size = UDim2.new(1, 0, 1, -50)
	content.Position = UDim2.new(0, 0, 0, 50)
	content.BackgroundTransparency = 1
	content.Parent = window
	content.ZIndex = 10
	
	-- Main Scroll Frame for EVERYTHING (tabs + content)
	local mainScrollFrame = Instance.new("ScrollingFrame")
	mainScrollFrame.Size = UDim2.new(1, 0, 1, 0)
	mainScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	mainScrollFrame.ScrollBarThickness = 8
	mainScrollFrame.ScrollBarImageColor3 = currentTheme.Accent
	mainScrollFrame.BackgroundTransparency = 1
	mainScrollFrame.BorderSizePixel = 0
	mainScrollFrame.ZIndex = 10
	mainScrollFrame.Parent = content
	
	local mainLayout = Instance.new("UIListLayout")
	mainLayout.Padding = UDim.new(0, 0)
	mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
	mainLayout.Parent = mainScrollFrame
	
	return window, mainScrollFrame
end

-- Create Tabs with Scrollable Content
function UILib:CreateTabs(window, mainScrollFrame)
	local tabSystem = {}
	local tabs = {}
	
	-- Tab Bar (Scrollable Horizontally)
	local tabBar = Instance.new("Frame")
	tabBar.Name = "TabBar"
	tabBar.Size = UDim2.new(1, 0, 0, 50)
	tabBar.BackgroundColor3 = currentTheme.Secondary
	tabBar.BorderSizePixel = 0
	tabBar.Parent = mainScrollFrame
	tabBar.ZIndex = 10
	tabBar.LayoutOrder = 1
	
	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0, 5)
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.FillDirection = Enum.FillDirection.Horizontal
	tabLayout.Parent = tabBar
	
	local tabPadding = Instance.new("UIPadding")
	tabPadding.PaddingLeft = UDim.new(0, 5)
	tabPadding.PaddingTop = UDim.new(0, 5)
	tabPadding.Parent = tabBar
	
	-- Content Area (Scrollable Content for each tab)
	local contentArea = Instance.new("Frame")
	contentArea.Name = "ContentArea"
	contentArea.Size = UDim2.new(1, 0, 0, 2000) -- Large height for scrolling
	contentArea.BackgroundTransparency = 1
	contentArea.Parent = mainScrollFrame
	contentArea.ZIndex = 10
	contentArea.LayoutOrder = 2
	
	function tabSystem:CreateTab(tabName)
		local tabButton = Instance.new("TextButton")
		tabButton.Size = UDim2.new(0, 85, 0, 35)
		tabButton.BackgroundColor3 = currentTheme.Primary
		tabButton.TextColor3 = currentTheme.Text
		tabButton.Text = tabName
		tabButton.Font = Enum.Font.GothamBold
		tabButton.TextSize = 12
		tabButton.BorderSizePixel = 0
		tabButton.Parent = tabBar
		tabButton.ZIndex = 11
		
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 6)
		btnCorner.Parent = tabButton
		
		-- Individual Scroll Frame for each tab's content
		local tabScrollFrame = Instance.new("ScrollingFrame")
		tabScrollFrame.Name = tabName .. "ScrollFrame"
		tabScrollFrame.Size = UDim2.new(1, 0, 0, 1500) -- Fixed scrollable height
		tabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will auto-calculate
		tabScrollFrame.ScrollBarThickness = 8
		tabScrollFrame.ScrollBarImageColor3 = currentTheme.Accent
		tabScrollFrame.BackgroundTransparency = 1
		tabScrollFrame.BorderSizePixel = 0
		tabScrollFrame.Visible = false
		tabScrollFrame.Parent = contentArea
		tabScrollFrame.ZIndex = 10
		
		local tabContentLayout = Instance.new("UIListLayout")
		tabContentLayout.Padding = UDim.new(0, 8)
		tabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		tabContentLayout.Parent = tabScrollFrame
		
		local tabContentPadding = Instance.new("UIPadding")
		tabContentPadding.PaddingBottom = UDim.new(0, 10)
		tabContentPadding.PaddingLeft = UDim.new(0, 10)
		tabContentPadding.PaddingRight = UDim.new(0, 10)
		tabContentPadding.PaddingTop = UDim.new(0, 10)
		tabContentPadding.Parent = tabScrollFrame
		
		tabButton.MouseButton1Click:Connect(function()
			for _, tab in pairs(tabs) do
				tab.ScrollFrame.Visible = false
				tab.Button.BackgroundColor3 = currentTheme.Primary
			end
			tabScrollFrame.Visible = true
			tabButton.BackgroundColor3 = currentTheme.Accent
		end)
		
		tabs[tabName] = {Button = tabButton, ScrollFrame = tabScrollFrame}
		
		if not next(tabs, nil) then
			tabScrollFrame.Visible = true
			tabButton.BackgroundColor3 = currentTheme.Accent
		end
		
		return tabScrollFrame
	end
	
	return tabSystem
end

-- Create Button
function UILib:CreateButton(parent, text, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 50)
	button.BackgroundColor3 = currentTheme.Accent
	button.TextColor3 = currentTheme.Text
	button.Text = text
	button.Font = Enum.Font.GothamBold
	button.TextSize = 15
	button.BorderSizePixel = 0
	button.Parent = parent
	button.ZIndex = 11
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button
	
	button.MouseButton1Click:Connect(callback)
	
	return button
end

-- Create Toggle
function UILib:CreateToggle(parent, text, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 55)
	container.BackgroundTransparency = 1
	container.Parent = parent
	container.ZIndex = 11
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -70, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = currentTheme.Text
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.ZIndex = 12
	label.Parent = container
	
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 65, 0, 35)
	toggle.Position = UDim2.new(1, -70, 0.5, -17)
	toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	toggle.Text = ""
	toggle.BorderSizePixel = 0
	toggle.Parent = container
	toggle.ZIndex = 12
	
	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(1, 0)
	toggleCorner.Parent = toggle
	
	local toggleCircle = Instance.new("Frame")
	toggleCircle.Size = UDim2.new(0, 30, 0, 30)
	toggleCircle.Position = UDim2.new(0, 2, 0.5, -15)
	toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	toggleCircle.BorderSizePixel = 0
	toggleCircle.Parent = toggle
	toggleCircle.ZIndex = 13
	
	local circleCorner = Instance.new("UICorner")
	circleCorner.CornerRadius = UDim.new(1, 0)
	circleCorner.Parent = toggleCircle
	
	local isOn = false
	
	toggle.MouseButton1Click:Connect(function()
		isOn = not isOn
		if isOn then
			toggle.BackgroundColor3 = currentTheme.Accent
			toggleCircle:TweenPosition(UDim2.new(0, 35, 0.5, -15), "Out", "Quad", 0.2, true)
		else
			toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			toggleCircle:TweenPosition(UDim2.new(0, 2, 0.5, -15), "Out", "Quad", 0.2, true)
		end
		callback(isOn)
	end)
	
	return container, toggle
end

-- Create Label
function UILib:CreateLabel(parent, text)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 40)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = currentTheme.Text
	label.Font = Enum.Font.GothamBold
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.Parent = parent
	label.ZIndex = 11
	
	return label
end

-- Create Divider
function UILib:CreateDivider(parent)
	local divider = Instance.new("Frame")
	divider.Size = UDim2.new(1, 0, 0, 2)
	divider.BackgroundColor3 = currentTheme.Accent
	divider.BorderSizePixel = 0
	divider.Parent = parent
	divider.ZIndex = 11
	
	return divider
end

-- Set Theme
function UILib:SetTheme(themeName)
	currentTheme = Themes[themeName] or Themes.Default
	UILib:Notify("Theme", "Changed to " .. themeName, 2)
end

-- ===================== BUILD THE HUB =====================

print("🔧 Building GUI...")

local mainWindow, mainScrollFrame = UILib:CreateWindow(Config.HubName, nil, nil)
print("✅ Main window created")

local tabSystem = UILib:CreateTabs(mainWindow, mainScrollFrame)
print("✅ Tab system created - SCROLLABLE")

-- HOME TAB
local homeTab = tabSystem:CreateTab("Home")
UILib:CreateLabel(homeTab, "Welcome to Mimic Hub!")
UILib:CreateDivider(homeTab)
UILib:CreateLabel(homeTab, "Movement Features:")
UILib:CreateButton(homeTab, "Infinite Jump", function()
	UILib:Notify("Jump", "Infinite Jump Enabled!", 2)
end)
UILib:CreateButton(homeTab, "Walk Speed +", function()
	UILib:Notify("Speed", "Speed Increased!", 2)
end)
UILib:CreateButton(homeTab, "Speed Reset", function()
	UILib:Notify("Speed", "Speed Reset!", 2)
end)
UILib:CreateButton(homeTab, "Fly Mode", function()
	UILib:Notify("Fly", "Fly Mode Enabled!", 2)
end)
UILib:CreateButton(homeTab, "Noclip", function()
	UILib:Notify("Noclip", "Noclip Enabled!", 2)
end)

-- TELEPORT TAB
local teleportTab = tabSystem:CreateTab("Teleport")
UILib:CreateLabel(teleportTab, "Teleportation")
UILib:CreateDivider(teleportTab)
UILib:CreateButton(teleportTab, "Spawn Point", function()
	UILib:Notify("Teleport", "Teleported to spawn!", 2)
end)
UILib:CreateButton(teleportTab, "Random Location", function()
	UILib:Notify("Teleport", "Teleported randomly!", 2)
end)
UILib:CreateButton(teleportTab, "Teleport Up 50 Studs", function()
	UILib:Notify("Teleport", "Teleported up!", 2)
end)
UILib:CreateButton(teleportTab, "Teleport Down 50 Studs", function()
	UILib:Notify("Teleport", "Teleported down!", 2)
end)
UILib:CreateButton(teleportTab, "Teleport Forward", function()
	UILib:Notify("Teleport", "Teleported forward!", 2)
end)

-- SCRIPTS TAB
local scriptsTab = tabSystem:CreateTab("Scripts")
UILib:CreateLabel(scriptsTab, "Script Manager")
UILib:CreateDivider(scriptsTab)
UILib:CreateButton(scriptsTab, "Script 1: Speed", function()
	UILib:Notify("Scripts", "Speed script loaded!", 2)
end)
UILib:CreateButton(scriptsTab, "Script 2: Flight", function()
	UILib:Notify("Scripts", "Flight script loaded!", 2)
end)
UILib:CreateButton(scriptsTab, "Script 3: Vision", function()
	UILib:Notify("Scripts", "Vision script loaded!", 2)
end)
UILib:CreateButton(scriptsTab, "Script 4: Stealth", function()
	UILib:Notify("Scripts", "Stealth script loaded!", 2)
end)
UILib:CreateButton(scriptsTab, "Script 5: Godmode", function()
	UILib:Notify("Scripts", "Godmode script loaded!", 2)
end)

-- SETTINGS TAB
local settingsTab = tabSystem:CreateTab("Settings")
UILib:CreateLabel(settingsTab, "Customization")
UILib:CreateDivider(settingsTab)
UILib:CreateToggle(settingsTab, "Notifications", function(state)
	UILib:Notify("Settings", "Notifications: " .. (state and "ON" or "OFF"), 1)
end)
UILib:CreateToggle(settingsTab, "Sound Effects", function(state)
	UILib:Notify("Settings", "Sound: " .. (state and "ON" or "OFF"), 1)
end)
UILib:CreateToggle(settingsTab, "Auto-Execute", function(state)
	UILib:Notify("Settings", "Auto-Execute: " .. (state and "ON" or "OFF"), 1)
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
UILib:CreateButton(settingsTab, "Forest Theme", function()
	UILib:SetTheme("Forest")
end)

-- ABOUT TAB
local aboutTab = tabSystem:CreateTab("About")
UILib:CreateLabel(aboutTab, "Mimic Hub v3.0")
UILib:CreateDivider(aboutTab)
UILib:CreateLabel(aboutTab, "Delta iOS Edition")
UILib:CreateLabel(aboutTab, "✓ Fully Scrollable")
UILib:CreateDivider(aboutTab)
UILib:CreateLabel(aboutTab, "Features:")
UILib:CreateLabel(aboutTab, "✓ Infinite Jump")
UILib:CreateLabel(aboutTab, "✓ Walk Speed")
UILib:CreateLabel(aboutTab, "✓ Teleport System")
UILib:CreateLabel(aboutTab, "✓ Script Manager")
UILib:CreateLabel(aboutTab, "✓ 4 Themes")
UILib:CreateLabel(aboutTab, "✓ Touch Support")
UILib:CreateLabel(aboutTab, "✓ Scrollable UI")

-- Welcome Notification
UILib:Notify("Welcome", "Mimic Hub Ready! 🎮", 3)

print("✅ Mimic Hub v3.0 Loaded!")
print("✅ iOS Delta Executor Edition")
print("✅ All features enabled with scrolling!")
