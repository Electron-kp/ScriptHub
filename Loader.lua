-- Super Simple Script Hub Loader
-- Lädt den Script Hub von GitHub

-- Einfache Nachrichtenfunktion
local function showMessage(text, duration)
    duration = duration or 5
    
    -- GUI erstellen
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGUI"
    
    -- Versuchen, es zum CoreGui hinzuzufügen (funktioniert nur, wenn das Spiel es erlaubt)
    local success = pcall(function() 
        screenGui.Parent = game:GetService("CoreGui") 
    end)
    
    -- Wenn es nicht zum CoreGui hinzugefügt werden kann, zum PlayerGui hinzufügen
    if not success then
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Frame erstellen
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(0.5, -150, 0.85, -50)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    -- Ecken abrunden
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    -- Text hinzufügen
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -20, 1, -20)
    textLabel.Position = UDim2.new(0, 10, 0, 10)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 16
    textLabel.TextWrapped = true
    textLabel.Text = text
    textLabel.Parent = frame
    
    -- Nach X Sekunden entfernen
    spawn(function()
        wait(duration)
        screenGui:Destroy()
    end)
    
    return screenGui
end

-- Lade den Script Hub
local loadingMessage = showMessage("Script Hub wird geladen...", 10)

-- GitHub Repository Information
local GITHUB_USER = "Electron-kp"
local GITHUB_REPO = "Script-Hub" -- Stelle sicher, dass dies exakt mit deinem Repository übereinstimmt

-- Versuche, den Script Hub zu laden
local scriptUrl = "https://raw.githubusercontent.com/" .. GITHUB_USER .. "/" .. GITHUB_REPO .. "/main/ScriptHub.lua"

local success, errorMsg = pcall(function()
    return loadstring(game:HttpGet(scriptUrl))()
end)

if loadingMessage then
    loadingMessage:Destroy()
end

if not success then
    warn("Script Hub konnte nicht geladen werden: " .. tostring(errorMsg))
    showMessage("Fehler beim Laden des Script Hubs!\n" .. tostring(errorMsg), 10)
else
    showMessage("Script Hub wurde erfolgreich geladen!", 3)
end 
