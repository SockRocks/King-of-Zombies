local zombieTable = {}

local zedTable = {}

function populateZTable(File)
    zedTable = util.JSONToTable(file.Read(File, "DATA"))
end

if not file.Exists("zed_table.json", "DATA") then
    local defaultZ_table = 
    {
        normal = 
        {
            class = "npc_zombie",
            price = 1
        },

        fast = 
        {
            class = "npc_fastzombie",
            price = 2
        }
    }

    local data = util.TableToJSON(defaultZ_table, true)

    file.Open("zed_table.json", "w", "DATA")
    file.Write("zed_table.json", data)
end

populateZTable("zed_table.json")
zombieTable.zedTable = zedTable

return zombieTable