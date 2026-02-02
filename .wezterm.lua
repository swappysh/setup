-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Core appearance settings
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19
config.color_scheme = "tokyonight_night"
config.enable_tab_bar = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

-- Advanced features
config.pane_focus_follows_mouse = true
config.scrollback_lines = 100000

-- Task completion notifications using user variables
wezterm.on('user-var-changed', function(window, pane, name, value)
  if name == 'wez_notify' then
    window:toast_notification('WezTerm', value, nil, 4000)
  end
end)

-- Key bindings (merged from both configs)
config.keys = {
  -- Pane management (from GitHub)
  {
    key = "d",
    mods = "CMD",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },

  -- Pane navigation (from GitHub)
  {
    key = "LeftArrow",
    mods = "CMD",
    action = act.ActivatePaneDirection("Prev"),
  },
  {
    key = "RightArrow",
    mods = "CMD",
    action = act.ActivatePaneDirection("Next"),
  },

  -- Tab navigation (from GitHub)
  {
    key = "LeftArrow",
    mods = "CMD|OPT",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "CMD|OPT",
    action = act.ActivateTabRelative(1),
  },

  -- Word navigation (from both configs)
  {
    key = "LeftArrow",
    mods = "OPT",
    action = act.SendString("\x1bb"),
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = act.SendString("\x1bf"),
  },

  -- Vim integration (from GitHub)
  {
    key = "s",
    mods = "CMD",
    action = act.SendString("\x1b:w\n"),
  },

  -- Multi-line input (from local)
  {
    key = "Enter",
    mods = "SHIFT",
    action = act.SendString("\x1b\r"),
  },

  -- Quick config editing (from local)
  {
    key = ",",
    mods = "SUPER",
    action = act.SpawnCommandInNewWindow({
      cwd = os.getenv("WEZTERM_CONFIG_DIR"),
      args = { os.getenv("SHELL"), "-c", "$EDITOR $WEZTERM_CONFIG_FILE" },
    }),
  },
}

-- Mouse bindings (from GitHub)
config.mouse_bindings = {
  -- Block selection with Cmd+Alt+Click
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CMD|ALT",
    action = act.SelectTextAtMouseCursor("Block"),
    alt_screen = "Any",
  },
  -- Semantic zone selection with 4-click
  {
    event = { Down = { streak = 4, button = "Left" } },
    action = act.SelectTextAtMouseCursor("SemanticZone"),
    mods = "NONE",
  },
}

-- Return the configuration to wezterm
return config
