local vessels_formspec =
	"size[8,7;]" ..
	"list[context;vessels;0,0.3;8,2;]" ..
	"list[current_player;main;0,2.85;8,1;]" ..
	"list[current_player;main;0,4.08;8,3;8]" ..
	"listring[context;vessels]" ..
	"listring[current_player;main]"

local function update_vessels(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local invlist = inv:get_list("vessels")

	local formspec = vessels_formspec
	-- Inventory slots overlay
	local bx, by = 0, 0.3
	local n_written, n_empty = 0, 0
	for i = 1, 16 do
		if i == 9 then
			bx = 0
			by = by + 1
		end
		local stack = invlist[i]
		if stack:is_empty() then
		else
			local metatable = stack:get_meta():to_table() or {}
			if metatable.fields and metatable.fields.text then
				n_written = n_written + stack:get_count()
			else
				n_empty = n_empty + stack:get_count()
			end
		end
		bx = bx + 1
	end
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", "Vessels Shelf")
end

minetest.register_node("magic:shelf", {
	description = "Vessels Shelf",
	tiles = {"default_wood.png", "default_wood.png", "magic_shelf.png",
		"magic_shelf.png", "magic_shelf.png", "magic_shelf.png"},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("vessels", 8 * 2)
		update_vessels(pos)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("vessels")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "vessel") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in vessels shelf at " .. minetest.pos_to_string(pos))
		update_vessels(pos)
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" puts stuff to vessels shelf at " .. minetest.pos_to_string(pos))
		update_vessels(pos)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from vessels shelf at " .. minetest.pos_to_string(pos))
		update_vessels(pos)
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "vessels", drops)
		drops[#drops+1] = "magic:shelf"
		minetest.remove_node(pos)
		return drops
	end,
})

minetest.register_craft({
	output = "magic:shelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

minetest.register_node("magic:bottle", {
	description = "Empty Bottle",
	drawtype = "plantlike",
	tiles = {"magic_bottle.png"},
	inventory_image = "magic_bottle.png",
	wield_image = "magic_bottle.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "magic:bottle 20",
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "", "default:glass"},
		{"", "default:glass", ""},
	},
})

minetest.register_node("magic:health", {
	description = "Elixir of Health MK1",
	drawtype = "plantlike",
	tiles = {"magic_health.png"},
	inventory_image = "magic_health.png",
	wield_image = "magic_health.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, not_in_craftguide = 1},
	on_use = minetest.item_eat(10, "magic:bottle"),
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("magic:health_1", {
	description = "Elixir of Health MK2",
	drawtype = "plantlike",
	tiles = {"magic_health_1.png"},
	inventory_image = "magic_health_1.png",
	wield_image = "magic_health_1.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, not_in_craftguide = 1},
	on_use = minetest.item_eat(15, "magic:bottle"),
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("magic:health_2", {
	description = "Elixir of Health MK3",
	drawtype = "plantlike",
	tiles = {"magic_health_2.png"},
	inventory_image = "magic_health_2.png",
	wield_image = "magic_health_2.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, not_in_craftguide = 1},
	on_use = minetest.item_eat(20, "magic:bottle"),
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "magic:health 10",
	recipe = {"magic:bottle", "default:apple", "default:peach", "flowers:viola"},
})

minetest.register_craft({
	type = "shapeless",
	output = "magic:health_1 10",
	recipe = {"magic:health", "default:pear", "default:plum", "flowers:geranium"},
})

minetest.register_craft({
	type = "shapeless",
	output = "magic:health_2 10",
	recipe = {"magic:health_1", "default:berry", "default:cactus_fig", "flowers:tulip"},
})

minetest.register_node("magic:mana", {
	description = "Elixir of Mana MK1",
	drawtype = "plantlike",
	tiles = {"magic_mana.png"},
	inventory_image = "magic_mana.png",
	wield_image = "magic_mana.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, not_in_craftguide = 1},
	on_use = function(itemstack, user)
		if itemstack:take_item() ~= nil then
			mana.add_up_to(user:get_player_name(), 75)
			if itemstack:is_empty() then
				itemstack:add_item("magic:bottle")
			else
				local inv = user:get_inventory()
				-- Check if inv is null, since non-players don't have one
				if inv and inv:room_for_item("main", {name="magic:bottle"}) then
					inv:add_item("main", "magic:bottle")
				else
					local pos = user:getpos()
					pos.y = math.floor(pos.y + 0.5)
					minetest.add_item(pos, "magic:bottle")
				end
			end
		end
		return itemstack
	end,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("magic:mana_1", {
	description = "Elixir of Mana MK1",
	drawtype = "plantlike",
	tiles = {"magic_mana_1.png"},
	inventory_image = "magic_mana_1.png",
	wield_image = "magic_mana_1.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, not_in_craftguide = 1},
	on_use = function(itemstack, user)
		if itemstack:take_item() ~= nil then
			mana.add_up_to(user:get_player_name(), 150)
			if itemstack:is_empty() then
				itemstack:add_item("magic:bottle")
			else
				local inv = user:get_inventory()
				-- Check if inv is null, since non-players don't have one
				if inv and inv:room_for_item("main", {name="magic:bottle"}) then
					inv:add_item("main", "magic:bottle")
				else
					local pos = user:getpos()
					pos.y = math.floor(pos.y + 0.5)
					minetest.add_item(pos, "magic:bottle")
				end
			end
		end
		return itemstack
	end,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("magic:mana_2", {
	description = "Elixir of Mana MK3",
	drawtype = "plantlike",
	tiles = {"magic_mana_2.png"},
	inventory_image = "magic_mana_2.png",
	wield_image = "magic_mana_2.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, not_in_craftguide = 1},
	on_use = function(itemstack, user)
		if itemstack:take_item() ~= nil then
			mana.add_up_to(user:get_player_name(), 1000000000)
			if itemstack:is_empty() then
				itemstack:add_item("magic:bottle")
			else
				local inv = user:get_inventory()
				-- Check if inv is null, since non-players don't have one
				if inv and inv:room_for_item("main", {name="magic:bottle"}) then
					inv:add_item("main", "magic:bottle")
				else
					local pos = user:getpos()
					pos.y = math.floor(pos.y + 0.5)
					minetest.add_item(pos, "magic:bottle")
				end
			end
		end
		return itemstack
	end,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "magic:mana 10",
	recipe = {"magic:bottle", "default:peach", "default:banana", "flowers:dandelion_yellow"},
})

minetest.register_craft({
	type = "shapeless",
	output = "magic:mana_1 10",
	recipe = {"magic:mana", "default:mango", "default:pear", "flowers:rose"},
})

minetest.register_craft({
	type = "shapeless",
	output = "magic:mana_2 10",
	recipe = {"magic:mana_1", "default:apple", "default:orange", "default:dandelion_white"},
})

minetest.register_node("magic:experience", {
	description = "Elixir of Experience MK1",
	drawtype = "plantlike",
	tiles = {"magic_experience.png"},
	inventory_image = "magic_experience.png",
	wield_image = "magic_experience.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	on_use = function(itemstack, user)
		if itemstack:take_item() ~= nil then
			experience.add_up_to(user:get_player_name(), 20)
			if itemstack:is_empty() then
				itemstack:add_item("magic:bottle")
			else
				local inv = user:get_inventory()
				-- Check if inv is null, since non-players don't have one
				if inv and inv:room_for_item("main", {name="magic:bottle"}) then
					inv:add_item("main", "magic:bottle")
				else
					local pos = user:getpos()
					pos.y = math.floor(pos.y + 0.5)
					minetest.add_item(pos, "magic:bottle")
				end
			end
		end
		return itemstack
	end,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("magic:experience_1", {
	description = "Elixir of Experience MK2",
	drawtype = "plantlike",
	tiles = {"magic_experience_1.png"},
	inventory_image = "magic_experience_1.png",
	wield_image = "magic_experience_1.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	on_use = function(itemstack, user)
		if itemstack:take_item() ~= nil then
			experience.add_up_to(user:get_player_name(), 60)
			if itemstack:is_empty() then
				itemstack:add_item("magic:bottle")
			else
				local inv = user:get_inventory()
				-- Check if inv is null, since non-players don't have one
				if inv and inv:room_for_item("main", {name="magic:bottle"}) then
					inv:add_item("main", "magic:bottle")
				else
					local pos = user:getpos()
					pos.y = math.floor(pos.y + 0.5)
					minetest.add_item(pos, "magic:bottle")
				end
			end
		end
		return itemstack
	end,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("magic:experience_2", {
	description = "Elixir of Experience MK3",
	drawtype = "plantlike",
	tiles = {"magic_experience_2.png"},
	inventory_image = "magic_experience_2.png",
	wield_image = "magic_experience_2.png",
	paramtype = "light",
	visual_scale = 0.5,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	on_use = function(itemstack, user)
		if itemstack:take_item() ~= nil then
			experience.add_up_to(user:get_player_name(), 120)
			if itemstack:is_empty() then
				itemstack:add_item("magic:bottle")
			else
				local inv = user:get_inventory()
				-- Check if inv is null, since non-players don't have one
				if inv and inv:room_for_item("main", {name="magic:bottle"}) then
					inv:add_item("main", "magic:bottle")
				else
					local pos = user:getpos()
					pos.y = math.floor(pos.y + 0.5)
					minetest.add_item(pos, "magic:bottle")
				end
			end
		end
		return itemstack
	end,
	sounds = default.node_sound_glass_defaults(),
})