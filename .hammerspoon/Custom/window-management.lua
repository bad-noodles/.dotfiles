local function resize_window(x_ratio, y_ratio, w_ratio, h_ratio)
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  win:setFrame({
    x = screen.x + (screen.w * x_ratio),
    y = screen.y + (screen.h * y_ratio),
    w = screen.w * w_ratio,
    h = screen.h * h_ratio,
  })
end

local layouts = {
  { key = "m", x = 0, y = 0, w = 1, h = 1 },
  { key = "h", x = 0, y = 0, w = 0.5, h = 1 },
  { key = "l", x = 0.5, y = 0, w = 0.5, h = 1 },
  { key = "k", x = 0, y = 0, w = 1, h = 0.5 },
  { key = "j", x = 0, y = 0.5, w = 1, h = 0.5 },
}

for _, layout in ipairs(layouts) do
  hs.hotkey.bind({ "cmd", "ctrl" }, layout.key, function()
    resize_window(layout.x, layout.y, layout.w, layout.h)
  end)
end

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
	hotkeys = {
		screen_left = { { "ctrl", "alt", "cmd" }, "h" },
		screen_right = { { "ctrl", "alt", "cmd" }, "l" },
	},
})
