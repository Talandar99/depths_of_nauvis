data:extend({
	{
		type = "bool-setting",
		name = "depthsofnauvis-deep-sea-mechanic",
		setting_type = "startup",
		default_value = true,
		order = "depths-of-nauvis-a",
	},
	{
		type = "bool-setting",
		name = "generate-oil-only-on-water",
		setting_type = "startup",
		default_value = false,
		order = "depths-of-nauvis-c",
	},
	{
		type = "bool-setting",
		name = "generate-uranium-only-on-water",
		setting_type = "startup",
		default_value = true,
		order = "depths-of-nauvis-d",
	},
})
local function force_setting(setting_type, setting_name, value)
	local setting = data.raw[setting_type .. "-setting"][setting_name]
	if setting then
		if setting_type == "bool" then
			setting.forced_value = value
		else
			setting.allowed_values = { value }
		end
		setting.default_value = value
		setting.hidden = true
	end
end
force_setting("bool", "deepsea-on-nauvis", true)
