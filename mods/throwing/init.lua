throwing_arrows = {
	{"throwing:arrow_steel", "throwing:arrow_steel_entity"},
	{"throwing:arrow_stone", "throwing:arrow_stone_entity"},
}

dofile(minetest.get_modpath("throwing").."/defaults.lua")

local input = io.open(minetest.get_modpath("throwing").."/throwing.conf", "r")
if input then
	dofile(minetest.get_modpath("throwing").."/throwing.conf")
	input:close()
	input = nil
end

dofile(minetest.get_modpath("throwing").."/functions.lua")

dofile(minetest.get_modpath("throwing").."/tools.lua")

dofile(minetest.get_modpath("throwing").."/standard_arrows.lua")

if minetest.setting_get("log_mods") then
	minetest.log("action", "throwing loaded")
end
