require "lib"

-- TODO: change window management for use with hs.grid

local mod1 = { 'shift', 'cmd' }
local mod2 = { 'ctrl', 'cmd' }
local mod3 = { 'rightcmd', 'rightalt' }
local mod4 = { 'shift', 'ctrl', 'cmd' }
local mod5 = { 'alt', 'cmd' }
local mod6 = { 'ctrl', 'alt' }
local mod7 = { 'shift', 'fn' }

-- Clipboard manager: https://github.com/p0deje/Maccy
-- hs.application.launchOrFocus('Maccy')

-- Caffeine: https://github.com/IntelliScape/caffeine/
-- hs.application.launchOrFocus('Caffeine')

function move_window(X, Y, W, H)
  local window = hs.window.focusedWindow()
  local screenFrame = window:screen():frame()
  window:setFrame({
    x = screenFrame.x + screenFrame.w * X,
    y = screenFrame.y + screenFrame.h * Y,
    w = screenFrame.w * W,
    h = screenFrame.h * H
  })
end

local new_terminal_window = function()
  local application = hs.application.get('Terminal')
  if application then
    application:activate(false)
    hs.eventtap.keyStroke({ 'cmd' }, 'N')
  else
    hs.application.launchOrFocus('Terminal')
  end
end

local new_finder_window = function() hs.application.find("Finder"):selectMenuItem({ "File", "New Finder Window" }) end

-- mapping = {{modifier, key, function}}
local mappings = {
  -- Create new Finder window in active workspace
  { mod1, 'F',      new_finder_window },
  { mod2, 'F',      new_finder_window },

  -- Launch Apps
  { mod2, 'C',      function() hs.application.launchOrFocus('Visual Studio Code') end },
  { mod2, 'E',      function() hs.application.launchOrFocus('Cot Editor') end },
  { mod2, 'B',      function() hs.application.launchOrFocus('Firefox') end },
  
  -- cmd+return: launch or focus
  -- shift+cmd+ return: new tab
  { 'cmd', 'return', function() hs.application.launchOrFocus('Terminal') end  },
  { mod1, 'return',  new_terminal_window},

  -- Toggle Dark mode
  { mod5, 'T',      toggle_dark_mode },
  { mod6, 'Y',      toggle_night_shift }, -- not working

  -- control brightness
  { mod7, 'F1',     decrease_keyboard_brightness },
  { mod7, 'F2',     increase_keyboard_brightness },
  { mod7, 'F3',     toggle_keyboard_backlight }, -- not working

  -- Move window to the left
  { mod2, 'H',      function() move_window(0, 0, 0.5, 1) end },
  { mod2, 'left',   function() move_window(0, 0, 0.5, 1) end },

  -- Move window to the right
  { mod2, 'L',      function() move_window(0.5, 0, 0.5, 1) end },
  { mod2, 'right',  function() move_window(0.5, 0, 0.5, 1) end },

  -- Move window to upper right
  { mod2, 'I',      function() move_window(0.5, 0, 0.5, 0.5) end },

  -- Move window to lower right
  { mod2, 'K',      function() move_window(0.5, 0.5, 0.5, 0.5) end },

  -- Move window to upper left
  { mod2, 'U',      function() move_window(0, 0, 0.5, 0.5) end },

  -- Move window to lower left
  { mod2, 'J',      function() move_window(0, 0.5, 0.5, 0.5) end },

  -- Maximize window
  { mod2, 'P',      function() hs.window.focusedWindow():maximize() end },
  { mod2, 'up',     function() hs.window.focusedWindow():maximize() end },

  -- Almost maximized window
  { mod2, 'M',      function() move_window(0.1, 0.1, 0.8, 0.8) end },
  { mod2, 'down',   function() move_window(0.1, 0.1, 0.8, 0.8) end },
}

for i, map in ipairs(mappings) do
  hs.hotkey.bind(map[1], map[2], map[3])
end
