-- Super Simple Script Hub Loader
-- GitHub-Benutzer und Repository-Name
local githubUser = "Electron-kp"
local githubRepo = "ScriptHub"

-- Einfache Mini-Funktion für Benachrichtigungen
local function showMessage(text)
    if not text then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoaderMessage"
    
    -- Versuche zuerst in CoreGui
    local success = pcall(function()
        screenGui.Parent = game:GetService("CoreGui")
    end)
    
    -- Falls nicht erfolgreich, verwende PlayerGui
    if not success then
        pcall(function()
            screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        end)
    end
    
    -- Erstelle die UI
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 50)
    frame.Position = UDim2.new(0.5, -100, 0.8, -25)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -10, 1, 0)
    textLabel.Position = UDim2.new(0, 5, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14
    textLabel.Text = text
    textLabel.TextWrapped = true
    textLabel.Parent = frame
    
    -- Automatisches Ausblenden nach 5 Sekunden
    spawn(function()
        wait(5)
        screenGui:Destroy()
    end)
end

-- Script versuchen zu laden
local success, errorMsg = pcall(function()
    local scriptUrl = "https://raw.githubusercontent.com/" .. githubUser .. "/" .. githubRepo .. "/main/ScriptHub.lua"
    
    showMessage("Lade Script Hub...")
    
    -- Script laden
    local scriptContent = game:HttpGet(scriptUrl)
    
    if scriptContent and #scriptContent > 0 then
        -- Script ausführen
        loadstring(scriptContent)()
    else
        error("Konnte keine Inhalte vom GitHub-Repository laden")
    end
end)

-- Bei Fehler eine Meldung anzeigen
if not success then
    warn("Script Hub Fehler: " .. tostring(errorMsg))
    showMessage("Fehler: " .. tostring(errorMsg):sub(1, 50))
end 
