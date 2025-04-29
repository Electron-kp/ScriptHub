-- Script Hub Konfiguration
-- Diese Datei enthält Informationen über verfügbare Scripts

-- Grundkonfiguration
local config = {
    -- Info über das Repository
    githubUser = "Electron-kp",
    githubRepo = "Script-Hub",
    githubBranch = "main",
    
    -- Spiel-spezifische Scripts
    gameScripts = {
        -- Format: [GameID] = { scripts = { {name = "Script Name", description = "Beschreibung", loadstring = "loadstring()" }, ... } }
        
        -- Beispiel: Brookhaven
        [4924922222] = {
            scripts = {
                {
                    name = "Brookhaven",
                    description = "Hauptscript für Brookhaven",
                    loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Games/Brookhaven.lua'))()"
                },
                {
                    name = "Brookhaven Admin",
                    description = "Admin-Funktionen für Brookhaven",
                    loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Games/BrookhavenAdmin.lua'))()"
                }
            }
        },
        
        -- Beispiel: Blox Fruits
        [2753915549] = {
            scripts = {
                {
                    name = "Blox Fruits",
                    description = "Hauptscript für Blox Fruits",
                    loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Games/BloxFruits.lua'))()"
                },
                {
                    name = "Blox Fruits Auto Farm",
                    description = "Auto-Farming für Blox Fruits",
                    loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Games/BloxFruitsAutoFarm.lua'))()"
                }
            }
        },
        
        -- Beispiel: Adopt Me
        [920587237] = {
            scripts = {
                {
                    name = "Adopt Me",
                    description = "Hauptscript für Adopt Me",
                    loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Games/AdoptMe.lua'))()"
                }
            }
        }
        
        -- Weitere Spiele hier hinzufügen
    },
    
    -- Universal Scripts die in jedem Spiel funktionieren
    universalScripts = {
        -- Format: { name = "Display Name", description = "Beschreibung", loadstring = "loadstring()" }
        {
            name = "Infinity Jump",
            description = "Ermöglicht endloses Springen mit der Leertaste",
            loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Universal/InfinityJump.lua'))()"
        },
        
        {
            name = "Simple ESP",
            description = "Spieler durch Wände sehen",
            loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Universal/SimpleESP.lua'))()"
        },
        
        {
            name = "Admin Commands",
            description = "Einfache Admin-Befehle",
            loadstring = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Electron-kp/Script-Hub/main/Universal/AdminCommands.lua'))()"
        }
        
        -- Weitere Universal Scripts hier hinzufügen
    }
}

return config 