#!/bin/bash
set -euo pipefail

cat <<'EOF' | fuzzel --dmenu --width=60 --lines=20
                  KEYBINDINGS CHEAT SHEET
BASICS
  Mod+Shift+R          Reload Sway config
  Mod+Return           Open terminal
  Mod+Q                Kill focused window
  Mod+R                App launcher
  Mod+I                Browser
  Mod+E                File manager
  Mod+D                Discord
  Mod+Space            Switch keyboard layout

MENUS / TUI
  Mod+N                Network TUI (wlctl)
  Mod+A                Audio mixer TUI (wiremix)
  Mod+B                Bluetooth TUI (bluetui)
  Mod+S                System info TUI (btop)
  Mod+P                Power menu
  Mod+U                Update menu
  Mod+C                Config menu
  Mod+M                General menu

SCREENSHOTS
  Print                Area screenshot → save + copy to clipboard
  Mod+Shift+S          Area screenshot → save + copy to clipboard

FOCUS
  Mod+H/J/K/L          Focus left / down / up / right
  Mod+←/↓/↑/→          Focus left / down / up / right

MOVE WINDOW
  Mod+Shift+H/J/K/L    Move window left / down / up / right
  Mod+Shift+←/↓/↑/→    Move window left / down / up / right
  Mod+LMB              Move window with mouse

WORKSPACES
  Mod+1..9             Switch workspace 1..9
  Mod+Shift+1..9       Move window to workspace 1..9

LAYOUT
  Mod+F                Fullscreen toggle
  Mod+V                Toggle floating/tiling

SCRATCHPAD
  Mod+-                Send window to scratchpad
  Mod+=                Show/cycle scratchpad

RESIZE
  Mod+Ctrl+H/J/K/L     Resize (width/height)
  Mod+Ctrl+←/↓/↑/→     Resize (width/height)
  Mod+RMB              Resize window with mouse
EOF
