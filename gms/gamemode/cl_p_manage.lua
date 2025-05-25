local p_manager = {}

function getPoints()
    p_manager.pPoints = net.ReadDouble()
end

function getZKingStatus()
    p_manager.ZOMBIE_KING = net.ReadBool()
end
    

p_manager.pPoints = 0
p_manager.ZOMBIE_KING = false

net.Receive("getPts", getPoints)
net.Receive("classUpdate", getZKingStatus)

return p_manager