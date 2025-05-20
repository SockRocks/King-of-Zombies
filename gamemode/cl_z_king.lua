local zedTable = {}
IS_ZKING = false -- remember to make function to receive a class update from the server so this variable is updated

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

function displaySpawnMen()
    if input.IsKeyDown(KEY_C) and IS_ZKING then
        if not IsValid(MyFrame) then
            MyFrame = vgui.Create("DFrame")

            MyFrame:SetTitle("Spawn Menu")
            MyFrame:SetSize(400, 300 + (#zedTable / 10) * 20)
            MyFrame:SetPos(10, 20)
            MyFrame:MakePopup()

            local curCol, curRow = 10, 20
            local count = 0

            for k, v in pairs(zedTable) do
                local price = vgui.Create("DLabel", MyFrame)
                price:SetText("Price: " .. v.price)
                price:SetPos(curCol, curRow)
                local buy = vgui.Create("DButton", MyFrame)
                buy:SetText(k)
                buy:SetPos(curCol, curRow + 20)

                buy.DoClick = function(button)
                    net.Start("spawnZed")
                    net.WriteString(k)
                    net.SendToServer()
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