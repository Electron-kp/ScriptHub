-- Simple Script Hub Loader
-- Configure your GitHub username and repository name here
local githubUser = "Electron-kp"
local githubRepo = "ScriptHub"

-- Create a simple notification function
local function notify(title, text, duration)
    -- Create GUI for notification
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoaderNotification"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() 
        screenGui.Parent = game:GetService("CoreGui")
    end)
    
    -- If failed to parent to CoreGui (happens in some games), try PlayerGui
    if not screenGui.Parent then
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 80)
    frame.Position = UDim2.new(0.5, -125, 0.8, -40)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = frame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.Text = title
    titleLabel.Parent = frame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0, 30)
    textLabel.Position = UDim2.new(0, 0, 0.5, -15)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.TextSize = 14
    textLabel.Text = text
    textLabel.Parent = frame
    
    -- Animate and destroy
    spawn(function()
        wait(duration or 3)
        frame:TweenPosition(
            UDim2.new(0.5, -125, 1, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.5,
            false,
            function()
                screenGui:Destroy()
            end
        )
    end)
end

-- Direct loading approach
local success, err = pcall(function()
    -- Print information (useful for debugging)
    print("Loading Script Hub...")
    print("GitHub User: " .. githubUser)
    print("GitHub Repo: " .. githubRepo)
    
    -- Direct URL to the raw content
    local scriptUrl = "https://raw.githubusercontent.com/" .. githubUser .. "/" .. githubRepo .. "/main/ScriptHub.lua"
    print("Script URL: " .. scriptUrl)
    
    -- Get the script content
    local scriptContent = game:HttpGet(scriptUrl)
    print("Script content length: " .. #scriptContent .. " characters")
    
    -- Load the script
    loadstring(scriptContent)()
end)

if success then
    notify("Script Hub", "Successfully loaded!", 3)
else
    warn("Script Hub Error: " .. tostring(err))
    notify("Script Hub Error", tostring(err):sub(1, 30) .. "...", 5)
end 
