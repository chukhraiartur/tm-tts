buttonsData = {
	{tooltip = "ЭРА КОРПОРАЦИЙ\n\n67 проектов\n+4 промо проекта\n2 корпорации",
	position = {-0.4, 0.3, -0.781}, click_function = "FeraCorp"},
	{tooltip = "ПРОЛОГ\n\n35 прологов\n7 проектов\n5 корпораций",
	position = {-0.4, 0.3, -0.673}, click_function = "Fprologe"},
	{tooltip = "ВЕНЕРА\n\nПоле Венеры\n49 проектов\n5 корпораций",
	position = {-0.4, 0.3, -0.565}, click_function = "Fvenus"},
	{tooltip = "КОЛОНИИ\n\n11 колоний\n49 проектов\n5 корпораций",
	position = {-0.4, 0.3, -0.457}, click_function = "Fcolony"},
	{tooltip = "КРИЗИС\n\nПоле событий\nПолитическое поле\n36 событий\n17 проектов\n6 корпораций",
	position = {-0.4, 0.3, -0.349}, click_function = "Fcrisis"},
	{tooltip = "ПЕРВООТКРЫВАТЕЛИ\n\nПоле влияния\n10 специальных тайлов\n6 событий\n16 прологов\n2 колонии\n60 проектов\n23 корпораций",
	position = {-0.4, 0.3, -0.241}, click_function = "Fpathfinders"},
	{tooltip = "АРЕС\n\n23 проектов (11 обновленных старых)\n22 специальных тайлов (11 обновленных старых)",
	position = {-0.4, 0.3, -0.133}, click_function = "Fares"},
	{tooltip = "ПОДЗЕМНЫЙ МИР\n\n91 жетон подземных ресурсов\n92 проекта\n12 корпораций\n15 прологов\n5 событий\n3 колонии",
	position = {-0.4, 0.3, -0.025}, click_function = "Funderworld"},
	{tooltip = "СПОНСОРСТВО\n\n26 жетонов спонсоров",
	position = {-0.4, 0.3, 0.083}, click_function = "Fsponsorship"},
	
	{tooltip = "Количество корпораций для выбора",
	position = {0.4, 0.3, -0.781}, click_function = "FcorpCount"},
	{tooltip = "Количество прологов для выбора",
	position = {0.4, 0.3, -0.673}, click_function = "FprologeCount"},
	{tooltip = "Выбор игрового поля: база, Эллада, Элизий",
	position = {0.4, 0.3, -0.565}, click_function = "Fmap"},
	{tooltip = "Правительственная поддержка:\nВ конце поколения первый игрок повышает 1 из глобальных параметров не получая от этого бонусов",
	position = {0.4, 0.3, -0.457}, click_function = "Fsupport"},
	{tooltip = "Перерасчет РТ:\nУменьшать ли РТ в фазе солнечной системы при игре с дополнением 'Кризис'",
	position = {0.4, 0.3, -0.349}, click_function = "Fminusrt"},
	{tooltip = "Драфт:\nВ фазе исследования игроки будут обмениваться картами, что повысит контроль над картами и позволит посмотреть больше вариантов",
	position = {0.4, 0.3, -0.241}, click_function = "Fdraft"},
	{tooltip = "Обязательное терраформирование Венеры:\nДля окончания игры необходимо полное терраформирование Венеры\nПри включенной Правительственной поддержке будет вариант повышения Венеры",
	position = {0.4, 0.3, -0.133}, click_function = "FreqVenus"},
	{tooltip = 'Случайные достижения и награды:\nЗаменяет достижения и награды поля на 5 (6 при игре с "Венерой") случайных жетонов из 62 возможных',
	position = {0.4, 0.3, -0.025}, click_function = "FrandomMA"},
	{tooltip = "Настраиваемый старт:\nВ начале игры игроки получают несколько жетонов достижений, наград, колоний и спонсоров, они могут выбрать какие из них будут выложены на стол, остальные будут убраны.\n0 - выключено\n2-4 - количество выдаваемых жетонов каждого типа",
	position = {0.4, 0.3, 0.083}, click_function = "FcontrolStart"},
	{tooltip = "Чередование хода:\nВ четных поколениях ход передается по часовой стрелке, в нечетных - против часовой (как в драфте)\nВыключено - всегда по часовой",
	position = {0.4, 0.3, 0.191}, click_function = "FaltTurns"},

	{tooltip = "Закончить подготовку и начать игру!",
	position = {0, 0.3, 0.9}, scale = {0.4, 1, 0.4}, click_function = "finishSetup"},
}
checksData = {
	{tooltip = "eraCorp",		position = {-0.9, 0.2, -0.781}},
	{tooltip = "prologe",		position = {-0.9, 0.2, -0.673}},
	{tooltip = "venus",			position = {-0.9, 0.2, -0.565}},
	{tooltip = "colony",		position = {-0.9, 0.2, -0.457}},
	{tooltip = "crisis",		position = {-0.9, 0.2, -0.349}},
	{tooltip = "pathfinders",	position = {-0.9, 0.2, -0.241}},
	{tooltip = "ares",			position = {-0.9, 0.2, -0.133}},
	{tooltip = "underworld",	position = {-0.9, 0.2, -0.025}},
	{tooltip = "sponsorship",	position = {-0.9, 0.2, 0.083}},
	
	{tooltip = "corpCount",		position = {0.9, 0.2, -0.781}},
	{tooltip = "prologeCount",	position = {0.9, 0.2, -0.673}},
	{tooltip = "map",			position = {0.77, 0.2, -0.565}},
	{tooltip = "support",		position = {0.9, 0.2, -0.457}},
	{tooltip = "minusrt",		position = {0.9, 0.2, -0.349}},
	{tooltip = "draft",			position = {0.9, 0.2, -0.241}},
	{tooltip = "reqVenus",		position = {0.9, 0.2, -0.133}},
	{tooltip = "randomMA",			position = {0.9, 0.2, -0.025}},
	{tooltip = "controlStart",	position = {0.9, 0.2, 0.083}},
	{tooltip = "altTurns",		position = {0.9, 0.2, 0.191}},
}

config = {
	eraCorp = false,
	prologe = false,
	venus = false,
	colony = false,
	crisis = false,
	pathfinders = false,
	ares = false,
	underworld = false,
	sponsorship = false,
	
	corpCount = 2,
	prologeCount = 4,
	map = 1,
	support = false,
	minusrt = true,
	draft = false,
	reqVenus = false,
	randomMA = false,
	controlStart = 0,
	altTurns = false,
}


function onLoad()
	self.clearButtons()
	
	for _, button in ipairs(buttonsData) do
		addButton(button)
	end
	for _, check in ipairs(checksData) do
		addCheck(check)
	end
	for _, cfg in pairs(config) do
		if type(cfg) == "boolean" then
			updateCheck(_)
		else
			updateCheck(_, config[_])
		end
	end
	updateCheck("map", "База")
end


function FeraCorp()
	config.eraCorp = not config.eraCorp
	updateCheck("eraCorp")
end
function Fprologe()
	config.prologe = not config.prologe
	updateCheck("prologe")
end
function Fvenus()
	config.venus = not config.venus
	updateCheck("venus")
end
function Fcolony()
	config.colony = not config.colony
	updateCheck("colony")
end
function Fcrisis()
	config.crisis = not config.crisis
	updateCheck("crisis")
end
function Fpathfinders()
	config.pathfinders = not config.pathfinders
	updateCheck("pathfinders")
end
function Fares()
	config.ares = not config.ares
	updateCheck("ares")
end
function Funderworld()
	config.underworld = not config.underworld
	updateCheck("underworld")
end
function Fsponsorship()
	config.sponsorship = not config.sponsorship
	updateCheck("sponsorship")
end

function FcorpCount()
	config.corpCount = config.corpCount % 8 +1
	updateCheck("corpCount", config.corpCount)
end
function FprologeCount()
	config.prologeCount = (config.prologeCount+1) % 17
	updateCheck("prologeCount", config.prologeCount)
end
function Fmap()
	config.map = config.map % 4 +1
	name = {"База", "Эллада", "Элизий", "Рандом"}  -- 4 - случайное поле, выбирается в Global при старте
	updateCheck("map", name[config.map])
end
function Fsupport()
	config.support = not config.support
	updateCheck("support")
end
function Fminusrt()
	config.minusrt = not config.minusrt
	updateCheck("minusrt")
end
function Fdraft()
	config.draft = not config.draft
	updateCheck("draft")
end
function FreqVenus()
	config.reqVenus = not config.reqVenus
	updateCheck("reqVenus")
end
function FrandomMA()
	config.randomMA = not config.randomMA
	updateCheck("randomMA")
end
function FcontrolStart()
	config.controlStart = (config.controlStart +1) % 5
	if config.controlStart == 1 then
		config.controlStart = 2
	end
	updateCheck("controlStart", config.controlStart)
end
function FaltTurns()
	config.altTurns = not config.altTurns
	updateCheck("altTurns")
end

function finishSetup()
	Global.call("setup")
end



function updateCheck(check, value)
	for _, button in pairs(self.getButtons()) do
		if button.tooltip == check then
			if value == nil then
				if config[check] then
					self.editButton({index = button.index, label = "✔"})
				else
					self.editButton({index = button.index, label = "✘️"})
				end
			else
				self.editButton({index = button.index, label = value})
			end
		end
	end
end
function addButton(param)
	default = {
		click_function = " ",
		function_owner = self,
		tooltip = " ",
		position = {0, 0.3, 0},
		rotation = {0, 0, 0},
		scale = {0.55, 1, 0.4},
		width = 800,
		height = 100,
		font_size = 120,
		color = {1, 1, 1, 0},
		hover_color = {1, 1, 1, 0.07},
		press_color = {0.99, 0.54, 0, 0.3},
	}
	for edit, value in pairs(param) do
		default[edit] = value
	end
	self.createButton(default)
end
function addCheck(param)
	default = {
		click_function = " ",
		function_owner = self,
		label = "✘️",
		position = {0, 0.3, 0},
		rotation = {0, 0, 0},
		scale = {0.15, 1, 0.15},
		width = 0,
		height = 0,
		font_size = 300,
		color = {1, 1, 1},
		font_color = {1, 0.44, 0},
	}
	for edit, value in pairs(param) do
		default[edit] = value
	end
	self.createButton(default)
end