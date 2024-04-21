--[[
    This method removes a player from another player's party

    It does an unnecessary operation iterating trough the party to check if
    one of the members is the player, but it is unnecessary because the actual
    c++ method already checks that, so our  function can be much simpler
]]
function remove_member_from_player_party(playerId, membername)
    local player = Player(playerId)
    local party = player:getParty()
    local memberToRemove = Player(membername)
    party:removeMember(memberToRemove)
end
