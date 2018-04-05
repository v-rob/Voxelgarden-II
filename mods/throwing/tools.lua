if not DISABLE_WOODEN_BOW then
	throwing_register_bow ('bow_wood', 'Wooden bow', {x=1, y=1.3, z=0.5}, 15, 1, 1000, false, {
			{'', 'default:stick', ''},
			{'farming:string', '', 'default:stick'},
			{'', 'default:stick', ''},
		})
end

--[[if not DISABLE_LONGBOW then
	throwing_register_bow ('longbow', 'Longbow', {x=1, y=1.3, z=0.5}, 40, 1.5, 1000, false, {
			{'farming:string', 'group:wood', ''},
			{'farming:string', '', 'group:wood'},
			{'farming:string', 'group:wood', ''},
		})
end--]]

--[[if not DISABLE_COMPOSITE_BOW then
	throwing_register_bow ('bow_composite', 'Composite bow', {x=1, y=1.3, z=0.5}, 25, 1, 1000, false, {
			{'farming:string', 'group:wood', ''},
			{'farming:string', '', 'default:steel_ingot'},
			{'farming:string', 'group:wood', ''},
		})
end--]]

--[[if not DISABLE_STEEL_BOW then
	throwing_register_bow ('bow_steel', 'Steel bow', {x=1, y=1.3, z=0.5}, 40, 1, 1000, false, {
			{'farming:string', 'default:steel_ingot', ''},
			{'farming:string', '', 'default:steel_ingot'},
			{'farming:string', 'default:steel_ingot', ''},
		})
end

if not DISABLE_ROYAL_BOW then
	throwing_register_bow ('bow_royal', 'Royal bow', {x=1, y=1.3, z=0.5}, 40, 1, 1000, false, {
			{'farming:string', 'group:wood', 'default:diamond'},
			{'farming:string', '', 'default:gold_ingot'},
			{'farming:string', 'group:wood', 'default:diamond'},
		})
end--]]

if not DISABLE_CROSSBOW then
	throwing_register_bow ('crossbow', 'Crossbow', {x=1, y=1.3, z=0.5}, 35, 2, 1000, false, {
			{'group:wood', 'farming:string', ''},
			{'default:steel_ingot', 'farming:string', 'group:wood'},
			{'group:wood', 'farming:string', ''},
		})
end

--[[if not DISABLE_ARBALEST then
	throwing_register_bow ('arbalest', 'Arbalest', {x=1, y=1.3, z=0.5}, 45, 2, 1000, false, {
			{'default:steel_ingot', 'farming:string', 'default:stick'},
			{'default:steel_ingot', 'farming:string', 'default:steel_ingot'},
			{'default:steel_ingot', 'farming:string', 'default:stick'},
		})
end--]]