#!/bin/sh

# ---------------- Backlight ----------------
val=$(cat /sys/class/backlight/*/brightness)
max=$(cat /sys/class/backlight/*/max_brightness)
pct=$(( val * 100 / max ))
if [ "$pct" -ge 66 ]; then
    bl_icon="󰃠"
elif [ "$pct" -ge 33 ]; then
    bl_icon="󰃟"
else
    bl_icon="󰃞"
fi
backlight="$bl_icon $pct%"

# ---------------- Battery ----------------
cap=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)
case $cap in
    9[0-9]|100) bat_icon="󰁹" ;;
    8[0-9]) bat_icon="󰂂" ;;
    [6-7][0-9]) bat_icon="󰂀" ;;
    5[0-9]) bat_icon="󰁿" ;;
    4[0-9]) bat_icon="󰁽" ;;
    3[0-9]) bat_icon="󰁼" ;;
    2[0-9]) bat_icon="󰁻" ;;
    1[0-9]) bat_icon="󰁺" ;;
    *) bat_icon="󰂎" ;;
esac
[ "$status" = "Charging" ] && bat_icon="󰂄"
battery="$bat_icon $cap%"

# ---------------- Keyboard Layout ----------------
layout=$(swaymsg -t get_inputs \
    | grep -m1 "xkb_active_layout_name" \
    | sed 's/.*: "//;s/",.*//'
)
    
case "$layout" in
    *English*) layout="us" ;;
    *French*) layout="fr" ;;
esac

keyboard="󰌌 $layout"

# ---------------- Network ----------------
wifi=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
if [ -n "$wifi" ]; then
    net_icon="󰖩"
    network="$net_icon $wifi"
elif ip link show | grep -q "state UP.*eth"; then
    network="󰈀"
else
    network="󰖪"
fi

# ---------------- Volume ----------------
vol_line=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
vol_val=$(echo "$vol_line" | awk '{printf "%d\n", $2 * 100}')
if echo "$vol_line" | grep -q "MUTED"; then
    vol_icon="󰖁"
elif [ "$vol_val" -ge 50 ]; then
    vol_icon="󰕾"
else
    vol_icon="󰖀"
fi
volume="$vol_icon $vol_val%"

# ---------------- Clock ----------------
clock="$(date '+󰥔 %H:%M 󰃭 %a %Y-%m-%d')"

# ---------------- Combine ----------------
echo "$backlight | $battery | $keyboard | $network | $volume | $clock"
