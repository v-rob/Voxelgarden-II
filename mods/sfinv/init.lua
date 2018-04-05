dofile(minetest.get_modpath("sfinv") .. "/api.lua")

sfinv.register_page("sfinv:crafting", {
	title = "Crafting",
	get = function(self, player, context)
		return sfinv.make_formspec(player, context,
				"size[13.3,7.3]"..
				--"image[6,0.6;1,2;player.png]"..
				"list[current_player;main;2.5,3.5;8,4;]"..
				"list[current_player;craft;4.5,0;3,3;]"..
				"list[current_player;craftpreview;8.5,1;1,1;]"..
				"image[7.5,1;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
				"listring[current_player;main]"..
				"listring[current_player;craft]", true)
	end
})
