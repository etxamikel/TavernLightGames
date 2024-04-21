--[[
    The first problem I encountered is that in the current environment in my database there is no max_members
    for guilds, so this query would not be possible, but for the sake of the exercise, I will assume that it does exist

    The second problem is that this function, as given, only printed the name of one of the guilds meeting the condition,
    so I adapted the code to print all the guilds that met the condition

    Another problem was that there was no sanity check to check if the query had been successful and a result had been
    achieved

    Finally we should free the result since we have finished using it
]]

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))

    if resultId ~= false then
        repeat --this repeat is for printing all the guilds that the query returned
            local guildName = result.getString(resultId, "name")
            print(guildName)
        until not result.next(resultId) --until we have reached the last guild name
    end


    result.free(resultId)
end
