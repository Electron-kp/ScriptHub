-- Infinity Jump Script
-- Ein einfaches Script, das endloses Springen ermöglicht

-- Initialisierungsfunktion
local function initInfinityJump()
    -- Status des Infinity Jump
    local infinityJumpEnabled = false
    
    -- Überprüfen, ob das Script bereits geladen wurde
    if _G.InfinityJumpConnection then
        _G.InfinityJumpConnection:Disconnect()
        _G.InfinityJumpConnection = nil
        infinityJumpEnabled = false
        
        -- Benachrichtigung mit FluentUI anzeigen (wenn verfügbar)
        if game:GetService("CoreGui"):FindFirstChild("FluentProviderUI") then
            local Fluent = nil
            for _, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Notify") then
                    Fluent = v
                    break
                end
            end
            
            if Fluent then
                Fluent:Notify({
                    Title = "Infinity Jump",
                    Content = "Infinity Jump wurde deaktiviert!",
                    Duration = 3
                })
            end
        else
            -- Fallback-Benachrichtigung
            game.StarterGui:SetCore("SendNotification", {
                Title = "Infinity Jump",
                Text = "Infinity Jump wurde deaktiviert!",
                Duration = 3
            })
        end
        
        return
    end
    
    -- Infinity Jump aktivieren
    infinityJumpEnabled = true
    
    -- Verbindung zum JumpRequest-Event erstellen
    _G.InfinityJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
        if infinityJumpEnabled then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
    
    -- Benachrichtigung mit FluentUI anzeigen (wenn verfügbar)
    if game:GetService("CoreGui"):FindFirstChild("FluentProviderUI") then
        local Fluent = nil
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "Notify") then
                Fluent = v
                break
            end
        end
        
        if Fluent then
            Fluent:Notify({
                Title = "Infinity Jump",
                Content = "Infinity Jump wurde aktiviert! Drücke die Leertaste zum Springen.",
                Duration = 3
            })
        end
    else
        -- Fallback-Benachrichtigung
        game.StarterGui:SetCore("SendNotification", {
            Title = "Infinity Jump",
            Text = "Infinity Jump wurde aktiviert! Drücke die Leertaste zum Springen.",
            Duration = 3
        })
    end
end

-- Script ausführen
initInfinityJump() 
