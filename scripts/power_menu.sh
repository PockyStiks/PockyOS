#!/bin/sh
set -euo pipefail

items=$(cat <<'EOF'
 Power Off
 Reboot
EOF
)

choice=$(printf '%s\n' "$items" | fuzzel --dmenu)

[ -z "${choice:-}" ] && exit 0

case "$choice" in
    " Power Off")
        exec systemctl poweroff
        ;;
    " Reboot")
        exec systemctl reboot
        ;;
    *)
        exit 1
        ;;
esac
