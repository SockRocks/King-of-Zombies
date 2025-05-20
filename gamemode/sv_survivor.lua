local sprintTable = {} -- monitors the stamina of all players
local BASE_STAMINA = 100

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
        end
    end
end

hook.Add("Think", "stamina tracker", manageStamina)