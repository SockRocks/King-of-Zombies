AddCSLuaFile("cl_init.lua")

AddCSLuaFile("player_classes/survivor.lua")
AddCSLuaFile("player_classes/zombie_king.lua")

AddCSLuaFile("shared.lua")

include("shared.lua")

zedTable = {}
pTable = {}
wTable = {}

ZOMBIE_KING = nil
function populateZTable(file)
    zedTable.normal = 
    {
        class = "npc_zombie",
        price = 1
    }

    zedTable.fast = 
    {
        class = "npc_fastzombie",
        price = 2
    }
    --[[zedTable.zp =
    {
        class = "npc_vj_zss_panic",
        price = 1
    }]]
end

function populateWTable()
    wTable[0] = "weapon_pistol"
    wTable[1] = "weapon_shotgun"
    wTable[2] = "m9k_colt1911"
    wTable[3] = "m9k_ump45"
end

function addToPTable(ply)
    pTable[ply] = 4 -- Sets initial points to zero
    PrintTable(pTable)
end

function setSurvivor(ply)
    if IsValid(ply) then
        print("Player:", ply:Nick())
        player_manager.SetPlayerClass(ply, "player_survivor")
        print(player_manager.GetPlayerClass(ply))

    end
end

function setZKing(ply)
    if IsValid(ply) then
        print("Player:", ply:Nick())
        player_manager.SetPlayerClass(ply, "player_zking")
        ZOMBIE_KING = ply
    end
end

function resetClass(ply)
    if IsValid(ply) then
        print("Player called reset class:", ply:Nick())
        player_manager.SetPlayerClass(ply, "player_default")
        print("Class:", player_manager.GetPlayerClass(ply))
    end
end

function getClass(ply)
    if IsValid(ply) then
        print("Player:", ply:Nick())
        print("Class:", player_manager.GetPlayerClass(ply))
    end
end

function spawnZed(ply, cmd, args)
    if #args <= 0 then 
        print("Incorrect arg count")
        return 
    elseif player_manager.GetPlayerClass(ply) ~= "player_zking" then
        print("You are not the zombie king")
        return
    end

    if IsValid(ply) then
        selected = zedTable[args[1]]
        print("Player points:", pTable[ply])
        print("Price:", selected.price)

        if pTable[ply] < selected.price then
            print("Not enough points!")
            return
        end

        print("Class is", selected.class)
        local zed = ents.Create(selected.class)

        zed:SetPos(ply:GetEyeTrace().HitPos)
        zed:SetAngles(Angle(0.0, 90.0, 0.0))
        zed:Spawn()
        pTable[ply] = pTable[ply] - selected.price
        print("New points:", pTable[ply])
    end
end

function noClipPerms(ply)
    if IsValid(ply) then
        if player_manager.GetPlayerClass(ply) == "player_zking" then
            return true 
        else
            return false
        end
    end
end

-- Searches for the entity class in the zed table
-- if a match isn't found nil is returned; otherwise, the enemy table is returned
function isEnemy(entClass)
    for k, v in pairs(zedTable) do
        if v.class == entClass then
            return v
        end
    end

    return nil
end
function giveZPts(target, dmgInfo)
    local dmg = dmgInfo:GetDamage()
    local att_ent = dmgInfo:GetAttacker()
    local cls = att_ent:GetClass()

    if target:IsPlayer() then
        local enem = isEnemy(cls)

        if enem then
            pTable[ZOMBIE_KING] = pTable[ZOMBIE_KING] + dmg / 2
        end
        PrintTable(pTable)
    else
        if isEnemy(target:GetClass()) and att_ent:IsPlayer() then
            pTable[att_ent] = pTable[att_ent] + dmg / 2
            if pTable[att_ent] > 10 then
                spawnRandWeap(att_ent)
                pTable[att_ent] = pTable[att_ent] / 2
            end
            PrintTable(pTable)
        end
    end
end

function spawnRandWeap(ply)
    local rnd = math.random(0, #wTable)
    local weapon = wTable[rnd]
    print("Spawning:", weapon)
    local pPos = ply:GetPos()
    local rndAngle = math.random() * (2 * math.pi)
    local radius = 100
    local wPos = Vector(radius * math.cos(rndAngle), radius * math.sin(rndAngle), 0) + pPos
    
    local newWeap = ents.Create(weapon)
    print("Player", pPos)
    newWeap:SetPos(wPos)
    newWeap:Spawn()
    print("Weapon:", wPos)
end
hook.Add("PlayerNoClip", "Disable no-clip for survivors", noClipPerms)
hook.Add("PlayerInitialSpawn", "add to player table", addToPTable)
hook.Add("EntityTakeDamage", "Detect zed damage", giveZPts)
-- A bunch of developer commands
concommand.Add("be-survivor", setSurvivor)
concommand.Add("reset-class", resetClass)
concommand.Add("get-class", getClass)
concommand.Add("be-zking", setZKing)
concommand.Add("spawn-weap", spawnRandWeap)

concommand.Add("spawn-zombie", spawnZed)
populateZTable()
populateWTable()