#!/bin/sh
set -euo pipefail

items=$(cat <<'EOF'
󰤄 Sway config
󰍉 Fuzzel config
 Foot config
󰂚 Mako config
󰙅 Yazi config
󰅩 Helix config
󰗀 Helix languages
󰆍 Zshrc
EOF
)

choice=$(printf '%s\n' "$items" | fuzzel --dmenu)

[ -z "${choice:-}" ] && exit 0

case "$choice" in
    "󰤄 Sway config")
        path="~/.config/sway/config"
        ;;
    "󰍉 Fuzzel config")
        path="~/.config/fuzzel/fuzzel.ini"
        ;;
    " Foot config")
        path="~/.config/foot/foot.ini"
        ;;
    "󰂚 Mako config")
        path="~/.config/mako/config"
        ;;
    "󰙅 Yazi config")
        path="~/.config/yazi/yazi.toml"
        ;;
    "󰅩 Helix config")
        path="~/.config/helix/config.toml"
        ;;
    "󰗀 Helix languages")
        path="~/.config/helix/languages.toml"
        ;;
    "󰆍 Zshrc")
        path="~/.zshrc"
        ;;
    *)
        exit 1
        ;;
esac

path=${path/#\~/$HOME}

exec foot helix "$path"
