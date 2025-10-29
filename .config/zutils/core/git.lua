local git = {}

local plugin_folder = os.getenv("ZUTIL_HOME") .. "/.plugins/"

function git.resolve(path)
  -- TODO: Other sources
  return 'https://github.com/' .. path
end

function git.checkout(path)
  local url = git.resolve(path)
  os.execute("git clone " .. url .. " " .. plugin_folder .. path)
end

function git.pull(path)
  local handle = io.popen("git -C " .. plugin_folder .. path .. " pull")
  local out = handle:read("*a")
  handle:close()

  return out
end

return git
