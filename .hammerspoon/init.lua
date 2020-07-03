local mash = { 'alt', 'ctrl', 'cmd' }
local logger = hs.logger.new('logger', 'debug')

-- Hello World Snippet

hs.hotkey.bind(mash, "W", function()
  hs.alert.show("Hello World!")
end)


-- Window Management
-- TODO: make size dependent on screenrecording variable and screensize

local units = {
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  rightTop       = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  rightBot       = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  leftTop        = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  leftBot        = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():move(units.right50,    nil, true, 0) end)
hs.hotkey.bind(mash, 'o', function() hs.window.focusedWindow():move(units.rightTop,    nil, true, 0) end)
hs.hotkey.bind(mash, 'l', function() hs.window.focusedWindow():move(units.rightBot,    nil, true, 0) end)
hs.hotkey.bind(mash, 'left', function() hs.window.focusedWindow():move(units.left50,     nil, true, 0) end)
hs.hotkey.bind(mash, 'i', function() hs.window.focusedWindow():move(units.leftTop,     nil, true, 0) end)
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():move(units.leftBot,     nil, true, 0) end)
hs.hotkey.bind(mash, 'up', function() hs.window.focusedWindow():move(units.top50,      nil, true, 0) end)
hs.hotkey.bind(mash, 'down', function() hs.window.focusedWindow():move(units.bot50,      nil, true, 0) end)
hs.hotkey.bind(mash, 'm', function() hs.window.focusedWindow():move(units.maximum,    nil, true, 0) end)
hs.hotkey.bind(mash, 'n', function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

-- Frame
-- TODO: toggle screenrecording variable; shortcut / hs.application.watcher ?
local mainFrame = hs.screen.mainScreen():fullFrame()
local W = mainFrame.w*0.7 + 1
local H = mainFrame.h*0.7 + 1

-- logger:d(W)
-- c = require("hs.canvas")
-- a = c.new{x=0,y=0,h=H,w=W}:appendElements({
--     action = "fill",
--     fillColor = { alpha = 0.5, blue = 1.0  },
--     frame = { x = "0", y = H-1, h = 1, w = W, },
--     type = "rectangle",
--     withShadow = true,
--   }, {
--     action = "fill",
--     fillColor = { alpha = 0.5, blue = 1.0  },
--     frame = { x = W-1, y = "0", h = H, w = 1, },
--     type = "rectangle",
--     withShadow = true,
--   }):show()

-- automatically reload config

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
