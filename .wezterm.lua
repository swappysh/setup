-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19

config.color_scheme = 'tokyonight_night'
config.pane_focus_follows_mouse = true
config.scrollback_lines = 100000

config.enable_tab_bar = false

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

config.keys = {
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key="LeftArrow",
    mods="OPT",
    action=wezterm.action{SendString="\x1bb"}
  },
  {
    key="RightArrow",
    mods="OPT",
    action=wezterm.action{SendString="\x1bf"}
  },
  {
    key = 'LeftArrow',
    mods = 'CMD|OPT',
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = 'RightArrow',
    mods = 'CMD|OPT',
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = wezterm.action{ActivatePaneDirection='Prev'},
  },
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = wezterm.action{ActivatePaneDirection='Next'},
  },
  {
    key="s",
    mods="CMD",
    action = wezterm.action{SendString="\x1b:w\n"}
  },
}

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CMD|ALT',
    action = wezterm.action.SelectTextAtMouseCursor 'Block',
    alt_screen='Any'
  },
  {
    event = { Down = { streak = 4, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
}

-- and finally, return the configuration to wezterm
return config
