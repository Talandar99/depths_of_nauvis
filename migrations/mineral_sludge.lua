if script.active_mods["Krastorio2-spaced-out"] or script.active_mods["Krastorio2"] then
	for _, planet in pairs(game.planets) do
		if planet.name == "nauvis" and planet.surface then
			local surface = planet.surface
			local map_gen_settings = surface.map_gen_settings
			map_gen_settings.autoplace_controls["mineral-sludge"] = {}
			map_gen_settings.autoplace_settings.entity.settings["mineral-sludge"] = {}
			surface.map_gen_settings = map_gen_settings
			surface.regenerate_entity("mineral-sludge")
			game.print("⚓Mineral Sludge was properly added to surface of Nauvis. Search in new chunks to find it!⚓")
		end
	end
end
