-- Счетчик городов
-- ONLY_MARS = false: все города на столе (Марс, Ганимед, Фобос, Венера, Столица)
-- ONLY_MARS = true:  только города на поверхности Марса
ONLY_MARS = false

-- диск Марса на поле (мировые X/Z); Ганимед и Фобос лежат дальше радиуса
MARS_CENTER = {x = 0.85, z = 0.29}
MARS_RADIUS = 11.5

local checkPending = false

function onLoad()
	scheduleCityCheck()
end

function onObjectDrop(player_color, obj)
	if isCity(obj) then scheduleCityCheck() end
end

function onObjectDestroy(obj)
	if isCity(obj) then scheduleCityCheck() end
end

function onObjectEnterContainer(container, obj)
	if isCity(obj) then scheduleCityCheck() end
end

function scheduleCityCheck()  -- пересчет с задержкой, пока тайл не уляжется
	if checkPending then return end
	checkPending = true
	Wait.time(function()
		checkPending = false
		cityCheck()
	end, 1)
end

function cityCheck()
	local cityCount = 0
	for _, obj in ipairs(getObjects()) do
		if isCity(obj) and (not ONLY_MARS or isOnMars(obj)) then
			cityCount = cityCount + 1
		end
	end
	self.setValue(cityCount)
end

function isCity(obj)  -- обычные тайлы городов и Столица имеют описание "Город"
	return obj.getDescription() == "Город"
end

function isOnMars(obj)
	local pos = obj.getPosition()
	local dx, dz = pos.x - MARS_CENTER.x, pos.z - MARS_CENTER.z
	return dx * dx + dz * dz <= MARS_RADIUS * MARS_RADIUS
end
