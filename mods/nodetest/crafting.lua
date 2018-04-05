--
-- Crafting definition
--

minetest.register_craft({
	output = 'nodetest:papyrus_roots',
	recipe = {
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
	}
})

minetest.register_craft({
	output = 'default:papyrus 9',
	recipe = {
		{'nodetest:papyrus_roots'},
	}
})

minetest.register_craft({
	output = 'nodetest:wattle',
	recipe = {
		{'default:dry_shrub', 'default:dry_shrub', 'default:dry_shrub'},
		{'default:dry_shrub', 'default:dry_shrub', 'default:dry_shrub'},
		{'default:dry_shrub', 'default:dry_shrub', 'default:dry_shrub'},
	}
})

minetest.register_craft({
	output = 'default:dry_shrub 9',
	recipe = {
		{'nodetest:wattle'},
	}
})

minetest.register_craft({
	output = 'dye:white',
	recipe = {
		{'nodetest:bone'},
	}
})

minetest.register_craft({
	output = 'nodetest:spearwood',
	recipe = {
		{'', '', 'default:stick'},
		{'', 'default:stick', ''},
		{'default:stick', '', ''},
	}
})

minetest.register_craft({
	output = 'nodetest:spearstone',
	recipe = {
		{'', '', 'group:stone'},
		{'', 'default:stick', ''},
		{'default:stick', '', ''},
	}
})

minetest.register_craft({
	output = 'nodetest:seedling 4',
	recipe = {
		{'group:sapling'},
	}
})

--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "nodetest:seedling",
	burntime = 1,
})