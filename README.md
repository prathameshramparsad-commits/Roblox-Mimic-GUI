# Roblox Mimic Hub - Custom GUI Framework

**A powerful, fully customizable GUI framework for Roblox games with NO key system required! Now with full mobile support! 📱**

## Features ✨

✅ **No Key System** - Completely open and accessible
✅ **Tab System** - Organize features into multiple tabs
✅ **Draggable Windows** - Move the UI around the screen (mouse & touch)
✅ **Custom Buttons & Toggles** - Fully interactive components
✅ **Text Input Fields** - Accept user input
✅ **Notification System** - Display alerts and messages
✅ **Script Executor** - Run custom Lua scripts
✅ **4 Theme Presets** - Default, Dark Mode, Neon Purple, Forest
✅ **Modern Design** - Clean, professional UI with smooth animations
✅ **Mobile Optimized** - Full touch support & responsive layout
✅ **Easy to Customize** - Modular code structure

## Installation 🚀

### Method 1: Quick Load (One-Click) ⚡ RECOMMENDED
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/prathameshramparsad-commits/Roblox-Mimic-GUI/main/INSTALLER.lua"))()
```

### Method 2: Mobile/Desktop Executable
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/prathameshramparsad-commits/Roblox-Mimic-GUI/main/MainGUI_Mobile_Executable.lua"))()
```

### Method 3: Copy-Paste
1. Copy the code from `MainGUI_Mobile_Executable.lua`
2. In Roblox Studio, create a new `LocalScript` in `StarterPlayer > StarterCharacterScripts` or `StarterPlayer > StarterPlayerScripts`
3. Paste the code
4. Run the game

## Device Support 📱💻

### Desktop Features
- 500x600px window
- Standard button sizes (35px height)
- Optimized mouse controls
- 6px scroll bar thickness

### Mobile Features ✨ NEW!
- 95% width, 85% height responsive layout
- **Large touch-friendly buttons (45px height)**
- **Bigger toggles & input boxes**
- **Larger text for readability**
- **Full touch event support**
- Auto-detection: Automatically optimizes for your device
- Pinch zoom compatible
- Portrait & Landscape support

**The GUI automatically detects your device and optimizes the layout!**

## Usage 📖

### Basic Setup
The GUI automatically loads with a main window containing multiple tabs:

- **Home** - Welcome screen with basic features
- **Scripts** - Script manager and script executor
- **Settings** - Customization and theme selection
- **About** - Information about the hub

### Creating Custom Elements

#### Add a Button
```lua
UILib:CreateButton(parentFrame, "Button Text", function()
    print("Button clicked!")
end)
```

#### Add a Toggle
```lua
UILib:CreateToggle(parentFrame, "Toggle Label", function(state)
    print("Toggle state: ", state)
end)
```

#### Add a Text Input
```lua
UILib:CreateInput(parentFrame, "Enter text...", function(text)
    print("User entered: ", text)
end)
```

#### Send a Notification
```lua
UILib:Notify("Title", "Message", 3) -- 3 = duration in seconds
```

#### Create a New Tab
```lua
local myTab = tabSystem:CreateTab("My Tab")
UILib:CreateButton(myTab, "My Button", function()
    print("Clicked!")
end)
```

#### Change Theme
```lua
UILib:SetTheme("DarkMode")  -- Options: Default, DarkMode, NeonPurple, Forest
```

## Themes 🎨

Choose from 4 beautiful pre-built themes:

- **Default** - Blue and orange accent
- **DarkMode** - Dark gray with cyan accent
- **NeonPurple** - Purple neon with hot pink accent
- **Forest** - Green with light green accent

## Customization 🛠️

Edit the `Config` and `Themes` tables to customize colors and appearance:

```lua
local Themes = {
    MyTheme = {
        Primary = Color3.fromRGB(255, 0, 0),
        Secondary = Color3.fromRGB(50, 50, 50),
        Accent = Color3.fromRGB(0, 255, 0),
        Text = Color3.fromRGB(255, 255, 255),
    },
}
```

## API Reference 📚

### Main Functions

| Function | Description |
|----------|-------------|
| `UILib:CreateWindow(title, size, position)` | Create a new window |
| `UILib:CreateButton(parent, text, callback)` | Create a button |
| `UILib:CreateToggle(parent, text, callback)` | Create a toggle switch |
| `UILib:CreateInput(parent, placeholder, callback)` | Create text input |
| `UILib:CreateLabel(parent, text)` | Create a label |
| `UILib:CreateDivider(parent)` | Create a divider line |
| `UILib:Notify(title, message, duration)` | Show a notification |
| `UILib:SetTheme(themeName)` | Change the theme |
| `UILib:CreateTabs(window, scrollFrame)` | Create a tab system |
| `UILib:CreateScriptExecutor(parent)` | Add script executor |

## Example Script 💻

Here's an example of extending the GUI:

```lua
-- Add a custom feature to the home tab
local homeTab = tabSystem:CreateTab("Home")

-- Add some buttons
UILib:CreateButton(homeTab, "Teleport to Spawn", function()
    local player = game.Players.LocalPlayer
    local spawn = workspace:FindFirstChild("Spawn")
    if spawn then
        player.Character:MoveTo(spawn.Position)
        UILib:Notify("Teleport", "Teleported to spawn!", 2)
    end
end)

-- Add a toggle for god mode
UILib:CreateToggle(homeTab, "God Mode", function(state)
    if state then
        UILib:Notify("God Mode", "Enabled", 1)
        -- Your god mode code here
    else
        UILib:Notify("God Mode", "Disabled", 1)
    end
end)
```

## Features Overview 🎮

### 1. **Tab System**
Organize your GUI into multiple tabs for better organization

### 2. **Draggable Windows**
Click and drag the title bar to move the GUI around (works on mobile too!)

### 3. **Notification System**
Display pop-up notifications to the user with auto-dismiss

### 4. **Script Executor**
Built-in Lua script execution with error handling

### 5. **Theme Customization**
Switch between 4 themes or create your own

### 6. **Mobile Optimization** ✨ NEW!
- Automatic device detection
- Touch-friendly UI elements
- Responsive scaling
- Optimized text sizes

## Performance ⚡

- Lightweight and optimized
- No performance impact on game
- Efficient UI rendering
- Smooth animations
- Works on all devices

## Files in Repository 📁

- **MainGUI_Mobile_Executable.lua** - Full GUI framework (recommended)
- **INSTALLER.lua** - One-click installer
- **MainGUI.lua** - Original desktop version
- **MainGUI_Mobile.lua** - Mobile source code
- **USAGE_EXAMPLES.lua** - Code examples
- **README.md** - This file

## License 📄

Free to use and modify for any purpose. No key required!

## Support 🤝

For issues, questions, or suggestions, feel free to open an issue on GitHub.

---

**Made with ❤️ for the Roblox community**

### Quick Links
- 📥 **Quick Install:** `loadstring(game:HttpGet("https://raw.githubusercontent.com/prathameshramparsad-commits/Roblox-Mimic-GUI/main/INSTALLER.lua"))()`
- 📱 **Mobile Support:** Full touch & responsive layout
- 🎨 **Customize:** Edit colors in the Themes table
- 🔧 **Extend:** Add your own features using the API
- 📖 **Learn:** Check the examples and API reference

**Enjoy your custom Mimic Hub! 🎮✨**
