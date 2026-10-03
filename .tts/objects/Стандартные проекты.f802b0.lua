buttons = {
	{"Продажа патентов\n\nПродать карты проектов в малой руке по 1 M€ за каждую", "sellCard"},
	{"Электростанция   (11 M€)\n\nПовысить производство энергии", "power"},
	{"Астероид   (14 M€)\n\nПовысить температуру", "asteroid"},
	{"Водоносный пласт   (18 M€)\n\nВыложить океан", "ocean"},
	{"Озеленение   (23 M€)\n\nВыложить озеленение", "plant"},
	{"Город   (25 M€)\n\nВыложить город", "city"}
}

function onLoad()
	self.clearButtons()
	
	for i, data in ipairs(buttons) do
		addButton(i, data[1], data[2])
	end
end
function addButton(i, tooltip, func)
	self.createButton({
		click_function = func,
		function_owner = self,
		position = {0, 0.5, i*1.15},
		scale = {4, 1, 4},
		width = 600,
		height = 100,
		color = {0, 0, 0, 0.8},
		tooltip = tooltip,
	})
end

function sellCard(obj, player_color)
	for _, obj in pairs(Player[player_color].getHandObjects()) do
		if obj.type == "Card" then
			for __, data in pairs(obj.getData().CustomDeck) do
				if data.BackURL == "https://steamusercontent-a.akamaihd.net/ugc/99472719161571100/EA0122B9E00F0FB9069FC2C275D83C63D1D5BA3E/" then
					obj.setPosition({-21.27, 3, -10.76})
					obj.setRotation({0.00, 180.00, 180.00})
				end
			end
		end
	end
	getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("ResNamesAdd", {name = "Мега Кредиты", add = #Player[player_color].getHandObjects()})
end
function power(obj, player_color)
	if getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("Get")["Мега Кредиты"].c >= 11 then
		Player[player_color].showConfirmDialog("Повысить производство энергии за 11 M€?",
			function (player_color)
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("ResNamesAdd", {name = "Мега Кредиты", add = -11})
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("ProdAdd", {name = "Энергия", add = 1})
				printToAll(player_color .." строит электростанцию!")
			end
		)
	end
end
function asteroid(obj, player_color)
	if getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("Get")["Мега Кредиты"].c >= 14 then
		Player[player_color].showConfirmDialog("Повысить температуру за 14 M€?",
			function (player_color)
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("ResNamesAdd", {name = "Мега Кредиты", add = -14})
				getObjectFromGUID("c9adc5").call("heat", player_color)
			end
		)
	end
end
function ocean(obj, player_color)
	if getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("Get")["Мега Кредиты"].c >= 18 then
		Player[player_color].showConfirmDialog("Выложить океан за 18 M€?",
			function (player_color)
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("ResNamesAdd", {name = "Мега Кредиты", add = -18})
				getObjectFromGUID("d6af9e").takeObject({position = {-13.00, 2.00, -5.50}})
				broadcastToAll(player_color .." выкладывает океан!")
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).setVar("RT", getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).getVar("RT") + 1)
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("RTupd")
			end
		)
	end
end
function plant(obj, player_color)
	if getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("Get")["Мега Кредиты"].c >= 23 then
		Player[player_color].showConfirmDialog("Выложить озеленение за 23 M€?",
			function (player_color)
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("ResNamesAdd", {name = "Мега Кредиты", add = -23})
				getObjectFromGUID("e4c505").takeObject({position = {-13.00, 2.00, -6.50}, rotation={0, 270, 0}})
				broadcastToAll(player_color .." выкладывает озеленение!")
				getObjectFromGUID(Global.getVar("PLData").colorMarkerBag[player_color]).takeObject({position={-13.00, 2.00, -6.50}, rotation={0, 270, 0}})
				getObjectFromGUID("4fdd36").call("breath", player_color)
			end
		)
	end
end
function city(obj, player_color)
	if getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("Get")["Мега Кредиты"].c >= 25 then
		Player[player_color].showConfirmDialog("Выложить город за 25 M€?",
			function (player_color)
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("ResNamesAdd", {name = "Мега Кредиты", add = -25})
				getObjectFromGUID(Global.getVar("PLData").resLists[player_color]).call("ProdAdd", {name = "Мега Кредиты", add = 1})
				getObjectFromGUID("f38446").takeObject({position = {-13.00, 2.00, -7.50}, rotation={0, 270, 0}})
				getObjectFromGUID(Global.getVar("PLData").cityMarkerBag[player_color]).takeObject({position={-13.00, 2.20, -7.50}, rotation={0, 270, 0}})
				broadcastToAll(player_color .." выкладывает город!")
			end
		)
	end
end