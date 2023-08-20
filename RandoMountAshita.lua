--RandoMount by Harissa and Hammoncheese!
--Special Ashita Version! January 11, 2023
--Original created June 1, 2022
_addon.author   = 'Harissa';
_addon.name     = 'randomount';
_addon.version  = '1.0.0';

MountList = require('mounts')

function initialize_myMounts()
    
    math.randomseed(os.time())

end

-- Define a function to pick a random mount and summon it
function SummonRandomMount()
    -- Initialize an empty table to store the player's mounts
    local mounts = {}

    for _, key_item in pairs(MountList) do
        if AshitaCore:GetDataManager():GetPlayer():HasKeyItem(key_item.id) then
            table.insert(mounts, key_item.id)
        end
    end

    -- Check if the player has any mounts
    if (#mounts > 0) then
        -- Select a random mount from the table
        local mountIndex = math.random(1, #mounts)
        local mountId = mounts[mountIndex]

        -- Summon the mount
       local s = filter_name(MountList[mountId].en)
        AshitaCore:GetChatManager():QueueCommand('/mount "'..s..'"', 1)
    else
        -- Notify the player that they have no mounts
        print("You have no mounts.")
    end
end

function filter_name(name)
    local s, _ = string.gsub(name, ' companion', '')
    s, _ = string.gsub(s, ' whistle', '')
    s, _ = string.gsub(s, ' key', '')
    s, _ = string.gsub(s, '♪', '')
    return s
end

ashita.register_event('load', initialize_myMounts)

-- Register a command to summon a random mount
ashita.register_event("command", function(cmd, ntype)
    if cmd == "/randomount" or cmd == "/rmount" then
        SummonRandomMount()
        return true 
    end
    return false
end )

