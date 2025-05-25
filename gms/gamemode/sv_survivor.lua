local ptsManager = include("sv_p_manage.lua")

local sprintTable = {} -- monitors the stamina of all players
local BASE_STAMINA = 100
local POINT_TRACKER = 0

function manageStamina()
    for k, v in ipairs(player.GetAll()) do
        if v ~= GAMEMODE.ZOMBIE_KING then
            if not sprintTable[v] then
                sprintTable[v] = {stamina = BASE_STAMINA, baseRun = v:GetRunSpeed()}
            end

            if v:KeyDown(IN_SPEED) then
                if sprintTable[v].stamina <= 0 then
                    v:SetRunSpeed(v:GetWalkSpeed())
                else
                    sprintTable[v].stamina = sprintTable[v].stamina - 0.5
                    v:SetRunSpeed(sprintTable[v].baseRun)
                end
            else
                if sprintTable[v].stamina < BASE_STAMINA then
                    sprintTable[v].stamina = sprintTable[v].stamina + 0.5
                end
            end
        else
            -- Hopefully tick rate is 66 for server
            -- if so this is 30 * 66 to give points every 30 seconds
            if POINT_TRACKER >= 10 * (1 / (engine.TickInterval())) and GAMEMODE.ZOMBIE_KING then
                GAMEMODE.pTable[GAMEMODE.ZOMBIE_KING] = GAMEMODE.pTable[GAMEMODE.ZOMBIE_KING] + 1
                ptsManager.sendPts(v)
                POINT_TRACKER = 0
            else
                POINT_TRACKER = POINT_TRACKER + 1
            end
        end
    end
end

hook.Add("Think", "stamina tracker", manageStamina)