-- Infinity Jump Script
-- Kann der Spieler unbegrenzt springen lassen
-- Für den Universal Ordner im Script Hub

-- Überprüfen, ob die Funktion bereits aktiv ist
local infiniteJumpEnabled = not _G.InfiniteJumpEnabled
_G.InfiniteJumpEnabled = infiniteJumpEnabled

-- Je nach Status aktivieren oder deaktivieren
if infiniteJumpEnabled then
    -- Verbindung zum JumpRequest-Event erstellen
    local connection = game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfiniteJumpEnabled then
            local player = game:GetService("Players").LocalPlayer
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
    
    -- Verbindung speichern, um später trennen zu können
    _G.InfiniteJumpConnection = connection
    
    -- Benachrichtigung anzeigen (wenn Fluent verfügbar)
    if Fluent then
        Fluent:Notify({
            Title = "Infinity Jump", 
            Content = "Unbegrenztes Springen aktiviert",
            Duration = 3
        })
    end
else
    -- Verbindung trennen, wenn vorhanden
    if _G.InfiniteJumpConnection then
        _G.InfiniteJumpConnection:Disconnect()
        _G.InfiniteJumpConnection = nil
    end
    
    -- Benachrichtigung anzeigen (wenn Fluent verfügbar)
    if Fluent then
        Fluent:Notify({
            Title = "Infinity Jump", 
            Content = "Unbegrenztes Springen deaktiviert",
            Duration = 3
        })
    end
end

-- Rückgabe für Script-Status
return {
    name = "Infinity Jump",
    enabled = infiniteJumpEnabled
} 