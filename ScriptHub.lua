-- Minimale Version des ScriptHub
-- Vereinfacht für bessere Kompatibilität und weniger Fehler

-- Grundlegende Konfiguration
local Config = {
    WindowName = "Script Hub v1.0",
    Color = Color3.fromRGB(41, 74, 122),
    Keybind = Enum.KeyCode.F7
}

-- UI-Bibliothek laden (FluentUI)
local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"))()
end)

if not success then
    warn("Fehler beim Laden der UI-Bibliothek: " .. tostring(Library))
    -- Versuchen Sie, den Benutzer zu benachrichtigen
    local function showErrorMessage(message)
        -- Einfache Bildschirmnachricht erstellen
        local screenGui = Instance.new("ScreenGui")
        pcall(function() screenGui.Parent = game:GetService("CoreGui") end)
        if not screenGui.Parent then
            pcall(function() screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end)
        end
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 100)
        frame.Position = UDim2.new(0.5, -150, 0.5, -50)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BorderSizePixel = 0
        frame.Parent = screenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = frame
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -20, 1, -20)
        textLabel.Position = UDim2.new(0, 10, 0, 10)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.Gotham
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 14
        textLabel.TextWrapped = true
        textLabel.Text = message
        textLabel.Parent = frame
        
        -- Nachricht nach 5 Sekunden ausblenden
        spawn(function()
            wait(5)
            screenGui:Destroy()
        end)
    end
    
    showErrorMessage("UI-Bibliothek konnte nicht geladen werden. Bitte versuche es später erneut.")
    return
end

-- Fenster erstellen
local Window = Library:CreateWindow({
    Name = Config.WindowName,
    Themeable = {
        Info = "Einfache Version des Script Hub"
    }
})

-- Tabs erstellen
local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "home" }),
    Scripts = Window:AddTab({ Title = "Scripts", Icon = "code" }),
    Universal = Window:AddTab({ Title = "Universal", Icon = "globe" }),
    Settings = Window:AddTab({ Title = "Einstellungen", Icon = "settings" })
}

-- HOME TAB INHALT
local success, error = pcall(function()
    Tabs.Home:AddParagraph({
        Title = "Willkommen im Script Hub",
        Content = "Dies ist eine vereinfachte Version des Script Hub. Wähle einen Tab, um zu beginnen."
    })
    
    Tabs.Home:AddButton({
        Title = "Discord beitreten",
        Description = "Tritt unserem Discord-Server bei",
        Callback = function()
            -- Discord-Link zum Kopieren in die Zwischenablage
            setclipboard("https://discord.gg/yourdiscord")
            Library:Notify({
                Title = "Discord",
                Content = "Discord-Link in Zwischenablage kopiert!",
                Duration = 3
            })
        end
    })
end)

if not success then
    warn("Fehler beim Laden des Home-Tabs: " .. tostring(error))
end

-- SCRIPTS TAB INHALT
local success, error = pcall(function()
    Tabs.Scripts:AddParagraph({
        Title = "Spiel-spezifische Scripts",
        Content = "Scripts für " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    })
    
    -- Beispiel-Script-Button
    Tabs.Scripts:AddButton({
        Title = "Script 1",
        Description = "Beispiel-Script für dieses Spiel",
        Callback = function()
            Library:Notify({
                Title = "Script",
                Content = "Script 1 wird ausgeführt...",
                Duration = 3
            })
            -- Hier würde der eigentliche Script-Code ausgeführt werden
        end
    })
end)

if not success then
    warn("Fehler beim Laden des Scripts-Tabs: " .. tostring(error))
end

-- UNIVERSAL TAB INHALT
local success, error = pcall(function()
    Tabs.Universal:AddParagraph({
        Title = "Universal Scripts",
        Content = "Scripts, die in jedem Spiel funktionieren"
    })
    
    -- Einfacher ESP-Button als Beispiel
    Tabs.Universal:AddButton({
        Title = "Einfacher ESP",
        Description = "Markiert andere Spieler",
        Callback = function()
            Library:Notify({
                Title = "Universal",
                Content = "ESP wird geladen...",
                Duration = 3
            })
            -- Hier würde der ESP-Code stehen
        end
    })
end)

if not success then
    warn("Fehler beim Laden des Universal-Tabs: " .. tostring(error))
end

-- SETTINGS TAB INHALT
local success, error = pcall(function()
    Tabs.Settings:AddParagraph({
        Title = "Einstellungen",
        Content = "Grundlegende Einstellungen für Script Hub"
    })
    
    Tabs.Settings:AddButton({
        Title = "UI schließen",
        Description = "Schließt das Script Hub",
        Callback = function()
            Library:Destroy()
        end
    })
    
    -- Tastenkombination zum Öffnen/Schließen
    Tabs.Settings:AddKeybind({
        Title = "Öffnen/Schließen",
        Description = "Tastenkombination zum Öffnen/Schließen des Script Hub",
        Default = Config.Keybind,
        Callback = function()
            Library:ToggleUI()
        end
    })
end)

if not success then
    warn("Fehler beim Laden des Settings-Tabs: " .. tostring(error))
end

-- Benachrichtigung anzeigen, dass alles geladen wurde
Library:Notify({
    Title = "Script Hub",
    Content = "Script Hub wurde erfolgreich geladen!",
    Duration = 3
})

-- Ende des Scripts 
