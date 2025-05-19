DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

function PLAYER:Spawn()
    print("setting vis")
    self.Player:SetNoTarget(true)
    self.Player:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    self.Player:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self.Player:SetColor(Color(0,0,0,0))
end


player_manager.RegisterClass("player_zking", PLAYER, "player_default")