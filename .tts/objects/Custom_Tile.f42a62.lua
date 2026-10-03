Backs = {
	project = "https://steamusercontent-a.akamaihd.net/ugc/99472719161571100/EA0122B9E00F0FB9069FC2C275D83C63D1D5BA3E/",
	corporation = "https://steamusercontent-a.akamaihd.net/ugc/830203174353589618/94E278550FA7701ACDF2BA3BCDDF508964122104/",
	prolog = "https://steamusercontent-a.akamaihd.net/ugc/28804201134524710/B8335437F9AD086CC9B9522E928577D6E1344DEA/",
	crisis = "https://steamusercontent-a.akamaihd.net/ugc/1636452068648244507/9E93DA1D2229D74112A016D4C54DEE598126A426/",
	sponsorship = "https://steamusercontent-a.akamaihd.net/ugc/28811178277742185/1E5CD93249373D9E124B2060581F43DC5BF921FF/",
	milestone = "https://steamusercontent-a.akamaihd.net/ugc/28812445892062376/2A6C6D3AA5FC654AFFD6F3260AFAC83514571181/",
	award = "https://steamusercontent-a.akamaihd.net/ugc/28812445892062293/66A0D24C0E463AED66FBB72DBA00496B34EFC9DE/",
}
discardPos = {
	project = {{-21.27, 3, -10.76}, {0.00, 180.00, 180.00}},
	corporation = {{-58.00, 2.00, 19.00}, {0.00, 180.00, 0.00}},
	prolog = {{-58.00, 2.00, 23.00}, {0.00, 180.00, 0.00}},
	sponsorship = {{-60.00, 3.00, 31.00}, {0.00, 90.00, 0.00}},
	milestone = {{-58.0, 3.00, 31.00}, {0.00, 90.00, 0.00}},
	award = {{-56.00, 3.00, 31.00}, {0.00, 90.00, 0.00}},
}

function onload ()
	self.createButton({
		click_function = 'discard',
		label = 'Discard',
		function_owner = self,
		position = { 0, -0.1, 0},
		rotation = {0, 0, 0},
		width = 1200,
		height = 500,
		font_size = 200
	})
end

function discard(_, colour)
	for _, obj in pairs(Player[colour].getHandObjects()) do
		if obj.type == "Card" then
			for __, data in pairs(obj.getData().CustomDeck) do
				for back, url in pairs(Backs) do
					if data.BackURL == url then
						obj.setPosition(discardPos[back][1])
						obj.setRotation(discardPos[back][2])
					end
				end
			end
		elseif obj.type == "Tile" and obj.getDescription() == "Колония" then
			Global.getVar("objs").colonyBag.putObject(obj)
		end
	end
end
