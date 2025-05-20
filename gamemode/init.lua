AddCSLuaFile("cl_init.lua")
AddCSLuaFile("player_classes/survivor.lua")
AddCSLuaFile("player_classes/zombie_king.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_z_king.lua")

include("shared.lua")
include("p_perms.lua")
include("sv_survivor.lua")
local zombKing = include("z_king.lua")
local wTable = include("weapTable.lua")
local zTable = include("z_table.lua")


GM.pTable = {}
GM.ZOMBIE_KING = nil


function GM:PlayerInitialSpawn(ply)
    self.pTable[ply] = 4 -- Sets initial points to zero
end



-- COMMANDS ---
function setSurvivor(ply)
    if IsValid(ply) then
        print(ply:Nick() .. " is a survivor now...")
        GAMEMODE.ZOMBIE_KING = nil
        player_manager.SetPlayerClass(ply, "player_survivor")
    end
end

function setZKing(ply)
    if IsValid(ply) then
        print(ply:Nick() .. " is the new zombie king!")

        player_manager.SetPlayerClass(ply, "player_zking")
        GAMEMODE.ZOMBIE_KING = ply
    end
end

function resetClass(ply)
    if IsValid(ply) then
        print(ply:Nick() .. " reset to player_default")
        player_manager.SetPlayerClass(ply, "player_default")
    end
end

function getClass(ply)
    if IsValid(ply) then
        print(ply:Nick() .. " is " .. player_manager.GetPlayerClass(ply))
    end
end

-- A bunch of developer commands
concommand.Add("be-survivor", setSurvivor)
concommand.Add("reset-class", resetClass)
concommand.Add("get-class", getClass)
concommand.Add("be-zking", setZKing)

-- Set up network strings
util.AddNetworkString("spawnZed")