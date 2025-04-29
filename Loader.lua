-- Super Simple Script Hub Loader v2
local githubUser = "Electron-kp"
local githubRepo = "ScriptHub"

-- Script laden
local scriptUrl = "https://raw.githubusercontent.com/" .. githubUser .. "/" .. githubRepo .. "/main/ScriptHub.lua"
loadstring(game:HttpGet(scriptUrl))() 
