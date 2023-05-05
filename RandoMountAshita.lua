--RandoMount by Harissa and Hammoncheese!
--Special Ashita Version! January 11, 2023
--Original created June 1, 2022
_addon.author   = 'Harissa';
_addon.name     = 'randomount';
_addon.version  = '0.0.0';

-- Define a function to pick a random mount and summon it
function SummonRandomMount()
    -- Initialize an empty table to store the player's mounts
    local mounts = {}

    -- TODO: This is what FindAll uses
    local inventory = AshitaCore:GetDataManager():GetInventory();
    local resources = AshitaCore:GetResourceManager();

    -- Iterate through all the key items the player has
    for i = 0, numKeyItems - 1 do
        -- Check if the key item is a mount
        -- TODO: We don't know if these hex values are correct
        if (keyItems[i] >= 0x7E9 and keyItems[i] <= 0x803) then
            -- Add the mount to the table
            table.insert(mounts, keyItems[i])
        end
    end

    -- Check if the player has any mounts
    if (#mounts > 0) then
        -- Select a random mount from the table
        -- TODO: This is the correct random function, but we forgot to seed
        local mountIndex = math.random(1, #mounts)
        local mountId = mounts[mountIndex]

        -- Summon the mount
        AshitaCore:GetChatModule():SendCommand('/mount '..mountId, 1)
    else
        -- Notify the player that they have no mounts
        print("You have no mounts.")
    end
end

-- Register a command to summon a random mount
ashita.register_event("command", function(cmd, ntype)
    if cmd == "/randomount" or cmd == "/rmount" then
        SummonRandomMount()
        return true 
    end
    return false
end )

