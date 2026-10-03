function onLoad()
	holdOcean = #self.getObjects()
	if self.getButtons() then
		self.removeButton(1)
	end
	
	self.createButton({
		click_function = " ",
		function_owner = self,
		label = 9 - #self.getObjects() .." / 9",
		position = {0, 0.1, 0},
		rotation = {0, -90, 0},
		width = 0,
		height = 0,
		font_size = 500,
		font_color = {0.27, 0.77, 0.67},
	})
end

function onObjectLeaveContainer(container, object)
	holdOcean = countOceans()
	if self == container then
		self.editButton({
			index = 0,
			label = 9 - countOceans() .." / 9",
		})
	end
	
	for _, player in pairs(Player.getPlayers()) do  -- нахождение игрока вытащевшего океан
		Wait.time(function()
			if player.getHoldingObjects() then
				for __, obj in pairs(player.getHoldingObjects()) do
					if obj == object and object.getDescription() == "Океан" then
						getObjectFromGUID(Global.getVar("PLData").resLists[player.color]).setVar("RT", getObjectFromGUID(Global.getVar("PLData").resLists[player.color]).getVar("RT") + 1)
						getObjectFromGUID(Global.getVar("PLData").resLists[player.color]).call("RTupd")
						
						printToAll(Player[player.color].steam_name .. " выкладывает океан",{0, 1, 0})
					end
				end
			end
		end, 0.1)
	end
end

function onObjectEnterContainer(container, object)
	holdOcean = countOceans()
	if self == container then
		self.editButton({
			index = 0,
			label = 9 - countOceans() .." / 9",
		})
	end
end

function countOceans()
	local count = 0
	for _, obj in ipairs(self.getObjects()) do
		if obj.description == "Океан" then
			count = count + 1
		end
	end
	return count
end