---@diagnostic disable: need-check-nil

local plugin_folder = os.getenv("ZUTIL_HOME") .. "/.plugins/"

local git = {}

-- Adapters
local regular = {}
local sparse = {}

function regular.clone(repo)
	local url = git.resolve(repo)
	os.execute("git clone " .. url .. " " .. plugin_folder .. repo)
end

function regular.pull(repo)
	local handle = io.popen("git -C " .. plugin_folder .. repo .. " pull")
	local out = handle:read("*a")
	handle:close()

	return out
end

function sparse.clone(repo, path)
	local url = git.resolve(repo)
	local handle = io.popen("git clone --depth=1 --filter=tree:0 --no-checkout " .. url .. " " .. plugin_folder .. repo)
	local out = handle:read("*a")
	handle:close()
  

	handle = io.popen("git -C " .. plugin_folder .. repo .. " sparse-checkout init")
	out = out .. "\n" .. handle:read("*a")
	handle:close()

	handle = io.popen("git -C " .. plugin_folder .. repo .. " sparse-checkout set " .. path)
	out = out .. "\n" .. handle:read("*a")
	handle:close()

	handle = io.popen("git -C " .. plugin_folder .. repo .. " checkout")
	out = out .. "\n" .. handle:read("*a")
	handle:close()

	return out
end

function git.is_sparse(repo)
	local handle = io.popen("git -C " .. plugin_folder .. repo .. " sparse-checkout list")
	local out = handle:read("*a")

	handle:close()

	return out ~= "fatal: this worktree is not sparse"
end

function git.resolve(repo)
	-- TODO: Other sources
	return "https://github.com/" .. repo
end

function git.download(repo, path)
	print(path)
	if not path then
		return regular.clone(repo)
	end

	return sparse.clone(repo, path)
end

function git.pull(repo)
	return regular.pull(repo)
end

return git
