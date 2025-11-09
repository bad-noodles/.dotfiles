---@diagnostic disable: undefined-field, undefined-global

describe("Plugin", function()
	local plugin
	local fake_home
	local git
	local list

	setup(function()
		fake_home = os.tmpname()

		os.remove(fake_home)
		os.execute("mkdir " .. fake_home)
		os.execute("mkdir " .. fake_home .. "/.plugins")
		os.execute("mkdir " .. fake_home .. "/.generated")
		os.execute("touch " .. fake_home .. "/plugins")

		---@diagnostic disable-next-line: duplicate-set-field
		os.getenv = function()
			return fake_home
		end

		git = mock(require("framework/git"), true)

		git.download = spy.new(function(repo, path)
			local p = fake_home .. "/.plugins/" .. repo .. "/"
			if path then
				p = p .. "/" .. path .. "/"
			end

			os.execute("mkdir -p " .. p)
		end)

		package.loaded["framework/git"] = git

		list = mock(require("framework/list"), true)

		list.exists = spy.new(function(_, id)
			return id == "Existing/Plugin"
		end)

		list.new = spy.new(function()
			return list
		end)

		package.loaded["framework/list"] = list

		plugin = require("core/plugin")
	end)

	teardown(function()
		os.execute("rm -rf " .. fake_home)
	end)

	before_each(function()
		list.add:clear()
		git.download:clear()
	end)

	describe("install", function()
		it("installs a plugin", function()
			local plug = plugin:new("Existing/Plugin")
			assert.True(plug:install())

			assert.stub(list.add).was.called_with(list, "Existing/Plugin")
			assert.spy(git.download).was.called_with("Existing/Plugin", nil)
		end)

		it("fails to install a plugin if it is already installed", function()
			local plug = plugin:new("Existing/Plugin")

			assert.False(plug:install())
			assert.stub(list.add).was.called_with(list, "Existing/Plugin")
			assert.spy(git.download).was.not_called()
		end)
	end)

	describe("is_listed", function()
		it("returns false for a plugin that is not listed", function()
			assert.False(plugin.is_listed("NonExisting/Plugin"))
		end)

		it("returns true for a plugin that is listed", function()
			assert.True(plugin.is_listed("Existing/Plugin"))
		end)
	end)

	describe("is_installed", function()
		it("returns false for a plugin that is not installed", function()
			assert.False(plugin.is_installed("NonExisting/Plugin"))
		end)

		it("returns true for a plugin that is installed", function()
			assert.True(plugin.is_installed("Existing/Plugin"))
		end)
	end)

	describe("update", function()
		it("returns true if a plugin had updates", function()
			git.pull = spy.new(function()
				return "Updated\n"
			end)
			local plug = plugin:new("Existing/Plugin")
			assert.True(plug:update())
		end)

		it("returns false if a plugin had no updates", function()
			git.pull = spy.new(function()
				return "Already up to date.\n"
			end)
			local plug = plugin:new("Existing/Plugin")
			assert.False(plug:update())
		end)
	end)

	describe("list", function()
		it("returns an empty list if there are no plugins", function()
			list.values = spy.new(function()
				return {}
			end)
			assert.True(#plugin.list() == 0)
		end)
		it("returns a list of plugins if there are plugins", function()
			list.values = spy.new(function()
				return { "Existing/Plugin" }
			end)
			assert.True(#plugin.list() == 1)
		end)
	end)

	describe("uninstall", function()
		it("uninstalls a plugin", function()
			local plug = plugin:new("Existing/Plugin")
			plug:uninstall()
			assert.stub(list.remove).was.called_with(list, "Existing/Plugin")
      assert.False(plugin.is_installed("Existing/Plugin"))
		end)
	end)
end)
