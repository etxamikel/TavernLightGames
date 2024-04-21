

--[[
    The first thing I changed was that there was no need to perform the 
    storage release as an event 1 second after the logout, it could be done
    instantly.

    Secondly, if I understood correctly, releasing the storage should work with a key
    not arbitrarly removing the storage with id 1000 so I added a second parameter key
    to the function releaseStorage to specify which slot to release
]]

local function releaseStorage(player, key)
    player:setStorageValue(key, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        releaseStorage(player, 1000)
    end
    return true
end
