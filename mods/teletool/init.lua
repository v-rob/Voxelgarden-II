-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end

teletool = {}

--[[ Load settings, apply default settings ]]
teletool.settings = {}
teletool.settings.avoid_collisions = true
teletool.settings.adjust_head = true
teletool.settings.cost_mana = 35
local avoid_collisions = minetest.setting_getbool("teletool_avoid_collisions")
if avoid_collisions ~= nil then
	teletool.settings.avoid_collision = avoid_collisions
end
local adjust_head = minetest.setting_getbool("teletool_adjust_head")
if adjust_head ~= nil then
	teletool.settings.adjust_head = adjust_head
end
local cost_mana = tonumber(minetest.setting_get("teletool_cost_mana"))
if cost_mana ~= nil then
	teletool.settings.cost_mana = cost_mana
end


function teletool.teleport(player, pointed_thing)
	local pos = pointed_thing.above
	local src = player:getpos()
	local dest = {x=pos.x, y=math.ceil(pos.y)-0.5, z=pos.z}
	local over = {x=dest.x, y=dest.y+1, z=dest.z}
	local destnode = minetest.get_node({x=dest.x, y=math.ceil(dest.y), z=dest.z})
	local overnode = minetest.get_node({x=over.x, y=math.ceil(over.y), z=over.z})

	if teletool.settings.adjust_head then
		-- This trick prevents the player's head to spawn in a walkable node if the player clicked on the lower side of a node
		-- NOTE: This piece of code must be updated as soon the collision boxes of players become configurable
		if minetest.registered_nodes[overnode.name].walkable then
			dest.y = dest.y - 1
		end
	end

	if teletool.settings.avoid_collisions then
		-- The destination must be collision free
		destnode = minetest.get_node({x=dest.x, y=math.ceil(dest.y), z=dest.z})
		if minetest.registered_nodes[destnode.name].walkable then
			return false
		end
	end
	minetest.sound_play( {name="teletool_teleport1", gain=1}, {pos=src, max_hear_distance=12})
	player:setpos(dest)
	minetest.after(0.5, function(dest) minetest.sound_play( {name="teletool_teleport2", gain=1}, {pos=dest, max_hear_distance=12}) end, dest)

	return true
end

minetest.register_tool("teletool:teletool_mana", {
	description = ("Mirror of Teleportation"),
	_doc_items_longdesc = desc_mana,
	_doc_items_usagehelp = use_mana,
	range = 20.0,
	tool_capabilities = {},
	wield_image = "teletool_teletool_mana.png",
	inventory_image = "teletool_teletool_mana.png",
	on_use = function(itemstack, user, pointed_thing)
		local failure = false
		if(pointed_thing.type == "node") then
			if(mana.get(user:get_player_name()) >= teletool.settings.cost_mana) then
				failure = not teletool.teleport(user, pointed_thing)
				if not failure then
					failure = not mana.subtract(user:get_player_name(), teletool.settings.cost_mana)
				end
			else
				failure = true
			end
		else
			failure = true
		end
		if failure then
			minetest.sound_play( {name="teletool_fail", gain=1}, {pos=user:getpos(), max_hear_distance=4})
		end
		return itemstack
	end,
	groups = { teletool = 1 },
})