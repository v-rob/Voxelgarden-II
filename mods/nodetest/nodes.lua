minetest.register_node("nodetest:papyrus_roots", {
	description = "Papyrus Roots",
	tiles = {"nodetest_papyrus_roots.png"},
	paramtype = "light",
	is_ground_content = true,
	liquids_pointable = true,
	groups = {snappy=2, flammable=2, oddly_breakable_by_hand=1, soil=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("nodetest:wattle", {
	description = "Wattle",
	tiles = {"nodetest_wattle.png"},
	paramtype = "light",
	is_ground_content = true,
	liquids_pointable = true,
	groups = {snappy=2, flammable=2, oddly_breakable_by_hand=1, soil=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("nodetest:seedling", {
	description = "Seedling",
	drawtype = "plantlike",
	tiles = {"nodetest_seedling.png"},
	inventory_image = "nodetest_seedling.png",
	wield_image = "nodetest_seedling.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {snappy=3, flammable=2, flora=1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"Jungle"},
	decoration = {"nodetest:seedling"},
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"Jungle"},
	decoration = {"farming:weed"},
	y_min = 0,
	y_max = 32000,
})