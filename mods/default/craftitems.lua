-- mods/default/craftitems.lua

--
-- Crafting items
--

minetest.register_craftitem("default:stick", {
	description = "Stick",
	inventory_image = "default_stick.png",
	groups = {stick=1},
})

minetest.register_craftitem("default:paper", {
	description = "Paper",
	inventory_image = "default_paper.png",
})

local lpp = 17 -- Lines per book's page
local function book_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local meta = itemstack:get_meta()
	local title, text, owner = "", "", player_name
	local page, page_max, lines, string = 1, 1, {}, ""

	-- Backwards compatibility
	local old_data = minetest.deserialize(itemstack:get_metadata())
	if old_data then
		meta:from_table({ fields = old_data })
	end

	local data = meta:to_table().fields

	if data.owner then
		title = data.title
		text = data.text
		owner = data.owner

		for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
			lines[#lines+1] = str
		end

		if data.page then
			page = data.page
			page_max = data.page_max

			for i = ((lpp * page) - lpp) + 1, lpp * page do
				if not lines[i] then break end
				string = string .. lines[i] .. "\n"
			end
		end
	end
	local formspec
	if owner == player_name then
		formspec = "size[13.3,7.3]"..
			"field[0.4,0.8;13.15,0;title;;"..minetest.formspec_escape(title).."]"..
			"textarea[0.4,0.95;13.15,6.65;text;;"..minetest.formspec_escape(text)..";]"..
			"image_button_exit[0.11,6.83;3,0.7;;save;Save]"
	else
		formspec = "size[13.3,7.3]"..
			"label[0.1,0;"..minetest.formspec_escape(title).."]"..
			"textarea[0.4,0.7;13.15,6.9;;"..minetest.formspec_escape(string ~= "" and string or text)..";]"..
			"image_button[0.11,6.83;1.64,0.7;;book_prev;<<]"..
			"label[1.87,6.88;"..page.."/"..page_max.."]"..
			"image_button[2.53,6.83;1.64,0.7;;book_next;>>]"
	end

	minetest.show_formspec(player_name, "default:book", formspec)
	return itemstack
end

local max_text_size = 10000
local max_title_size = 80
local short_title_size = 35
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "default:book" then return end
	local inv = player:get_inventory()
	local stack = player:get_wielded_item()

	if fields.save and fields.title and fields.text
			and fields.title ~= "" and fields.text ~= "" then
		local new_stack, data
		if stack:get_name() ~= "default:book_written" then
			local count = stack:get_count()
			if count == 1 then
				stack:set_name("default:book_written")
			else
				stack:set_count(count - 1)
				new_stack = ItemStack("default:book_written")
			end
		else
			data = stack:get_meta():to_table().fields
		end

		if data and data.owner and data.owner ~= player:get_player_name() then
			return
		end

		if not data then data = {} end
		data.title = fields.title:sub(1, max_title_size)
		data.owner = player:get_player_name()
		local short_title = data.title
		-- Don't bother triming the title if the trailing dots would make it longer
		if #short_title > short_title_size + 3 then
			short_title = short_title:sub(1, short_title_size) .. "..."
		end
		data.description = "\""..short_title.."\" by "..data.owner
		data.text = fields.text:sub(1, max_text_size)
		data.text = data.text:gsub("\r\n", "\n"):gsub("\r", "\n")
		data.page = 1
		data.page_max = math.ceil((#data.text:gsub("[^\n]", "") + 1) / lpp)

		if new_stack then
			new_stack:get_meta():from_table({ fields = data })
			if inv:room_for_item("main", new_stack) then
				inv:add_item("main", new_stack)
			else
				minetest.add_item(player:getpos(), new_stack)
			end
		else
			stack:get_meta():from_table({ fields = data })
		end

	elseif fields.book_next or fields.book_prev then
		local data = stack:get_meta():to_table().fields
		if not data or not data.page then
			return
		end

		data.page = tonumber(data.page)
		data.page_max = tonumber(data.page_max)

		if fields.book_next then
			data.page = data.page + 1
			if data.page > data.page_max then
				data.page = 1
			end
		else
			data.page = data.page - 1
			if data.page == 0 then
				data.page = data.page_max
			end
		end

		stack:get_meta():from_table({fields = data})
		stack = book_on_use(stack, player)
	end

	-- Update stack
	player:set_wielded_item(stack)
end)

minetest.register_craftitem("default:book", {
	description = "Book",
	inventory_image = "default_book.png",
	groups = {book = 1, flammable = 3},
	on_use = book_on_use,
})

minetest.register_craftitem("default:book_written", {
	description = "Book With Text",
	inventory_image = "default_book_written.png",
	groups = {book = 1, not_in_creative_inventory = 1, flammable = 3},
	stack_max = 1,
	on_use = book_on_use,
})

minetest.register_craftitem("default:coal_lump", {
	description = "Coal Lump",
	inventory_image = "default_coal_lump.png",
})

minetest.register_craftitem("default:iron_lump", {
	description = "Iron Lump",
	inventory_image = "default_iron_lump.png",
})

minetest.register_craftitem("default:tin_lump", {
	description = "Tin Lump",
	inventory_image = "default_tin_lump.png",
})

minetest.register_craftitem("default:copper_lump", {
	description = "Copper Lump",
	inventory_image = "default_copper_lump.png",
})

minetest.register_craftitem("default:mese_crystal", {
	wield_scale = {x=1,y=1,z=0},
	description = "Mese Crystal",
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("default:gold_lump", {
	description = "Gold Lump",
	inventory_image = "default_gold_lump.png",
})

minetest.register_craftitem("default:clay_lump", {
	description = "Clay Lump",
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("default:steel_ingot", {
	description = "Steel Ingot",
	inventory_image = "default_steel_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:copper_ingot", {
	description = "Copper Ingot",
	inventory_image = "default_copper_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:tin_ingot", {
	description = "Tin Ingot",
	inventory_image = "default_tin_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:gold_ingot", {
	description = "Gold Ingot",
	inventory_image = "default_gold_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:bronze_ingot", {
	description = "Bronze Ingot",
	inventory_image = "default_bronze_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:mese_crystal_fragment", {
	wield_scale = {x=1,y=1,z=0},
	description = "Mese Crystal Fragment",
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("default:clay_brick", {
	description = "Clay Brick",
	inventory_image = "default_clay_brick.png",
})
