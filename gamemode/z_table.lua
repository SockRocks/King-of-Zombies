local zombieTable = {}

local zedTable = {}

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
end

populateZTable()
zombieTable.zedTable = zedTable

return zombieTable