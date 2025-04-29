-- Example Game Script
-- Replace the filename with the actual game ID (e.g., 123456.lua)

return {
    name = "Example Game", -- Name to display in the UI
    author = "Your Username", -- Creator of the script
    description = "Example scripts for demonstration", -- Short description
    scripts = {
        {
            name = "Auto Farm",
            description = "Automatically farms resources",
            callback = function()
                -- Code to execute when this script is selected
                print("Auto Farm script executed")
                
                -- Example notification
                loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))():Notify({
                    Title = "Auto Farm",
                    Content = "Auto Farm script has been activated!",
                    Duration = 5
                })
                
                -- Example auto farm code would go here
                -- This is just a placeholder
                local runService = game:GetService("RunService")
                local connection
                
                connection = runService.Heartbeat:Connect(function()
                    -- Your auto farm logic would go here
                    -- For example, teleporting to resources, collecting them, etc.
                    task.wait(1)
                    print("Auto farming...")
                end)
                
                -- Cleanup function (important for proper script management)
                return function()
                    if connection then
                        connection:Disconnect()
                        print("Auto Farm stopped")
                    end
                end
            end
        },
        {
            name = "ESP",
            description = "See players through walls",
            callback = function()
                -- Code to execute when this script is selected
                print("ESP script executed")
                
                -- Example notification
                loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))():Notify({
                    Title = "ESP",
                    Content = "ESP has been activated!",
                    Duration = 5
                })
                
                -- Example ESP code would go here
                -- This is just a placeholder
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
                
                -- Cleanup function
                return function()
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
                        
                        print("ESP stopped")
                    end
                end
            end
        },
        {
            name = "Speed Hack",
            description = "Increase your movement speed",
            callback = function()
                -- Code to execute when this script is selected
                print("Speed Hack script executed")
                
                -- Example notification
                loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))():Notify({
                    Title = "Speed Hack",
                    Content = "Speed Hack has been activated!",
                    Duration = 5
                })
                
                -- Example speed hack code
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
                
                -- Cleanup function
                return function()
                    if connection then
                        connection:Disconnect()
                    end
                    
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid.WalkSpeed = originalSpeed
                    end
                    
                    print("Speed Hack stopped")
                end
            end
        }
    }
} 