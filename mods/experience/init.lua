local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
	S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end

experience = {}
experience.playerlist = {}
experience.level = 2

experience.settings = {}
experience.settings.default_max = 2

do
	local default_max = tonumber(minetest.setting_get("experience_default_max"))
	if default_max ~= nil then
		experience.settings.default_max = default_max
	end
end

--[===[
	API functions
]===]

function experience.set(playername, value) 
	if value < 0 then
		minetest.log("info", "[experience] Warning: experience.set was called with negative value!")
		value = 0
	end
	value = experience.round(value)
	if value >= experience.playerlist[playername].maxexperience then
		minetest.chat_send_player(playername, "Level "..experience.playerlist[playername].level.."!")
		experience.playerlist[playername].level = experience.playerlist[playername].level + 1
		experience.playerlist[playername].maxexperience =  2 ^ experience.playerlist[playername].level
		experience.playerlist[playername].experience = 0
		mana.setmax(playername, 60 + (t.level * 20))
		value = 0
		experience.hud_update(playername)
	end
	if experience.playerlist[playername].experience ~= value then
		experience.playerlist[playername].experience = value
		experience.hud_update(playername)
	end
end

function experience.setmax(playername, value)
	if value < 0 then
		value = 0
		minetest.log("info", "[experience] Warning: experience.setmax was called with negative value!")
	end
	value = experience.round(value)
	if experience.playerlist[playername].maxexperience ~= value then
		experience.playerlist[playername].maxexperience = value
		if(experience.playerlist[playername].experience > value) then
			experience.playerlist[playername].experience = value
		end
		experience.hud_update(playername)
	end
end

function experience.get(playername)
	return experience.playerlist[playername].experience
end

function experience.getlevel(playername)
	return experience.playerlist[playername].level
end

function experience.getmax(playername)
	return experience.playerlist[playername].maxexperience
end

function experience.add_up_to(playername, value)
	local t = experience.playerlist[playername]
	value = experience.round(value)
	if t.experience + value >= t.maxexperience then
		minetest.chat_send_player(playername, "Level "..t.level.."!")
		t.level = t.level + 1
		t.maxexperience =  2 ^ t.level
		t.experience = 0
		mana.setmax(playername, 60 + (t.level * 20))
		value = 0
		experience.hud_update(playername)
	end
	if(t ~= nil and value >= 0) then
		local excess
		if((t.experience + value) > t.maxexperience) then
			excess = (t.experience + value) - t.maxexperience
			t.experience = t.maxexperience
		else
			excess = 0
			t.experience = t.experience + value
		end
		experience.hud_update(playername)
		return true, excess
	else
		return false
	end
end

function experience.add(playername, value)
	local t = experience.playerlist[playername]
	value = experience.round(value)
	if t.experience + value >= t.maxexperience then
		minetest.chat_send_player(playername, "Level "..t.level.."!")
		t.level = t.level + 1
		t.maxexperience =  2 ^ t.level
		t.experience = 0
		mana.setmax(playername, 60 + (t.level * 20))
		value = 0
		experience.hud_update(playername)
	end
	if(t ~= nil and ((t.experience + value) <= t.maxexperience) and value >= 0) then
		t.experience = t.experience + value 
		experience.hud_update(playername)
		return true
	else
		return false
	end
end

function experience.subtract(playername, value)
	local t = experience.playerlist[playername]
	value = experience.round(value)
	if(t ~= nil and t.experience >= value and value >= 0) then
		t.experience = t.experience -value 
		experience.hud_update(playername)
		return true
	else
		return false
	end
end

function experience.subtract_up_to(playername, value)
	local t = experience.playerlist[playername]
	value = experience.round(value)
	if(t ~= nil and value >= 0) then
		local missing
		if((t.experience - value) < 0) then
			missing = math.abs(t.experience - value)
			t.experience = 0
		else
			missing = 0
			t.experience = t.experience - value
		end
		experience.hud_update(playername)
		return true, missing
	else
		return false
	end
end

--[===[
	File handling, loading data, saving data, setting up stuff for players.
]===]


-- Load the playerlist from a previous session, if available.
do
	local filepath = minetest.get_worldpath().."/experience.mt"
	local file = io.open(filepath, "r")
	if file then
		minetest.log("action", "[experience] experience.mt opened.")
		local string = file:read()
		io.close(file)
		if(string ~= nil) then
			local savetable = minetest.deserialize(string)
			experience.playerlist = savetable.playerlist
			minetest.debug("[experience] experience.mt successfully read.")
		end
	end
end

function experience.save_to_file()
	local savetable = {}
	savetable.playerlist = experience.playerlist

	local savestring = minetest.serialize(savetable)

	local filepath = minetest.get_worldpath().."/experience.mt"
	local file = io.open(filepath, "w")
	if file then
		file:write(savestring)
		io.close(file)
		minetest.log("action", "[experience] Wrote experience data into "..filepath..".")
	else
		minetest.log("error", "[experience] Failed to write experience data into "..filepath..".")
	end
end


minetest.register_on_respawnplayer(function(player)
	local playername = player:get_player_name()
	experience.set(playername, 0)
	experience.hud_update(playername)
end)


minetest.register_on_leaveplayer(function(player)
	local playername = player:get_player_name()
	if not minetest.get_modpath("hudbars") ~= nil then
		experience.hud_remove(playername)
	end
	experience.save_to_file()
end)

minetest.register_on_shutdown(function()
	minetest.log("action", "[experience] Server shuts down. Rescuing data into experience.mt")
	experience.save_to_file()
end)

minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
	
	if experience.playerlist[playername] == nil then
		experience.playerlist[playername] = {}
		experience.playerlist[playername].experience = 0
		experience.playerlist[playername].maxexperience = experience.settings.default_max
		experience.playerlist[playername].level = 2
		experience.playerlist[playername].remainder = 0
	end

	if minetest.get_modpath("hudbars") ~= nil then
		hb.init_hudbar(player, "experience", experience.get(playername), experience.getmax(playername))
	else
		experience.hud_add(playername)
	end
end)

--[===[
	HUD functions
]===]

if minetest.get_modpath("hudbars") ~= nil then
	hb.register_hudbar("experience", 0xFFFFFF, S("Experience"), { bar = "experience_bar.png", icon = "experience_icon.png", bgicon = "experience_bgicon.png" }, 0, experience.settings.default_max, false)

	function experience.hud_update(playername)
		local player = minetest.get_player_by_name(playername)
		if player ~= nil then
			hb.change_hudbar(player, "experience", experience.get(playername), experience.getmax(playername))
		end
	end

	function experience.hud_remove(playername)
	end

else
	function experience.experiencestring(playername)
		return S("Experience: @1/@2", experience.get(playername), experience.getmax(playername))
	end
	
	function experience.hud_add(playername)
		local player = minetest.get_player_by_name(playername)
		local id = player:hud_add({
			hud_elem_type = "text",
			position = { x = 0.5, y=1 },
			text = experience.experiencestring(playername),
			scale = { x = 0, y = 0 },
			alignment = { x = 1, y = 0},
			direction = 1,
			number = 0xFFFFFF,
			offset = { x = -262, y = -103}
		})
		experience.playerlist[playername].hudid = id
		return id
	end
	
	function experience.hud_update(playername)
		local player = minetest.get_player_by_name(playername)
		player:hud_change(experience.playerlist[playername].hudid, "text", experience.experiencestring(playername))
	end
	
	function experience.hud_remove(playername)
		local player = minetest.get_player_by_name(playername)
		player:hud_remove(experience.playerlist[playername].hudid)
	end
end

--[===[
	Helper functions
]===]
experience.round = function(x)
	return math.ceil(math.floor(x+0.5))
end
