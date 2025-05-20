AddCSLuaFile("cl_init.lua")
AddCSLuaFile("player_classes/survivor.lua")
AddCSLuaFile("player_classes/zombie_king.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_z_king.lua")
AddCSLuaFile("cl_p_manage.lua")

include("shared.lua")
include("p_perms.lua")
include("sv_survivor.lua")
local zombKing = include("z_king.lua")
local wTable = include("weapTable.lua")
local zTable = include("z_table.lua")
local p_management = include("sv_p_manage.lua")


GM.pTable = {}
GM.ZOMBIE_KING = nil


function GM:PlayerInitialSpawn(ply)
    self.pTable[ply] = 4 -- Sets initial points to zero
    p_management.sendPts(ply)
end

-- Handles game commands
function GM:PlayerSay(ply, msg)
    if ply:IsAdmin() then
        local allPs = player.GetAll()
        if msg == "!select" then
            PrintMessage(HUD_PRINTTALK, "Choosing a new zombie king!")
            timer.Simple(2, function()
                local newKing = allPs[math.random(#allPs)]
                setZKing(allPs[math.random(#allPs)])
                PrintMessage(HUD_PRINTCENTER, newKing:Nick() .. " is the new zombie king!")

                for i in ipairs(allPs) do
                    if allPs[i] ~= self.ZOMBIE_KING then
                        for j=1, 10 do
                            allPs[i]:ChatPrint(" ")
                        end
                        allPs[i]:ChatPrint("You are now a survivor...")
                        setSurvivor(allPs[i])
                    end
                end
            end)
        elseif msg == "!start" then
            if self.ZOMBIE_KING then
                self.ZOMBIE_KING:Spawn()
            end
            
            for i in ipairs(allPs) do
                if allPs[i] ~= self.ZOMBIE_KING then
                    allPs[i]:Spawn()
                end
            end
        end

    end
    return msg
end



-- COMMANDS ---
function setSurvivor(ply)
    if IsValid(ply) then
        print(ply:Nick() .. " is a survivor now...")
        GAMEMODE.ZOMBIE_KING = nil
        player_manager.SetPlayerClass(ply, "player_survivor")
        p_management.updateCls(ply)
    end
end

function setZKing(ply)
    if IsValid(ply) then
        print(ply:Nick() .. " is the new zombie king!")

        player_manager.SetPlayerClass(ply, "player_zking")
        GAMEMODE.ZOMBIE_KING = ply
        p_management.updateCls(ply)
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

function getZTable()
    if zTable.zedTable then
        PrintTable(zTable.zedTable)
    else
        MsgC(Color(255, 0, 0), "Failed to fetch zed table!")
    end
end

function getWTable()
    if wTable.wTable then
        PrintTable(wTable.wTable)
    else
        MsgC(Color(255, 0, 0), "Failed to fetch weapon table!")
    end
end

-- A bunch of developer commands
concommand.Add("be-survivor", setSurvivor)
concommand.Add("reset-class", resetClass)
concommand.Add("get-class", getClass)
concommand.Add("be-zking", setZKing)
concommand.Add("get-z_table", getZTable)
concommand.Add("get-w_table", getWTable)

-- Set up network strings
util.AddNetworkString("spawnZed")
util.AddNetworkString("getPts")
util.AddNetworkString("classUpdate")

timer.Simple(2, function()
    PrintMessage(HUD_PRINTCENTER, "Welcome to King of Zombies!")
    PrintMessage(HUD_PRINTTALK, "Welcome to King of Zombies")
    PrintMessage(HUD_PRINTTALK, "Type !select in the chat to chose the next zombie king!")
end)