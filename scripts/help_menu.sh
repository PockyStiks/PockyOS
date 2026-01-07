#!/bin/sh
set -eu

text="$(cat <<'EOF'
Keybindings Cheat Sheet

Basics
  Mod+Shift+R   Reload Sway config
  Mod+Return    Open terminal
  Mod+Q         Kill focused window
  Mod+R         App launcher
  Mod+I         Browser
  Mod+D         Discord

Menus / TUI
  Mod+N         Network TUI (wlctl)
  Mod+S         Audio mixer TUI (wiremix)
  Mod+B         Bluetooth TUI (bluetui)
  Mod+P         Power menu
  Mod+U         Update menu
  Mod+C         Config menu
  Mod+M         General menu

Screenshots
  Print         Area screenshot → save + copy to clipboard
  Mod+Shift+S   Area screenshot → save + copy to clipboard

Keyboard
  Mod+Space     Next keyboard layout

Focus
  Mod+H/J/K/L   Focus left / down / up / right
  Mod+←/↓/↑/→   Focus left / down / up / right

Move window
  Mod+Shift+H/J/K/L   Move window left / down / up / right
  Mod+Shift+←/↓/↑/→   Move window left / down / up /right
  Mod+LMB             Move window with mouse

Workspaces
  Mod+1..0      Switch workspace 1..10
  Mod+Shift+1..0 Move window to workspace 1..10

Layout
  Mod+F         Fullscreen toggle
  Mod+V         Toggle floating/tiling

Scratchpad
  Mod+-         Send window to scratchpad
  Mod+=         Show/cycle scratchpad

Resize
  Mod+Ctrl+H/J/K/L   Resize (width/height)
  Mod+Ctrl+←/↓/↑/→   Resize (width/height)
  Mod+RMB            Resize window with mouse

Press Q to exit
EOF
)"

exec foot -T "Sway Help" -e sh -lc '
  printf "%s\n" "$0" | less -R
' "$text"
