local zTable = include("z_table.lua")
local p_manage = include("sv_p_manage.lua")

local zKing = {}

function spawnZed(ply, cmd, args)
    -- Initial error cases
    if #args <= 0 then 
        MsgC(Color(255,0,0), "Incorrect arg count")
        return 
    elseif ply ~= GAMEMODE.ZOMBIE_KING then
        MsgC(Color(255,0,0), "You are not the zombie king")
        return
    end

    if IsValid(ply) then
        local zedTable = zTable.zedTable
        selected = zedTable[args[1]]

        if GAMEMODE.pTable[ply] < selected.price then
            print("Not enough points!")
            return
        end

        local zed = ents.Create(selected.class)

        zed:SetPos(ply:GetEyeTrace().HitPos)
        zed:SetAngles(Angle(0.0, 90.0, 0.0))
        zed:Spawn()
        GAMEMODE.pTable[ply] = GAMEMODE.pTable[ply] - selected.price
        p_manage.sendPts(ply)

        print("Updated points:", GAMEMODE.pTable[ply])
    end
end

function receiveZedCommand(len, ply)
    local msg = net.ReadString()
    spawnZed(ply, "blah", {msg, msg})
end

zKing.spawnZed = spawnZed

concommand.Add("spawn-zombie", spawnZed)

net.Receive("spawnZed", receiveZedCommand)
return zKing