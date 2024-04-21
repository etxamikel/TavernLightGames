

function onCastSpell(creature, variant)

	-- Queue 6 events separated in time, each 500 ms separated from the last
	for i=0,5,1 do
		addEvent(ExecuteOneIteration, i*500 , creature:getId(), variant)
	end
	return TRUE
end

function ExecuteOneIteration(uid, vrt)
	--retrieve it once to use later
	local pos = Player(uid):getPosition()

	--how big the diamond shape will be
	local size = 4
	
	--Double foor loop to account for the x and the y
	for i = -size,size,1 do
		for j = -size,size,1 do
			--to ensure diamond shape x and y should add up to the size or less
			if (math.abs(i)+ math.abs(j)) <= size then 
				-- avoid creating effect on the player
				if i ~= 0 or j ~= 0 then 
					--randomness for the diamond not to fill every time
					local rand = math.random()
					if rand > 0.3 then
						--spawn effect at position
						local incrementPos = Position(i,j,0)
						local spawnPos = pos + incrementPos
						spawnPos:sendMagicEffect(CONST_ME_ICETORNADO )
					end
				end
			end
		end
	end



end


