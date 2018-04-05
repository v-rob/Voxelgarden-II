-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- Definitions made by this mod that other mods can use too
default = {}
default.player_attached = {}
default.LIGHT_MAX = 14
default.COUSHION = -10 -- Falling damage gets reduced by 10 percent.

-- GUI related stuff
default.gui_bg = ""
default.gui_bg_img = ""
default.gui_slots = ""

minetest.register_on_joinplayer(function(player)
	local physics = player:get_physics_override()
	physics.jump = 1.25
	player:set_physics_override(physics)
end)

-- Load files
dofile(minetest.get_modpath("default").."/gui.lua")
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/furnace.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/crafting.lua")
if minetest.get_mapgen_params().mgname ~= "v6" then
	dofile(minetest.get_modpath("default").."/biomes.lua")
end
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/trees.lua")
dofile(minetest.get_modpath("default").."/aliases.lua")
dofile(minetest.get_modpath("default").."/torch.lua")
