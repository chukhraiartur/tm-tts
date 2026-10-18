ResNames = {"Мега Кредиты", "Сталь", "Титан", "Растения", "Энергия", "Тепло"}

function Generate()
	local Counts = Get()
	
	local Counters = {}
	for _, obj in ipairs(self.getObjects()) do
		if obj.getScale()[1] > 0.26 then
			if isInArray(ResNames, obj.getName()) then
				Counters[obj.getName()] = obj
			end
		end
	end
	
	Counters["Мега Кредиты"].setVar("count", RT + Counts["Мега Кредиты"].c + Counts["Мега Кредиты"].p)
	Counters["Сталь"].setVar("count", Counts["Сталь"].c + Counts["Сталь"].p)
	Counters["Титан"].setVar("count", Counts["Титан"].c + Counts["Титан"].p)
	Counters["Растения"].setVar("count", Counts["Растения"].c + Counts["Растения"].p)
	Counters["Энергия"].setVar("count", Counts["Энергия"].p)
	Counters["Тепло"].setVar("count", Counts["Тепло"].c + Counts["Энергия"].c + Counts["Тепло"].p)
	for _, res in ipairs(ResNames) do
		Counters[res].call("updateDisplay")
	end
end

function ResNamesAdd(array)  --name, add
	for _, obj in ipairs(self.getObjects()) do
		if obj.getName() == array.name and obj.getScale()[1] > 0.26 then
			if obj.getVar("count") + array.add >= 0 then
				obj.setVar("count", obj.getVar("count") + array.add)
				obj.call("updateDisplay")
				return true
			else
				return false
			end
		end
	end
end
function ProdAdd(array)  --name, add
	if array.log == true then log(array) end
	PLListSet()
	
	local cubes = {}
	for _, obj in ipairs(self.getObjects()) do  -- определение кубиков
		if obj.getName() == array.name then
			if obj.getScale()[1] <= 0.26 and obj.getScale()[1] >= 0.24 then
				for __, point in ipairs(Points) do
					if Vector.equals(obj.getPosition():setAt(2,0), Points.obj.getPosition():setAt(2,0) + point.position, 0.2) then
						local prefix = point.tags[1]:sub(1, 1)
						local number = tonumber(point.tags[1]:sub(2))
						if prefix == 'm' then
							number = -number
						end
						table.insert(cubes, {obj, number})
					end
				end
			end
		elseif obj.getDescription() == array.name then
			cubeBag = obj
		end
	end
	--log(cubes)
	
	summ = 0
	for _, cube in ipairs(cubes) do
		summ = summ + cube[2] 
	end
		
	if summ + array.add >= 0 or array.name == "Мега Кредиты" then
		if #cubes > 0 then
			minCube = {nil, 99}  -- нахождение минимального кубика
			for _, cube in ipairs(cubes) do
				if math.abs(cube[2]) < math.abs(minCube[2]) then
					minCube = cube
				end
			end
			--Player.White.pingTable(minCube[1].getPosition())
			
			if array.add > 0 then
				for i = 1, array.add do  -- увеличение
					if minCube[2] == 5 then  -- перемещение 5->6
						if array.log == true then log("!1") end
						minCube[1].setPosition(minCube[1].getPosition() + Vector(2.2, 0, 0.55):rotateOver('y', PlList.getRotation()[2]))
						minCube[2] = minCube[2] + 1
						
					elseif minCube[2] == 9 then  -- перемещение 9->10
						if array.log == true then log("!2") end
						hitList = Physics.cast({
							origin = minCube[1].getPosition() + Vector(-0.55, 10, 0):rotateOver('y', PlList.getRotation()[2]),
							direction = {0, -0.4, 0},
							max_distance = 11,
						})
						minCube[1].setPosition(hitList[1].point + Vector(0, 0.2, 0))
						minCube[2] = minCube[2] + 1
						
					elseif minCube[2] == -1 then  -- перемещение -1 -> 0
						if array.log == true then log("!3 ".. minCube[2] .." ".. i) end
						minCube[1].setPosition(minCube[1].getPosition() + Vector(2.75, 0.1, 0.55):rotateOver('y', PlList.getRotation()[2]))
						if array.add > 0 then
							Wait.time(function()
								ProdAdd({name = array.name, add = array.add-i})
							end, 0.2)
						end
						break
						
					elseif minCube[2] < 10 then  -- обычное перемещение
						if array.log == true then log("!4") end
						minCube[1].setPosition(minCube[1].getPosition() + Vector(-0.55, 0, 0):rotateOver('y', PlList.getRotation()[2]))
						minCube[2] = minCube[2] + 1
						
					else  -- добавление кубика
						if array.log == true then log("!5") end
						cubeBag.takeObject({position = cubeBag.getPosition() + Vector(-0.55, 0.5, 0):rotateOver('y', PlList.getRotation()[2]), smooth = false})
						if array.add - i > 0 then
							Wait.time(function()
								ProdAdd({name = array.name, add = array.add - i})
							end, 0.1)
						end
						break
					end
				end
			else
				for i = array.add, -1 do  -- уменьшение
					if minCube[2] == 6 then  -- перемещение 6->5
						if array.log == true then log("!-1") end
						minCube[1].setPosition(minCube[1].getPosition() + Vector(-2.2, 0, -0.55):rotateOver('y', PlList.getRotation()[2]))
						minCube[2] = minCube[2] - 1
						
					elseif minCube[2] == 1 then  -- перемещение 1->0
						if array.log == true then log("!-2") end
						minCube[1].setPosition(minCube[1].getPosition() + Vector(0.55, 0.1, 0):rotateOver('y', PlList.getRotation()[2]))
						if array.add < 0 and i < -1 then
							Wait.time(function()
								ProdAdd({name = array.name, add = i+1})
							end, 0.2)
						end
						break
						
					elseif minCube[2] > 0 then  -- обычное перемещение
						if array.log == true then log("!-3") end
						minCube[1].setPosition(minCube[1].getPosition() + Vector(0.55, 0, 0):rotateOver('y', PlList.getRotation()[2]))
						minCube[2] = minCube[2] - 1
						
					elseif array.name == "Мега Кредиты" then  -- перемещение отрицательного кубика МК
						if minCube[2] > -4 then  -- обычное перемещение
						if array.log == true then log("!-4") end
							minCube[1].setPosition(minCube[1].getPosition() + Vector(0.55, 0, 0):rotateOver('y', PlList.getRotation()[2]))
							minCube[2] = minCube[2] - 1
							
						elseif minCube[2] == -4 then  -- перемещение -4 -> -5 
						if array.log == true then log("!-5 ".. minCube[2] .." ".. array.add) end
							hitList = Physics.cast({
								origin = minCube[1].getPosition() + Vector(0.55, 10, 0):rotateOver('y', PlList.getRotation()[2]),
								direction = {0, -0.4, 0},
								max_distance = 11,
							})
							minCube[1].setPosition(hitList[1].point + Vector(0, 0.2, 0))
							minCube[2] = minCube[2] - 1
							
						elseif minCube[2] == -5 then  -- добавление кубика -5 -> -6
							if array.log == true then log("!-6 ".. minCube[2] .." ".. array.add) end
							cubeBag.takeObject({position = cubeBag.getPosition() + Vector(-2.75, 0.5, -0.55):rotateOver('y', PlList.getRotation()[2]), smooth = false})
							Wait.time(function()
								ProdAdd({name = array.name, add = i+1})
							end, 0.1)
							break
						end
					end
				end
			end
		else
			if array.add > 0 then  -- добавление кубика 0 -> 1
				if array.log == true then log("!6") end
				cubeBag.takeObject({position = cubeBag.getPosition() + Vector(-0.55, 0.5, 0):rotateOver('y', PlList.getRotation()[2]), smooth = false})
				Wait.time(function()
					ProdAdd({name = array.name, add = array.add - 1})
				end, 0.1)
				
			elseif array.add < 0 and  array.name == "Мега Кредиты" then  -- добавление кубика 0 -> -1 для МК
				if array.log == true then log("!-7") end
				cubeBag.takeObject({position = cubeBag.getPosition() + Vector(-2.75, 0.5, -0.55):rotateOver('y', PlList.getRotation()[2]), smooth = false})
				Wait.time(function()
					ProdAdd({name = array.name, add = array.add + 1})
				end, 0.1)
			end
		end
		
		if summ + array.add >= 0 then
			return true
		elseif array.name == "Мега Кредиты" then
			return true
		end
	else
		return false
	end
end

function RTclick(obj, color, alt_click)
	if alt_click then
		RT = math.max(0, RT - 1)
	else
		RT = RT + 1
	end
	RTupd()
end
function RTupd()
	self.editButton({index=Button.RT, tooltip="Рейтинг терраформирования: ".. tostring(RT)})
	self.editButton({index=Button.RTLabel, label=RT})
	
	local token = {White = "ecaa6c", Red = "943859", Yellow = "7ddd14", Green = "8a0903", Blue = "a140d8"}
	if getObjectFromGUID(token[PLcolor]) then
		getObjectFromGUID(token[PLcolor]).setDescription(RT)
	end
end
function heat(obj, color, alt_click)
    if color == PLcolor then
		if not alt_click then
			if Get()["Тепло"].c >= heatCost then
				Player[color].showConfirmDialog("Повысить тепло?", function()
					getObjectFromGUID("c9adc5").call("heat", color)
					ResNamesAdd({name="Тепло", add=-heatCost})
				end)
			end
		else
			Player[color].showInputDialog("Сколько это должно стоить?", heatCost, function(a)
				heatCost = tonumber(a)
				self.editButton({index=Button.Heat, tooltip="Действие: повысить температуру за " ..heatCost.. " тепла\n[i](ПКМ: изменить цену повышения)[/i]"})
				self.editButton({index=Button.HeatLabel, label=heatCost})
			end)
		end
	else
		printToColor("Это не твой планшет!", color, {1, 0, 0})
	end
end
function plant(obj, color, alt_click)
    if color == PLcolor then
		if not alt_click then
			if Get()["Растения"].c >= plantCost then
				Player[color].showConfirmDialog("Произвести озеленение?", function()
					getObjectFromGUID("e4c505").takeObject({position=self.getPosition()+Vector(-4.5, 0.5, -3.5):rotateOver('y', self.getRotation()[2]), rotation={0, 270, 0},  smooth=false, callback_function=function(tile)
						-- маркер берется, когда тайл уже появился, и падает на него сверху
						getObjectFromGUID(Global.getVar("PLData").colorMarkerBag[color]).takeObject({position=tile.getPosition()+Vector(0, 1.5, 0), rotation={0, 270, 0},  smooth=false})
					end}).addToPlayerSelection(color)
					getObjectFromGUID("4fdd36").call("breath", color)
					ResNamesAdd({name="Растения", add=-plantCost})
					printToAll(color .." проводит озеленение!")
				end)
			end
		else
			Player[color].showInputDialog("Сколько это должно стоить?", plantCost, function(a)
				plantCost = tonumber(a)
				self.editButton({index=Button.Plant, tooltip="Действие: выложить озеленение за " ..plantCost.. " растений\n[i](ПКМ: изменить цену озеленения)[/i]"})
				self.editButton({index=Button.PlantLabel, label=plantCost})
			end)
		end
	else
		printToColor("Это не твой планшет!", color, {1, 0, 0})
	end
end
function steelCost(obj, color, alt_click)
    if color == PLcolor then
		if alt_click then
			Player[color].showInputDialog("Сколько это должно стоить?", steel, function(a)
				steel = tonumber(a)
				self.editButton({index=Button.Steel, label=steel})
			end)
		end
	end
end
function titanCost(obj, color, alt_click)
    if color == PLcolor then
		if alt_click then
			Player[color].showInputDialog("Сколько это должно стоить?", titan, function(a)
				titan = tonumber(a)
				self.editButton({index=Button.Titan, label=titan})
			end)
		end
	end
end

function Get()
	PLResNames = {}
	PLListSet()
	
	for _, res in ipairs(ResNames) do
		score = 0
		for __, obj in ipairs(self.getObjects()) do
			if obj.getName() == res then
				if obj.getScale()[1] <= 0.26 and obj.getScale()[1] >= 0.24 then
					for ___, point in ipairs(Points) do
						if Vector.equals(obj.getPosition():setAt(2,0), Points.obj.getPosition():setAt(2,0) + point.position, 0.1) then
							local prefix = point.tags[1]:sub(1, 1)
							local number = tonumber(point.tags[1]:sub(2))
							if prefix == 'm' then
								score = score - number
							elseif prefix == 'p' then
								score = score + number
							end
							--Player["White"].pingTable(Points.obj.getPosition() + point.position)
						end
					end
				else
					--obj.highlightOn({1,1,1}, 3)
					counter = obj
				end
			end
		end
		
		PLResNames[res] = {}
		PLResNames[res].c = counter.getVar("count")
		PLResNames[res].p = score
	end
	
	return PLResNames
end
function onLoad(saved_data)
	PLcolor = self.getDescription()
	if not (saved_data == nil or saved_data == "[]" or saved_data == "") then
		saved_data = JSON.decode(saved_data)
		
		RT = saved_data.RT
		plantCost = saved_data.plantCost
		heatCost = saved_data.heatCost
		steel = saved_data.steel
		titan = saved_data.titan
	else
		RT = 0
		plantCost = 8
		heatCost = 8
		steel = 2
		titan = 3
	end

	self.clearButtons()
	Button = {}
	Button.RT = 0			self.createButton({
		click_function = "RTclick",
		function_owner = self,
		position = {0.41, 0.04, 0.07},
		rotation = {0, 180, 0},
		scale = {.035, .035, .035},
		width = 1000,
		height = 1000,
		color = {0, 0, 0, 0},
		tooltip = "Рейтинг терраформирования: ".. RT
	})
	Button.RTLabel = 1		self.createButton({
		click_function = "nothing",
		function_owner = self,
		label = RT,
		font_size = 600,
		font_color = {1, 1, 1},
		position = {0.41, 0.04, 0.07},
		rotation = {0, 180, 0},
		scale = {.035, .035, .035},
		width = 0,
		height = 0,
		color = {0, 0, 0}
	})
	Button.Heat = 2			self.createButton({
		click_function = "heat",
		function_owner = self,
		position = {-0.325, 0.04, -0.32},
		rotation = {0, 180, 0},
		scale = {.9, .9, .9},
		width = 70,
		height = 100,
		color = {0, 0, 0, 0},
		tooltip = "Действие: повысить температуру за " ..heatCost.. " тепла\n[i](ПКМ: изменить цену повышения)[/i]"
	})
	Button.HeatLabel = 3	self.createButton({
		click_function = "nothing",
		function_owner = self,
		label = heatCost,
		font_size = 1000,
		font_color = {0, 0, 0},
		position = {-0.200, 0.04, -0.385},
		rotation = {0, 180, 0},
		scale = {.035, .035, .035},
		width = 300,
		height = 700,
		color = {0.41, 0.35, 0.33}
	})
	Button.Plant = 4		self.createButton({
		click_function = "plant",
		function_owner = self,
		position = {0.31, 0.04, -0.32},
		rotation = {0, 180, 0},
		scale = {.9, .9, .9},
		width = 70,
		height = 100,
		color = {0, 0, 0, 0},
		tooltip = "Действие: выложить озеленение за " ..plantCost.. " растений\n[i](ПКМ: изменить цену озеленения)[/i]"
	})
	Button.PlantLabel = 5	self.createButton({
		click_function = "nothing",
		function_owner = self,
		label = plantCost,
		font_size = 1000,
		font_color = {0, 0, 0},
		position = {0.435, 0.04, -0.385},
		rotation = {0, 180, 0},
		scale = {.035, .035, .035},
		width = 300,
		height = 700,
		color = {0.72, 0.58, 0.46}
	})
	Button.Steel = 6		self.createButton({
		click_function = "steelCost",
		function_owner = self,
		label = steel,
		font_size = 1000,
		font_color = {0, 0, 0},
		position = {-0.157, 0.04, 0.218},
		rotation = {0, 180, 0},
		scale = {.03, .03, .03},
		width = 300,
		height = 700,
		color = {0.83, 0.8, 0.11},
		tooltip = "[i](ПКМ: изменить цену стали)[/i]"
	})
	Button.Titan = 7		self.createButton({
		click_function = "titanCost",
		function_owner = self,
		label = titan,
		font_size = 1000,
		font_color = {0, 0, 0},
		position = {-0.43, 0.04, 0.218},
		rotation = {0, 180, 0},
		scale = {.03, .03, .03},
		width = 300,
		height = 700,
		color = {0.83, 0.8, 0.11},
		tooltip = "[i](ПКМ: изменить цену титана)[/i]"
	})
end
function nothing() end
function onSave()  -- система сохранения
	local state = {}
	state.RT = RT
	state.plantCost = plantCost
	state.heatCost = heatCost
	state.steel = steel
	state.titan = titan
	
	return JSON.encode(state)
end


function PLListSet()
	for _, obj in ipairs(self.getObjects()) do
		if obj.hasTag("PlList") then
			PlList = obj
			Points = obj.getSnapPoints()
			for __, point in ipairs(Points) do
				point.position:scale(5.46):rotateOver('y', obj.getRotation()[2]):setAt(2,0)
			end
			Points.obj = obj
			break
		end
	end
end
function ProdAddTest(array)  --name, add
	local oldP = Get()[array.name].p
	local rtn = ProdAdd(array)
	log("> Проверка: ".. oldP .." + ".. array.add .." = ".. oldP + array.add)
	
	Wait.time(function()
		if Get()[array.name].p ~= oldP + array.add then
			log("Что-то пошло не так!")
			log("Ожидалось: ".. oldP+array.add ..", получилось: ".. Get()[array.name].p)
		else
			log("Удача!")
			if array.debug == true then
				Wait.time(function()
					ProdAddTest({name= "Мега Кредиты", add= math.random(-10,10)-math.ceil(oldP*0.5), debug = true})
				end, 0.5)
			end
		end
	end, 1)
	
	return rtn
end
function isInArray(array, value)  -- поиск значения в массиве
	local find = false
	for _, v in pairs(array) do
		if v == value then
			find = true
			break
		end
	end
	return find
end