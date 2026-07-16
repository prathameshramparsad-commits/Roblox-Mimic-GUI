-- Mimic Hub Installer & Loader
-- Universal Installation Script - Works on Desktop & Mobile
-- Just run this script to load the GUI!

local game = game
local print = print

-- Initialize
print("🎮 Mimic Hub Installer v2.0")
print("Loading GUI Framework...")

-- Load the main GUI from GitHub
local success, result = pcall(function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/prathameshramparsad-commits/Roblox-Mimic-GUI/main/MainGUI_Mobile_Executable.lua"))()
end)

if success then
	print("✅ Mimic Hub loaded successfully!")
	print("📱 GUI is now ready to use")
else
	print("❌ Error loading Mimic Hub:")
	print(tostring(result))
end

return success
