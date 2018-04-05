conifer = {}

minetest.register_alias("mapgen_pine_tree", "conifer:tree")
minetest.register_alias("mapgen_pine_needles", "conifer:leaves_1")

--
-- Nodes
--

minetest.register_node("conifer:sapling", {
	description = "Conifer Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"conifer_sapling.png"},
	inventory_image = "conifer_sapling.png",
	wield_image = "conifer_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	waving = 1,
	on_timer = function(pos)
		local below = {x=pos.x, y=pos.y-1, z=pos.z}
		local name = minetest.get_node(below).name
		if minetest.get_item_group(name, "soil") ~= 0 then
			conifer.grow_conifersapling(pos)
		end
	end,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2, sapling=1, flammable=2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 4800))
	end,
})

minetest.register_alias("conifers:sapling", "conifer:sapling")
minetest.register_alias("nodetest:conifersapling", "conifer:sapling")

minetest.register_node("conifer:tree", {
	description = "Conifer Tree",
	tiles = {"conifer_tree_top.png", "conifer_tree_top.png", "conifer_tree.png"},
	groups = {tree=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_alias("conifers:trunk", "conifer:tree")
minetest.register_alias("nodetest:conifertree", "conifer:tree")

for i=1,2 do
	minetest.register_node("conifer:leaves_"..i, {
		description = "Conifer Leaves",
		drawtype = "allfaces_optional",
		visual_scale = 1.3,
		tiles = {"conifer_leaves_"..i..".png"},
		paramtype = "light",
		waving = 1,
		trunk = "conifer:tree",
		groups = {
				snappy=3,
				leafdecay=4,
				flammable=2,
				leaves=1,
				fall_damage_add_percent=default.COUSHION
			},
		drop = {
			max_items = 1,
			items = {
				{
					-- player will get sapling with 1/rarity chance
					items = {'conifer:sapling'},
					rarity = 40,
				},
				{
					-- player will get leaves only if he get no saplings,
					-- this is because max_items is 1
					items = {"conifer:leaves_"..i..""},
				}
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})
	
	minetest.register_node("conifer:pine_cone_leaves_"..i, {
		description = "Conifer Cone Leaves",
		drawtype = "allfaces_optional",
		visual_scale = 1.3,
		tiles = {"conifer_leaves_"..i..".png^conifer_pine_cone_leaves.png"},
		paramtype = "light",
		waving = 1,
		groups = {
				snappy=3,
				leafdecay=4,
				flammable=2,
				leaves=1,
				fall_damage_add_percent=default.COUSHION
			},
		drop = "conifer:pine_cone",
		sounds = default.node_sound_leaves_defaults(),
	})
	minetest.register_alias("nodetest:coniferleaves_"..i, "conifer:leaves_"..i)
end

minetest.register_node("conifer:pine_cone", {
	description = "Conifer Cone",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"conifer_pine_cone.png"},
	inventory_image = "conifer_pine_cone.png",
	wield_image = "conifer_pine_cone.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	buildable_to = true,
	floodable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {fleshy=3, dig_immediate=3, flammable=2, attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("conifer:cooked_pine_cone", {
	description = "Cooked Conifer Cone",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"conifer_cooked_pine_cone.png"},
	inventory_image = "conifer_cooked_pine_cone.png",
	wield_image = "conifer_cooked_pine_cone.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	buildable_to = true,
	floodable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {fleshy=3, dig_immediate=3, flammable=2, attached_node=1},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
	type = "cooking",
	output = "conifer:cooked_pine_cone",
	recipe = "conifer:pine_cone",
})

--
-- Crafting definition
--

dofile(minetest.get_modpath("conifer").."/trees.lua")