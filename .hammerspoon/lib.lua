function toggle_dark_mode()
  local script = [[
    set home_path to POSIX path of (path to home folder)
    set dark_background to POSIX path of (home_path & ".config/hammerspoon/wallpapers/dark.jpg")
    set light_background to POSIX path of (home_path & ".config/hammerspoon/wallpapers/light.jpg")

    tell application "System Events"
        tell appearance preferences
            set dark mode to not dark mode
            set is_dark_mode to dark mode
        end tell

        if is_dark_mode then
            set picture of every desktop to dark_background
        else
            set picture of every desktop to light_background
        end if
    end tell
    ]]
  hs.osascript.applescript(script)
end

-- Function to decrease keyboard backlight brightness
function decrease_keyboard_brightness()
  hs.eventtap.event.newSystemKeyEvent("ILLUMINATION_DOWN", true):post()
  hs.eventtap.event.newSystemKeyEvent("ILLUMINATION_DOWN", false):post()
end

-- Function to increase keyboard backlight brightness
function increase_keyboard_brightness()
  hs.eventtap.event.newSystemKeyEvent("ILLUMINATION_UP", true):post()
  hs.eventtap.event.newSystemKeyEvent("ILLUMINATION_UP", false):post()
end

-- Function to toggle keyboard backlight
function toggle_keyboard_backlight()
  hs.eventtap.event.newSystemKeyEvent("ILLUMINATION_TOGGLE", true):post()
  hs.eventtap.event.newSystemKeyEvent("ILLUMINATION_TOGGLE", false):post()
end

function toggle_night_shift()
  local script = [[
        tell application "System Events"
            tell process "System Preferences"
                delay 1
                click checkbox 1 of group 1 of scroll area 1 of group 1 of sheet 1 of window "Displays"
            end tell
        end tell
    ]]
  hs.osascript.applescript(script)
end

-- Create a simple notification
function send_notification()
  hs.notify.new({
    title = "Hammerspoon Notification",
    informativeText = "This is a simple notification created with Hammerspoon!",
    setIdImage = hs.image.imageFromName(hs.image.systemImageNames.ApplicationIcon),
    soundName = hs.notify.defaultNotificationSound
  }):send()
end

-- Define your choices
local choices = {
  {
    ["text"] = "First Choice",
    ["subText"] = "This is the subtext of the first choice",
    ["uuid"] = "001",
  },
  {
    ["text"] = "Second Option",
    ["subText"] = "I wonder what I should type here?",
    ["uuid"] = "002",
  },
  {
    ["text"] = hs.styledtext.new("Third Possibility",
      { font = { size = 18 }, color = hs.drawing.color.definedCollections.hammerspoon.green }),
    ["subText"] = "What a lot of choosing there is going on here!",
    ["uuid"] = "003",
  },
}

-- Create a chooser
local chooser = hs.chooser.new(
  function(choice)
    -- This function will be called when a choice is made in the chooser
    if choice then
      print("Selected option: " .. choice.text)
      -- Match the choice
      if choice.uuid == "001" then
        -- Perform action for the first choice
        print("Performing action for First Choice")
      elseif choice.uuid == "002" then
        -- Perform action for the second choice
        print("Performing action for Second Option")
      elseif choice.uuid == "003" then
        -- Perform action for the third choice
        print("Performing action for Third Possibility")
      end
    end
  end)

-- Add choices to the chooser
chooser:choices(choices)
