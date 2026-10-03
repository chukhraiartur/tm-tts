function onPickUp(player_color)
	if player_color != "Black" then
		broadcastToColor("Это чужой маркер!", player_color, {2,0,0})
		self.setDescription(Global.getVar("generation"))
	end
end

Pos1 = {-16.94, 7, -13.90}
Pos2 = {-16.94, 7, 15.11}
Pos3 = {17.46, 7, 15.08}
Pos4 = {17.41, 7, -13.92}

function onUpdate()
	if tonumber(self.getDescription()) then
		num = tonumber(self.getDescription())%100
		num2 = num%25/25
		self.setDescription("")
		
		if num >= 0 and num < 25 then
			pos = lerp(Pos1, Pos2, num2)
		elseif num >= 25 and num < 50 then
			pos = lerp(Pos2, Pos3, num2)
		elseif num >= 50 and num < 75 then
			pos = lerp(Pos3, Pos4, num2)
		elseif num >= 75 and num < 100 then
			pos = lerp(Pos4, Pos1, num2)
		end
		
		hitList = Physics.cast({
			origin = pos,
			direction = {0, -1, 0},
			max_distance = 7,
		})
		
		self.setPositionSmooth(hitList[1].point + Vector(0, 0.5, 0))
		self.setRotationSmooth({0, 0, 0})
	end
end

function lerp(a, b, t)
	out = {}
	for i = 1, 3 do
		out[i] = a[i] + (b[i]-a[i]) * t
	end
	return out
end

