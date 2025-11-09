local output = require("framework/output")

local List = {}

local root = os.getenv("ZUTIL_HOME")

function List:new(path)
  local list = {
    path = root .. "/" .. path
  }
  setmetatable(list, self)
  self.__index = self
  return list
end

function List:add(value)
  if self:exists(value) then
    return
  end

  local file, err = io.open(self.path, "a+")
  if not file then
    output.exit(output.error_codes.FailedToReadFile, err)
    return
  end
  file:write(value, "\n")
  file:close()
end

function List:exists(value)
  local file, err = io.open(self.path, "r")
  if not file then
    output.exit(output.error_codes.FailedToReadFile, err)
    return
  end

  for line in file:lines() do
    if line == value then
      file:close()
      return true
    end
  end

  file:close()
  return false
end

function List:remove(value)
  local file, err = io.open(self.path, "r")
  if not file then
    output.exit(output.error_codes.FailedToReadFile, err)
    return
  end

  local lines = {}
  for line in file:lines() do
    if line ~= value then
      table.insert(lines, line)
    end
  end

  file, err = io.open(self.path, "w")
  if not file then
    output.exit(output.error_codes.FailedToReadFile, err)
    return
  end
  for _, line in ipairs(lines) do
    file:write(line .. '\n')
  end

  file:close()
  return false
end

function List:values()
  local file, err = io.open(self.path, "r")
  if not file then
    output.exit(output.error_codes.FailedToReadFile, err)
    return
  end

  local values = {}

  for line in file:lines() do
    table.insert(values, line)
  end

  file:close()

  return values
end

return List
