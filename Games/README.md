# Games Folder

This folder contains game-specific scripts for the Script Hub.

## How to Add Game Scripts

1. Create a Lua file named with the game's Place ID, for example: `123456.lua` where `123456` is the Roblox game's Place ID.
2. The script file should return a table with the following structure:

```lua
return {
    name = "Game Name", -- Name to display in the UI
    author = "Author Name", -- Creator of the script
    description = "Description of the script", -- Short description
    scripts = {
        {
            name = "Script 1",
            description = "Description of Script 1",
            callback = function()
                -- Code to execute when this script is selected
                print("Script 1 executed")
            end
        },
        {
            name = "Script 2",
            description = "Description of Script 2",
            callback = function()
                -- Code to execute when this script is selected
                print("Script 2 executed")
            end
        }
        -- Add more scripts as needed
    }
}
```

3. The Script Hub will automatically detect and load the script when the player is in the corresponding game.

## Example Game Script

See the example script (`example_game.lua`) for a template to create your own game scripts. 