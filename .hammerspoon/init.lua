local mod1 = {'shift', 'cmd' }
local mod2 = { 'ctrl', 'cmd' }
local mod3 = { 'rightcmd', 'rightalt' }
local mod4 = { 'shift', 'ctrl', 'cmd' }

local function moveWindow(X, Y, W, H)
   local window = hs.window.focusedWindow()
   local screenFrame = window:screen():frame()
   window:setFrame({
      x = screenFrame.x + screenFrame.w * X,
      y = screenFrame.y + screenFrame.h * Y,
      w = screenFrame.w * W,
      h = screenFrame.h * H
   })
end

local function newTerminal()
   local application = hs.application.get('kitty')
   if application then
      application:activate(false)
      hs.eventtap.keyStroke({ 'cmd' }, 'N')
   else
      hs.application.launchOrFocus('kitty')
   end
end

local mappings = {
    { key = 'D', app = 'Discord' },
    { key = 'C', app = 'Visual Studio Code' },
    { key = 'E', app = 'CotEditor' },
    { key = 'B', app = 'Firefox' },
}

for i, map in ipairs(mappings) do
   hs.hotkey.bind(mod2, map.key, function() hs.application.launchOrFocus(map.app) end)
end

-- mapping = {{modifier, key, function}}
local mappings = {
   -- Create new Finder window in active workspace
   {mod1, 'F', function() hs.application.find("Finder"):selectMenuItem({"Fichier", "Nouvelle fenêtre Finder"}) end},
   {mod2, 'F', function() hs.application.find("Finder"):selectMenuItem({"Fichier", "Nouvelle fenêtre Finder"}) end},
   {mod3, 'F', function() hs.application.find("Finder"):selectMenuItem({"Fichier", "Nouvelle fenêtre Finder"}) end},
   
   -- Create new terminal window in active workspace
   {mod2, 'T', function() newTerminal() end},
   {mod4, 'T', function() newTerminal() end},
   {mod2, 'return', function() newTerminal() end},
   {mod1, 'return', function() newTerminal() end},
  
   -- Move window to the left
   {mod2, 'H', function() moveWindow(0, 0, 0.5, 1) end},
   {mod2, 'left', function() moveWindow(0, 0, 0.5, 1) end},
  
   -- Move window to the right
   {mod2, 'L', function() moveWindow(0.5, 0, 0.5, 1) end},
   {mod2, 'right', function() moveWindow(0.5, 0, 0.5, 1) end},
  
   -- Move window to upper right
   {mod2, 'I', function() moveWindow(0.5, 0, 0.5, 0.5) end},
  
   -- Move window to lower right
   {mod2, 'K', function() moveWindow(0.5, 0.5, 0.5, 0.5) end},
  
   -- Move window to upper left
   {mod2, 'U', function() moveWindow(0, 0, 0.5, 0.5) end},
  
   -- Move window to lower left
   {mod2, 'J', function() moveWindow(0, 0.5, 0.5, 0.5) end},
  
   -- Maximize window
   {mod2, 'P', function() hs.window.focusedWindow():maximize() end},
   {mod2, 'up', function() hs.window.focusedWindow():maximize() end},
  
   -- Almost maximized window
   {mod2, 'M', function() moveWindow(0.1, 0.1, 0.8, 0.8) end},
   {mod2, 'down', function() moveWindow(0.1, 0.1, 0.8, 0.8) end},
}

for i, map in ipairs(mappings) do
   hs.hotkey.bind(map[1], map[2], map[3])
end
