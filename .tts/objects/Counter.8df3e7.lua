function onObjectLeaveZone()
	cityCheck()
end

function onObjectEnterZone()
	cityCheck()
end

function cityCheck()
	cityCount = 0
	for _, tile in ipairs(getObjectFromGUID("f83d45").getObjects(false)) do
		if tile.getDescription() == "Город" then
			cityCount = cityCount + 1
		end
	end
	for _, tile in ipairs(getObjectFromGUID("62b7cb").getObjects(false)) do
		if tile.getDescription() == "Город" then
			cityCount = cityCount + 1
		end
	end
	self.setValue(cityCount)
end