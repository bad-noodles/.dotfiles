
local root = os.getenv("ZUTIL_HOME")
package.path = package.path .. ";" .. root .. "/lib/?.lua"

require("core/generator")()
os.execute("exec zsh")
