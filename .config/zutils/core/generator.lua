---@diagnostic disable: need-check-nil
local function generate(updated_plugins)
	local plugin = require("plugin")


  local seven_days = 604800

	local generated_folder = os.getenv("ZUTIL_HOME") .. "/.generated/"
	local file_path = generated_folder .. "init.zsh"
	os.execute("touch " .. file_path)
	os.execute("chmod 777 " .. file_path)

	local plugins = plugin.list()
	local output = io.open(file_path, "w")

  output:write([[
if [ -z "$ZUTIL_HOME" ]; then
  export ZUTIL_HOME=~/.config/zutils
fi
export PATH=$PATH:$ZUTIL_HOME/commands
if [ $(date +%s) -gt ]] .. os.time() + seven_days .. [[ ];
then
  (zplugin auto-update > $ZUTIL_HOME/.generated/stdout 2> $ZUTIL_HOME/.generated/stderr &)
fi
]])

	for _, plug in ipairs(plugins) do
		output:write("source " .. plug:main_file() .. "\n")
	end

  if updated_plugins ~= nil and #updated_plugins > 0 then
    output:write("echo \"Updated plugins:\"\n")
    for _, plugin_name in ipairs(updated_plugins) do
      output:write("echo \"- " .. plugin_name .. "\"\n")
    end
    output:write("(zapply &)")
  end

	output:close()
end

return generate
