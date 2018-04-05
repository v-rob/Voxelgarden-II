------------------------------
-- Happy Weather: Motes

-- License: MIT

-- Credits: xeranas
------------------------------

local motes = {}
motes.last_check = 0
motes.check_interval = 200
motes.chance = 0.2

-- Weather identification code
motes.code = "motes"

-- Manual triggers flags
local manual_trigger_start = false
local manual_trigger_end = false

-- Skycolor layer id
local SKYCOLOR_LAYER = "happy_weather_motes_sky"

motes.is_starting = function(dtime, position)
	if motes.last_check + motes.check_interval < os.time() then
		motes.last_check = os.time()
		if math.random() < motes.chance then
			happy_weather.request_to_end("light_rain")
			happy_weather.request_to_end("rain")
			happy_weather.request_to_end("heavy_rain")
			happy_weather.request_to_end("snow")
			return true
		end
	end

	if manual_trigger_start then
		manual_trigger_start = false
		return true
	end

	return false
end

motes.is_ending = function(dtime)
	if motes.last_check + motes.check_interval < os.time() then
		motes.last_check = os.time()
		if math.random() < 0.5 then
			return true
		end
	end

	if manual_trigger_end then
		manual_trigger_end = false
		return true
	end

	return false
end

local set_sky_box = function(player_name)
	local sl = {}
	sl.layer_type = skylayer.SKY_PLAIN
	sl.name = SKYCOLOR_LAYER
	sl.data = {gradient_data={}}
	sl.data.gradient_data.colors = {
		{r=137, g=226, b=164},
		{r=137, g=226, b=164},
		{r=0, g=0, b=0}
	}
	skylayer.add_layer(player_name, sl)
end

motes.add_player = function(player)
	set_sky_box(player:get_player_name())
end

motes.remove_player = function(player)
	skylayer.remove_layer(player:get_player_name(), SKYCOLOR_LAYER)
end

-- Random texture getter
local choice_random_rain_drop_texture = function()
	local base_name = "happy_weather_motes_mote_"
	local number = math.random(1, 2)
	local extension = ".png"
	return base_name .. number .. extension
end

local add_particle = function(player)
	local offset = {
		front = 10,
		back = 10,
		top = 4
	}

	local random_pos = hw_utils.get_random_pos(player, offset)

	if hw_utils.is_outdoor(random_pos) then
		minetest.add_particle({
			pos = {x=random_pos.x, y=random_pos.y, z=random_pos.z},
			velocity = {x = math.random(-1,-0.5), y = math.random(-2,-1), z = math.random(-1,-0.5)},
			acceleration = {x = math.random(-1,-0.5), y=-0.5, z = math.random(-1,-0.5)},
			expirationtime = 10,
			size = math.random(0.5, 1),
			collisiondetection = true,
			collision_removal = true,
			vertical = true,
			texture = choice_random_rain_drop_texture(),
			playername = player:get_player_name()
		})
	end
end

local display_particles = function(player)
	if hw_utils.is_underwater(player) then
		return
	end

	add_particle(player)
end

local particles_number_per_update = 10
motes.render = function(dtime, player)
	for i=particles_number_per_update, 1,-1 do
		display_particles(player)
	end
end

--[[motes.in_area = function(position)
	if hw_utils.is_biome_frozen(position) == false then
		return false
	end

	if position.y > -10 and position.y < 120 then
		return true
	end
	return false
end--]]

motes.start = function()
	manual_trigger_start = true
end

motes.stop = function()
	manual_trigger_end = true
end

happy_weather.register_weather(motes)