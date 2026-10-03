--[[
TODO
!автоматизация торговли с колониями
!автовыкладывание нейтральных делегатов
!переделать делегатов как в правилах
!перенести счетчики показателей в глобальный скрипт

!подключить генератор полей
^^венера 2+
^^луна+
^^меркурий-
^^эпилог+
^бетермент++
^идес++
^роб антиллес++
^солярис++
^ядерный удар++
^повестка дня+
^"аукцион" проектов?

улучшения
*добавить описания партий
*сортировка порядка тайлов
*генерировать названия на карте (для генератора карт)
*логировать все
*^	политику, колонии, параметры, карты
*во время драфта рисовать стрелку направления драфта на верхней руке
*вывод прогресса драфта в панель готовности
*"ушки" в стопке океанов вместо жетонов

баги
#обновление UI при возобновлении игры
+#перещитывать политику при загрузке

#"техники борьбы с опустыниванием" не переведена (pathfinders_prolog)
#неправильный текст на Bio-Sol (pathfinders_corp)
#неправильный текст на Odyssey (pathfinders_corp)
#неправильный текст на Polaris (pathfinders_corp)
#на Utopia нет M€ (crisis_corp)
#хакеры - машинный перевод (underworld_proj)
]]
--[[
+База
+Эра корпораций
+Пролог
+Венера
+Колонии
+Кризис

+Первооткрыватели
+Арес
+Подземный мир
+Спонсорство
Меркурий vs Марс
Эпилог
Венера 2.0
Луна
Высокая орбита

Бетермент
Идес
Роб Антиллес
Солярис
Ядерный удар
]]
--[[
getObjectFromGUID()
67a37b
objs.politicTile = getObjectFromGUID("174043")
objs.eventTile = getObjectFromGUID("debba0")
Wait.time(function()
end, 1)
]]

STEP = -1
objs = {}
deckPos = {
	project = {{-21.29, 1.46, 11.62}, {0.00, 180.00, 180.00}},
	corporation = {{-58.00, 2.00, 19.00}, {0.00, 180.00, 180.00}},
	prolog = {{-58.00, 2.00, 23.00}, {0.00, 180.00, 180.00}},
	event = {{-58.00, 2.00, 27.00}, {0.00, 90.00, 180.00}},
	milstone = {{-58.0, 2.00, 31.00}, {0.00, 90.00, 180.00}},
	award = {{-56.00, 2.00, 31.00}, {0.00, 90.00, 180.00}},
	sponsor = {{-60.00, 2.00, 31.00}, {0.00, 90.00, 180.00}}
}
DLCBoxCard = {
	base = {guid = "e660e5", content = {  -- база
		{name = "Колода проектов", pos = deckPos.project},
		{name = "Колода корпораций", pos = deckPos.corporation},
		{name = "Стопка достижений", pos = deckPos.milstone},
		{name = "Стопка наград", pos = deckPos.award},
		{name = "Жетоны спонсорства", pos = deckPos.sponsor}
	}},
	eraCorp = {guid = "637217", content = {  -- эра корпораций
		{name = 'Проекты "Эра корпораций"', pos = deckPos.project},
		{name = 'Корпорации "Эра корпораций"', pos = deckPos.corporation},
		{name = "Промо карты", pos = deckPos.project}
	}},
	prologe = {guid = "f75867", content = {  -- пролог
		{name = 'Проекты "Пролог"', pos = deckPos.project},
		{name = 'Корпорации "Пролог"', pos = deckPos.corporation},
		{name = 'Прологи "Пролог"', pos = deckPos.prolog},
		{name = "Подборщики партнеров по покупке", pos = deckPos.sponsor}
	}},
	venus = {guid = "3340b2", content = {  -- венера
		{name = 'Проекты "Венера"', pos = deckPos.project},
		{name = 'Корпорации "Венера"', pos = deckPos.corporation},
		{name = "Авиатор", pos = deckPos.milstone},
		{name = "Венерианец", pos = deckPos.award},
		{name = "Венерианские Гига-Буры", pos = deckPos.sponsor}
	}},
	colony = {guid = "9a3d5a", content = {  -- колонии
		{name = 'Проекты "Колонии"', pos = deckPos.project},
		{name = 'Корпорации "Колонии"', pos = deckPos.corporation},
		{name = 'Жетоны спонсорства "Колонии"', pos = deckPos.sponsor},
		{name = 'Пионер', pos = deckPos.milstone}
	}},
	crisis = {guid = "9f688b", content = {  -- кризис
		{name = 'Проекты "Кризис"', pos = deckPos.project},
		{name = 'Корпорации "Кризис"', pos = deckPos.corporation},
		{name = 'События "Кризис"', pos = deckPos.event},
		{name = "Политик", pos = deckPos.milstone},
		{name = 'Жетоны спонсорства "Кризис"', pos = deckPos.sponsor}
	}},
	pathfinders = {guid = "4c6c45", content = {  -- первооткрыватели
		{name = 'Проекты "Первооткрыватели"', pos = deckPos.project},
		{name = 'Корпорации "Первооткрыватели"', pos = deckPos.corporation},
		{name = 'Прологи "Первооткрыватели"', pos = deckPos.prolog},
		{name = 'События "Первооткрыватели"', pos = deckPos.event}
	}},
	ares = {guid = "7acbfe", content = {  -- арес
		{name = 'Проекты "Арес"', pos = deckPos.project},
		{name = 'Усиление пылевых бурь', pos = {{-2.57, 1.06, 13.29}, {0.00, 165.00, 0.00}}},
		{name = 'Усиление эрозии', pos = {{13.42, 1.06, 4.95}, {0.00, 180.00, 0.00}}}
	}},
	underworld = {guid = "0e8d4c", content = {  -- подземный мир
		{name = 'Проекты "Подземный мир"', pos = deckPos.project},
		{name = 'Корпорации "Подземный мир"', pos = deckPos.corporation},
		{name = 'Прологи "Подземный мир"', pos = deckPos.prolog},
		{name = 'События "Подземный мир"', pos = deckPos.event},
		{name = "Туннельщик", pos = deckPos.milstone},
		{name = 'Стопка наград "Подземный мир"', pos = deckPos.award}
	}},
	sponsorship = {guid = "39be6a", content = {  -- спонсорство
		{name = 'Спонсорство', pos = {{-7.95, 1.06, -10.55}, {0.00, 180.00, 0.00}}},  -- переместить в выкладку тайлов
		{name = 'Жетоны спонсорства', pos = deckPos.sponsor}
	}},
	randomMA = {guid = "39be6a", content = {  -- случайные достижения и награды
		{name = 'Стопка достижений', pos = deckPos.milstone},
		{name = 'Стопка наград', pos = deckPos.award}
	}}
}
PLData = {
	Clr2Name = {
		White = "Белый",
		Red = "Красный",
		Yellow = "Желтый",
		Green = "Зеленый",
		Blue = "Синий"
	},
	Name2Clr = {
		["Белый"] = "White",
		["Красный"] = "Red",
		["Желтый"] = "Yellow",
		["Зеленый"] = "Green",
		["Синий"] = "Blue"
	},
	readyRokets = {
		{
			White = "c5ccb8",
			Red = "9a43e6",
			Yellow = "80e59b",
			Green = "df9c0d",
			Blue = "8a3e15"
		},
		{
			White = "6a16d5",
			Red = "c71edc",
			Yellow = "1290fb",
			Green = "6fbe62",
			Blue = "da0da0"
		}
	},
	resLists = {
		White = "3c2ce3",
		Red = "361498",
		Yellow = "f5b199",
		Green = "777c48",
		Blue = "e8af76"
	},
	handPos = {
		White = {{46.69, 3, -16.28}, {0.00, 270.00, 0.00}},
		Red = {{2.80, 3, -42.09}, {0.00, 0.00, 0.00}},
		Yellow = {{-29.41, 3, -42.09}, {0.00, 0.00, 0.00}},
		Green = {{-30.01, 3, 42.07}, {0.00, 180.00, 0.00}},
		Blue = {{2.50, 3, 42.11}, {0.00, 180.00, 0.00}}
	},
	colorMarkerBag = {
		White = "4d3813",
		Red = "12c991",
		Yellow = "534757",
		Green = "6ae624",
		Blue = "7e9299"
	},
	cityMarkerBag = {
		White = "73ddfc",
		Red = "129e98",
		Yellow = "5d8831",
		Green = "09b7a5",
		Blue = "869ca2"
	}
}
Turns.enable = false
locker = {"9354f9", "d68373", "961278", "6a8317", "4265e6", "67a37b", "317983", "bcde74", "909ee9", "d3468a", "c3eb5f", "2be370", "5368d3", "e7f466", "1df3c5", "8f0349", "37d67b", "cbd6ad", "6d2f58", "3e934d", "95911b"}
Notes.setNotes('ИНСТРУКЦИЯ К СТОЛУ\n\nРейтинг измеряется не кубиком, а счетчиком рядом с планшетом игрока\nДля обозначения своей готовности/паса переключите ракету в нужное состояние\nПри нажатии на "СБРОС" сбрасывается только ваша малая рука по нужным стопкам\n\nВ игре все выполняется автоматически, кроме разыгрывания карт событий и выкладывания нейтральных делегатов\n\nПриятной игры!\n\n\n\n\n\n\n\n\n\nBy 4EPBRK_6RK_6RK')
--setTip('ИНСТРУКЦИЯ К СТОЛУ', 'Рейтинг измеряется не кубиком, а счетчиком рядом с планшетом игрока\nДля обозначения своей готовности/паса переключите ракету в нужное состояние\nПри нажатии на "СБРОС" сбрасывается только ваша малая рука по нужным стопкам\n\nВ игре все выполняется автоматически, кроме разыгрывания карт событий и выкладывания нейтральных делегатов\n\nПриятной игры!\n\n\n\n\n\n\n\n\n\nBy 4EPBRK_6RK_6RK')



function setup()  -- подготовка игры
	setLogs()  -- создание вкладок логов
	
	Notes.setNotes("")
	STEP = 0
	generation = 1
	printToAll("")
	broadcastToAll("►    ".. generation .." ПОКОЛЕНИЕ!")
	printToAll("")
	
	getObjectFromGUID("a63f90").setDescription(generation)  -- установка кубика поколений
	configs = getObjectFromGUID("86fef0").getTable("config")  -- получение настроек игры
	getObjectFromGUID("86fef0").destroy()
	log(configs)
	
	
	setPlayerTurns()  -- запоминание сидящих игроков
	setUI()  -- установка интерфейса
	mapSelect()  -- выбор поля
	placeTiles()  -- раскладка полей
	placeColonys()  -- раскладка колоний
	placeCrisis()  -- расстановка делегатов
	addTiles()  -- добавление специальных тайлов
	cardSetup()  -- сбор колод и выдача карт
	cardDeal()  -- выдача карт
	tokenSetup()  -- сбор наград и спонсоров
	moveFirstPlayerToken(playersTurns[math.random(#playersTurns)])  -- определение первого игрока
	setRockets(2)  -- отключение всех рокет
	
	Wait.time(function()
		if configs.controlStart > 0 then
			controlStart()  -- настраиваемый старт
		else
			buyCard() -- фаза исследований (покупка карт)
		end
	end, 3)
	
	log("")
end

function buyCard() -- фаза исследований (покупка карт)
	STEP = 1
	printToAll("")
	broadcastToAll("► Фаза исследований!")
	setRockets(2)
	if generation == 0 then
		--Notes.setNotes('ФАЗА ПОДГОТОВКИ\n\nВыберите 1 корпорацию и 2 пролога, разыграйте их и выложите в заготовленных для них местах (прологи разыгрываются в порядке ходов)\nВыберите и купите желаемые проекты из 10 карт в руке (каждая стоит 3 M$)\n\nПри готовности переключите ракету в 1 состояние "Активен!"')
		setTip('ФАЗА ПОДГОТОВКИ', 'Выберите 1 корпорацию и 2 пролога, разыграйте их и выложите в заготовленных для них местах (прологи разыгрываются в порядке ходов)\nВыберите и купите желаемые проекты из 10 карт в руке (каждая стоит 3 M$)\n\nПри готовности переключите ракету в 1 состояние "Активен!"')
	else
		--Notes.setNotes('ФАЗА ИССЛЕДОВАНИЙ\n\nВыберите и купите желаемые проекты из 4 карт в руке (каждая стоит 3 M$)\n\nПри готовности переключите ракету в 1 состояние "Активен!"')
		setTip('ФАЗА ИССЛЕДОВАНИЙ', 'Выберите и купите желаемые проекты из 4 карт в руке (каждая стоит 3 M$)\n\nПри готовности переключите ракету в 1 состояние "Активен!"')
	end
	
	Wait.condition(function()
		updateTurns()
		actions()  -- фаза действий
	end, function()
		return allReady(1)  -- ожидание готовности
	end)
end

function actions()  -- фаза действий
	STEP = 2
	printToAll("")
	broadcastToAll("► Фаза действий!")
	Turns.enable = true
	Turns.turn_color = getObjectFromGUID("2f276a").getDescription()
	--Notes.setNotes('ФАЗА ДЕЙСТВИЙ\n\nВ этой фазе вы можете разыгрывать карты проектов, выполнять стандартные проекты и действия с карт\nЗа свой ход вы можете совершить 1 или 2 действия\nЕсли вы пасуете, переключите ракету во 2 состояние "Пас" и ждите пока спасуют оставшиеся игроки')
	setTip('ФАЗА ДЕЙСТВИЙ', 'В этой фазе вы можете разыгрывать карты проектов, выполнять стандартные проекты и действия с карт\nЗа свой ход вы можете совершить 1 или 2 действия\nЕсли вы пасуете, переключите ракету во 2 состояние "Пас" и ждите пока спасуют оставшиеся игроки')
	
	Wait.condition(function()
		Turns.enable = false
		automatisation()  -- окончание фазы действий и выполнение остальных действий
	end, function()
		-- пропуск спасовавших игроков
		return allReady(2)  -- ожидание паса
	end)
end

function automatisation()  -- автоматизация всего что можно
	STEP = 3
	flipActionMarkers()  -- переворот жетончиков действий

	-- производство
	NotLog.log("ResLog", "\nПРОИЗВОДСТВО\n(".. generation .." поколения)", false)
	for _, player in pairs(playersTurns) do
		local prev = GOG(PLData.resLists[player]).call("Get")
		GOG(PLData.resLists[player]).call("Generate")
		Wait.time(function()
			local after = GOG(PLData.resLists[player]).call("Get")  -- логгирование производства
			NotLog.log("ResLog", "[".. player .."]   M€: ".. prev["Мега Кредиты"].c .." -> ".. after["Мега Кредиты"].c .." (".. prev["Мега Кредиты"].p .." + ".. GOG(PLData.resLists[player]).getVar("RT") .."РТ), Сталь: ".. prev["Сталь"].c .." -> ".. after["Сталь"].c .." (".. prev["Сталь"].p .."), Титан: ".. prev["Титан"].c .." -> ".. after["Титан"].c .." (".. prev["Титан"].p .."), Растения: ".. prev["Растения"].c .." -> ".. after["Растения"].c .." (".. prev["Растения"].p .."), Энергия: ".. prev["Энергия"].c .." -> ".. after["Энергия"].c .." (".. prev["Энергия"].p .."), Тепло: ".. prev["Тепло"].c .." -> ".. after["Тепло"].c .." (".. prev["Тепло"].p ..")")
		end, 0.1)
	end
	Wait.time(function()
		NotLog.log("ResLog", "", false)
	end, 0.2)
	
	-- проверка конца игры
	if configs.reqVenus then
		endGame = GOG("c9adc5").getVar("index") + GOG("4fdd36").getVar("index") + GOG("d6af9e").getVar("holdOcean") + GOG("9d6aeb").getVar("index") -3 == 0
	else
		endGame = GOG("c9adc5").getVar("index") + GOG("4fdd36").getVar("index") + GOG("d6af9e").getVar("holdOcean") -2 == 0
	end
	if endGame then
		broadcastToAll("")
		broadcastToAll("Игра окончена!")
	else
		if configs.colony then  -- возвращаются торговые флоты
			objs.colonyHub.call("returnShips")
		end
		colonyMarkerMove()  -- движение курсов на колониях
		govermentSupport()  -- правительственная поддержка
		
		if configs.crisis then  -- политика
			if configs.minusrt then
				for i, PL in ipairs(playersTurns) do
					Wait.time(function()
						GOG(PLData.resLists[PL]).setVar("RT", math.max(0, GOG(PLData.resLists[PL]).getVar("RT") - 1))
						GOG(PLData.resLists[PL]).call("RTupd")
					end, i)
				end
			end
			
			Wait.time(function()
				solarStage()  -- фаза солнечной системы
			end, 1)
		else
			reserch() -- фаза исследований (подготовка)
		end
	end
end

function solarStage()  -- фаза солнечной системы
	STEP = 4
	printToAll("")
	if generation ~= 1 then
		broadcastToAll("► Выполните событие!")  -- выполнение события
		--Notes.setNotes('РАЗЫГРЫВАНИЕ КАРТЫ ГЛОБАЛЬНОГО СОБЫТИЯ\n\nПрочитайте и выполните глобальное событие на правой карте на поле событий с учетов вашего влияния (влияние можно посмотреть в чате)\n\nВыложите верхнего нейтрального делегата с левой карты собития и нижнего с правой\n\nПри готовности переключите ракету в 1 состояние "Активен!"')
		setTip('РАЗЫГРЫВАНИЕ КАРТЫ ГЛОБАЛЬНОГО СОБЫТИЯ', 'Прочитайте и выполните глобальное событие на правой карте на поле событий с учетов вашего влияния (влияние можно посмотреть в чате)\n\nВыложите верхнего нейтрального делегата с левой карты собития и нижнего с правой\n\nПри готовности переключите ракету в 1 состояние "Активен!"')
		
		if not pcall(function()
			objs.politicTile.call("influenceScore")
			if type(objs.politicTile.getTable("influence")) == "table" then
				printToAll("   Влияние игроков:")
				for clr, score in pairs(objs.politicTile.getTable("influence")) do
					printToAll("      ".. clr .." - ".. score)
				end
			else
				log("influence не является массивом!")
			end
		end) then log("Ошибка в influenceScore!") end
	else
		eventSkip = true
	end
	
	
	Wait.condition(function()  -- выполнение оставшихся действий
		eventSkip = nil
		printToAll("[b]Выложите новых нейтральных делегатов[/b]")
		eventMove()  -- перемещение карт событий
		if not pcall(function() objs.politicTile.call("selectPresident") end) then log("Ошибка в selectPresident!") end  -- новый председатель
		if not pcall(function() objs.politicTile.call("refillLobby") end) then log("Ошибка в refillLobby!") end  -- заполнение очереди
		
		reserch() -- фаза исследований (подготовка)
	end, function()
		return eventSkip or allReady(1)  -- ожидание готовности
	end)
end

function reserch() -- фаза исследований (подготовка)
	STEP = 5
	generation = generation + 1  -- перемещение жетона поколений
	getObjectFromGUID("a63f90").setDescription(generation)
	printToAll("")
	printToAll("")
	broadcastToAll("►    ".. generation .." ПОКОЛЕНИЕ!")
	printToAll("")
	
	nextFirstPlayer()  -- определение первого игрока
	deal4card()  -- выдача карт
	if configs.draft then
		--Notes.setNotes('ДРАФТ ПРОЕКТОВ\n\nПосле получения карт выберите 1 и передайте остальные (для выбора, переместите карту из руки в зону над ней), повторяйте пока вам не передадут последнюю карту. Теперь это ваши карты для покупки, выберите и купите нужные.')
		setTip('ДРАФТ ПРОЕКТОВ', 'После получения карт выберите 1 и передайте остальные (для выбора, переместите карту из руки в зону над ней), повторяйте пока вам не передадут последнюю карту. Теперь это ваши карты для покупки, выберите и купите нужные.')
		spawnDraftHand()
		drafting(0, 4)
	else
		buyCard() -- этап покупки карт
	end
end



function setPlayerTurns()  -- запоминание сидящих игроков
	local cube = {White = "Белый", Red = "[FF0200]Красный", Yellow = "[FFFC00]Желтый", Green = "[09D900]Зеленый", Blue = "[0076FF]Синий"}
	
	playersTurns = {}
	for clr, nm in pairs(cube) do
		if Player[clr].seated then
			table.insert(playersTurns, clr)
			Wait.time(function()
				takeName("bfa029", {name = cube[clr]})
				if GOG(PLData.resLists[clr]).getVar("RT") == 0 then
					GOG(PLData.resLists[clr]).setVar("RT", 20)
					GOG(PLData.resLists[clr]).call("RTupd")
				end
			end, #playersTurns)
		end
	end
	--table.insert(playersTurns, "Red")
	--table.insert(playersTurns, "Blue")
	log("Порядок ходов:")
	log(playersTurns)
	
	updateTurns()
	
	
	addHotkey("Готовность", function(playerColor, object, pointerPosition, isKeyUp)
		if not isKeyUp then
			toggleRocket(Player[playerColor])
		end
	end, true)
end
function setUI()  -- создание интерфейса
	XMLcolor = {
		{White = "FFFFFF", Red = "FF0000", Yellow = "FFFF00", Green = "00FF00", Blue = "0000FF"},
		{White = "888888", Red = "880000", Yellow = "888800", Green = "008800", Blue = "000088"}
	}
	UI = {[[<Panel
		id="ActivePanel"
		width="300"
		height="150"
		allowDragging="true"
		active="false"
		rectAlignment="MiddleRight"
		returnToOriginalPositionWhenReleased="false"
		padding="5 5 5 5"
		color="#00000040"
		showAnimation="SlideIn_Right"
		hideAnimation="SlideOut_Right"
		>
	<VerticalLayout>
		<Button
				id="ActiveButton"
				onClick="toggleRocket"
				fontSize="30"
				fontStyle="Bold"
				showAnimation="Grow"
				hideAnimation="Shrink"
				>
			Готов!
		</Button>
		<HorizontalLayout>]],
[[
		</HorizontalLayout>
	</VerticalLayout>
</Panel>

<Panel
		id="TipPanel"
		width="400"
		height="300"
		active="false"
		rectAlignment="LowerRight"
		color="#00000040"
		ignoreLayout="true"
		showAnimation="SlideIn_Right"
		hideAnimation="SlideOut_Right"
		offsetXY="-10 10"
		>
	<Text
			id="TipTitle"
			height="95%"
			color="#FFFFFF"
			fontSize="30"
			showAnimation="FadeIn"
			hideAnimation="FadeOut"
			alignment="UpperRight"
			>
	</Text>
	<Text
			id="TipSubTitle"
			width="95%"
			height="95%"
			color="#FFFFFF"
			fontSize="20"
			showAnimation="FadeIn"
			hideAnimation="FadeOut"
			alignment="LowerRight"
			>
	</Text>
</Panel>

<Text
		id="Title"
		color="#FFFFFF"
		fontSize="50"
		showAnimation="Grow"
		active="false"
		>
	Test
</Text>]]}

	XML = ""
	for _, clr in ipairs(Global.getVar("playersTurns")) do
		XML = XML ..[[
		<Text
				id="]].. clr ..[["
				color="#]].. XMLcolor[2][clr] ..[["
				fontSize="50"
				fontStyle="Bold"
				>
			✘
		</Text>]]
	end
	Global.UI.setXml(UI[1] .. XML .. UI[2])
	Wait.time(function()
		Global.UI.show("ActivePanel")
	end, 1)
end
function setLogs()  -- создание вкладок логов
	log(NotLog.create("ResLog", "Лог ресурсов"))
end
function mapSelect()  -- выбор поля
	mapTile = getObjectFromGUID("317983")
	if configs.map == 1 then
		mapTile.setPosition({0.3, 0, 0.6})
	elseif configs.map == 2 then
		mapTile.setPosition({0.3, 0.75, 0.6})
		mapTile.setRotation({0, 180, 0})
	elseif configs.map == 3 then
		mapTile.setPosition({0.3, 0.95, 0.6})
		mapTile.setRotation({0, 180, 180})
	end
end
function cardSetup()  -- сбор колод
	local decks = {}
	table.insert(decks, DLCBoxCard.base)
	for dls, activate in pairs(configs) do
		if activate then
			table.insert(decks, DLCBoxCard[dls])
			log("Добавление ".. dls)
		end
		if dls == "sponsorship" then
			break
		end
	end
	
	takeDecks(decks)
	if configs.ares == false then  -- замена карт Ареса
		takeName(DLCBoxCard.base.guid, {name = 'Базовые без "Ареса"'}).setPositionSmooth(deckPos.project[1])
		takeName(DLCBoxCard.base.guid, {name = 'Базовые без "Ареса"'}).setRotationSmooth(deckPos.project[2])
		takeName(DLCBoxCard.eraCorp.guid, {name = 'Эра корпораций без "Арес"'}).setPositionSmooth(deckPos.project[1])
		takeName(DLCBoxCard.eraCorp.guid, {name = 'Эра корпораций без "Арес"'}).setRotationSmooth(deckPos.project[2])
	end
end
function cardDeal()  -- выдача карт
	Wait.time(function()
		for _, obj in ipairs(getObjectFromGUID("1ae58d").getObjects()) do  -- перемешивание и раздача начальных карт
			objs.projectDeck = obj
			obj.shuffle()
			obj.setName("Колода проектов")
			
			for __, PL in ipairs(playersTurns) do
				obj.deal(10, PL, 2)
			end
		end
		
		for _, obj in ipairs(getObjectFromGUID("2966ae").getObjects()) do  -- перемешивание и раздача остальных карт
			obj.shuffle()
			if obj.getPosition()[3] >= 18.9 and obj.getPosition()[3] <= 19.1 then
				obj.setName("Колода корпораций")
				
				for __, PL in ipairs(playersTurns) do
					obj.deal(configs.corpCount, PL, 3)
				end
			elseif obj.getPosition()[3] >= 22.9 and obj.getPosition()[3] <= 23.1 then
				obj.setName("Колода прологов")
				
				for __, PL in ipairs(playersTurns) do
					obj.deal(configs.prologeCount, PL, 4)
				end
			elseif obj.getPosition()[3] >= 26.9 and obj.getPosition()[3] <= 27.1 and configs.crisis then
				obj.setName("Колода событий")
				obj.setPositionSmooth(objs.eventTile.getPosition() + Vector(-4.20, 1, -1.72))
				obj.setRotationSmooth({0.00, 180.00, 0.00})
				Wait.time(function()
					eventMove()
				end, 2)
			elseif obj.getPosition()[3] >= 30.9 and obj.getPosition()[3] <= 31.1 and obj.getPosition()[1] >= -60.1 and obj.getPosition()[1] <= -59.9 then
				objs.sponsorDeck = obj
				objs.sponsorDeck.setName("Жетоны спонсорства")
			elseif obj.getPosition()[3] >= 30.9 and obj.getPosition()[3] <= 31.1 and obj.getPosition()[1] >= -58.1 and obj.getPosition()[1] <= -57.9 then
				objs.milstoneDeck = obj
				objs.milstoneDeck.setName("Стопка достижений")
			elseif obj.getPosition()[3] >= 30.9 and obj.getPosition()[3] <= 31.1 and obj.getPosition()[1] >= -56.1 and obj.getPosition()[1] <= -55.9 then
				objs.awardDeck = obj
				objs.awardDeck.setName("Стопка наград")
			end
		end
	end, 3)
end
function tokenSetup()  -- сбор наград и спонсоров
	Wait.time(function()
		if configs.sponsorship == true then  -- выкладывание спонсоров
			GOG("a8f658").setLock(true)
			GOG("a8f658").setPosition({-7.95, 0.9, -10.55})
			objs.sponsorDeck.shuffle()
			for i, pos in ipairs({{-14.27, 1.5, -9.62}, {-11.74, 1.5, -9.22}, {-9.21, 1.5, -9.02}, {-6.69, 1.5, -9.02}, {-4.16, 1.5, -9.22}, {-1.63, 1.5, -9.62}}) do
				Wait.time(function()
					objs.sponsorDeck.takeObject({
						position = pos,
						rotation = {0.00, 180.00, 0.00},
					})
				end, i*0.2)
				if i >= 6 - #playersTurns and configs.controlStart > 0 then
					break
				end
			end
		end
	end, 3)
	
	objs.milstonesTile = takeName(DLCBoxCard.randomMA.guid, {name = "Достижения"})  -- выкладывание планшетов для магнитиков
	objs.milstonesTile.setRotation({0, 180, 0})
	objs.milstonesTile.setLock(true)
	objs.awardsTile = takeName(DLCBoxCard.randomMA.guid, {name = "Награды"})
	objs.awardsTile.setRotation({0, 180, 0})
	objs.awardsTile.setLock(true)
	
	local MACount = 5
	if configs.venus then
		MACount = 6
	end
	
	Wait.time(function()
		objs.milstonesTile.setPosition({-7.95, 0.7, -12.24})
		objs.awardsTile.setPosition({8.46, 0.7, -12.24})
		
		local SP = {}
		for i = 1, MACount do
			table.insert(SP, {position = {-7+14*(i-1)/(MACount-1), 0, -0.1}, rotation = {0, 0, 0}, rotation_snap = true})
		end
		objs.milstonesTile.setSnapPoints(SP)
		objs.awardsTile.setSnapPoints(SP)
	end, 1)

	if configs.randomMA == true then  -- выкладывание достижений и наград
		Wait.time(function()
			objs.milstonesTile.setPosition({-7.95, 0.8, -12.24})
			objs.awardsTile.setPosition({8.46, 0.8, -12.24})
			
			objs.milstoneDeck.shuffle()
			objs.awardDeck.shuffle()
			count = MACount
			if configs.controlStart > 0 then
				count = MACount - #playersTurns
			end
			for i = 1, count do
				Wait.time(function()
					objs.milstoneDeck.takeObject({
						position = {-14.2+12.6/(MACount-1)*(i-1), 1.5, -12.15},
						rotation = {0.00, 180.00, 0.00},
					})
					Wait.time(function()
						objs.awardDeck.takeObject({
							position = {2.26+12.6/(MACount-1)*(i-1), 1.5, -12.15},
							rotation = {0.00, 180.00, 0.00},
						})
					end, (count+1)*0.2)
				end, i*0.2)
			end
		end, 4)
	end
end
function setRockets(state)  -- отключение всех рокет
	for _, roket in pairs(PLData.readyRokets[(state)%2+1]) do
		if getObjectFromGUID(roket) then
			getObjectFromGUID(roket).setState((state-1)%2+1)
			toggleRocket(Player[_], state)
		end
	end
end
function placeTiles()  -- раскладка полей
	sizes = {}
	if configs.venus then  -- запись длинн
		table.insert(sizes, 11.5)
	end
	if configs.crisis then
		table.insert(sizes, 10.5)
		table.insert(sizes, 10.5)
	end
	if configs.pathfinders then
		table.insert(sizes, 11.5)
	end
	poses = posTiles(sizes)
	
	i = 1
	if configs.venus then  -- раскладка полей
		objs.venusTile = takeName(DLCBoxCard.venus.guid, {name = "Атмосфера Венеры"})
		objs.venusTile.setPositionSmooth({-35.5-6.37, 1.52, poses[i]+3.57})
		objs.venusTile.setLock(true)
		objs.venusMarker = takeName(DLCBoxCard.venus.guid, {name = "Поле Венеры"})
		objs.venusMarker.setPositionSmooth({-35.5, 1, poses[i]})
		objs.venusMarker.setRotation({0.00, 180.00, 0.00})
		objs.venusMarker.setLock(true)
		i = i + 1
	end
	if configs.crisis then
		objs.eventTile = takeName(DLCBoxCard.crisis.guid, {name = "Поле событий"})
		objs.eventTile.setPositionSmooth({-35.5, 1, poses[i]})
		objs.eventTile.setRotation({0.00, 180.00, 0.00})
		objs.eventTile.setLock(true)
		objs.politicTile = takeName(DLCBoxCard.crisis.guid, {name = "Поле правительства"})
		objs.politicTile.setPositionSmooth({-35.5, 1, poses[i+1]})
		objs.politicTile.setRotation({0.00, 180.00, 0.00})
		objs.politicTile.setLock(true)
		i = i + 2
	end
	if configs.pathfinders then
		objs.planetTracks = takeName(DLCBoxCard.pathfinders.guid, {name = "Планетарные треки"})
		objs.planetTracks.setPositionSmooth({-35.5, 1, poses[i]})
		objs.planetTracks.setRotation({0.00, 180.00, 0.00})
		objs.planetTracks.setLock(true)
		i = i + 1
	end
	if configs.underworld then
		for _, guid in ipairs({"8f0349", "37d67b", "cbd6ad", "6d2f58", "3e934d", "d1608f", "4464b8", "66b027", "46bc95", "a3c43c"}) do
			getObjectFromGUID(guid).setPosition(getObjectFromGUID(guid).getPosition() + Vector(0, 1, 0))
			getObjectFromGUID(guid).setInvisibleTo({})
		end
	end
	
end
function placeColonys()  -- раскладка колоний
	if configs.colony then
		objs.colonyBag = takeName(DLCBoxCard.colony.guid, {name = "Колонии"})
		objs.colonyBag.setPositionSmooth({-63.00, 1.00, 0.00})
		objs.colonyBag.setLock(true)
		
		Wait.time(function()
			objs.colonyShipBag = takeName(DLCBoxCard.colony.guid, {name = "Корабли"})
			objs.colonyShipBag.setPositionSmooth({-63.00, 1.00, -2.00})
			objs.colonyShipBag.setLock(true)
			objs.colonyMarkerBag = takeName(DLCBoxCard.colony.guid, {name = "Маркеры курса"})
			objs.colonyMarkerBag.setPositionSmooth({-63.00, 1.00, -4.00})
			objs.colonyMarkerBag.setLock(true)
			
			if configs.venus then
				objs.colonyBag.putObject(takeName(DLCBoxCard.venus.guid, {name = "Титан"}))
			end
			if configs.pathfinders then
				objs.colonyBag.putObject(takeName(DLCBoxCard.pathfinders.guid, {name = "Япет"}))
				objs.colonyBag.putObject(takeName(DLCBoxCard.pathfinders.guid, {name = "Станция Ливитт"}))
			end
			if configs.underworld then
				objs.colonyBag.putObject(takeName(DLCBoxCard.underworld.guid, {name = "Амальтея"}))
				objs.colonyBag.putObject(takeName(DLCBoxCard.underworld.guid, {name = "Оберон"}))
				objs.colonyBag.putObject(takeName(DLCBoxCard.underworld.guid, {name = "Фобос"}))
			end
			
			if configs.venus or configs.crisis or configs.pathfinders then  -- разметка позиций колоний
				tilePos = -50
			else
				tilePos = -29
			end
			sizes = {5}
			for i = 1, math.max(#playersTurns+2, 5) do
				table.insert(sizes, 4.5)
			end
			poses = posTiles(sizes)
			
			objs.colonyHub = takeName(DLCBoxCard.colony.guid, {name = "Торговый флот"})  -- выкладывание колоний
			objs.colonyHub.setPositionSmooth({tilePos, 1.00, poses[1]})
			objs.colonyHub.setRotation({0.00, 180.00, 0.00})
			objs.colonyHub.setLock(true)
			
			objs.colonyBag.shuffle()
			if configs.controlStart > 0 then
				colonyPoses = poses
				colonytilePos = tilePos
				for i = 1, math.max(#playersTurns+2, 5)-#playersTurns do
					objs.colonyMarkerBag.takeObject().setPositionSmooth({tilePos-1.47, 1.5, poses[i+1]-1})
					local tile = objs.colonyBag.takeObject()
					tile.setPositionSmooth({tilePos, 1.00, poses[i+1]})
					tile.setRotation({0.00, 180.00, 0.00})
					tile.setLock(true)
					log(i)
				end
				Wait.time(function()
					for _, PL in ipairs(playersTurns) do
						objs.colonyBag.deal(configs.controlStart, PL, 3)
					end
				end, 2)
			else
				for i = 1, math.max(#playersTurns+2, 5) do
					objs.colonyMarkerBag.takeObject().setPositionSmooth({tilePos-1.47, 1.5, poses[i+1]-1})
					local tile = objs.colonyBag.takeObject()
					tile.setPositionSmooth({tilePos, 1.00, poses[i+1]})
					tile.setRotation({0.00, 180.00, 0.00})
					tile.setLock(true)
				end
			end
			
			
			tilePos = -45  -- выкладывание кораблей
			sizes = {}
			for i = 1, #playersTurns do
				table.insert(sizes, 1)
			end
			shipName = {White = "Белый", Red = "Красный", Yellow = "Желтый", Green = "Зеленый", Blue = "Синий"}
			poses = posTiles(sizes)
			for i, name in ipairs(playersTurns) do
				takeName(objs.colonyShipBag, {name = shipName[name]}).setPositionSmooth({-45, 1+i*.2, 0})
			end
			
			Wait.time(function()
				objs.colonyHub.call("returnShips")
			end, 2)
		end, 1)
	end
end
function placeCrisis()  -- расстановка делегатов
	if configs.crisis then
		objs.delegats = takeName(DLCBoxCard.crisis.guid, {name = "Делегаты", position = {-63, 1, -8}})
		objs.delegats.setLock(true)
		
		Wait.time(function()
			objs.politics = takeName(DLCBoxCard.crisis.guid, {desc = "Политика", position = objs.politicTile.getPosition() + Vector(0, 0.3, 3.54), rotation = {0, 180, 0}})
			objs.politics.setLock(true)
		
			objs.liderMarker = takeName(DLCBoxCard.crisis.guid, {name = "Лидирующая партия", position = objs.politicTile.getPosition() + Vector(5.84, 1, 0.56)})

			objs.delegatsBag = {}
			objs.delegatsBag[1] = takeName(objs.delegats.guid, {desc = "Нейтральный", position = objs.politicTile.getPosition() + Vector(-2.97, 0.20, 3.65), rotation = {0, 90, 0}})
			objs.delegatsBag[2] = takeName(objs.delegats.guid, {desc = "Белый", position = objs.politicTile.getPosition() + Vector(2.91, 0.20, 3.47), rotation = {0, 90, 0}})
			objs.delegatsBag[3] = takeName(objs.delegats.guid, {desc = "Красный", position = objs.politicTile.getPosition() + Vector(4.16, 0.20, 3.47), rotation = {0, 90, 0}})
			objs.delegatsBag[4] = takeName(objs.delegats.guid, {desc = "Желтый", position = objs.politicTile.getPosition() + Vector(5.56, 0.20, 3.44), rotation = {0, 90, 0}})
			objs.delegatsBag[5] = takeName(objs.delegats.guid, {desc = "Зеленый", position = objs.politicTile.getPosition() + Vector(2.90, 0.20, 2.57), rotation = {0, 90, 0}})
			objs.delegatsBag[6] = takeName(objs.delegats.guid, {desc = "Синий", position = objs.politicTile.getPosition() + Vector(4.18, 0.20, 2.58), rotation = {0, 90, 0}})
			for _, obj in ipairs(objs.delegatsBag) do
				obj.setLock(true)
			end
			
			objs.politicTile.call("refillLobby")
		end, 2)
	end
end
function addTiles()  -- добавление специальных тайлов
	i = 1
	if configs.pathfinders then
		objs.PFTiles = takeName(DLCBoxCard.pathfinders.guid, {name = 'Тайлы "Первооткрыватели"'})
		for _, obj in ipairs(objs.PFTiles.getObjects()) do
			objs.PFTiles.takeObject({position = {-21.18, 1+i*0.1, -4.63}})
			i = i + 1
		end
		objs.PFTiles.destruct()
	end
	
	if configs.ares then
		specTilesBag = getObjectFromGUID("0d97f2")
		for _, obj in ipairs(specTilesBag.getObjects()) do
			specTilesBag.takeObject().destruct()
		end
		
		objs.aresTiles = takeName(DLCBoxCard.ares.guid, {name = 'Тайлы "Арес"'})
		local tilePos = {}  -- выкладывание песчанных бурь
		for i = 1, math.min(3, 6-#playersTurns) do
			rn = math.random(61)
			if i > 1 then
				if tilePos[i-1] == rn then
					rn = rn + 1
				end
			end
			table.insert(tilePos, rn)
		end
		for _, pos in ipairs(tilePos) do
			local tile = takeName(objs.aresTiles.guid, {name = 'Пылевая буря'})
			pos = hexGrid(pos)
			pos[2] = pos[2] + 1
			tile.setPosition(pos)
			tile.setRotation({0, 270, 0})
		end
		
		for _, obj in ipairs(objs.aresTiles.getObjects()) do
			objs.aresTiles.takeObject({position = {-21.18, 1+i*0.1, -4.63}})
			i = i + 1
		end
		objs.aresTiles.destruct()
		
		oceansTilesBag = getObjectFromGUID("d6af9e")
		takeName(DLCBoxCard.ares.guid, {name = 'Пылевые бури'}).setPosition(oceansTilesBag.getPosition() + Vector(0, 0.2, 0))
		oceansTilesBag.takeObject({position = oceansTilesBag.getPosition() + Vector(0, 0.4, 0)})
		oceansTilesBag.takeObject({position = oceansTilesBag.getPosition() + Vector(0, 0.6, 0)})
		oceansTilesBag.takeObject({position = oceansTilesBag.getPosition() + Vector(0, 0.8, 0)})
		takeName(DLCBoxCard.ares.guid, {name = 'Эрозия'}).setPosition(oceansTilesBag.getPosition() + Vector(0, 1.0, 0))
		oceansTilesBag.takeObject({position = oceansTilesBag.getPosition() + Vector(0, 1.2, 0)})
		oceansTilesBag.takeObject({position = oceansTilesBag.getPosition() + Vector(0, 1.4, 0)})
	end
	
	if configs.underworld then
		objs.groundRes = takeName(DLCBoxCard.underworld.guid, {name = 'Подземные ресурсы'})
		objs.groundRes.setPosition({-8.50, 1.00, -6.50})
		objs.groundRes.setRotation({0.00, 180.00, 0.00})
		objs.groundRes.setLock(true)
		
		objs.excavationBag = takeName(DLCBoxCard.underworld.guid, {name = 'Маркеры раскопок'})
		objs.excavationBag.setPosition({-9.00, 1.00, -4.50})
		objs.excavationBag.setRotation({0.00, 180.00, 0.00})
		objs.excavationBag.setLock(true)
	end
end
function eventMove()  -- перемещение карт событий
	hitList = Physics.cast({
		origin = objs.eventTile.getPosition() + Vector(-4.20, 1, -1.72),
		direction = {0,-0.2,0},
		max_distance = 2,
	})
	eventDeckReady = false
	for _, obj in ipairs(hitList) do
		if obj.hit_object.type == "Deck" then
			eventDeckReady = true
			break
		end
	end
	if not eventDeckReady then
		hitList = Physics.cast({
			origin = objs.eventTile.getPosition() + Vector(4.30, 1, -1.72),
			direction = {0,-0.2,0},
			max_distance = 2,
		})
		for _, obj in ipairs(hitList) do
			if obj.hit_object.type == "Deck" then
				obj.hit_object.setPositionSmooth(objs.eventTile.getPosition() + Vector(-4.20, 1, -1.72))
				obj.hit_object.shuffle()
				obj.hit_object.takeObject({position = objs.eventTile.getPosition() + Vector(0.04, 1, -1.72)})
				break
			end
		end
	end
	
	
	hitList = Physics.cast({
		origin = objs.eventTile.getPosition() + Vector(0.04, 1, -1.72),
		direction = {0,-0.2,0},
		max_distance = 2,
	})
	for _, obj in ipairs(hitList) do
		if obj.hit_object.type == "Card" then
			obj.hit_object.setPositionSmooth(objs.eventTile.getPosition() + Vector(4.30, 1, -1.72))
			break
		end
	end
	
	hitList = Physics.cast({
		origin = objs.eventTile.getPosition() + Vector(-4.20, 1, -1.72),
		direction = {0,-0.2,0},
		max_distance = 2,
	})
	for _, obj in ipairs(hitList) do
		if obj.hit_object.type == "Deck" then
			obj.hit_object.takeObject({position = objs.eventTile.getPosition() + Vector(0.04, 1, -1.72)})
			break
		elseif obj.hit_object.type == "Card" then
			obj.hit_object.setPositionSmooth(objs.eventTile.getPosition() + Vector(0.04, 1, -1.72))
			break
		end
	end
end
function flipActionMarkers()  -- переворот жетончиков действий
	for _, obj in pairs(getAllObjects()) do
		if obj.getDescription() == 'Маркер действий' then
			local pos = obj.getPosition()
			pos[2] = pos[2]+0.2
			obj.setPositionSmooth(pos)
			local rot = obj.getRotation()
			rot[1] = 0
			rot[3] = 0
			obj.setRotationSmooth(rot)
		end
	end
end
function toggleRocket(player, state)  -- переключение ракеты
	if type(state) == "number" then
		local text = {"✔", "✘️"}
		Global.UI.setValue(player.color, text[state])
		Global.UI.setAttribute(player.color, "color", "#"..XMLcolor[state][player.color])
	else
		if getObjectFromGUID(PLData.readyRokets[1][player.color]) then
			getObjectFromGUID(PLData.readyRokets[1][player.color]).setState(2)
			Global.UI.setValue(player.color, "✘️")
			Global.UI.setAttribute(player.color, "color", "#"..XMLcolor[2][player.color])
		else
			if getObjectFromGUID(PLData.readyRokets[2][player.color]) then
				getObjectFromGUID(PLData.readyRokets[2][player.color]).setState(1)
				Global.UI.setValue(player.color, "✔")
				Global.UI.setAttribute(player.color, "color", "#"..XMLcolor[1][player.color])
			end
		end
	end
end
function onObjectStateChange(object, old_state_guid)  -- синхронизация интерфейса
	for i = 1, 2 do
		for clr, guid in pairs(PLData.readyRokets[i]) do
			if guid == object.guid then
				toggleRocket(Player[clr], i)
				if Turns.turn_color != clr then
					updateTurns()
				end
				break
			end
		end
	end
end
function onPlayerTurn(player, previous_player)  -- обновление ходов после смены хода
    updateTurns()  -- обновление порядка ходов
	
	if STEP == 2 then  -- лог ресурсов в начале хода
		if player then
			local res = GOG(PLData.resLists[player.color]).call("Get")
			NotLog.log("ResLog", "[".. player.color .."]   M€: ".. res["Мега Кредиты"].c .." (".. res["Мега Кредиты"].p .." + ".. GOG(PLData.resLists[player.color]).getVar("RT") .."РТ), Сталь: ".. res["Сталь"].c .." (".. res["Сталь"].p .."), Титан: ".. res["Титан"].c .." (".. res["Титан"].p .."), Растения: ".. res["Растения"].c .." (".. res["Растения"].p .."), Энергия: ".. res["Энергия"].c .." (".. res["Энергия"].p .."), Тепло: ".. res["Тепло"].c .." (".. res["Тепло"].p ..")")
		end
	end
end
function controlStart()  -- настраиваемый старт
	--Notes.setNotes('ФАЗА ПОДГОТОВКИ\n\nВыберите по одному жетону [b]достижения, награды, спонсора и колонии[/b]. Переложите выбранные жетоны в нижнюю малую руку, когда все игроки выберут жетоны, они войдут в игру.')
	setTip('ФАЗА ПОДГОТОВКИ', 'Выберите по одному жетону ДОСТИЖЕНИЯ, НАГРАДЫ, СПОНСОРА И КОЛОНИИ. Переложите выбранные жетоны в нижнюю малую руку, когда все игроки выберут жетоны, они войдут в игру.')
	
	spawnDraftHand()
	for _, PL in ipairs(playersTurns) do
		if configs.sponsorship then
			objs.sponsorDeck.deal(configs.controlStart, PL, 1)
		end
		if configs.randomMA then
			objs.milstoneDeck.deal(configs.controlStart, PL, 1)
			objs.awardDeck.deal(configs.controlStart, PL, 1)
		end
	end
	
	Wait.condition(function()
		CSTokensRefill()
		removeDraftHand()
		buyCard() -- фаза исследований (покупка карт)
	end, function()
		
		startReady = true  -- подcчет жетонов в руках
		tokenCount = {}
		for _, color in ipairs(playersTurns) do
			tokenCount[color] = {Sponsor = 0, Milstone = 0, Award = 0, Colony = 0}
			for __, obj in ipairs(Player[color].getHandObjects(Player[color].getHandCount())) do
				if obj.type == "Card" then
					for i, v in pairs(obj.getData().CustomDeck) do
						if v.BackURL == "https://steamusercontent-a.akamaihd.net/ugc/28811178277742185/1E5CD93249373D9E124B2060581F43DC5BF921FF/" then
							tokenCount[color].Sponsor = tokenCount[color].Sponsor + 1
						elseif v.BackURL == "https://steamusercontent-a.akamaihd.net/ugc/28812445892062376/2A6C6D3AA5FC654AFFD6F3260AFAC83514571181/" then
							tokenCount[color].Milstone = tokenCount[color].Milstone + 1
						elseif v.BackURL == "https://steamusercontent-a.akamaihd.net/ugc/28812445892062293/66A0D24C0E463AED66FBB72DBA00496B34EFC9DE/" then
							tokenCount[color].Award = tokenCount[color].Award + 1
						end
					end
				elseif obj.type == "Tile" then
					if obj.getDescription() == "Колония" then
						tokenCount[color].Colony = tokenCount[color].Colony + 1
					end
				end
			end
			
			if configs.sponsorship then  -- проверка нужных жетонов и пустой руки
				startReady = startReady and tokenCount[color].Sponsor == 1 and #Player[color].getHoldingObjects() == 0
			end
			if configs.randomMA then
				startReady = startReady and tokenCount[color].Milstone == 1 and tokenCount[color].Award == 1 and #Player[color].getHoldingObjects() == 0
			end
			if configs.colony then
				startReady = startReady and tokenCount[color].Colony == 1 and #Player[color].getHoldingObjects() == 0
			end
		end
		return startReady
	end)
end
function CSTokensRefill()  -- заполнение наград и спонсорств
	local MACount = 5
	if configs.venus then
		MACount = 6
	end
	
	colonyNames = {}
	for _, color in ipairs(playersTurns) do  -- уборка жетонов в колоду
		for __, obj in ipairs(Player[color].getHandObjects(Player[color].getHandCount())) do
			if obj.type == "Card" then
				for i, v in pairs(obj.getData().CustomDeck) do
					if v.BackURL == "https://steamusercontent-a.akamaihd.net/ugc/28811178277742185/1E5CD93249373D9E124B2060581F43DC5BF921FF/" then
						objs.sponsorDeck.putObject(obj)
					elseif v.BackURL == "https://steamusercontent-a.akamaihd.net/ugc/28812445892062376/2A6C6D3AA5FC654AFFD6F3260AFAC83514571181/" then
						objs.milstoneDeck.putObject(obj)
					elseif v.BackURL == "https://steamusercontent-a.akamaihd.net/ugc/28812445892062293/66A0D24C0E463AED66FBB72DBA00496B34EFC9DE/" then
						objs.awardDeck.putObject(obj)
					end
				end
			elseif obj.type == "Tile" then
				if obj.getDescription() == "Колония" then
					table.insert(colonyNames, obj.getName())
					objs.colonyBag.putObject(obj)
				end
			end
		end
	end
	
	if configs.sponsorship then  -- заполнение спонсоров
		local pos = {{-14.27, 1.5, -9.62}, {-11.74, 1.5, -9.22}, {-9.21, 1.5, -9.02}, {-6.69, 1.5, -9.02}, {-4.16, 1.5, -9.22}, {-1.63, 1.5, -9.62}}
		for i = 7-#playersTurns, 6 do
			objs.sponsorDeck.takeObject({
				position = pos[i],
				rotation = {0.00, 180.00, 0.00},
			})
		end
	end
	if configs.randomMA then  -- заполнение наград
		for i = MACount-#playersTurns+1, MACount do
			objs.milstoneDeck.takeObject({
				position = {-14.2+12.6/(MACount-1)*(i-1), 1.5, -12.15},
				rotation = {0.00, 180.00, 0.00},
			})
			objs.awardDeck.takeObject({
				position = {2.26+12.6/(MACount-1)*(i-1), 1.5, -12.15},
				rotation = {0.00, 180.00, 0.00},
			})
		end
	end
	if configs.colony then  -- заполнение колоний
		Wait.time(function()
			poses = colonyPoses
			tilePos = colonytilePos
			for i = math.max(#playersTurns+2, 5)-#playersTurns+1, math.max(#playersTurns+2, 5) do
				log(colonyNames[1])
				objs.colonyMarkerBag.takeObject().setPositionSmooth({tilePos-1.47, 1.5, poses[i+1]-1})
				local tile = objs.colonyBag.takeObject()
				tile.setPositionSmooth({tilePos, 1.00, poses[i+1]})
				tile.setRotation({0.00, 180.00, 0.00})
				tile.setLock(true)
			end
		end, 2)
	end
end

function allReady(state)  -- проверка готовности игроков
	local ready = 0
	for _, player in pairs(playersTurns) do
		if getObjectFromGUID(PLData.readyRokets[state][player]) then
			ready = ready + 1
		end
	end
	return ready == #playersTurns
end

function setTip(title, subTitle)
	Global.UI.hide("TipPanel")
	Wait.time(function()
		Global.UI.setValue("TipTitle", title)
		Global.UI.setValue("TipSubTitle", subTitle)
		Global.UI.show("TipPanel")
	end, 0.4)
end

function spawnDraftHand()  -- создание рук для драфта
	draftHands = {}
	for _, color in pairs(playersTurns) do
		hand = spawnObject({
			type = "HandTrigger",
			position = PLData.handPos[color][1],
			rotation = PLData.handPos[color][2],
			scale = {6, 3, 3},
		})
		hand.setValue(color)
		table.insert(draftHands, hand)
	end
end
function removeDraftHand()  -- удаление рук для драфта
	hand = {}
	for _, color in pairs(playersTurns) do
		hand[color] = Player[color].getHandObjects(1)
	end
	
	for _, color in pairs(playersTurns) do
		hand[color] = Player[color].getHandObjects(Player[color].getHandCount())
		for __, obj in pairs(hand[color]) do
			obj.setPositionSmooth(Player[color].getHandTransform(1).position)
		end
	end
	
	for _, obj in pairs(draftHands) do
		obj.destruct()
	end
end
function drafting(num, count)  -- драфт
	if count-num > 0 then
		log("Ожидание ".. count-num .." карт в основной руке и ".. num .." в драфтовой")
		Wait.condition(function()
			if num != 0 then
				swichHands(generation%2 == 1)
			else
				if generation%2 == 1 then
					printToAll("Драфт против часовой ( → )")
				else
					printToAll("Драфт по часовой ( ← )")
				end
			end
			drafting(num+1, count)
		end, function()  -- ожидание нужного количества карт в руках
			chooseHand = true
			draftHand = true
			emptyHand = true
			for _, color in pairs(playersTurns) do
				chooseHand = chooseHand and #Player[color].getHandObjects(1) == count-num
				draftHand = draftHand and #Player[color].getHandObjects(Player[color].getHandCount()) == num
				if Player[color].getHoldingObjects() then
					emptyHand = emptyHand and #Player[color].getHoldingObjects() == 0
				end
			end
			return chooseHand and draftHand and emptyHand
		end)
	else
		printToAll("Драфт завершен!")
		removeDraftHand()
		buyCard()
	end
end
function swichHands(dir)  -- обмен руками
	hand = {}
	for _, color in pairs(playersTurns) do
		hand[color] = Player[color].getHandObjects(1)
	end
	for i, color in ipairs(playersTurns) do
		for _, obj in pairs(hand[color]) do
			if dir then
				givePl = playersTurns[(i - 2 + #playersTurns) % #playersTurns + 1]
			else
				givePl = playersTurns[i % #playersTurns + 1]
			end
			
			obj.setPosition(Player[givePl].getHandTransform(1).position)
			obj.setRotation(Player[givePl].getHandTransform(1).rotation + Vector(0, 180, 0))
		end
	end
end

function deal4card()  -- выдача карт с добором из сброса
	for _, obj in pairs(getObjectFromGUID("1ae58d").getObjects()) do
		if obj.type == "Deck" then
			objs.projectDeck = obj
			break
		end
	end
	if objs.projectDeck.getQuantity() < 4 * #playersTurns then
		for _, obj in pairs(getObjectFromGUID("0e0cb2").getObjects()) do
			if obj.type == "Deck" then
				discardDeck = obj
				break
			end
		end
		objs.projectDeck.putObject(discardDeck)
		objs.projectDeck.shuffle()
	end
	objs.projectDeck.deal(4)
end
function nextFirstPlayer()  -- определение первого игрока
	FirstPlayer = getObjectFromGUID("2f276a").getDescription()
	for i, player in pairs(playersTurns) do
		if FirstPlayer == player then
			moveFirstPlayerToken(playersTurns[i % #playersTurns +1])
			log(FirstPlayer .." --> ".. playersTurns[i % #playersTurns +1])
			break
		end
	end
end
function govermentSupport()  -- правительственная поддержка
	if configs.support then
		options = {}
		if getObjectFromGUID("4fdd36").getVar("index") > 1 then table.insert(options, "Уровень кислорода") end
		if getObjectFromGUID("c9adc5").getVar("index") > 1 then table.insert(options, "Температура") end
		if getObjectFromGUID("d6af9e").getVar("holdOcean") > 0 then table.insert(options, "Количество океанов") end
		if configs.venus and configs.reqVenus and getObjectFromGUID("9d6aeb").getVar("index") > 1 then table.insert(options, "Атмосфера Венеры") end
		
		FirstPlayer = getObjectFromGUID("2f276a").getDescription()
		Player[FirstPlayer].showOptionsDialog("Какой показатель повысить?", options, 1,
			function(text, index, player_color)
				if text == "Уровень кислорода" then
					getObjectFromGUID("4fdd36").call("increaseO2")
				elseif text == "Температура" then
					getObjectFromGUID("c9adc5").call("increaseTemp")
				elseif text == "Количество океанов" then
					ocean = getObjectFromGUID("d6af9e").takeObject({position = {11.50, 2.00, 9.00}})
					Player["White"].pingTable({11.50, 1.00, 9.00})
					broadcastToAll(Player[FirstPlayer].steam_name ..", выложи океан на поле")
				elseif text == "Атмосфера Венеры" then
					getObjectFromGUID("9d6aeb").call("increaseVenus")
				end
			end
		)
	end
end
function colonyMarkerMove()  -- движение курсов на колониях
	for _, obj in ipairs(getObjects()) do
		if obj.getName() == "Торговый курс" then
			HitList = Physics.cast({
				origin = obj.getPosition(),
				direction = {0,-0.1,0},
				max_distance = 0.4,
			})
			for __, tile in ipairs(HitList) do
				if tile.hit_object.getDescription() == "Колония" then
					cubePos = math.ceil((tile.hit_object.getPosition()[1] - obj.getPosition()[1] - 2.1) / -0.73)
					if cubePos < 6 then
						obj.setPositionSmooth(obj.getPosition() + Vector(0.73, 0, 0))
					end
				end
			end
		end
	end
end
function colonyTrade(param)  -- торговля с колонией  -- переместить проверку наличия торгового флота
	local player_color = param[1]
	local object = param[2]
	
	local PLNames = {["Белый"] = "White", ["Красный"] = "Red", ["Желтый"] = "Yellow", ["Зеленый"] = "Green", ["Синий"] = "Blue"}
	local Sales = {
		White = 0,
		Red = 0,
		Yellow = 0,
		Green = 0,
		Blue = 0
	}
	local BonusMove = {
		White = 0,
		Red = 0,
		Yellow = 0,
		Green = 0,
		Blue = 0
	}
	
	-- проверка занятости колонии
	local hitList = Physics.cast({
		origin = object.getPosition() + Vector(1.9, 1, 0.8),
		direction = {0, -1, 0},
		max_distance = 1,
	})
	local tradeReady = true
	for _, obj in ipairs(hitList) do
		if obj.hit_object.getDescription() == "Торговый флот" then
			broadcastToColor("[FF0000]Колония уже занята!", player_color)
			tradeReady = false
			break
		end
	end
	
	-- торговля с колонией
	if tradeReady then
		for _, obj in ipairs(GOG("62b7cb").getObjects()) do  -- поиск свободного флота
			if obj.getDescription() == "Торговый флот" and PLNames[obj.getName()] == player_color then
				local hitList = Physics.cast({
					origin = obj.getPosition(),
					direction = {0, -1, 0},
					max_distance = 1,
				})
				for __, tile in ipairs(Physics.cast({  -- поиск корабля в доках
							origin = obj.getPosition(),
							direction = {0, -1, 0},
							max_distance = 1})) do
					if tile.hit_object.getName() == "Торговый флот" then  -- торговля с колонией
						local PlayerResList = GOG(PLData.resLists[player_color])  -- запрос ресурса
						local PLres = PlayerResList.call("Get")
						local options = {}
						local optionsIndex = {}
						local defaultRes = 1
						for res, cost in pairs({["Мега Кредиты"] = {9, "FFAE00"}, ["Титан"] = {3, "000000"}, ["Энергия"] = {3, "B100FF"}}) do
							if PLres[res].c >= cost[1] then
								table.insert(options, "[".. cost[2] .."]".. res .." (".. PLres[res].c .."  -> ".. (PLres[res].c - cost[1] + Sales[player_color]) ..")")
								table.insert(optionsIndex, {res, cost[1]})
								if res == "Энергия" then
									defaultRes = #options
								end
							end
						end
						Player[player_color].showOptionsDialog("За какой ресурс использовать для оплаты торговли?", options, defaultRes,
							function(text, index, player_color)
								PlayerResList.call("ResNamesAdd", {name = optionsIndex[index][1], add = -optionsIndex[index][2] + Sales[player_color]})
				
				
								obj.setPositionSmooth(object.getPosition() + Vector(1.96, 0.5, 0.7))  -- перемещение флота
								
								local markers = Physics.cast({
									origin = object.getPosition() + Vector(-3.5, 0.37, -0.95),
									direction = {1, 0, 0},
									max_distance = 7,
								})
								for ___, marker in ipairs(markers) do
									if marker.hit_object.getName() == "Торговый курс" then  -- перемещение курса
										local colonyMarkerPos = -1
										if #markers > 1 then
											colonyMarkerPos = math.ceil((tile.hit_object.getPosition()[1] - markers[___-1].hit_object.getPosition()[1] - 2.1) / -0.73)
										end
										local markerPos = math.ceil((tile.hit_object.getPosition()[1] - marker.hit_object.getPosition()[1] - 2.1) / -0.73)
										marker.hit_object.setPositionSmooth(marker.hit_object.getPosition() + Vector(-0.73 * (markerPos - colonyMarkerPos -1), 0, 0))
										
										printToAll(player_color .." торгует с колонией \"".. object.getName() .."\" (торговый курс перемещается с ".. markerPos +1 .." на ".. colonyMarkerPos +2 ..")")
									end
								end
							end
						)
					end
				end
			end
		end
	end
end

NotLog = {}  -- система логгирования
function NotLog.create(id, name)
	Notes.addNotebookTab({title = name .."\n".. id, body = ""})
	return 'Вкладка логов "'.. id ..'" создана'
end
function NotLog.log(id, text, timestamp)
	for _, tab in ipairs(Notes.getNotebookTabs()) do
		if string.find(tab.title, "\n") then
			if string.sub(tab.title, string.find(tab.title, "\n")+1, -1) == id then
				if timestamp == false then
					timestamp = ""
				else
					timestamp = "[".. os.date("%H:%M:%S") .."] "
				end
				Notes.editNotebookTab({index = tab.index, body = tab.body .."\n".. timestamp .. text})
				logged = "Записано [".. id .."]: ".. text
				break
			end
		end
	end
	return logged
end


function moveFirstPlayerToken(newFirstPlayer)  -- объявление и перемещение первого игрока
	local firstPlayerTokenSpot = {White = {23.02, 2, -3.63}, Red = {15.6, 2, -17.5}, Yellow = {-15, 2, -17.4}, Green = {-14.9, 2, 18.5}, Blue = {15.6, 2, 18.5}}
	local firstPlayerTokenRot = {White = 90, Red = 180, Yellow = 180, Green = 0, Blue = 0}
	
	FPToken = getObjectFromGUID("2f276a")
	FPToken.setDescription(newFirstPlayer)
	FPToken.setPositionSmooth(firstPlayerTokenSpot[newFirstPlayer])
	FPToken.setRotationSmooth({0, firstPlayerTokenRot[newFirstPlayer], 0})
	
	broadcastToAll(Player[newFirstPlayer].steam_name .." теперь первый игрок")
	Turns.turn_color = newFirstPlayer
end
function takeDecks(array)  -- выкладывание колод дополнений
	for _, dlc in pairs(array) do
		container = getObjectFromGUID(dlc.guid)
		for __, testDeck in pairs(dlc.content) do
			for ___, obj in pairs(container.getObjects()) do
				if obj.name == testDeck.name then
					container.takeObject({
						index = obj.index,
						position = testDeck.pos[1],
						rotation = testDeck.pos[2],
						smooth = true,
					})
				end
			end
		end
	end
end
function posTiles(tileLengths)  -- определение позиции планшетов
    local totalLength = 0

    -- Вычисляем общую длину всех тайлов
    for _, length in ipairs(tileLengths) do
        totalLength = totalLength + length
    end

    -- Вычисляем начальную позицию для первого тайла
    local startPosition = totalLength / 2
    local currentPosition = startPosition

    -- Размещаем тайлы
    local tiles = {}
    for _, length in ipairs(tileLengths) do
        -- Позиция тайла будет смещена на половину его длины
        local centerPosition = currentPosition - length / 2
        table.insert(tiles, centerPosition)
        currentPosition = currentPosition - length
    end

    return tiles
end
function updateTurns()  -- обновление порядка ходов
	if playersTurns then
		PlOrder = {}
		for _, player in ipairs(playersTurns) do
			if getObjectFromGUID(PLData.readyRokets[1][player]) then
				table.insert(PlOrder, player)
			end
		end
		Turns.order = PlOrder
	end
	--if #Turns.order == 1 then
	--	printToAll(Turns.order[1] ..", ты последний неспасовавший игрок")
	--end
end
function takeName(cont, array)  -- доставание объекта по имени/описанию
	if type(cont) == "string" then
		container = GOG(cont)
	else
		container = cont
	end
	if type(array.name) == "string" then
		for _, obj in ipairs(container.getObjects()) do
			if obj.name == array.name then
				array.index = obj.index
				rnrt = container.takeObject(array)
				break
			end
		end
	elseif type(array.desc) == "string" then
		for _, obj in ipairs(container.getObjects()) do
			if obj.description == array.desc then
				array.index = obj.index
				rnrt = container.takeObject(array)
				break
			end
		end
	else
		rnrt = container.takeObject(array)
	end
	return rnrt
end
function hexGrid(num)
	pos = {}
	SizeMap = 5
	OX, OY = 0.27, 0.67
	SX, SY = 1.21, 2.08
	for y = 1, 2 * SizeMap - 1 do
		for x = 1, SizeMap + y - math.max(0, 2 * y - 2 * SizeMap) - 1 do
			offset = 2 * SizeMap - (SizeMap + y - math.max(0, 2 * y - 2 * SizeMap) - 1) -1
			table.insert(pos, {(offset + 2*(x-SizeMap))*SX+OX, 0, (-(y-SizeMap))*SY+OY})
		end
	end
	return pos[num]
end
function GOG(guid)  -- getObjectFromGUID()-
	return getObjectFromGUID(guid)
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

function onSave()  -- система сохранения
	local state = {}
	state.generation = generation
	state.configs = configs
	state.playersTurns = playersTurns
	state.STEP = STEP
	
	if objs then
		local objs2 = {}
		for name, value in pairs(objs) do
			if type(value) == "userdata" then
				objs2[name] = value.guid
			elseif type(value) == "table" then
				objs2[name] = {}
				for name2, value2 in pairs(value) do
					objs2[name][name2] = value2.guid
				end
			end
		end
		state.objs = objs2
	end
	
	return JSON.encode(state)
end
function onLoad(saved_data)  -- система загрузки и блокировка объектов
	if not (saved_data == nil or saved_data == "[]" or saved_data == "") then
		saved_data = JSON.decode(saved_data)

		generation = saved_data.generation
		configs = saved_data.configs
		playersTurns = saved_data.playersTurns
		
		if saved_data.objs then
			local objs2 = saved_data.objs
			objs = {}
			for name, value in pairs(objs2) do
				if type(value) == "string" then
					objs[name] = getObjectFromGUID(value)
				elseif type(value) == "table" then
					objs[name] = {}
					for name2, value2 in pairs(value) do
						objs[name][name2] = getObjectFromGUID(value2)
					end
				end
			end
		end
		
		if saved_data.STEP == 1 then
			buyCard()
		elseif saved_data.STEP == 2 then
			actions()
		elseif saved_data.STEP == 4 then
			solarStage()
		end
		
		if configs then
			setPlayerTurns()
			setUI()
		end
	end
	
	for _, guid in pairs(locker) do
		object = getObjectFromGUID(guid)
		if object then
			object.interactable = false
		end
	end
	
	
	if configs then
		if configs.underworld == true then
			for _, guid in ipairs({"8f0349", "37d67b", "cbd6ad", "6d2f58", "3e934d", "d1608f", "4464b8", "66b027", "46bc95", "a3c43c"}) do
				getObjectFromGUID(guid).setInvisibleTo({})
			end
		else
			for _, guid in ipairs({"8f0349", "37d67b", "cbd6ad", "6d2f58", "3e934d", "d1608f", "4464b8", "66b027", "46bc95", "a3c43c"}) do
				getObjectFromGUID(guid).setInvisibleTo({"White", "Red", "Yellow", "Green", "Blue"})
			end
		end
		if configs.crisis == true then
			objs.politicTile.call("checkAll")
		end
	else
		for _, guid in ipairs({"8f0349", "37d67b", "cbd6ad", "6d2f58", "3e934d", "d1608f", "4464b8", "66b027", "46bc95", "a3c43c"}) do
			getObjectFromGUID(guid).setInvisibleTo({"White", "Red", "Yellow", "Green", "Blue"})
		end
	end
end