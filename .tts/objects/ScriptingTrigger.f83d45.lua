function onChat(message, sender)
	if message == "!поле" then
		MapCheck()
		return false
	end
	
	if message == "!поле " then
		clearText()
		return false
	end
end


function MapCheck()
	clearText()
	
	PL = {0, 0, 0, 0, 0}  -- подсчет ПО
	for _, tile in ipairs(self.getObjects(false)) do
		hitList = Physics.cast({  -- определение маркера
			origin = tile.getPosition() + Vector(0, 1.5, 0),
			direction = {0,-0.1,0},
			max_distance = 1,
		})
		
		if #hitList > 0 then  -- определение цвета тайла
			clr = hitList[1].hit_object.getColorTint()
			PLi = nil
			if clr.b >= 0.9 then
				if clr.g >= 0.9 then
					--print("Белый!")
					PLi = 1
				else
					--print("Синий!")
					PLi = 5
				end
			elseif clr.r >= 0.9 then
				if clr.g >= 0.9 then
					--print("Желтый!")
					PLi = 3
				else
					--print("Красный!")
					PLi = 2
				end
			elseif clr.g >= 0.7 then
				--print("Зеленый!")
				PLi = 4
			end
			
			tile.highlightOn(clr, 60)
			
			if tile.getDescription() == "Город" then  -- подсчет очков города
				forests = 0
				for i = 1, 6 do					
					findList = Physics.cast({
						origin = tile.getPosition() + Vector(1.5, 0.5, 0):rotateOver('y', 60*i),
						direction = {0,-0.1,0},
						max_distance = 0.4,
					})
					if #findList > 0 then
						if findList[1].hit_object.getDescription() == "Лес" then
							forests = forests + 1
						end
					end
				end
				--print("Город +" .. forests)
				PL[PLi] = PL[PLi] + forests
				textSpawn(tile.getPosition(), forests, clr)
			elseif tile.getDescription() == "Лес" then  -- подсчет очков леса
				--print("Лес +1")
				PL[PLi] = PL[PLi] + 1
				textSpawn(tile.getPosition(), "1", clr)
			end
		end
	end



	PLm = {0, 0, 0, 0, 0}  -- подсчет маркеров
	for _, tile in ipairs(self.getObjects(true)) do
		if tile.getScale()[2] >= 0.29 and tile.getScale()[2] <= 0.36 then
			--Player["White"].pingTable(tile.getPosition())
			
			clr = tile.getColorTint()
			PLi = nil
			if clr.b >= 0.9 then
				if clr.g >= 0.9 then
					--print("Белый!")
					PLi = 1
				else
					--print("Синий!")
					PLi = 5
				end
			elseif clr.r >= 0.9 then
				if clr.g >= 0.9 then
					--print("Желтый!")
					PLi = 3
				else
					--print("Красный!")
					PLi = 2
				end
			elseif clr.g >= 0.7 then
				--print("Зеленый!")
				PLi = 4
			end
			
			PLm[PLi] = PLm[PLi] + 1
		end
	end
	
	print("")
	broadcastToAll("Подсчет поля  (ПО, маркеры)")
	if PL[1] > 0 or PLm[1] > 0 then
		broadcastToAll("Белый  -  " .. PL[1] ..",  ".. PLm[1], {1, 1, 1})
	end
	if PL[2] > 0 or PLm[2] > 0 then
		broadcastToAll("Красный  -  " .. PL[2] ..",  ".. PLm[2], {1, 0.5, 0.5})
	end
	if PL[3] > 0 or PLm[3] > 0 then
		broadcastToAll("Желтый  -  " .. PL[3] ..",  ".. PLm[3], {1, 1, 0.5})
	end
	if PL[4] > 0 or PLm[4] > 0 then
		broadcastToAll("Зеленый  -  " .. PL[4] ..",  ".. PLm[4], {0.5, 1, 0.5})
	end
	if PL[5] > 0 or PLm[5] > 0 then
		broadcastToAll("Синий  -  " .. PL[5] ..",  ".. PLm[5], {0.5, 0.5, 1})
	end
end


function textSpawn(pos, text, color)
	spawnObjectJSON({
		json = [[{
			"Name": "3DText",
			"Transform": {
				"posX": ]].. pos[1] ..[[,
				"posY": ]].. pos[2] + 1.5 ..[[,
				"posZ": ]].. pos[3] + 0.5 ..[[,
				"rotX": 90,
				"rotY": 0,
				"rotZ": 0,
			},
			"Locked": true,
			"Text": {
				"Text": "]].. tostring(text) ..[[",
				"colorstate": {
					"r": ]].. color.r ..[[,
					"g": ]].. color.g ..[[,
					"b": ]].. color.b ..[[
				},
				"fontSize": 100
			},
			"Tags": [
				"ScoreText"
			]
		}]]
	})
end

function clearText()
	for _, obj in ipairs(getObjects(true)) do
		if obj.type == "3D Text" then
			log(obj.getTags())
			if obj.hasTag("ScoreText") then
				destroyObject(obj)
			end
		end
	end
end