--[[
This file holds all functions related to weapon handling
]]

local weapTable = {}

local wTable = {} -- Holds all valid weapons

function populateWTable(File)
    wTable = util.JSONToTable(file.Read("w_table.json", "DATA"), false, false)
end

function spawnRandWeap(ply)
    -- Choose a random weapon from the table
    local rnd = math.random(0, #wTable)
    local weapon = wTable[rnd].class

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

if not file.Exists("w_table.json", "DATA") then
    --[[
    Weapons are defined by class and type
    type indicates whether it's a primary, secondary, tertiary, or item.
    A player can have one of each excluding items
    ]]
    local default = {
        [0] = 
            {
                class = "weapon_pistol", 
                wType = "secondary"
            },
        [1] = 
        {
            class = "weapon_shotgun",
            wType = "primary"
        },
        [2] = 
        {
            class = "weapon_frag",
            wType = "tertiary"
        },
        [3] = 
        {
            class = "item_healthkit",
            wType = "item"
        }
    }

    local data = util.TableToJSON(default, true)
    file.Open("w_table.json", "w", "DATA")
    file.Write("w_table.json", data)
end

populateWTable("w_table.json")


weapTable.wTable = wTable
weapTable.spawnWeap = spawnRandWeap

concommand.Add("spawn-weap", spawnRandWeap)


return weapTable
