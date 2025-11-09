local input = require("framework/input")
local output = require("framework/output")
local plugin = require("core/plugin")
local generate = require("core/generator")

local function repo()
	return input.nth_argument(2)
end

local function get_plugin()
	return plugin:new(repo(), input.nth_argument(3))
end

local commands = {}

function commands.install()
	if repo() == nil then
		plugin.install_all()
		generate()
		return
	end

	local plug = get_plugin()
	if plug.listed and plug.installed then
		output.exit(
			output.error_codes.AlreadyInstalled,
			"Plugin " .. repo() .. ' already installed! Did you mean "update" instead?'
		)
	end

	plug:install()
	generate()
end

function commands.update()
	if repo() == nil then
		plugin.update_all()
		generate()
		return
	end

	local plug = get_plugin()
	if plug.listed and not plug.installed then
		output.exit(
			output.error_codes.ListedButNotInstalled,
			"Plugin " .. repo() .. ' is listed but not yet installed! Did you mean "install" instead?'
		)
	end

	if not plug.listed and not plug.installed then
		output.exit(
			output.error_codes.NotInstalled,
			"Plugin " .. repo() .. ' not yet installed! Did you mean "install" instead?'
		)
	end

	print("Updating \27[1m" .. plug.id .. "\27[0m")
	plug:update()
	generate()
end

function commands.auto_update()
	local updated = plugin.update_all()
	if #updated == 0 then
		return
	end

	generate(updated)
end

function commands.uninstall()
	if repo() == nil then
		commands.help()
		output.exit(output.error_codes.BadUsage, "Please specify what plugin you want to uninstall")
	end

	local plug = get_plugin()

	print("Uninstalling \27[1m" .. plug.id .. "\27[0m")
	plug:uninstall()
	generate()
end

function commands.list()
	local has_uninstalled = false
	local not_installed_only = input.flag("not-installed")
	local installed_only = input.flag("installed")

	for _, plug in ipairs(plugin.list()) do
		if (installed_only and not plug.installed) or (not_installed_only and plug.installed) then
			goto continue
		end

		if plug.installed then
			print(plug.repo)
		else
			has_uninstalled = true
			print(plug.repo, "(not installed)")
		end
		::continue::
	end

	if has_uninstalled then
		print("\nRun `zplugin install` to install all missing plugins")
	end
end

function commands.help()
	output.print([[
Usage: zplugin install [repo] [path]
       zplugin uninstall [repo] [path]
       zplugin list [list-options]
       zplugin help

repo:
  Full http git repository path or github "username/repository".
  If not provided on install, it will install all listed but uninstalled plugins.

path:
  For plugins that do not reside on the root of the repository.

list-options:
  --installed       Lists installed plugins only
  --not-installed   Lists plugins that are listed for installation but not checked out yet
  ]])
end

local cmd = commands[string.gsub(input.nth_argument(1), "-", "_")]

if not cmd then
	commands.help()
	output.exit(output.error_codes.BadUsage, 'Unknown command "' .. input.nth_argument(1) .. '"')
end

cmd()
