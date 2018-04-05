dofile(minetest.get_modpath("player_api") .. "/api.lua")

-- Default player appearance
player_api.register_model("player.obj", {
	animation_speed = 0,
	textures = {"player_back.png", "player.png"},
	animations = {
		-- Standard animations.
		stand     = {x = 0,   y = 0},
		lay       = {x = 0,   y = 0},
		walk      = {x = 0,   y = 0},
		mine      = {x = 0,   y = 0},
		walk_mine = {x = 0,   y = 0},
		sit       = {x = 0,   y = 0},
	},
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.77, 0.3},
	stepheight = 1.1,
})

-- Update appearance when the player joins
minetest.register_on_joinplayer(function(player)
	player_api.player_attached[player:get_player_name()] = false
	player_api.set_model(player, "player.obj")
	player:set_local_animation(
		{x = 0,   y = 0},
		{x = 0,   y = 0},
		{x = 0,   y = 0},
		{x = 0,   y = 0},
		0
	)
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end)
