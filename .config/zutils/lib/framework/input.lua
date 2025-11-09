local Input = {}

local arguments = {}
local argument_names = {}

for _, a in ipairs(arg) do
	local key, value = a:match("^%-%-([^=]+)=(.+)$")
	if key and value then
		arguments[key] = value
    argument_names[key] = true
	elseif a:sub(1, 2) == "--" then
		arguments[a:sub(3)] = true
	else
		table.insert(arguments, a)
	end
end

function Input.flag(name)
  return arguments[name] == true
end

function Input.named_argument(name)
  if not argument_names[name] then
    return false
  end

  return arguments[name]
end

function Input.nth_argument(pos)
  return arguments[pos]
end

return Input
