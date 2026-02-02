# Development Environment Setup

Personal configuration files for development tools and terminal setup.

## WezTerm Configuration

This repository includes a comprehensive WezTerm configuration with advanced features.

### Setup Instructions

```bash
# Copy WezTerm config to your home directory
cp .wezterm.lua ~/.wezterm.lua
```

WezTerm will automatically reload when you save the config file.

### Features

**Visual Appearance:**
- Font: MesloLGS Nerd Font Mono (size 19)
- Color scheme: tokyonight_night
- Window opacity: 80% with macOS blur effect (blur level: 20)
- Integrated window control buttons (minimize, maximize, close)
- Tab bar enabled
- Large scrollback buffer: 100,000 lines

**Pane Management:**
- `Cmd+D` - Split pane horizontally
- `Cmd+Shift+D` - Split pane vertically
- `Cmd+Left/Right Arrow` - Navigate between panes
- Mouse focus follows pointer automatically

**Tab Navigation:**
- `Cmd+Option+Left/Right Arrow` - Switch between tabs

**Text Navigation:**
- `Option+Left/Right Arrow` - Jump backward/forward by word

**Editor Integration:**
- `Cmd+S` - Save in vim (sends `:w\n`)
- `Shift+Enter` - Multi-line input handling

**Configuration:**
- `Cmd+,` - Quick access to open config file

**Mouse Features:**
- `Cmd+Alt+Click` - Block text selection mode
- `4-click` - Semantic zone selection (selects entire logical block)

**Task Notifications:**
- Terminal can send desktop notifications via `wez_notify` user variable

### Customization

To change the color scheme, modify this line in `.wezterm.lua`:
```lua
config.color_scheme = "tokyonight_night"
```

WezTerm includes 735+ built-in color schemes. Popular alternatives: `Batman`, `Dracula`, `Nord`, `Solarized Dark`.

### References

**WezTerm Setup:**
- Great tutorial: https://www.josean.com/posts/how-to-setup-wezterm-terminal
- Official docs: https://wezterm.org/config/files.html

## iTerm Setup

Alternative setup guide: https://gist.github.com/GLMeece/4b51037daa0d6b83256f80b560246f38

## Git Tips

**Ignore untracked files locally:**
https://stackoverflow.com/a/1753078

## iOS Development

Swift language support in Cursor: https://docs.cursor.com/guides/languages/swift
