-- Load Fluent Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Create a Fluent Window for Key System
local Window = Fluent:CreateWindow({
    Title = "Shadowbyte Key System",
    SubTitle = "by your_username",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- Enables blur, false to disable blur
    Theme = "Dark"
})

-- Create Tabs for Fluent Interface
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" })
}

-- Key system section
local KeySection = Tabs.Main:AddSection({
    Title = "Key System"
})

_G.Key = "nothing yet"

-- Button to copy key link
KeySection:AddButton({
    Title = "Copy Key Link",
    Description = "Copy the key link to paste in browser",
    Callback = function()
        setclipboard("your_key_link")  -- Provide your actual key link here
    end
})

-- Label to show the current key
local KeyLabel = KeySection:AddLabel({
    Title = "Key | " .. _G.Key
})

-- Input box to enter the key
local KeyInput = KeySection:AddInput({
    Title = "Enter Key",
    Default = "Enter your key",
    Placeholder = "Your key here",
    Callback = function(txt)
        _G.Key = txt
        KeyLabel:SetText("Key | " .. _G.Key)
        CheckKey()  -- Call CheckKey when a key is entered
    end
})

-- Boolean to track if key is already checked
_G.CheckedKey = false
local OutputLabel = KeySection:AddLabel({
    Title = ""
})

-- Function to check if the key is valid
function CheckKey()
    if _G.CheckedKey then
        return
    end

    local key = game:HttpGet("https://redirect-api.work.ink/tokenValid/" .. _G.Key .. "?linkId=64581")
    
    if key == "False" then
        OutputLabel:SetText("Key incorrect")
        return
    end

    _G.CheckedKey = true
    OutputLabel:SetText("Key Validated Successfully!")
    
    -- Load the game list or execute code
    local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/shadowofficials1/Testscript/refs/heads/main/GameLists.lua"))()

    for PlaceID, Execute in pairs(Games) do
        -- Execute the game script if the key is valid
        loadstring(game:HttpGet(Execute))()
    end
end

-- Notify when the script is loaded
Fluent:Notify({
    Title = "Fluent",
    Content = "The key system has been loaded.",
    Duration = 5
})

-- Set the window to be visible
Window:SelectTab(1)

-- Optional: You can use SaveManager and InterfaceManager to handle settings or save states
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:SetFolder("ShadowbyteKeySystem")
InterfaceManager:SetFolder("ShadowbyteKeySystem/Interface")

-- Build the interface section for settings (if needed)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
