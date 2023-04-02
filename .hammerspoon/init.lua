alt1 =  {'ctrl', 'cmd'}
alt2 =  {'rightcmd', 'rightalt'}
alt2 = {'alt', 'cmd'}
alt3 = {'shift', 'alt', 'cmd'}

hotkeys = {
    d = "Discord",
    t = "Alacritty",
    c = "Visual Studio Code",
    b = "Firefox",
    f = "Finder",
}

-- launch application
for key, app in pairs(hotkeys) do
    hs.hotkey.bind(alt2, key, function()
        hs.application.launchOrFocus(app)
    end)
end

local function moveWindow(x, y, w, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  f.x = screen.x + (screen.w * x)
  f.y = screen.y + (screen.h * y)
  f.w = screen.w * w
  f.h = screen.h * h

  win:setFrame(f)
end

-- move window to the left
hs.hotkey.bind(alt1, "h", function() moveWindow(0, 0, 0.5, 1) end)

-- move window to the right
hs.hotkey.bind(alt1, "l", function() moveWindow(0.5, 0, 0.5, 1) end)

-- move window to upper right
hs.hotkey.bind(alt1, "i", function() moveWindow(0.5, 0, 0.5, 0.5) end)

-- move window to lower right
hs.hotkey.bind(alt1, "k", function() moveWindow(0.5, 0.5, 0.5, 0.5) end)

-- move window to upper left
hs.hotkey.bind(alt1, "u", function() moveWindow(0, 0, 0.5, 0.5) end)

-- move window to lower left
hs.hotkey.bind(alt1, "j", function() moveWindow(0, 0.5, 0.5, 0.5) end)

-- maxize window
hs.hotkey.bind(alt1, "m", function()
  local win = hs.window.focusedWindow()
    win:maximize()
end)

-- almost maxize window
hs.hotkey.bind(alt1, "p", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.w = screen.w * 0.8
  f.h = screen.h * 0.8
  f.x = screen.x + (screen.w - f.w) / 2
  f.y = screen.y + (screen.h - f.h) / 2

  win:setFrame(f)
end)





