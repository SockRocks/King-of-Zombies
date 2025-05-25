local zedTable = util.JSONToTable(file.Read("zed_table.json", "DATA"))
local pManage = include("cl_p_manage.lua")

function displaySpawnMen()

    -- Add label to display current amount of points the zking has
    if input.IsKeyDown(KEY_C) and pManage.ZOMBIE_KING then
        if not IsValid(MyFrame) then
            MyFrame = vgui.Create("DFrame")

            MyFrame:SetTitle("Spawn Menu")
            MyFrame:SetSize(400, 300 + (#zedTable / 10) * 20)
            MyFrame:SetPos(10, 20)
            MyFrame:MakePopup()
            curPts = vgui.Create("DLabel", MyFrame)
            curPts:SetText("Points: " .. pManage.pPoints)
            curPts:SetPos(5,20)
            curPts:SetTextColor(Color(255, 255, 0))

            local curCol, curRow = 10, 40
            local count = 0

            for k, v in pairs(zedTable) do
                local price = vgui.Create("DLabel", MyFrame)
                price:SetText("Price: " .. v.price)
                price:SetPos(curCol, curRow)
                local buy = vgui.Create("DButton", MyFrame)
                buy:SetText(k)
                buy:SetPos(curCol, curRow + 20)

                buy.DoClick = function(button)
                    local pts = pManage.pPoints
                    net.Start("spawnZed")
                    net.WriteString(k)
                    net.SendToServer()
                    if v.price <= pts then
                        curPts:SetText("Points: " .. (pts - v.price))
                    end
                end
                curCol = curCol + 100
                count = count + 1
                if count % 2 == 0 then
                    count = 0
                    curRow = curRow + 80
                    curCol = 10
                end
            end
        end
    else
        if IsValid(MyFrame) then
            MyFrame:Remove()
        end
    end
end

hook.Add("Think", "OpenCustomMenuOnCHold", displaySpawnMen)