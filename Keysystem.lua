-- Load Fluent Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Create a new window for the UI
local Window = Fluent:CreateWindow({
    Title = "Shadowbyte Key System",
    SubTitle = "by ShadowOfficial",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Add tabs to the window
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- Create a section in the main tab for the key system
local Section = Tabs.Main:AddSection({
    Title = "Key System",
    Description = "Enter your key below to access the game."
})

-- Initialize the key variable and create the button for copy key link
_G.Key = "nothing yet"

Section:AddButton({
    Title = "Copy Key Link",
    Description = "Paste link in browser",
    Callback = function()
        setclipboard("key link") -- Replace with your actual key link
    end
})

-- Create a label to show the entered key
local KeyLabel = Section:AddLabel("Key | " .. _G.Key)

-- Create a textbox to input the key
local KeyInput = Section:AddTextBox({
    Title = "Key",
    Description = "Enter your key",
    Callback = function(txt)
        KeyLabel:UpdateLabel("Key > " .. txt)
        _G.Key = txt
        CheckKey()
    end
})

-- Create an output label to display messages about the key
local OutputLabel = Section:AddParagraph({
    Title = "Output",
    Content = "Enter the key to check"
})

-- Function to check the key and load the game script
_G.CheckedKey = false
function CheckKey()
    if _G.CheckedKey then
        return
    end

    -- Make an HTTP request to check if the key is valid (replace with actual API)
    local key = game:HttpGet("https://redirect-api.work.ink/tokenValid/" .. _G.Key .. "?linkId=64581")

    if key == "False" then
        OutputLabel:UpdateLabel("Key incorrect")
        return
    end

    -- If the key is valid, mark it as checked
    _G.CheckedKey = true
    OutputLabel:UpdateLabel("Key correct, loading game...")

    -- Load the GameList after the key is validated
    local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/shadowofficials1/Testscript/refs/heads/main/GameList.lua"))()

    for PlaceID, Execute in pairs(Games) do
        if PlaceID == game.PlaceId then
            loadstring(game:HttpGet(Execute))()
            break -- Exit loop after the first matching game script is loaded
        end
    end

    -- Close the window after the game script is loaded
    Window:Destroy()
end

-- Notify the user that the key system has been loaded
Fluent:Notify({
    Title = "Key System",
    Content = "Please enter your key to continue.",
    Duration = 5
})
