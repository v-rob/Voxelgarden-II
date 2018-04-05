function furnature.get_nodedef_field(nodename, fieldname)
	if not minetest.registered_nodes[nodename] then
		return nil
	end
	return minetest.registered_nodes[nodename][fieldname]
end

furnature.fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 },
}

furnature.fdir_to_fwd = {
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
}

function furnature.stack_sideways(itemstack, placer, pointed_thing, node1, node2, dir)
	local pos = pointed_thing.under
	local pnode = minetest.get_node(pointed_thing.under)
	local rnodedef = minetest.registered_nodes[pnode.name]

	if not rnodedef["buildable_to"] then
		pos = pointed_thing.above
	end

	local fdir = minetest.dir_to_facedir(placer:get_look_dir())
	local pos2
	if dir then
		pos2 = { x = pos.x + furnature.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + furnature.fdir_to_right[fdir+1][2] }
	else
		pos2 = { x = pos.x + furnature.fdir_to_fwd[fdir+1][1], y=pos.y, z = pos.z + furnature.fdir_to_fwd[fdir+1][2] }
	end

	local tnode = minetest.get_node(pos)
	local tnode2 = minetest.get_node(pos2)

	if furnature.get_nodedef_field(tnode.name, "buildable_to")
	  and furnature.get_nodedef_field(tnode2.name, "buildable_to")
	  and not minetest.is_protected(pos, placer:get_player_name())
	  and not minetest.is_protected(pos2, placer:get_player_name()) then
		minetest.add_node(pos, { name = node1, param2 = fdir })
		minetest.add_node(pos2, { name = node2, param2 = fdir })
		if not (creative and creative.is_enabled_for
					and creative.is_enabled_for(player_name)) then
				itemstack:take_item()
			end
			return itemstack
	end
end

minetest.register_node("furnature:bench_large_1_left", {
	description = "Simple Bench",
	tiles = {"furnature_wood.png",},
	inventory_image = "furnature_bench_large_1_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.375, 0.5, 0.4375, 0.4375}, -- NodeBox1
			{-0.5, 0, 0.375, 0.5, 0.1875, 0.4375}, -- NodeBox2
			{-0.5, -0.125, 0.115, 0.5, -0.0625, 0.35}, -- NodeBox3
			{-0.5, -0.125, -0.0872, 0.5, -0.0625, 0.079}, -- NodeBox4
			{-0.3125, -0.5, 0.4375, -0.25, 0.375, 0.5}, -- NodeBox5
			{-0.3125, -0.25, -0.0625, -0.25, -0.125, 0.4375}, -- NodeBox6
			{-0.3125, -0.5, -0.0625, -0.25, -0.25, 0}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.09375, 1.5, 0.5, 0.5 }
	},
	sounds = default.node_sound_wood_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		return furnature.stack_sideways(itemstack, placer, pointed_thing,
			"furnature:bench_large_1_left", "furnature:bench_large_1_right", true)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + furnature.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + furnature.fdir_to_right[fdir+1][2] }
		if minetest.get_node(pos2).name == "furnature:bench_large_1_right" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("furnature:bench_large_1_right", {
	tiles = {"furnature_wood.png",},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.375, 0.5, 0.4375, 0.4375}, -- NodeBox1
			{-0.5, 0, 0.375, 0.5, 0.1875, 0.4375}, -- NodeBox2
			{-0.5, -0.125, 0.115, 0.5, -0.0625, 0.35}, -- NodeBox3
			{-0.5, -0.125, -0.0872, 0.5, -0.0625, 0.079}, -- NodeBox4
			{0.25, -0.5, 0.4375, 0.3125, 0.375, 0.5}, -- NodeBox5
			{0.25, -0.25, -0.0625, 0.3125, -0.125, 0.5}, -- NodeBox6
			{0.25, -0.5, -0.0625, 0.3125, -0.25, 0}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
	sounds = default.node_sound_wood_defaults(),
})


minetest.register_node("furnature:bench_large_2_left", {
	description = "Fancy Garden Bench",
	tiles = {"furnature_wood.png",},
	inventory_image = "furnature_bench_large_2_inv.png",
	drawtype = "nodebox",
	paramtype = "light",
    paramtype2 = "facedir",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5}, -- NodeBox1
			{-0.375, 0.3125, 0.4375, 0.5, 0.4375, 0.5}, -- NodeBox2
			{-0.375, -0.0625, 0.4375, 0.5, 0.0625, 0.5}, -- NodeBox3
			{-0.3125, 0.0625, 0.45, -0.25, 0.3125, 0.48}, -- NodeBox4
			{-0.1875, 0.0625, 0.45, -0.125, 0.3125, 0.48}, -- NodeBox5
			{-0.0625, 0.0625, 0.45, 0, 0.3125, 0.48}, -- NodeBox6
			{0.0625, 0.0625, 0.45, 0.125, 0.3125, 0.48}, -- NodeBox7
			{0.1875, 0.0625, 0.45, 0.25, 0.3125, 0.48}, -- NodeBox8
			{0.3125, 0.0625, 0.45, 0.375, 0.3125, 0.48}, -- NodeBox9
			{0.4375, 0.0625, 0.45, 0.5, 0.3125, 0.48}, -- NodeBox10
			{-0.5, 0.0625, -0.145362, -0.375, 0.125, 0.375}, -- NodeBox11
			{-0.5, -0.5, -0.0625, -0.375, 0.0625, 0.0625}, -- NodeBox12
			{-0.4375, -0.125, -0.0625, 0.5, -0.0911603, 0.4375}, -- NodeBox13
			{-0.4375, -0.4375, 0.0625, -0.375, -0.3125, 0.375}, -- NodeBox14
			{-0.375, -0.342324, 0.25, 0.5, -0.4375, 0.1875}, -- NodeBox15
			{-0.5, -0.25, -0.0290173, 0.5, -0.125, 0.0125346}, -- NodeBox16
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.15625, 1.5, 0.5, 0.5 }
	},
	sounds = default.node_sound_wood_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		return furnature.stack_sideways(itemstack, placer, pointed_thing,
			"furnature:bench_large_2_left", "furnature:bench_large_2_right", true)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + furnature.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + furnature.fdir_to_right[fdir+1][2] }
		if minetest.get_node(pos2).name == "furnature:bench_large_2_right" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("furnature:bench_large_2_right", {
	tiles = {"furnature_wood.png",},
	drawtype = "nodebox",
	paramtype = "light",
    paramtype2 = "facedir",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.5, 0.3125, 0.4375, 0.375, 0.4375, 0.5}, -- NodeBox2
			{-0.5, -0.0625, 0.4375, 0.375, 0.0625, 0.5}, -- NodeBox3
			{-0.5, 0.0625, 0.45, -0.4375, 0.3125, 0.48}, -- NodeBox4
			{-0.375, 0.0625, 0.45, -0.3125, 0.3125, 0.48}, -- NodeBox5
			{-0.25, 0.0625, 0.45, -0.1875, 0.3125, 0.48}, -- NodeBox6
			{-0.125, 0.0625, 0.45, -0.0625, 0.3125, 0.48}, -- NodeBox7
			{0, 0.0625, 0.45, 0.0625, 0.3125, 0.48}, -- NodeBox8
			{0.125, 0.0625, 0.45, 0.1875, 0.3125, 0.48}, -- NodeBox9
			{0.25, 0.0625, 0.45, 0.3125, 0.3125, 0.48}, -- NodeBox10
			{0.375, 0.0625, -0.145362, 0.5, 0.125, 0.375}, -- NodeBox11
			{0.375, -0.5, -0.0625, 0.5, 0.125, 0.0625}, -- NodeBox12
			{0.375, -0.4375, 0.0625, 0.4375, -0.3125, 0.375}, -- NodeBox13
			{-0.5, -0.4375, 0.1875, 0.375, -0.342324, 0.25}, -- NodeBox14
			{-0.5, -0.125, -0.0625, 0.4375, -0.0911603, 0.4375}, -- NodeBox15
			{-0.5, -0.25, -0.0290173, 0.5, -0.125, 0.0125346}, -- NodeBox16
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 0, 0, 0, 0, 0, 0 }
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'furnature:bench_large_2_left',
	recipe = {
		{'group:stick', 'group:stick', 'group:stick'},
		{'furnature:wood', 'furnature:wood', 'furnature:wood'},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'furnature:bench_large_1_left',
	recipe = {
		{'', 'group:stick', ''},
		{'furnature:wood', 'furnature:wood', 'furnature:wood'},
		{'group:stick', '', 'group:stick'},
	}
})