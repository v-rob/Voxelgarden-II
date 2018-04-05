-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.


-- Global namespace for functions

stairs = {}

local function rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:getpos()
		if placer_pos then
			param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
		end

		local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
		local fpos = finepos.y % 1

		if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
				or (fpos < -0.5 and fpos > -0.999999999) then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

-- Register stairs.
-- Node will be called stairs:stair_<subname>

function stairs.register_stair(subname, recipeitem, groups, images, description, sounds)
	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
				align_style = "world",
			}
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	groups.stair = 1
	minetest.register_node(":stairs:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	if recipeitem then
		-- Recipe matches appearence in inventory
		minetest.register_craft({
			output = 'stairs:stair_' .. subname .. ' 8',
			recipe = {
				{"", "", recipeitem},
				{"", recipeitem, recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use stairs to craft full blocks again (1:1)
		minetest.register_craft({
			type = "shapeless",
			output = recipeitem .. ' 3',
			recipe = {'stairs:stair_' .. subname, 'stairs:stair_' .. subname, 'stairs:stair_' .. subname, 'stairs:stair_' .. subname},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = 'stairs:stair_' .. subname,
				burntime = math.floor(baseburntime * 0.75),
			})
		end
	end
end


-- Slab facedir to placement 6d matching table
local slab_trans_dir = {[0] = 8, 0, 2, 1, 3, 4}

-- Register slabs.
-- Node will be called stairs:slab_<subname>

function stairs.register_slab(subname, recipeitem, groups, images, description, sounds)
	-- Set world-aligned textures
	local slab_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			slab_images[i] = {
				name = image,
				align_style = "world",
			}
		else
			slab_images[i] = table.copy(image)
			if image.align_style == nil then
				slab_images[i].align_style = "world"
			end
		end
	end
	groups.slab = 1
	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = slab_images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	if recipeitem then
		minetest.register_craft({
			output = 'stairs:slab_' .. subname .. ' 6',
			recipe = {
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use 2 slabs to craft a full block again (1:1)
		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {'stairs:slab_' .. subname, 'stairs:slab_' .. subname},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = 'stairs:slab_' .. subname,
				burntime = math.floor(baseburntime * 0.5),
			})
		end
	end
end

-- Register stairs.
-- Node will be called stairs:stair_inner_<subname>

function stairs.register_stair_inner(subname, recipeitem, groups, images, description, sounds)
	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
				align_style = "world",
			}
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	groups.stair = 1
	minetest.register_node(":stairs:stair_inner_" .. subname, {
		description = description .. " Inner",
		drawtype = "nodebox",
		tiles = stair_images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
				{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	if recipeitem then
		minetest.register_craft({
			output = 'stairs:stair_inner_' .. subname .. ' 7',
			recipe = {
				{ "", recipeitem, ""},
				{ recipeitem, "", recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use inner stairs to craft a full block again (1:1)
		minetest.register_craft({
			type = "shapeless",
			output = recipeitem .. ' 6',
			recipe = {'stairs:stair_inner_' .. subname, 'stairs:stair_inner_' .. subname, 'stairs:stair_inner_' .. subname,
				'stairs:stair_inner_' .. subname, 'stairs:stair_inner_' .. subname, 'stairs:stair_inner_' .. subname,
				'stairs:stair_inner_' .. subname},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = 'stairs:stair_inner_' .. subname,
				burntime = math.floor(baseburntime * 0.875),
			})
		end
	end
end

-- Register stairs.
-- Node will be called stairs:stair_outer_<subname>

function stairs.register_stair_outer(subname, recipeitem, groups, images, description, sounds)
	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
				align_style = "world",
			}
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	groups.stair = 1
	minetest.register_node(":stairs:stair_outer_" .. subname, {
		description = description .. " Outer",
		drawtype = "nodebox",
		tiles = stair_images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	if recipeitem then
		minetest.register_craft({
			output = 'stairs:stair_outer_' .. subname .. ' 5',
			recipe = {
				{ "", "", ""},
				{ "", recipeitem, ""},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Use outer stairs to craft a full block again (1:1)
		minetest.register_craft({
			type = "shapeless",
			output = recipeitem .. ' 4',
			recipe = {'stairs:stair_outer_' .. subname, 'stairs:stair_outer_' .. subname, 'stairs:stair_outer_' .. subname,
				'stairs:stair_outer_' .. subname, 'stairs:stair_outer_' .. subname},
		})

		-- Fuel
		local baseburntime = minetest.get_craft_result({
			method = "fuel",
			width = 1,
			items = {recipeitem}
		}).time
		if baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = 'stairs:stair_outer_' .. subname,
				burntime = math.floor(baseburntime * 0.625),
			})
		end
	end
end

-- Stair/slab registration function.
-- Nodes will be called stairs:{stair,slab}_<subname>

function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab, sounds)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair, sounds)
	stairs.register_stair_inner(subname, recipeitem, groups, images, desc_stair, sounds)
	stairs.register_stair_outer(subname, recipeitem, groups, images, desc_stair, sounds)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab, sounds)
end

-- Register default stairs and slabs

stairs.register_stair_and_slab(
	"wood",
	"default:wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"default_wood.png"},
	"Wooden Stair",
	"Wooden Slab",
	default.node_sound_wood_defaults()
)

stairs.register_stair_and_slab(
	"stone",
	"default:stone",
	{cracky = 3},
	{"default_stone.png"},
	"Stone Stair",
	"Stone Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"stone_crumbled",
	"default:stone_crumbled",
	{cracky=3, oddly_breakable_by_hand=1},
	{"default_stone_crumbled.png"},
	"Crumbled Stone Stair",
	"Crumbled Stone Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"cobble",
	"default:cobble",
	{cracky = 3},
	{"default_cobble.png"},
	"Cobblestone Stair",
	"Cobblestone Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"mossycobble",
	"default:mossycobble",
	{cracky = 3},
	{"default_mossycobble.png"},
	"Mossy Cobblestone Stair",
	"Mossy Cobblestone Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"stonebrick",
	"default:stonebrick",
	{cracky = 2},
	{"default_stone_brick.png"},
	"Stone Brick Stair",
	"Stone Brick Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"desert_stone",
	"default:desert_stone",
	{cracky = 3},
	{"default_desert_stone.png"},
	"Desert Stone Stair",
	"Desert Stone Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"desert_stone_crumbled",
	"default:desert_stone_crumbled",
	{cracky=3, oddly_breakable_by_hand=1},
	{"default_desert_stone_crumbled.png"},
	"Crumbled Desert Stone Stair",
	"Crumbled Desert Stone Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"desert_stonebrick",
	"default:desert_stonebrick",
	{cracky = 2},
	{"default_desert_stone_brick.png"},
	"Desert Stone Brick Stair",
	"Desert Stone Brick Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"granite",
	"default:granite",
	{cracky=1, stone=1},
	{"default_granite.png"},
	"Granite Stair",
	"Granite Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"sandstone",
	"default:sandstone",
	{crumbly = 2, cracky = 2},
	{"default_sandstone.png"},
	"Sandstone Stair",
	"Sandstone Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"brick",
	"default:brick",
	{cracky = 3},
	{"default_brick.png"},
	"Brick Stair",
	"Brick Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"steelblock",
	"default:steelblock",
	{cracky = 2},
	{"default_steel_block.png"},
	"Steel Block Stair",
	"Steel Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"ironblock",
	"default:ironblock",
	{cracky = 2},
	{"default_iron_block.png"},
	"Iron Block Stair",
	"Iron Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"tinblock",
	"default:tinblock",
	{cracky = 2},
	{"default_tin_block.png"},
	"Tin Block Stair",
	"Tin Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"copperblock",
	"default:copperblock",
	{cracky = 2},
	{"default_copper_block.png"},
	"Copper Block Stair",
	"Copper Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"bronzeblock",
	"default:bronzeblock",
	{cracky = 2},
	{"default_bronze_block.png"},
	"Bronze Block Stair",
	"Bronze Block Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"ice",
	"default:ice",
	{cracky = 3, puts_out_fire = 1, cools_lava = 1, slippery = 3},
	{"default_ice.png"},
	"Ice Stair",
	"Ice Slab",
	default.node_sound_glass_defaults()
)

stairs.register_stair_and_slab(
	"hardened_clay",
	"default:hardened_clay",
	{crumbly=3},
	{"default_hardened_clay.png"},
	"Hardened Clay Stair",
	"Hardened Clay Slab",
	default.node_sound_stone_defaults()
)

stairs.register_stair_and_slab(
	"conifer_tree",
	"conifer:tree",
	{tree=1, choppy=2, flammable=1},
	{"conifer_tree_top.png", "conifer_tree_top.png", "conifer_tree.png"},
	"Conifer Tree Stair",
	"Conifer Tree Slab",
	default.node_sound_wood_defaults()
)

stairs.register_stair_and_slab(
	"tree",
	"default:tree",
	{tree=1, choppy=2, flammable=1},
	{"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	"Tree Stair",
	"Tree Slab",
	default.node_sound_wood_defaults()
)

stairs.register_stair_and_slab(
	"jungletree",
	"default:jungletree",
	{tree=1, choppy=2, flammable=1},
	{"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	"Jungletree Stair",
	"Jungletree Slab",
	default.node_sound_wood_defaults()
)

stairs.register_stair_and_slab(
	"papyrus_roots",
	"nodetest:papyrus_roots",
	{snappy=2, flammable=2, oddly_breakable_by_hand=1, soil=1},
	{"nodetest_papyrus_roots.png"},
	"Papyrus Root Stair",
	"Papyrus Root Slab",
	default.node_sound_leaves_defaults()
)

stairs.register_stair_and_slab(
	"wattle",
	"nodetest:wattle",
	{snappy=2, flammable=2, oddly_breakable_by_hand=1, soil=1},
	{"nodetest_wattle.png"},
	"Wattle Stair",
	"Wattle Slab",
	default.node_sound_leaves_defaults()
)