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
    print("Error opening file:", err)
    os.exit(2, true)
  end
  file:write(value, "\n")
  file:close()
end

function List:exists(value)
  local file, err = io.open(self.path, "r")
  if not file then
    print("Error opening file:", err)
    os.exit(2, true)
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

function List:values()
  local file, err = io.open(self.path, "r")
  if not file then
    print("Error opening file:", err)
    os.exit(2, true)
  end

  local values = {}

  for line in file:lines() do
    table.insert(values, line)
  end

  file:close()

  return values
end

return List
