local function handleResult(_, result)
  if (result:matched() > 0) then
    ---@type hs.axuielement
    local btn = result[1]
    btn:performAction(hs.axuielement.actions.press)
  end
end

---@param el hs.axuielement
local function filter(el)
  local value = el:attributeValue("AXDescription")
  return value == "Quick connect button" or value == "Disconnect button"
end

---@type hs.axuielement | nil
local vpnElement = hs.axuielement.applicationElement("NordVPN")
if vpnElement == nil then
  print("Could not find VPN")
  return
end

hs.hotkey.bind({ "cmd", "shift" }, "v", function()
  vpnElement:elementSearch(handleResult, filter, { ["count"] = 1 })
end)
