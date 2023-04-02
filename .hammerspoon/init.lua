local super = { 'ctrl', 'cmd' }
local meta = { 'shift', 'ctrl', 'cmd' }
local hyper = { 'rightcmd', 'rightalt' }

local function focusedWindowAndFrame()
   local window = hs.window.focusedWindow()
   local windowFrame = window:frame()
   local screenFrame = window:screen():frame()
   return window, windowFrame, screenFrame
end

local function moveWindow(X, Y, W, H)
   local window, windowFrame, screenFrame = focusedWindowAndFrame()
   windowFrame.x = screenFrame.x + (screenFrame.w * X)
   windowFrame.y = screenFrame.y + (screenFrame.h * Y)
   windowFrame.w = screenFrame.w * W
   windowFrame.h = screenFrame.h * H
   window:setFrame(windowFrame)
end

local function centeredWindow()
   local window, windowFrame, screenFrame = focusedWindowAndFrame()
   windowFrame.w = screenFrame.w * 0.8
   windowFrame.h = screenFrame.h * 0.8
   windowFrame.x = screenFrame.x + (screenFrame.w - windowFrame.w) / 2
   windowFrame.y = screenFrame.y + (screenFrame.h - windowFrame.h) / 2
   window:setFrame(windowFrame)
end

local function newTerminal()
   local application = hs.application.get('Alacritty')
   if application then
      application:activate(false)
      hs.eventtap.keyStroke({ 'cmd' }, 'N')
   else
      hs.application.launchOrFocus('Alacritty')
   end
end

hs.fnutils.each({
   { key = 'D', app = 'Discord' },
   { key = 'T', app = 'Alacritty' },
   { key = 'C', app = 'Visual Studio Code' },
   { key = 'E', app = 'CotEditor' },
   { key = 'B', app = 'Firefox' }
}, function(map)
   hs.hotkey.bind(super, map.key, function() hs.application.launchOrFocus(map.app) end)
end)

-- mapping = {{modifier, key, function}}
local mappings = {
   -- Create new Finder window in active workspace
   {hyper, 'F', function() hs.application.find("Finder"):selectMenuItem({"Fichier", "Nouvelle fenêtre Finder"}) end},
   -- Create new terminal window in active workspace
   {meta, 'T', newTerminal},
   {{'shift', 'cmd' }, 'return', newTerminal},
   -- Move window to the left
   {super, 'H', function() moveWindow(0, 0, 0.5, 1) end},
   {super, 'left', function() moveWindow(0, 0, 0.5, 1) end},
   -- Move window to the right
   {super, 'L', function() moveWindow(0.5, 0, 0.5, 1) end},
   {super, 'right', function() moveWindow(0.5, 0, 0.5, 1) end},
   -- Move window to upper right
   {super, 'I', function() moveWindow(0.5, 0, 0.5, 0.5) end},
   -- Move window to lower right
   {super, 'K', function() moveWindow(0.5, 0.5, 0.5, 0.5) end},
   -- Move window to upper left
   {super, 'U', function() moveWindow(0, 0, 0.5, 0.5) end},
   -- Move window to lower left
   {super, 'J', function() moveWindow(0, 0.5, 0.5, 0.5) end},
   -- Maximize window
   {super, 'P', function() hs.window.focusedWindow():maximize() end},
   {super, 'up', function() hs.window.focusedWindow():maximize() end},
   -- Almost maximized window
   {super, 'M', centeredWindow },
   {super, 'down', centeredWindow }
}

for i, mapping in ipairs(mappings) do
   hs.hotkey.bind(mapping[1], mapping[2], mapping[3])
end
