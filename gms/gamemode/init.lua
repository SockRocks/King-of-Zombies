AddCSLuaFile("cl_init.lua")
AddCSLuaFile("player_classes/survivor.lua")
AddCSLuaFile("player_classes/zombie_king.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_z_king.lua")
AddCSLuaFile("cl_p_manage.lua")

include("shared.lua")
include("p_perms.lua")
include("sv_survivor.lua")
--[[local zombKing = include("z_king.lua")
local wTable = include("weapTable.lua")
local zTable = include("z_table.lua")
local p_management = include("sv_p_manage.lua")]]


--[[function GM:PlayerInitialSpawn(ply)
    self.pTable[ply] = 0 -- Sets initial points to zero
    p_management.sendPts(ply)
end


function getWTableEntry(weap)
    for _, v in pairs(wTable.wTable) do
        if v.class == weap:GetClass() then
            return v
        end
    end
    return nil 
end
function GM:PlayerCanPickupWeapon(ply, weap)
    if ply ~= self.ZOMBIE_KING then
        local found = false
        for k,v in pairs(wTable.wTable) do
            if v.class == weap:GetClass() then
                found = true 

                for _, j in pairs(ply:GetWeapons()) do
                    local entry = getWTableEntry(j)

                    -- If one of the inventory items is non-existent player can't pickup items
                    if not entry then
                        return false
                    end

                    -- Can't have more than 1 of the same type
                    if entry.wType == v.wType then
                        ply:DropWeapon(j)
                        return true
                    end
                end

                return true
            end
        end

        if (#ply:GetWeapons() == 0) and found then
            return true
        end

        return false

    else
        return false
    end
end

-- Set up network strings
util.AddNetworkString("spawnZed")
util.AddNetworkString("getPts")
util.AddNetworkString("classUpdate")

timer.Simple(2, function()
    PrintMessage(HUD_PRINTCENTER, "Welcome to King of Zombies!")
    PrintMessage(HUD_PRINTTALK, "Welcome to King of Zombies")
    PrintMessage(HUD_PRINTTALK, "Type !select in the chat to chose the next zombie king!")
end)]]