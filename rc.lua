local gears = require('gears')
local awful = require('awful')
local wibox = require("wibox")
require('awful.autofocus')
local beautiful = require('beautiful')

-- Theme
beautiful.init(require('theme'))


-- Layout
require('layout')

-- Init all modules
require('module.notifications')
require('module.auto-start')
require('module.decorate-client')
-- Backdrop causes bugs on some gtk3 applications
--require('module.backdrop')
require('module.exit-screen')
require('module.quake-terminal')

-- Setup all configurations
require('configuration.client')
require('configuration.tags')
_G.root.keys(require('configuration.keys.global'))

-- {{{ Screen
-- Reset wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal( "property::geometry", function(s) beautiful.wallpaper.maximized( beautiful.wallpaper, s, beautiful.wallpapers) end )

-- Signal function to execute when a new client appears.
_G.client.connect_signal(
  'manage',
  function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not _G.awesome.startup then
      awful.client.setslave(c)
    end

    if _G.awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end
)

-- Enable sloppy focus, so that focus follows mouse.
--[[
_G.client.connect_signal(
  'mouse::enter',
  function(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = true})
  end
)
--]]

-- Make the focused window have a glowing border
_G.client.connect_signal(
  'focus',
  function(c)
    c.border_color = beautiful.border_focus
  end
)
_G.client.connect_signal(
  'unfocus',
  function(c)
    c.border_color = beautiful.border_normal
  end
)
awful.util.spawn_with_shell("nm-applet &")
awful.util.spawn_with_shell("xfce4-power-manager &")
awful.util.spawn_with_shell("telegram-desktop &")
awful.util.spawn_with_shell("flameshot &")
awful.util.spawn_with_shell("pnmixer &")
awful.util.spawn_with_shell("brave &")
awful.util.spawn_with_shell("xfce4-clipman &")
awful.util.spawn_with_shell("picom &")
awful.util.spawn_with_shell("feh --bg-scale /mnt/D/PHOTOS/wp4198956-mgaming-wallpapers.jpg &")