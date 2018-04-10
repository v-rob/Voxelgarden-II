furnature = {}

minetest.register_node("furnature:chair", {
	    description = "Chair",
		tiles = {"furnature_wood.png"},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
		    type = "fixed",
		    fixed = {
				{-0.3125, -0.5, 0.1875, -0.1875, 0.5, 0.3125},
				{0.1875, -0.5, 0.1875, 0.3125, 0.5, 0.3125},
				{-0.3125, -0.5, -0.3125, -0.1875, 0, -0.1875},
				{0.1875, -0.5, -0.3125, 0.3125, 0, -0.1875},
				{-0.3125, -0.125, -0.3125, 0.3125, 0, 0.3125},
				{-0.25, 0.0625, 0.25, 0.25, 0.4375, 0.25},
		    },
		},
		selection_box = {
		    type = "fixed",
		    fixed = {-0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.3125},
		},
		groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2},
		sounds = default.node_sound_wood_defaults(),
	})
	
	minetest.register_craft({
		output = 'furnature:chair',
		recipe = {
			{'group:stick', ''},
			{'group:stick', 'furnature:wood'},
			{'group:stick', 'group:stick'},
		}
	})

minetest.register_node("furnature:bench", {
	drawtype = "nodebox",
	description = ("Plain Bench"),
	tiles = {"furnature_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.15, 0.1,  0.5,  -0.05, 0.5},
					{-0.4, -0.5,  0.2, -0.3, -0.15, 0.4},
					{ 0.3, -0.5,  0.2,  0.4, -0.15, 0.4},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, 0, 0.5, 0, 0.5},
				}
	},
})

minetest.register_craft({
	output = 'furnature:bench',
	recipe = {
		{'group:stick', 'furnature:wood', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_node("furnature:shelf", {
	drawtype = "nodebox",
	description = ("Shelf"),
	tiles = {"furnature_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
 			{-0.5, -0.5, -0.3, -0.4, 0.5, 0.5},
 			{0.4, -0.5, -0.3, 0.5, 0.5, 0.5},
			{-0.5, -0.2, -0.3,  0.5, -0.1, 0.5},
			{-0.5, 0.3, -0.3, 0.5, 0.4, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5,  0.5, 0.5,  0.5},
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos);
		meta:set_string("formspec",
			"size[8,8]"..
			"list[current_name;main;0,0;8,3;]"..
			"list[current_player;main;0,4;8,4;]")
		meta:set_string("infotext", ("Storage Shelf"))
		local inv = meta:get_inventory();
		inv:set_size("main", 24);
	end,
	can_dig = function( pos,player )
		local  meta = minetest.get_meta( pos );
		local  inv = meta:get_inventory();
		return inv:is_empty("main");
	end,
	on_metadata_inventory_put  = function(pos, listname, index, stack, player)
		local  meta = minetest.get_meta( pos );
		meta:set_string('infotext', ('Storage Shelf'));
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local  meta = minetest.get_meta( pos );
		local  inv = meta:get_inventory();
		if( inv:is_empty("main")) then
				meta:set_string('infotext', ('Storage Shelf'));
		end
	end,
})

minetest.register_craft({
	output = 'furnature:shelf',
	recipe = {
		{'furnature:wood', '', 'furnature:wood'},
		{'furnature:wood', 'group:stick', 'furnature:wood'},
		{'furnature:wood', '', 'furnature:wood'},
	}
})

minetest.register_node("furnature:table", {
	drawtype = "nodebox",
	description = ("Table"),
	tiles = {"furnature_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		    type = "fixed",
		    fixed = {
		        { -0.4, -0.5, -0.4, -0.3,  0.4, -0.3 },
		        {  0.3, -0.5, -0.4,  0.4,  0.4, -0.3 },
		        { -0.4, -0.5,  0.3, -0.3,  0.4,  0.4 },
		        {  0.3, -0.5,  0.3,  0.4,  0.4,  0.4 },
		        { -0.5,  0.4, -0.5,  0.5,  0.5,  0.5 },
		        { -0.4, -0.2, -0.3, -0.3, -0.1,  0.3 },
		        {  0.3, -0.2, -0.4,  0.4, -0.1,  0.3 },
		        { -0.3, -0.2, -0.4,  0.4, -0.1, -0.3 },
		        { -0.3, -0.2,  0.3,  0.3, -0.1,  0.4 },
		    },
		},
		selection_box = {
		    type = "fixed",
		    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
})

minetest.register_craft({
	output = 'furnature:simple_table',
	recipe = {
		{'furnature:wood', 'furnature:wood', 'furnature:wood'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_node("furnature:simple_table", {
	drawtype = "nodebox",
	description = ("Simple Table"),
	tiles = {"furnature_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		    type = "fixed",
		    fixed = {
		        { -0.1, -0.5, -0.1,  0.1, 0.49,  0.1},
				{ -0.5,  0.5, -0.5,  0.5, 0.4,  0.5},
		    },
		},
		selection_box = {
		    type = "fixed",
		    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
})

minetest.register_craft({
	output = 'furnature:table',
	recipe = {
		{'furnature:wood', 'furnature:wood', 'furnature:wood'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_node("furnature:plain_table", {
	drawtype = "nodebox",
	description = ("Plain Table"),
	tiles = {"furnature_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
			type = "fixed",
			fixed = {
				{-0.500000,0.312500,-0.500000,0.500000,0.500000,0.500000},
				{-0.437500,-0.500000,-0.437500,-0.250000,0.500000,-0.250000}, 
				{-0.437500,-0.500000,0.250000,-0.250000,0.500000,0.437500},
				{0.250000,-0.500000,-0.437500,0.437500,0.500000,-0.250000},
				{0.250000,-0.500000,0.250000,0.437500,0.500000,0.447500}, 
			},
		},
		selection_box = {
		    type = "fixed",
		    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
})

minetest.register_craft({
	output = 'furnature:plain_table',
	recipe = {
		{'furnature:wood', 'furnature:wood', 'furnature:wood'},
		{'group:stick', '', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_node("furnature:wood", {
	description = "Polished Wood",
	tiles = {"furnature_wood.png"},
	is_ground_content = false,
	groups = {choppy=2, oddly_breakable_by_hand=1, flammable=3, wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'furnature:wood 2',
	recipe = {
		{'default:wood', 'default:wood'},
	}
})

minetest.register_craft({
	output = 'default:wood',
	recipe = {
		{'furnature:wood'},
	}
})

stairs.register_stair_and_slab(
	"furnature_wood",
	"furnature:wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"furnature_wood.png"},
	"Polished Wooden Stair",
	"Polished Wooden Slab",
	default.node_sound_wood_defaults()
)

dofile(minetest.get_modpath("furnature").."/barter.lua")
dofile(minetest.get_modpath("furnature").."/store.lua")
dofile(minetest.get_modpath("furnature").."/benches.lua")