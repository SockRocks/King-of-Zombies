local sprintTable = {} -- monitors the stamina of all players

function manageStamina()
    for k, v in ipairs(player.GetAll()) do
        if not sprintTable[v] then
            sprintTable[v] = {stamina = 100, baseRun = v:GetRunSpeed()}
        end
        if v:KeyDown(IN_SPEED) then
            if sprintTable[v].stamina <= 0 then
                v:SetRunSpeed(v:GetWalkSpeed())
            else
                sprintTable[v].stamina = sprintTable[v].stamina - 0.5
                v:SetRunSpeed(sprintTable[v].baseRun)
            end
        else
            if sprintTable[v].stamina < 100 then
                sprintTable[v].stamina = sprintTable[v].stamina + 0.5
            end
        end
    end
end

hook.Add("Think", "stamina tracker", manageStamina)