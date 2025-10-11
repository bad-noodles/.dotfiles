hs.loadSpoon('EmmyLua')
hs.loadSpoon("SpoonInstall")
hs.loadSpoon("ReloadConfiguration")

spoon.ReloadConfiguration:start()

spoon.SpoonInstall:andUse("FnMate")

require("./Custom/window-management")
require("./Custom/app-shortcuts")
-- require("./Custom/menu/menu")
-- require("./Custom/AppSwitcher/app_switcher")
