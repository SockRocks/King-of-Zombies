DEFINE_BASECLASS( "player_default" )

local PLAYER = {}
PLAYER.WalkSpeed = 230
PLAYER.RunSpeed = 300
function PLAYER:Loadout()
	self.Player:Give( "weapon_pistol" )
 
end

function PLAYER:Spawn()
	self.Player:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self.Player:SetColor(Color(255,255,255,255))
end


player_manager.RegisterClass("player_survivor", PLAYER, "player_default")