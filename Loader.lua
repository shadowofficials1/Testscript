-- Load the key system first and validate the key
local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/shadowofficials1/Testscript/refs/heads/main/Keysystem.lua"))()

-- Check if the key was valid
if KeySystem() then
    print("Key validated successfully. Loading game script...")
else
    print("Invalid key. Please check your key and try again.")
end
