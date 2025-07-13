--local p_management = include("sv_p_manage.lua")

-- COMMANDS ---
--[[function setSurvivor(ply)
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
end]]

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

--[[function getZTable()
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
end]]

-- A bunch of developer commands
--concommand.Add("be-survivor", setSurvivor)
concommand.Add("reset-class", resetClass)
concommand.Add("get-class", getClass)
--concommand.Add("be-zking", setZKing)
--concommand.Add("get-z_table", getZTable)
--concommand.Add("get-w_table", getWTable)




local function selectKing()
    PrintMessage(HUD_PRINTTALK, "Choosing a new zombie king!")
    local allPs = player.GetAll()
            
    timer.Simple(2, function()
        local newKing = allPs[math.random(#allPs)]

        setZKing(allPs[math.random(#allPs)])
        PrintMessage(HUD_PRINTCENTER, newKing:Nick() .. " is the new zombie king!")

        for i in ipairs(allPs) do
            if allPs[i] ~= self.ZOMBIE_KING then  
                allPs[i]:ChatPrint("[GAME] You are now a survivor...")
                setSurvivor(allPs[i])
            end
        end
    end)
end

local function startGame()    
    for i in ipairs(allPs) do
        allPs[i]:Spawn()
    end
end


-- Handles game commands
function GAMEMODE:PlayerSay(ply, msg)
    if ply:IsAdmin() then
        if msg == "!select" then
            selectKing()
        elseif msg == "!start" then
            startGame()
        end
    end
end