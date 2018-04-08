minetest.clear_registered_biomes()
-- Below 0
minetest.register_biome({
	name = "Sea_Dirt",
	node_top = "default:dirt",			depth_top = 3,
	node_riverbed = "default:dirt",	depth_riverbed = 2,
	y_min = -32000,					y_max = 0,
	heat_point = 70,				humidity_point = 40,
})

minetest.register_biome({
	name = "Sea_Sand",
	node_top = "default:sand",			depth_top = 3,
	node_riverbed = "default:sand",	depth_riverbed = 2,
	y_min = -32000,					y_max = 5,
	heat_point = 130,				humidity_point = 40,
})

minetest.register_biome({
	name = "Sea_Desert_Sand",
	node_top = "default:desert_sand",		depth_top = 3,
	node_filler = "default:desert_stone",	depth_filler = 3,
	node_riverbed = "default:desert_sand",	depth_riverbed = 2,
	node_stone = "default:desert_stone",
	y_min = -32000,					y_max = 5,
	heat_point = 150,				humidity_point = -60,
})

minetest.register_biome({
	name = "Sea_Gravel",
	node_top = "default:gravel",		depth_top = 3,
	node_filler = "default:stone",		depth_filler = 3,
	node_riverbed = "default:gravel",	depth_riverbed = 2,
	y_min = -32000,					y_max = 5,
	heat_point = 70,				humidity_point = -60,
})

-- Over 0
-- Woods
minetest.register_biome({
	name = "Conifer",
	node_top = "default:dirt_with_snow",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	node_riverbed = "default:dirt",	depth_riverbed = 2,
	y_min = 1,					y_max = 32000,
	heat_point = 40,				humidity_point = 70,
})
-- Transition Conifer-Tree
minetest.register_biome({
	name = "CT",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	node_riverbed = "default:dirt",	depth_riverbed = 2,
	y_min = 1,					y_max = 32000,
	heat_point = 65,				humidity_point = 75,
})

minetest.register_biome({
	name = "Tree",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 3,
	node_riverbed = "default:dirt",	depth_riverbed = 2,
	y_min = 1,					y_max = 32000,
	heat_point = 90,				humidity_point = 80,
})

minetest.register_biome({
	name = "Jungle",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 4,
	node_riverbed = "default:dirt",	depth_riverbed = 2,
	y_min = 1,					y_max = 32000,
	heat_point = 140,				humidity_point = 70,
})

minetest.register_biome({
	name = "Desert",
	node_top = "default:desert_sand",		depth_top = 3,
	node_filler = "default:desert_stone",		depth_filler = 8,
	node_riverbed = "default:sand",	depth_riverbed = 2,
	node_stone = "default:desert_stone",
	y_min = 1,					y_max = 32000,
	heat_point = 155,				humidity_point = -45,
})

-- Special Biomes
minetest.register_biome({
	name = "Glacier",
	node_top = "default:snowblock",			depth_top = 2,
	node_filler = "default:ice",			depth_filler = 32,
	node_water_top = "default:ice",			depth_water_top = 3,
	node_riverbed = "default:gravel",	depth_riverbed = 2,
	node_river_water = "default:ice",
	y_min = 1,					y_max = 32000,
	heat_point = 20,				humidity_point = -30,
})

minetest.register_biome({
	name = "Gravel_Ice",
	node_top = "default:gravel",			depth_top = 3,
	node_dust = "default:snow",
	node_water_top = "default:ice",			depth_water_top = 3,
	node_riverbed = "default:gravel",	depth_riverbed = 2,
	node_river_water = "default:ice",
	y_min = 1,					y_max = 32000,
	heat_point = 1,				humidity_point = -40,
})

minetest.register_biome({
	name = "Gravel_Desert",
	node_top = "default:gravel",			depth_top = 3,
	node_filler = "default:desert_stone",		depth_filler = 3,
	node_riverbed = "default:gravel",	depth_riverbed = 2,
	node_stone = "default:desert_stone",
	y_min = 1,					y_max = 32000,
	heat_point = 200,				humidity_point = -20,
})

-- Decoration

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.00,
		scale = 0.020,
		spread = {x = 250, y = 250, z = 250},
		seed = 153,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"Conifer", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_1.mts",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.00,
		scale = 0.010,
		spread = {x = 250, y = 250, z = 250},
		seed = 154,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"Conifer", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_2.mts",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.00,
		scale = 0.030,
		spread = {x = 250, y = 250, z = 250},
		seed = 538,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"Tree", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_tree.mts",
	rotation = "random",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.001,
	biomes = {"Tree", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_cherry_tree.mts",
	rotation = "random",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.05,
		scale = 0.020,
		spread = {x = 250, y = 250, z = 250},
		seed = 539,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"Tree", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_apple_tree.mts",
	rotation = "random",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.03,
	biomes = {"Jungle"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_jungletree.mts",
	rotation = "random",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:cactus"},
	sidelen = 16,
	fill_ratio = 0.15,
	biomes = {"Jungle"},
	decoration = {"default:junglegrass"},
	y_min = 0,
	y_max = 32000,
})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:orange_leaves",
		wherein        = "default:jungleleaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:berry_leaves",
		wherein        = "default:leaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:mango_leaves",
		wherein        = "default:jungleleaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:peach_leaves",
		wherein        = "default:leaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:pear_leaves",
		wherein        = "default:leaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:plum_leaves",
		wherein        = "default:leaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:apple_leaves",
		wherein        = "default:leaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:banana_leaves",
		wherein        = "default:jungleleaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "conifer:pine_cone_leaves_1",
		wherein        = "conifer:leaves_1",
		clust_scarcity = 3 * 3 * 3,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "conifer:pine_cone_leaves_2",
		wherein        = "conifer:leaves_2",
		clust_scarcity = 3 * 3 * 3,
		clust_num_ores = 1,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})