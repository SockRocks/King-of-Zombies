GAMEMODE.pTable = GAMEMODE.pTable or {}
GAMEMODE.ZOMBIE_KING = GAMEMODE.ZOMBIE_KING or nil


function GAMEMDOE:PlayerInitialSpawn(ply)
    self.pTable[ply] = 0 -- Sets initial points to zero
    p_management.sendPts(ply)
end