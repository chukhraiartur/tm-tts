temperature = {
	{14.29, 1.51,10.30},
	{14.30, 1.51, 9.42},
	{14.33, 1.51, 8.55},
	{14.36, 1.51, 7.62},
	{14.34, 1.51, 6.72},
	{14.36, 1.51, 5.85},
	{14.35, 1.51, 4.95},
	{14.34, 1.51, 4.04},
	{14.36, 1.51, 3.16},
	{14.29, 1.51, 2.25},
	{14.32, 1.51, 1.34},
	{14.30, 1.51, 0.43},
	{14.31, 1.51, -0.45},
	{14.32, 1.51, -1.33},
	{14.36, 1.51, -2.22},
	{14.39, 1.51, -3.14},
	{14.39, 1.51, -4.05},
	{14.39, 1.51, -4.95},
	{14.40, 1.51, -5.83},
	{14.27, 1.51, -7.16},
}


function onLoad(saved_data)
	if saved_data ~= "" and saved_data ~= nil then
    			local loaded_data = JSON.decode(saved_data)
    index = loaded_data.tempIndex
	else
    index = #temperature
	end
    self.createButton({
         click_function = 'increaseTemp',
            label = '+',
            function_owner = self,
            position = { 0, 0.2, 0.9},
            rotation = {0, 0, 0},
            width = 1000,
            height = 500,
            font_size = 450,
            color = {1, 0, 0}
        })
    self.createButton({
            click_function = 'decreaseTemp',
            label = '-',
            function_owner = self,
            position = { 0, 0.2, 2.1},
            rotation = {0, 0, 0},
            width = 500,
            height = 500,
            font_size = 450,
            color = {0.52941176470588, 0.8078431372549, 0.92156862745098}
        })
    end

function increaseTemp(object, color)
    index = index - 1
    if index > 0 then
        tempMarker = getObjectFromGUID("f1bfac")
        tempMarker.setPositionSmooth(temperature[index])
		
		if color then
			printToAll(Player[color].steam_name .. " повышает температуру на 2 градуса", {1, 0.5, 0})
			getObjectFromGUID(Global.getVar("PLData").resLists[color]).setVar("RT", getObjectFromGUID(Global.getVar("PLData").resLists[color]).getVar("RT") + 1)
			getObjectFromGUID(Global.getVar("PLData").resLists[color]).call("RTupd")
			
			if index == 17 or index == 15 then
				getObjectFromGUID(Global.getVar("PLData").resLists[color]).call("ProdAdd", {name = "Тепло", add = 1})
				printToAll(Player[color].steam_name .." повышает свое производство тепла на 1!")
			end
		else
			printToAll("Правительство повышает температуру на 2 градуса", {0.5, 0.5, 0.5})
		end
    else
        printToAll("Температура не может быть выше +8", {1, 0, 0})
        index = index + 1
    end
end
function heat(color)
	increaseTemp(self, color)
end

function decreaseTemp(object, color)
        index = index + 1
    if index <= 20 then
        tempMarker = getObjectFromGUID("f1bfac")
        tempMarker.setPositionSmooth(temperature[index])
        printToAll(Player[color].steam_name .. " понижает температуру на 2 градуса", {1, 1, 0})
    else
        printToAll("Температура не может быть ниже -30", {1,0,0})
        index = index - 1
    end
end


function onSave()

    --Put variables to save into a table
    local data_to_save = {tempIndex = index}
    saved_data = JSON.encode(data_to_save)
    return saved_data
end
