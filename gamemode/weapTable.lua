--[[
This file holds all functions related to weapon handling
]]

local weapTable = {}

local wTable = {} -- Holds all valid weapons

function populateWTable()
    wTable[0] = "weapon_pistol"
    wTable[1] = "weapon_shotgun"
end

function spawnRandWeap(ply)
    -- Choose a random weapon from the table
    local rnd = math.random(0, #wTable)
    local weapon = wTable[rnd]

    -- Calculate a random point around the player to spawn the weapon
    local pPos = ply:GetPos()
    local rndAngle = math.random() * (2 * math.pi)
    local radius = 100
    local wPos = Vector(radius * math.cos(rndAngle), radius * math.sin(rndAngle), 0) + pPos
    
    -- Actually spawn it
    local newWeap = ents.Create(weapon)
    newWeap:SetPos(wPos)
    newWeap:Spawn()
end

populateWTable()


weapTable.wTable = wTable
weapTable.spawnWeap = spawnRandWeap

concommand.Add("spawn-weap", spawnRandWeap)


return weapTable
