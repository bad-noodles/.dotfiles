local resize = function(cb)
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	cb(f, max)
	win:setFrame(f)
end

-- Maximise
hs.hotkey.bind({ "cmd", "ctrl" }, "m", function()
	resize(function(frame, max)
		frame.x = max.x
		frame.y = max.y
		frame.w = max.w
		frame.h = max.h
	end)
end)

-- Left
hs.hotkey.bind({ "cmd", "ctrl" }, "h", function()
	resize(function(frame, max)
		frame.x = max.x
		frame.y = max.y
		frame.w = max.w / 2
		frame.h = max.h
	end)
end)

-- Right,
hs.hotkey.bind({ "cmd", "ctrl" }, "l", function()
	resize(function(frame, max)
		frame.x = max.x + (max.w / 2)
		frame.y = max.y
		frame.w = max.w / 2
		frame.h = max.h
	end)
end)

-- Up
hs.hotkey.bind({ "cmd", "ctrl" }, "k", function()
	resize(function(frame, max)
		frame.x = max.x
		frame.y = max.y
		frame.w = max.w
		frame.h = max.h / 2
	end)
end)

-- Down
hs.hotkey.bind({ "cmd", "ctrl" }, "j", function()
	resize(function(frame, max)
		frame.x = max.x
		frame.y = max.y + (max.h / 2)
		frame.w = max.w
		frame.h = max.h / 2
	end)
end)

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight", {
	hotkeys = {
		screen_left = { { "ctrl", "alt", "cmd" }, "h" },
		screen_right = { { "ctrl", "alt", "cmd" }, "l" },
	},
})
