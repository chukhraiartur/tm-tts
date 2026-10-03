oxygen = {
    {8.40, 1.54, 9.12},
    {7.38, 1.54, 9.94},
    {6.28, 1.54, 10.64},
    {5.08, 1.54, 11.23},
    {3.94, 1.54, 11.68},
    {2.67, 1.54, 12.00},
    {1.43, 1.54, 12.21},
    {0.20, 1.54, 12.23},
    {-1.05, 1.54, 12.18},
    {-2.31, 1.54, 11.97},
    {-3.51, 1.54, 11.69},
    {-4.70, 1.54, 11.20},
    {-5.84, 1.54, 10.59},
    {-6.96, 1.54, 9.84},
    {-8.03, 1.54, 9.02},
}


function onLoad(saved_data)
	if saved_data ~= "" and saved_data ~= nil then
    			local loaded_data = JSON.decode(saved_data)
    index = loaded_data.oxygenIndex
	else
    index = #oxygen
end

self.createButton({
         click_function = 'increaseO2',
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
        click_function = 'decrease02',
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


function increaseO2(object, color)
    index = index - 1
    if index > 0 then
        marker = getObjectFromGUID("ca3d95")
		marker.setPositionSmooth(oxygen[index])
		
		if color then
			printToAll(Player[color].steam_name .. " увеличивает уровень кислорода на 1%",{0, 1, 0})
			getObjectFromGUID(Global.getVar("PLData").resLists[color]).setVar("RT", getObjectFromGUID(Global.getVar("PLData").resLists[color]).getVar("RT") + 1)
			getObjectFromGUID(Global.getVar("PLData").resLists[color]).call("RTupd")
			
			if index == 7 then
				getObjectFromGUID("c9adc5").call("heat", color)
			end
		else
			printToAll("Правительство увеличивает уровень кислорода на 1%",{0.5, 0.5, 0.5})
		end
    else
        printToAll("Уровень кислорода не может быть выше 14%",{1,0,0})
        index = index + 1
    end
end

function breath(color)
	increaseO2(self, color)
end

function decrease02(object, color)
        index = index + 1
    if index <= 15 then
         marker = getObjectFromGUID("ca3d95")
         marker .setPositionSmooth(oxygen[index])
        printToAll(Player[color].steam_name .. " уменьшает уровень кислорода на 1%", {1, 1, 0})
    else
        printToAll("Уровень кислорода не может быть ниже 0%", {1,0,0})
        index = index - 1
    end
end




function onSave()

    --Put variables to save into a table
    local data_to_save = {oxygenIndex = index}
    saved_data = JSON.encode(data_to_save)
    return saved_data
end
