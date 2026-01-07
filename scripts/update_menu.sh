#!/bin/sh
set -euo pipefail

items=$(cat <<'EOF'
󰚰 Update system
󰍉 Search package
󰏗 Install package
EOF
)

choice=$(printf '%s\n' "$items" | fuzzel --dmenu)

[ -z "${choice:-}" ] && exit 0

case "$choice" in
    "󰚰 Update system")
        exec foot -e paru -Syu
        ;;
    "󰍉 Search package")
        pkg=$(pacman -Slq | fuzzel --dmenu)
        [ -n "${pkg:-}" ] && exec foot -e sh -c "pacman -Si '$pkg'; echo; read -n 1 -s -r -p 'Press any key...'"
        ;;
    "󰏗 Install package")
        pkg=$(pacman -Slq | fuzzel --dmenu)
        [ -n "${pkg:-}" ] && exec foot -e sudo pacman -S --needed "$pkg"
        ;;
    *)
        exit 1
        ;;
esac
