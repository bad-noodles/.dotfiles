local list = require("framework/list")
local git = require("framework/git")
local fs = require("framework/fs")

local plugin_folder = os.getenv("ZUTIL_HOME") .. "/.plugins/"
local plugin_list = list:new("plugins")

local Plugin = {}

local function full_path(repo, path)
	local p = plugin_folder .. repo .. "/"
	if path then
		p = p .. "/" .. path .. "/"
	end

	return p
end

function Plugin.is_listed(id)
	return plugin_list:exists(id)
end

function Plugin.is_installed(repo, path)
  local _, err = fs.exists(full_path(repo, path))
  return err == nil
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
			table.insert(updated, plug.repo)
		end
	end

	return updated
end

function Plugin:main_file()
	local path = full_path(self.repo, self.path)
	-- FIX: take care of popen in framework level
	local files = io.popen("ls -pa " .. path .. " | grep .plugin.zsh"):lines()
	for f in files do
		return path .. "/" .. f
	end
end

function Plugin:install()
	plugin_list:add(self.id)

	if Plugin.is_installed(self.id) then
		return false
	end

	git.download(self.repo, self.path)
  return true
end

function Plugin.install_all()
	local plugins = Plugin.list()

	for _, plug in ipairs(plugins) do
		plug:install()
	end
end

function Plugin:update()
	plugin_list:add(self.id)
	local out = git.pull(full_path(self.repo, self.path))

	return out ~= "Already up to date.\n", out
end

function Plugin:uninstall()
	plugin_list:remove(self.id)
	fs.delete_dir(full_path(self.repo, self.path))
end

function Plugin:new(repo, path)
	local id = repo
	if path then
		id = id .. ":" .. path
	end

	local plugin = {
		id = id,
		repo = repo,
		path = path,
		listed = Plugin.is_listed(id),
		installed = Plugin.is_installed(repo, path),
	}
	setmetatable(plugin, self)
	self.__index = self
	return plugin
end

return Plugin
