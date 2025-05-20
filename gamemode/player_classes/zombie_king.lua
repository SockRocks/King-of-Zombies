DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

function PLAYER:Spawn()
    self.Player:SetNoTarget(true)
    self.Player:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    self.Player:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self.Player:SetColor(Color(0,0,0,0))
    self.Player:GodEnable()
end

function PLAYER:Loadout()
    self.Player:StripWeapons()
    self.Player:RemoveAllItems()
end


player_manager.RegisterClass("player_zking", PLAYER, "player_default")