minetest.register_node("bells:bronze_bell", {
	description = "Bronze Bell",
	drawtype = "mesh",
	tiles = {"default_bronze_block.png"},
	paramtype = "light",
	mesh = "bells_bell.obj",
	selection_box = {
		type = "fixed",
		fixed = {-0.55, -0.5, -0.55, 0.55, 0.5, 0.55}
	},
	is_ground_content = false,
	groups = {cracky = 2},
	on_punch = function (pos, node, puncher)
		minetest.sound_play('bells_bell_punch', {pos = pos, gain = 1.5, max_hear_distance = 2000});
	end,
	on_rightclick = function(pos, node, puncher)
		minetest.sound_play('bells_bell', {pos = pos, gain = 15, max_hear_distance = 1000});
	end,
})

minetest.register_craft({
	output = "bells:bronze_bell",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "", "default:bronze_ingot"},
		{"default:bronze_ingot", "", "default:bronze_ingot"},
			}
})

minetest.register_node("bells:silver_bell", {
	description = "Silver Bell",
	drawtype = "mesh",
	tiles = {"default_steel_block.png"},
	paramtype = "light",
	mesh = "bells_bell.obj",
	selection_box = {
		type = "fixed",
		fixed = {-0.55, -0.5, -0.55, 0.55, 0.5, 0.55}
	},
	is_ground_content = false,
	groups = {cracky = 2},
	on_punch = function (pos, node, puncher)
		minetest.sound_play('bells_bell_punch', {pos = pos, gain = 1.5, max_hear_distance = 2000});
	end,
	on_rightclick = function(pos, node, puncher)
		minetest.sound_play('bells_bell', {pos = pos, gain = 15, max_hear_distance = 1000});
	end,
})

minetest.register_craft({
	output = "bells:silver_bell",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
			}
})

minetest.register_node("bells:iron_bell", {
	description = "Iron Bell",
	drawtype = "mesh",
	tiles = {"default_iron_block.png"},
	paramtype = "light",
	mesh = "bells_bell.obj",
	selection_box = {
		type = "fixed",
		fixed = {-0.55, -0.5, -0.55, 0.55, 0.5, 0.55}
	},
	is_ground_content = false,
	groups = {cracky = 2},
	on_punch = function (pos, node, puncher)
		minetest.sound_play('bells_bell_punch', {pos = pos, gain = 1.5, max_hear_distance = 2000});
	end,
	on_rightclick = function(pos, node, puncher)
		minetest.sound_play('bells_bell', {pos = pos, gain = 15, max_hear_distance = 1000});
	end,
})

minetest.register_craft({
	output = "bells:iron_bell",
	recipe = {
		{"default:iron_lump", "default:iron_lump", "default:iron_lump"},
		{"default:iron_lump", "", "default:iron_lump"},
		{"default:iron_lump", "", "default:iron_lump"},
			}
})