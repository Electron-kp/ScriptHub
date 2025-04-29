-- Script Hub with Fluent UI
-- Configuration
local config = {
    title = "Script Hub",
    theme = "Dark",
    keybind = Enum.KeyCode.RightControl,
    saveConfig = true,
    autoLoad = true
}

-- Script Hub Core
local ScriptHub = {}
ScriptHub.Loaded = false
ScriptHub.Games = {}
ScriptHub.ActiveScripts = {}

-- Load Fluent UI Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/ThemeManager.lua"))()

-- Create main window
local Window = Fluent:CreateWindow({
    Title = config.title,
    SubTitle = "by Your Username",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = config.theme,
    MinimizeKey = config.keybind
})

-- Create tabs
local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "home" }),
    Scripts = Window:AddTab({ Title = "Scripts", Icon = "code" }),
    Universal = Window:AddTab({ Title = "Universal", Icon = "globe" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Home tab content
Tabs.Home:AddSection("Welcome")
Tabs.Home:AddParagraph("Welcome to Script Hub", "Navigate to the Scripts tab to find scripts for this game or check the Universal tab for scripts that work in any game.")

Tabs.Home:AddSection("Game Information")
local gameNameLabel = Tabs.Home:AddParagraph("Game", game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
local gameIdLabel = Tabs.Home:AddParagraph("Game ID", tostring(game.PlaceId))

-- Universal Scripts tab
Tabs.Universal:AddSection("Universal Scripts")
Tabs.Universal:AddParagraph("Universal Scripts", "These scripts work in any game.")

-- Example universal scripts
Tabs.Universal:AddButton({
    Title = "Simple ESP",
    Description = "Basic player ESP that works in most games",
    Callback = function()
        -- Check if script is already running
        if ScriptHub.ActiveScripts["Simple ESP"] then
            -- Stop the script
            if type(ScriptHub.ActiveScripts["Simple ESP"]) == "function" then
                ScriptHub.ActiveScripts["Simple ESP"]() -- Call cleanup function
            end
            ScriptHub.ActiveScripts["Simple ESP"] = nil
            
            Fluent:Notify({
                Title = "Script Hub",
                Content = "Simple ESP has been stopped",
                Duration = 3
            })
        else
            -- Example ESP code
            local players = game:GetService("Players")
            local runService = game:GetService("RunService")
            local connection
            
            -- Create ESP highlights
            local function createESP()
                for _, player in pairs(players:GetPlayers()) do
                    if player ~= players.LocalPlayer and player.Character then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "ESP_Highlight"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.Adornee = player.Character
                        highlight.Parent = player.Character
                    end
                end
            end
            
            -- Update ESP
            connection = runService.Heartbeat:Connect(function()
                createESP()
            end)
            
            -- Store cleanup function
            ScriptHub.ActiveScripts["Simple ESP"] = function()
                if connection then
                    connection:Disconnect()
                    
                    -- Remove all highlights
                    for _, player in pairs(players:GetPlayers()) do
                        if player.Character then
                            local highlight = player.Character:FindFirstChild("ESP_Highlight")
                            if highlight then
                                highlight:Destroy()
                            end
                        end
                    end
                end
            end
            
            Fluent:Notify({
                Title = "Script Hub",
                Content = "Simple ESP has been activated",
                Duration = 3
            })
        end
    end
})

Tabs.Universal:AddButton({
    Title = "Speed Boost",
    Description = "Increases your movement speed",
    Callback = function()
        -- Check if script is already running
        if ScriptHub.ActiveScripts["Speed Boost"] then
            -- Stop the script
            if type(ScriptHub.ActiveScripts["Speed Boost"]) == "function" then
                ScriptHub.ActiveScripts["Speed Boost"]() -- Call cleanup function
            end
            ScriptHub.ActiveScripts["Speed Boost"] = nil
            
            Fluent:Notify({
                Title = "Script Hub",
                Content = "Speed Boost has been stopped",
                Duration = 3
            })
        else
            -- Example speed boost code
            local player = game:GetService("Players").LocalPlayer
            local originalSpeed = 16
            local speedMultiplier = 2
            
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = originalSpeed * speedMultiplier
            end
            
            -- Monitor for new characters (in case of respawn)
            local connection = player.CharacterAdded:Connect(function(character)
                if character:WaitForChild("Humanoid") then
                    character.Humanoid.WalkSpeed = originalSpeed * speedMultiplier
                end
            end)
            
            -- Store cleanup function
            ScriptHub.ActiveScripts["Speed Boost"] = function()
                if connection then
                    connection:Disconnect()
                end
                
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = originalSpeed
                end
            end
            
            Fluent:Notify({
                Title = "Script Hub",
                Content = "Speed Boost has been activated",
                Duration = 3
            })
        end
    end
})

Tabs.Universal:AddButton({
    Title = "Infinite Jump",
    Description = "Allows you to jump infinitely",
    Callback = function()
        -- Check if script is already running
        if ScriptHub.ActiveScripts["Infinite Jump"] then
            -- Stop the script
            if type(ScriptHub.ActiveScripts["Infinite Jump"]) == "function" then
                ScriptHub.ActiveScripts["Infinite Jump"]() -- Call cleanup function
            end
            ScriptHub.ActiveScripts["Infinite Jump"] = nil
            
            Fluent:Notify({
                Title = "Script Hub",
                Content = "Infinite Jump has been stopped",
                Duration = 3
            })
        else
            -- Example infinite jump code
            local userInputService = game:GetService("UserInputService")
            local players = game:GetService("Players")
            local player = players.LocalPlayer
            
            local connection = userInputService.JumpRequest:Connect(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
            
            -- Store cleanup function
            ScriptHub.ActiveScripts["Infinite Jump"] = function()
                if connection then
                    connection:Disconnect()
                end
            end
            
            Fluent:Notify({
                Title = "Script Hub",
                Content = "Infinite Jump has been activated",
                Duration = 3
            })
        end
    end
})

-- Settings tab content
Tabs.Settings:AddSection("User Interface")

local ThemeToggle = Tabs.Settings:AddToggle("DarkTheme", {
    Title = "Dark Theme",
    Default = config.theme == "Dark",
    Callback = function(Value)
        if Value then
            Fluent:ToggleTheme("Dark")
        else
            Fluent:ToggleTheme("Light")
        end
        config.theme = Value and "Dark" or "Light"
    end
})

Tabs.Settings:AddKeybind("ToggleKeybind", {
    Title = "Toggle UI Keybind",
    Default = config.keybind,
    Callback = function()
        Window:Minimize()
    end,
    ChangedCallback = function(New)
        config.keybind = New
    end
})

Tabs.Settings:AddToggle("AutoLoadGames", {
    Title = "Auto Load Game Scripts",
    Default = config.autoLoad,
    Callback = function(Value)
        config.autoLoad = Value
    end
})

-- Additional settings
Tabs.Settings:AddSection("Appearance")

Tabs.Settings:AddDropdown("FontSize", {
    Title = "Font Size",
    Values = {"Small", "Medium", "Large"},
    Default = "Medium",
    Callback = function(Value)
        -- Font size logic would go here
        Fluent:Notify({
            Title = "Settings",
            Content = "Font size changed to " .. Value,
            Duration = 3
        })
    end
})

Tabs.Settings:AddSlider("Transparency", {
    Title = "UI Transparency",
    Default = 0,
    Min = 0,
    Max = 95,
    Callback = function(Value)
        -- Transparency logic would go here
        Window.Frame.BackgroundTransparency = Value / 100
    end
})

Tabs.Settings:AddColorpicker("AccentColor", {
    Title = "Accent Color",
    Default = Color3.fromRGB(50, 139, 255),
    Callback = function(Value)
        -- Accent color logic would go here
    end
})

-- Add SaveManager and ThemeManager to window
SaveManager:SetLibrary(Fluent)
ThemeManager:SetLibrary(Fluent)

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

-- Function to find and load game scripts
function ScriptHub:LoadGameScripts()
    -- Get current game ID
    local placeId = game.PlaceId
    local gameScriptsFound = false
    
    -- Clear previous scripts if any
    Tabs.Scripts:ClearTab()
    Tabs.Scripts:AddSection("Game-Specific Scripts")
    
    -- Check if we have a script for this game
    local success, gameModule = pcall(function()
        -- In a real implementation, you would use a better method to check if the file exists
        -- This is just a placeholder for demonstration
        return loadstring(readfile("games/" .. placeId .. ".lua"))()
    end)
    
    if success and gameModule then
        -- Add game info
        Tabs.Scripts:AddSection("Game Information")
        Tabs.Scripts:AddParagraph("Game", gameModule.name)
        Tabs.Scripts:AddParagraph("Created by", gameModule.author)
        Tabs.Scripts:AddParagraph("Description", gameModule.description)
        
        -- Add scripts section
        Tabs.Scripts:AddSection("Available Scripts")
        
        -- Add each script as a button
        for i, script in ipairs(gameModule.scripts) do
            Tabs.Scripts:AddButton({
                Title = script.name,
                Description = script.description,
                Callback = function()
                    -- Check if script is already running
                    if ScriptHub.ActiveScripts[script.name] then
                        -- Stop the script
                        if type(ScriptHub.ActiveScripts[script.name]) == "function" then
                            ScriptHub.ActiveScripts[script.name]() -- Call cleanup function
                        end
                        ScriptHub.ActiveScripts[script.name] = nil
                        
                        Fluent:Notify({
                            Title = "Script Hub",
                            Content = script.name .. " has been stopped",
                            Duration = 3
                        })
                    else
                        -- Run the script
                        local cleanup = script.callback()
                        ScriptHub.ActiveScripts[script.name] = cleanup
                        
                        Fluent:Notify({
                            Title = "Script Hub",
                            Content = script.name .. " has been activated",
                            Duration = 3
                        })
                    end
                end
            })
        end
        
        gameScriptsFound = true
    end
    
    -- If no scripts were found, show a message
    if not gameScriptsFound then
        Tabs.Scripts:AddParagraph("No Scripts Found", "No scripts available for this game yet.")
        Tabs.Scripts:AddButton({
            Title = "Check for Updates",
            Callback = function()
                Fluent:Notify({
                    Title = "Script Hub",
                    Content = "Checking for updates...",
                    Duration = 3
                })
                -- Would implement update checking logic here
            end
        })
    end
end

-- Function to cleanup all active scripts
function ScriptHub:CleanupActiveScripts()
    for scriptName, cleanup in pairs(ScriptHub.ActiveScripts) do
        if type(cleanup) == "function" then
            cleanup()
        end
    end
    ScriptHub.ActiveScripts = {}
end

-- Initialize the Script Hub
function ScriptHub:Init()
    -- Set the window to initialized
    ScriptHub.Loaded = true
    
    -- Load game scripts if auto load is enabled
    if config.autoLoad then
        ScriptHub:LoadGameScripts()
    end
    
    -- Add handler for game switching (in case player teleports to a different game)
    game:GetService("Players").PlayerRemoving:Connect(function(player)
        if player == game:GetService("Players").LocalPlayer then
            ScriptHub:CleanupActiveScripts()
        end
    end)
    
    -- Notify the user that the UI is loaded
    Fluent:Notify({
        Title = "Script Hub",
        Content = "Script Hub has been loaded!",
        Duration = 5
    })
end

-- Start the Script Hub
ScriptHub:Init()

-- Return the Script Hub object (useful for accessing from other scripts)
return ScriptHub 