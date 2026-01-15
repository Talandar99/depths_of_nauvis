local resource_autoplace = require("resource-autoplace")
-- holmium sludge
data:extend({
	{
		type = "fluid",
		subgroup = "fluid",
		name = "uranium-sludge",
		icon = "__depths_of_nauvis__/graphics/uranium-sludge.png",
		default_temperature = 25,
		base_color = { r = 0.0, g = 0.29, b = 0.04, a = 1.000 },
		flow_color = { r = 0.0, g = 0.49, b = 0.07, a = 1.000 },
		icon_size = 64,
		order = "a[fluid]-b[uranium-sludge]",
		pressure_to_speed_ratio = 0.4,
		flow_to_energy_ratio = 0.59,
		auto_barrel = false,
		auto_titanium_barrel = true,
		fuel_value = "0.15MJ",
	},
})

-- map resource
data:extend({
	{
		type = "autoplace-control",
		name = "uranium-sludge",
		richness = true,
		can_be_disabled = true,
		order = "a-e-b",
		category = "resource",
		icon = "__depths_of_nauvis__/graphics/uranium-sludge.png",
		hidden = true,
	},
	{
		type = "resource-category",
		name = "offshore-fluid",
	},
	{
		type = "resource",
		name = "uranium-sludge",
		collision_mask = { layers = { water_resource = true } },
		icon = "__depths_of_nauvis__/graphics/uranium-sludge.png",
		flags = { "placeable-neutral" },
		category = "offshore-fluid",
		subgroup = "mineable-fluids",
		order = "a-b-b",
		infinite = true,
		highlight = true,
		--minimum = 60000,
		minimum = 100000,
		normal = 250000,
		--surface_conditions = {
		--	{
		--		property = "pressure",
		--		min = 1000,
		--		max = 1000,
		--	},
		--},
		infinite_depletion_amount = 1,
		resource_patch_search_radius = 50,
		minable = {
			mining_time = 1,
			results = {
				{
					type = "fluid",
					name = "uranium-sludge",
					amount_min = 6, --base is 10
					amount_max = 6, --base is 10
					probability = 1,
				},
			},
		},
		map_generator_bounding_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
		collision_bounding_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
		collision_box = table.deepcopy(data.raw.resource["crude-oil"].collision_box),
		selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
		autoplace = resource_autoplace.resource_autoplace_settings({
			name = "uranium-sludge",
			order = "b",
			--base_density = 10,
			base_density = 1,
			base_spots_per_km2 = 1.8,
			--random_probability = 1 / 400,
			random_probability = 1 / 600,
			random_spot_size_minimum = 1, --base 2
			random_spot_size_maximum = 2, --base 4
			additional_richness = 250000,
			has_starting_area_placement = false,
			regular_rq_factor_multiplier = 1,
			planet = "nauvis",
		}),
		stage_counts = { 0 },
		stages = {
			sheet = {
				icon = "__depths_of_nauvis__/graphics/uranium-sludge.png",
				filename = "__depths_of_nauvis__/graphics/uranium-sludge-stain.png",
				priority = "extra-high",
				width = 148,
				height = 120,
				frame_count = 4,
				variation_count = 1,
				shift = util.by_pixel(0, -2),
				scale = 0.7,
			},
		},
		map_color = { r = 0.00, g = 0.79, b = 0.00 },
		map_grid = false,
	},
})

data:extend({
	{
		type = "recipe",
		name = "uranium-sludge-processing",
		icon = "__depths_of_nauvis__/graphics/uranium-sludge-processing.png",
		icon_size = 64,
		category = "oil-processing",
		auto_recycle = false,
		enabled = false,
		allow_productivity = true,
		energy_required = 5,
		ingredients = {
			{ type = "fluid", name = "uranium-sludge", amount = 100 },
			{ type = "fluid", name = "sulfuric-acid", amount = 10 },
		},
		results = {
			--{ type = "item", name = "uranium-ore", amount = 1, probability = 0.25 },
			{ type = "item", name = "uranium-ore", amount = 1 },
		},
		crafting_machine_tint = {

			primary = { r = 0.19, g = 0.07, b = 0.17, a = 1.000 },
			secondary = { r = 0.26, g = 0.1, b = 0.23, a = 1.000 },
			tertiary = { r = 0.19, g = 0.07, b = 0.17, a = 1.000 },
			quaternary = { r = 0.87, g = 0.38, b = 0.50, a = 1.000 },
		},
		main_product = "uranium-ore",
	},
})

if settings.startup["deep-sea-mechanic"].value then
	local landfill = data.raw.item["landfill"]

	if landfill and landfill.place_as_tile and landfill.place_as_tile.tile_condition then
		for i = #landfill.place_as_tile.tile_condition, 1, -1 do
			if landfill.place_as_tile.tile_condition[i] == "deepwater" then
				table.remove(landfill.place_as_tile.tile_condition, i)
			end
		end
	end
end
-- change research to regulat research trigger
data.raw["technology"]["oil-processing"].unit = {
	count = 100,
	ingredients = {
		{ "automation-science-pack", 1 },
		{ "logistic-science-pack", 1 },
	},
	time = 30,
}
data.raw["technology"]["oil-processing"].research_trigger = nil
data.raw["technology"]["uranium-processing"].unit = {
	count = 100,
	ingredients = {
		{ "automation-science-pack", 1 },
		{ "logistic-science-pack", 1 },
		{ "chemical-science-pack", 1 },
	},
	time = 30,
}

data.raw["technology"]["uranium-processing"].research_trigger = nil

-- makes sure mining oil don't require oil to not softlock yourself
data.raw["technology"]["deep_sea_oil_extraction"].unit = {
	count = 100,
	ingredients = {
		{ "automation-science-pack", 1 },
		{ "logistic-science-pack", 1 },
	},
	time = 30,
}

if mods["Krastorio2-spaced-out"] or mods["Krastorio2"] then
	data:extend({
		--------------------- fluid and recipe
		{
			type = "fluid",
			subgroup = "fluid",
			name = "mineral-sludge",
			icon = "__depths_of_nauvis__/graphics/mineral-sludge.png",
			default_temperature = 25,
			base_color = { r = 0.0, g = 0.24, b = 0.60, a = 1.000 },
			flow_color = { r = 0.0, g = 0.24, b = 0.60, a = 1.000 },
			icon_size = 64,
			order = "a[fluid]-b[mineral-sludge]",
			pressure_to_speed_ratio = 0.4,
			flow_to_energy_ratio = 0.59,
			auto_barrel = false,
			auto_titanium_barrel = true,
			fuel_value = "0.15MJ",
		},
		{
			type = "recipe",
			name = "kr-mineral-water",
			icon_size = 64,
			category = "kr-fluid-filtration",
			auto_recycle = false,
			enabled = false,
			allow_productivity = true,
			energy_required = 5,
			ingredients = {
				{ type = "fluid", name = "mineral-sludge", amount = 100 },
			},
			results = {
				{ type = "fluid", name = "kr-mineral-water", amount = 40 },
				{ type = "item", name = "coal", amount = 2 },
			},
			crafting_machine_tint = {

				primary = { r = 0.19, g = 0.07, b = 0.17, a = 1.000 },
				secondary = { r = 0.26, g = 0.1, b = 0.23, a = 1.000 },
				tertiary = { r = 0.19, g = 0.07, b = 0.17, a = 1.000 },
				quaternary = { r = 0.87, g = 0.38, b = 0.50, a = 1.000 },
			},
			main_product = "kr-mineral-water",
		},
		--------------------- generation
		{
			type = "autoplace-control",
			name = "mineral-sludge",
			richness = true,
			can_be_disabled = true,
			order = "a-e-b",
			category = "resource",
			icon = "__depths_of_nauvis__/graphics/mineral-sludge.png",
			hidden = true,
		},
		{
			type = "resource-category",
			name = "offshore-fluid",
		},
		{
			type = "resource",
			name = "mineral-sludge",
			collision_mask = { layers = { water_resource = true } },
			icon = "__depths_of_nauvis__/graphics/mineral-sludge.png",
			flags = { "placeable-neutral" },
			category = "offshore-fluid",
			subgroup = "mineable-fluids",
			order = "a-b-b",
			infinite = true,
			highlight = true,
			--minimum = 60000,
			minimum = 100000,
			normal = 250000,
			--surface_conditions = {
			--	{
			--		property = "pressure",
			--		min = 1000,
			--		max = 1000,
			--	},
			--},
			infinite_depletion_amount = 1,
			resource_patch_search_radius = 50,
			minable = {
				mining_time = 1,
				results = {
					{
						type = "fluid",
						name = "mineral-sludge",
						amount_min = 6, --base is 10
						amount_max = 6, --base is 10
						probability = 1,
					},
				},
			},
			map_generator_bounding_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
			collision_bounding_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
			collision_box = table.deepcopy(data.raw.resource["crude-oil"].collision_box),
			selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
			autoplace = resource_autoplace.resource_autoplace_settings({
				name = "mineral-sludge",
				order = "b",
				--base_density = 10,
				base_density = 1,
				base_spots_per_km2 = 1.8,
				--random_probability = 1 / 400,
				random_probability = 1 / 600,
				random_spot_size_minimum = 1, --base 2
				random_spot_size_maximum = 2, --base 4
				additional_richness = 250000,
				has_starting_area_placement = false,
				regular_rq_factor_multiplier = 1,
				planet = "nauvis",
			}),
			stage_counts = { 0 },
			stages = {
				sheet = {
					icon = "__depths_of_nauvis__/graphics/mineral-sludge.png",
					filename = "__depths_of_nauvis__/graphics/mineral-sludge-stain.png",
					priority = "extra-high",
					width = 148,
					height = 120,
					frame_count = 4,
					variation_count = 1,
					shift = util.by_pixel(0, -2),
					scale = 0.7,
				},
			},
			map_color = { r = 0.80, g = 0.6, b = 0.90 },
			map_grid = false,
		},
	})

	--------------------- tech
	local tech = data.raw.technology["silicon-processing"]
	if tech and tech.effects then
		table.insert(tech.effects, {
			type = "unlock-recipe",
			recipe = "kr-mineral-water",
		})
	end
end
