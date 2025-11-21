-- Definicja helpera
function table.filterKey(t, keyToRemove)
	local new_table = {}
	for k, v in pairs(t) do
		if k ~= keyToRemove then
			new_table[k] = v
		end
	end
	return new_table
end
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["water"].size = 4

if settings.startup["generate-oil-only-on-water"].value then
	data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls =
		table.filterKey(data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls, "crude-oil")
	data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings.entity.settings =
		table.filterKey(data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings.entity.settings, "crude-oil")
end

if settings.startup["generate-uranium-only-on-water"].value then
	data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls =
		table.filterKey(data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls, "uranium-ore")
	data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings.entity.settings =
		table.filterKey(data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings.entity.settings, "uranium-ore")
end

local planet = data.raw.planet and data.raw.planet["nauvis"]
local mgs = planet.map_gen_settings or {}
mgs.autoplace_controls = mgs.autoplace_controls or {}
mgs.autoplace_controls["uranium-sludge"] = mgs.autoplace_controls["uranium-sludge"]
	or {
		frequency = 3,
		size = 1.2,
		richness = 2,
		starting_area = false,
	}

mgs.autoplace_settings = mgs.autoplace_settings or {}
mgs.autoplace_settings["entity"] = mgs.autoplace_settings["entity"] or { settings = {} }
mgs.autoplace_settings["entity"].settings["uranium-sludge"] = mgs.autoplace_settings["entity"].settings["uranium-sludge"]
	or {}

planet.map_gen_settings = mgs
