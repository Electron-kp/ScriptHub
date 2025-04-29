-- Script Hub mit Fluent UI
-- Einfache Version mit Konfigurationsdatei

-- Einfache Fehlermeldung anzeigen
local function showErrorMessage(text, duration)
    duration = duration or 5
    
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
    textLabel.Text = text
    textLabel.Parent = frame
    
    spawn(function()
        wait(duration)
        screenGui:Destroy()
    end)
    
    return screenGui
end

-- Debug Funktion für Ausgabe
local function debugPrint(message)
    print("Script Hub Debug: " .. tostring(message))
end

-- HTTP Anfrage mit besserer Fehlerbehandlung
local function safeHttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success then
        debugPrint("HTTP Fehler: " .. tostring(result) .. " für URL: " .. url)
        return nil
    end
    
    return result
end

-- Lade die Konfigurationsdatei
local config
local configSuccess, configError = pcall(function()
    -- Versuche, die Konfigurationsdatei lokal zu laden
    config = loadstring(safeHttpGet("https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/config.lua"))()
end)

if not configSuccess or not config then
    showErrorMessage("Fehler beim Laden der Konfiguration: " .. tostring(configError), 10)
    return
end

debugPrint("Konfiguration erfolgreich geladen")

-- Fluent UI Library laden
local Fluent = nil
local FluentLoadingMessage = showErrorMessage("Lade Fluent UI...", 30)

local success = pcall(function()
    Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
end)

if not success or not Fluent then
    debugPrint("Erster Versuch Fluent zu laden fehlgeschlagen, versuche alternative URL")
    success = pcall(function()
        Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Fluent.lua"))()
    end)
    
    if not success or not Fluent then
        if FluentLoadingMessage then
            FluentLoadingMessage:Destroy()
        end
        showErrorMessage("Fehler beim Laden der UI-Bibliothek. Bitte versuche es später erneut.", 10)
        warn("Fluent UI konnte nicht geladen werden.")
        return
    end
end

if FluentLoadingMessage then
    FluentLoadingMessage:Destroy()
end

-- Fenster erstellen
local Window = Fluent:CreateWindow({
    Title = "Script Hub",
    SubTitle = "by " .. config.githubUser,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Tabs erstellen
local HomeTab = Window:AddTab({ Title = "Home", Icon = "home" })
local ScriptsTab = Window:AddTab({ Title = "Scripts", Icon = "code" })
local UniversalTab = Window:AddTab({ Title = "Universal", Icon = "globe" })
local SettingsTab = Window:AddTab({ Title = "Settings", Icon = "settings" })

-- HOME TAB
HomeTab:AddSection("Willkommen")
HomeTab:AddParagraph({ Title = "Willkommen im Script Hub", Content = "Wähle einen Tab aus, um zu beginnen." })

HomeTab:AddButton({
    Title = "Discord beitreten",
    Description = "Tritt unserem Discord-Server bei",
    Callback = function()
        setclipboard("https://discord.gg/yourdiscord")
        Fluent:Notify({
            Title = "Script Hub", 
            Content = "Discord-Link kopiert!",
            Duration = 3
        })
    end
})

-- SCRIPTS TAB - Jetzt nutzen wir die config.lua für Spielscripts
ScriptsTab:AddSection("Spiel-spezifische Scripts")

-- Spielname und ID ermitteln
local gameId = game.PlaceId
local gameName = "Unbekannt"

pcall(function()
    gameName = game:GetService("MarketplaceService"):GetProductInfo(gameId).Name
end)

ScriptsTab:AddParagraph({ Title = "Aktives Spiel", Content = gameName .. " (ID: " .. gameId .. ")" })

-- Prüfen, ob Scripts für dieses Spiel in der Konfiguration existieren
local gameScriptConfig = config.gameScripts[gameId]

if gameScriptConfig and gameScriptConfig.scripts and #gameScriptConfig.scripts > 0 then
    -- Für jedes Script einen Button hinzufügen
    for i, scriptData in ipairs(gameScriptConfig.scripts) do
        ScriptsTab:AddButton({
            Title = scriptData.name,
            Description = scriptData.description or "Script für " .. scriptData.name,
            Callback = function()
                local success, result = pcall(function()
                    return loadstring(scriptData.loadstring)()
                end)
                
                if success then
                    Fluent:Notify({
                        Title = "Script Hub", 
                        Content = scriptData.name .. " wurde geladen!",
                        Duration = 3
                    })
                else
                    Fluent:Notify({
                        Title = "Script Hub", 
                        Content = "Fehler beim Ausführen des Scripts: " .. tostring(result),
                        Duration = 5
                    })
                end
            end
        })
    end
else
    ScriptsTab:AddParagraph({ Title = "Nicht unterstützt", Content = "Dieses Spiel wird derzeit nicht unterstützt." })
end

-- UNIVERSAL TAB - Aus der config.lua laden
UniversalTab:AddSection("Universal Scripts")

if #config.universalScripts > 0 then
    for _, script in ipairs(config.universalScripts) do
        UniversalTab:AddButton({
            Title = script.name,
            Description = script.description,
            Callback = function()
                local success, result = pcall(loadstring(script.loadstring))
                
                if success then
                    Fluent:Notify({
                        Title = "Script Hub", 
                        Content = script.name .. " wurde geladen!",
                        Duration = 3
                    })
                else
                    Fluent:Notify({
                        Title = "Script Hub", 
                        Content = "Fehler beim Ausführen des Scripts: " .. tostring(result),
                        Duration = 5
                    })
                end
            end
        })
    end
else
    UniversalTab:AddParagraph({ Title = "Keine Scripts gefunden", Content = "Es wurden keine Universal Scripts gefunden." })
end

-- SETTINGS TAB
SettingsTab:AddSection("Benutzeroberfläche")

-- Theme Toggle
local themeToggle = SettingsTab:AddToggle({
    Title = "Dunkles Theme",
    Default = true,
    Callback = function(Value)
        Fluent:ToggleTheme(Value and "Dark" or "Light")
    end
})

-- UI Key Bind
SettingsTab:AddKeybind({
    Title = "UI-Taste",
    Default = Enum.KeyCode.RightControl,
    KeySelected = function(Key)
        Window.MinimizeKey = Key
    end,
    ChangedCallback = function(Key)
        Window.MinimizeKey = Key
    end
})

-- Close UI Button
SettingsTab:AddButton({
    Title = "UI schließen",
    Description = "Schließt das Script Hub",
    Callback = function()
        if Fluent and Fluent.Destroy then
            Fluent:Destroy()
        else
            for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
                if v.Name:find("Fluent") then
                    v:Destroy()
                end
            end
        end
    end
})

-- Neu laden Button
SettingsTab:AddButton({
    Title = "Script Hub neu laden",
    Description = "Lädt das Script Hub neu",
    Callback = function()
        Fluent:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Loader.lua"))()
    end
})

-- Status Section
SettingsTab:AddSection("Status")

-- Calculate total game scripts
local totalGameScripts = 0
for _, gameData in pairs(config.gameScripts) do
    if gameData.scripts then
        totalGameScripts = totalGameScripts + #gameData.scripts
    end
end

-- Add Debug Info
SettingsTab:AddParagraph({ 
    Title = "Debug Info", 
    Content = "GitHub User: " .. config.githubUser .. 
              "\nGitHub Repo: " .. config.githubRepo .. 
              "\nBranch: " .. config.githubBranch ..
              "\nUnterstützte Spiele: " .. (function() 
                  local count = 0
                  for _ in pairs(config.gameScripts) do count = count + 1 end
                  return count
              end)() ..
              "\nSpiel-Scripts gesamt: " .. totalGameScripts ..
              "\nUniversal Scripts: " .. #config.universalScripts
})

-- Benachrichtigung anzeigen
Fluent:Notify({
    Title = "Script Hub", 
    Content = "Script Hub wurde erfolgreich geladen!",
    Duration = 3
}) 
