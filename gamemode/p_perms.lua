local zTable = include("z_table.lua")
local wTable = include("weapTable.lua")

function noClipPerms(ply)
    if IsValid(ply) then
        if ply == GAMEMODE.ZOMBIE_KING then
            return true 
        else
            return false
        end
    end
end

-- Searches for the entity class in the zed table
-- if a match isn't found nil is returned; otherwise, the enemy table is returned
function isEnemy(entClass)
    for k, v in pairs(zTable.zedTable) do
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

    -- If the player took damage
    if target:IsPlayer() then
        local enem = isEnemy(cls)

        if enem then
            GAMEMODE.pTable[ZOMBIE_KING] = GAMEMODE.pTable[GAMEMODE.ZOMBIE_KING] + dmg / 2
        end
    else
        -- Award the player points if they damaged a zombie
        if isEnemy(target:GetClass()) and att_ent:IsPlayer() then
            GAMEMODE.pTable[att_ent] = GAMEMODE.pTable[att_ent] + dmg / 2

            if GAMEMODE.pTable[att_ent] > 10 then
                wTable.spawnWeap(att_ent)
                GAMEMODE.pTable[att_ent] = GAMEMODE.pTable[att_ent] / 2
            end
        end
    end
end


hook.Add("EntityTakeDamage", "Detect zed damage", giveZPts)
hook.Add("PlayerNoClip", "Disable no-clip for survivors", noClipPerms)