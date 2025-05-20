local p_manage = {}

-- Sends the given player's points to the appropriate player
-- call whenever points are updated
function sendPts(ply)
    net.Start("getPts")
    print("Points are:", GAMEMODE.pTable[ply])
    local pts = GAMEMODE.pTable[ply]
    print("Points type is ", type(pts))
    net.WriteDouble(pts)
    net.Send(ply)
end

function updateClassStatus(ply)
    net.Start("classUpdate")
    if ply == GAMEMODE.ZOMBIE_KING then
        net.WriteBool(true)
    else
        net.WriteBool(false)
    end
    net.Send(ply)
end

p_manage.sendPts = sendPts
p_manage.updateCls = updateClassStatus

return p_manage