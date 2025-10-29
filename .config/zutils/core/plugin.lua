local list = require("list")
local git = require("git")

local plugin_folder = os.getenv("ZUTIL_HOME") .. "/.plugins/"

local Plugin = {
	installed = false,
	listed = false,
}

local plugin_list = list:new("plugins")

function Plugin.is_listed(plugin_name)
	return plugin_list:exists(plugin_name)
end

function Plugin.is_installed(plugin_name)
	local path = plugin_folder .. plugin_name .. "/"
	local ok, err, code = os.rename(path, path)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

function Plugin.list()
	local plugins = {}

	for _, plugin_name in ipairs(plugin_list:values()) do
		table.insert(plugins, Plugin:new(plugin_name))
	end

	return plugins
end

function Plugin.update_all()
	local plugins = Plugin.list()
	local updated = {}

	for _, plug in ipairs(plugins) do
		local had_updates = plug:update()
		if had_updates then
			table.insert(updated, plug.name)
		end
	end

	return updated
end

function Plugin:main_file()
	local path = plugin_folder .. self.name
	local files = io.popen("ls -pa " .. path .. " | grep .plugin.zsh"):lines()
	for f in files do
		return plugin_folder .. self.name .. "/" .. f
	end
end

function Plugin:install()
	print("Installing " .. self.name)
	plugin_list:add(self.name)

	if Plugin.is_installed(self.name) then
		print("Already installed")
		return
	end

	git.checkout(self.name)
end

function Plugin.install_all()
	local plugins = Plugin.list()

	for _, plug in ipairs(plugins) do
		plug:install()
	end
end

function Plugin:update()
	print("Updating \27[1m" .. self.name .. "\27[0m")
	plugin_list:add(self.name)
	local out = git.pull(self.name)
	print(out)
	return out ~= "Already up to date.\n"
end

function Plugin:new(plugin_name)
	local plugin = {
		name = plugin_name,
		listed = Plugin.is_listed(plugin_name),
		installed = Plugin.is_installed(plugin_name),
	}
	setmetatable(plugin, self)
	self.__index = self
	return plugin
end

return Plugin
