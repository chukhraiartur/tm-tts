function onObjectLeaveContainer(container, object)
	for _, player in pairs(Player.getPlayers()) do  -- нахождение игрока вытащевшего океан
		Wait.time(function()
			if player.getHoldingObjects() then
				for __, obj in pairs(player.getHoldingObjects()) do
					if obj == object and object.getDescription() == "Лес" and getObjectFromGUID("4fdd36").getVar("index") > 1 then
						getObjectFromGUID("4fdd36").call("breath", player.color)
					end
				end
			end
		end, 0.1)
	end
end