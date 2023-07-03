-- Load MOOSE module
local MOOSE = require('Moose')

-- Define the mission
local mission = MOOSE.Mission:new("Air-to-Ground Training in Range 19")

-- Set up the coalitions
local blueCoalition = mission:NewCoalition("Blue")
local redCoalition = mission:NewCoalition("Red")

-- Add the F-15E Strike Eagle aircraft for the Blue Team
local blueTeam = mission:NewGroup("Blue Team")
blueTeam:SpawnInZone("Blue Spawn Zone") -- Replace "Blue Spawn Zone" with the desired starting zone for the Blue Team

-- Add the Su-27 aircraft for the Red Team
local redTeam = mission:NewGroup("Red Team")
redTeam:SpawnInZone("Red Spawn Zone") -- Replace "Red Spawn Zone" with the desired starting zone for the Red Team

-- Add infantry for the Red Team
local redInfantry = mission:NewGroup("Red Infantry")
redInfantry:SpawnInZone("Red Infantry Spawn Zone") -- Replace "Red Infantry Spawn Zone" with the desired starting zone for the Red Team's infantry

-- Add infantry for the Blue Team
local blueInfantry = mission:NewGroup("Blue Infantry")

-- Function to spawn Blue infantry near Red infantry
function spawnBlueInfantryNearRed()
    -- Define a zone around the Red infantry
    local zoneAroundRedInfantry = ZONE:New("Zone around Red Infantry", redInfantry:GetPointVec2(), 500) -- The third parameter is the radius of the zone in meters
    -- Spawn Blue infantry in this zone
    blueInfantry:SpawnInZone(zoneAroundRedInfantry)
end

-- Add JTACs for both teams
local blueJTAC = mission:NewJTAC("Blue JTAC", "Blue Team")
local redJTAC = mission:NewJTAC("Red JTAC", "Red Team")

-- Define Range 19 as the training range
local range19 = mission:NewZone("Range 19")

-- Blue Team's Objectives
local blueCASObjective = mission:NewObjective("Blue CAS Objective")
blueCASObjective:SetCoalition(blueCoalition)
blueCASObjective:AddTargetZone(range19) -- Replace with the actual target zones for the Blue Team

-- Red Team's Objectives
local redCASObjective = mission:NewObjective("Red CAS Objective")
redCASObjective:SetCoalition(redCoalition)
redCASObjective:AddThreatZone(range19) -- Replace with the actual threat zones for the Red Team

-- Execute the mission
mission:Start()

-- Call the function to spawn Blue infantry near Red infantry
spawnBlueInfantryNearRed()

-- Debriefing and Evaluation
mission:AddMissionEndFunction(function()
    local blueTeamPerformance = blueTeam:GetMissionPerformance()
    local redTeamPerformance = redTeam:GetMissionPerformance()

    -- Print debriefing information or perform further evaluation as needed
    print("Debriefing:")
    print("Blue Team Performance:", blueTeamPerformance)
    print("Red Team Performance:", redTeamPerformance)
end)