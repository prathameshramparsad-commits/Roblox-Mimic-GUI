-- Mimic Hub GUI - Usage Examples
-- This file shows how to use the framework

-- ==========================================
-- EXAMPLE 1: Creating a Simple Feature Tab
-- ==========================================

local featuresTab = tabSystem:CreateTab("Features")

-- Add a label
UILib:CreateLabel(featuresTab, "Player Features")

-- Add a divider
UILib:CreateDivider(featuresTab)

-- Add buttons
UILib:CreateButton(featuresTab, "Infinite Jump", function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            UILib:Notify("Jump", "Infinite Jump Enabled", 2)
        end
    end
end)

UILib:CreateButton(featuresTab, "Walk Speed +", function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 50
            UILib:Notify("Speed", "Walk Speed Increased", 2)
        end
    end
end)

-- ==========================================
-- EXAMPLE 2: Using Toggles
-- ==========================================

local advancedTab = tabSystem:CreateTab("Advanced")

UILib:CreateLabel(advancedTab, "Game Features")
UILib:CreateDivider(advancedTab)

local noClipEnabled = false
UILib:CreateToggle(advancedTab, "No Clip", function(state)
    noClipEnabled = state
    if state then
        UILib:Notify("No Clip", "Enabled", 1)
    else
        UILib:Notify("No Clip", "Disabled", 1)
    end
end)

-- ==========================================
-- EXAMPLE 3: Using Text Input
-- ==========================================

UILib:CreateInput(advancedTab, "Enter player name...", function(playerName)
    local targetPlayer = game.Players:FindFirstChild(playerName)
    if targetPlayer then
        UILib:Notify("Success", "Found player: " .. playerName, 2)
    else
        UILib:Notify("Error", "Player not found", 2)
    end
end)

-- ==========================================
-- EXAMPLE 4: Custom Notifications
-- ==========================================

-- Success notification
UILib:Notify("Success", "This is a success message", 3)

-- Error notification
UILib:Notify("Error", "This is an error message", 3)

-- Info notification
UILib:Notify("Info", "This is an info message", 3)

-- ==========================================
-- EXAMPLE 5: Creating a Settings Panel
-- ==========================================

local customSettingsTab = tabSystem:CreateTab("Options")

UILib:CreateLabel(customSettingsTab, "GUI Settings")
UILib:CreateDivider(customSettingsTab)

-- GUI Opacity Toggle
UILib:CreateToggle(customSettingsTab, "Show GUI", function(state)
    if state then
        UILib:Notify("GUI", "GUI is visible", 1)
    else
        UILib:Notify("GUI", "GUI is hidden", 1)
    end
end)

-- Sound Toggle
UILib:CreateToggle(customSettingsTab, "Enable Sound", function(state)
    if state then
        UILib:Notify("Sound", "Sound enabled", 1)
    else
        UILib:Notify("Sound", "Sound disabled", 1)
    end
end)

-- ==========================================
-- EXAMPLE 6: Teleportation Features
-- ==========================================

local teleportTab = tabSystem:CreateTab("Teleport")

UILib:CreateLabel(teleportTab, "Teleport Locations")
UILib:CreateDivider(teleportTab)

local locations = {
    ["Spawn"] = Vector3.new(0, 10, 0),
    ["Mountain"] = Vector3.new(100, 50, 100),
    ["Forest"] = Vector3.new(-100, 20, -100),
    ["Sky"] = Vector3.new(0, 500, 0),
}

for locationName, position in pairs(locations) do
    UILib:CreateButton(teleportTab, "Teleport to " .. locationName, function()
        local player = game.Players.LocalPlayer
        if player.Character then
            player.Character:MoveTo(position)
            UILib:Notify("Teleport", "Teleported to " .. locationName, 2)
        end
    end)
end

-- ==========================================
-- EXAMPLE 7: Script Manager
-- ==========================================

local scriptsManagerTab = tabSystem:CreateTab("Scripts")

UILib:CreateLabel(scriptsManagerTab, "Loaded Scripts")
UILib:CreateDivider(scriptsManagerTab)

local scripts = {
    ["Speed Script"] = "game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100",
    ["Jump Script"] = "game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)",
    ["Fly Script"] = "-- Fly script code here",
}

for scriptName, scriptCode in pairs(scripts) do
    UILib:CreateButton(scriptsManagerTab, "Load " .. scriptName, function()
        local success, err = pcall(function()
            loadstring(scriptCode)()
        end)
        
        if success then
            UILib:Notify("Success", scriptName .. " loaded", 2)
        else
            UILib:Notify("Error", "Failed to load: " .. scriptName, 3)
        end
    end)
end

-- ==========================================
-- EXAMPLE 8: Advanced Lua Script Execution
-- ==========================================

-- This is already built-in to the Scripts tab!
-- Users can paste Lua code directly and execute it

-- Example code that could be pasted:
-- local player = game.Players.LocalPlayer
-- player.Character:MoveTo(Vector3.new(0, 100, 0))
-- print("Teleported!")

-- ==========================================
-- EXAMPLE 9: Player Info Display
-- ==========================================

local infoTab = tabSystem:CreateTab("Info")

UILib:CreateLabel(infoTab, "Player Information")
UILib:CreateDivider(infoTab)

local player = game.Players.LocalPlayer
UILib:CreateLabel(infoTab, "Name: " .. player.Name)
UILib:CreateLabel(infoTab, "UserId: " .. player.UserId)
UILib:CreateLabel(infoTab, "Level: 50") -- Replace with actual level

-- ==========================================
-- EXAMPLE 10: Theme Switching
-- ==========================================

-- Already implemented in Settings tab!
-- But here's how to do it programmatically:

UILib:SetTheme("Default") -- Default theme
UILib:SetTheme("DarkMode") -- Dark theme
UILib:SetTheme("NeonPurple") -- Neon purple theme
UILib:SetTheme("Forest") -- Forest theme

-- ==========================================
-- TIPS & TRICKS
-- ==========================================

-- Tip 1: Chain multiple functions
UILib:Notify("Tip", "You can chain multiple operations", 2)
local myTab = tabSystem:CreateTab("Tip")
UILib:CreateLabel(myTab, "Hello!")

-- Tip 2: Use callbacks for complex logic
UILib:CreateButton(myTab, "Complex Action", function()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health > 0 then
            UILib:Notify("Status", "Player is alive", 2)
        else
            UILib:Notify("Status", "Player is dead", 2)
        end
    end
end)

-- Tip 3: Use error handling in callbacks
UILib:CreateButton(myTab, "Safe Operation", function()
    local success, error = pcall(function()
        -- Your code here
        local result = 10 / 2
        print(result)
    end)
    
    if not success then
        UILib:Notify("Error", "Operation failed: " .. error, 3)
    end
end)

print("✓ All examples loaded successfully!")