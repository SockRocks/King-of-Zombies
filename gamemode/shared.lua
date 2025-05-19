GM.Name = "King of Zombies"
GM.Author = "Ethan Gaver"
GM.FolderName = "kingofzombies"

function GM:Initialize()
    print("Initialized")
end

include( "player_classes/survivor.lua" )
include( "player_classes/zombie_king.lua" )