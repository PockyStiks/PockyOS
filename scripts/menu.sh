#!/bin/sh
set -euo pipefail

SCRIPTS_DIR="${HOME}/.config/scripts"
POWER_SCRIPT="${SCRIPTS_DIR}/power_menu.sh"
UPDATE_SCRIPT="${SCRIPTS_DIR}/update_menu.sh"
CONFIG_SCRIPT="${SCRIPTS_DIR}/config_menu.sh"

AUDIO_APP="wiremix"
BT_APP="bluetui"
NET_APP="wlctl"

items=$(cat <<'EOF'
 Power
󰤢 Network
 Bluetooth
󰕾 Audio
󰚰 Update
󰒓 Configs
EOF
)

choice=$(printf '%s\n' "$items" | fuzzel --dmenu)

[ -z "${choice:-}" ] && exit 0

case "$choice" in
    " Power")
        exec "$POWER_SCRIPT"
        ;;
    "󰤢 Network")
        exec foot -e "$NET_APP"
        ;;
    " Bluetooth")
        exec foot -e "$BT_APP"
        ;;
    "󰕾 Audio")
        exec foot -e "$AUDIO_APP"
        ;;
    "󰚰 Update")
        exec "$UPDATE_SCRIPT"
        ;;
    "󰒓 Configs")
        exec "$CONFIG_SCRIPT"
        ;;
    *)
        exit 1
        ;;
esac
