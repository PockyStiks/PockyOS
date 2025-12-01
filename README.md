# PockyOS
My Arch + SwayFX config

# SwayFX Minimal Stack Reference

## 1. Window Manager
- **SwayFX**
  - Wayland compositor (fork of Sway)
  - Features: rounded corners, blur, subtle animations
  - Config: `~/.config/sway/config`

---

## 2. Status Bar
- **Waybar (minimal)**
  - Modules: workspaces, battery, network, tray, clock
  - Lightweight (~20–30 MB)
  - Minimal CSS for clean look
  - Config example:
      "modules-left": ["workspaces"],
      "modules-center": [],
      "modules-right": ["battery", "network", "tray", "clock"]

---

## 3. Launcher
- **Fuzzel**
  - Fuzzy search for apps
  - App icons
  - Minimal, clean design
  - Config: INI file
  - Keybind example: `Super+Space`

---

## 4. Notifications
- **Mako**
  - Wayland-native, lightweight
  - CSS-like theming optional
  - Autostart with SwayFX

---

## 5. Essential TUIs

| Function | Recommended TUI | Notes / Alternatives |
|----------|----------------|--------------------|
| WiFi / Network | `nmtui` | Ncurses-based, simple |
| Package Management | `paru --interactive` | Arch/AUR helper, interactive |
| Flatpak Management | `flatpakx` | Minimal, works like a GUI |
| Wallpaper Selection | `fzf` + `wpaperd` | Pick files interactively, set wallpaper |
| Processes / System Info | `htop` | Monitor CPU, RAM, processes |
| Disk Usage | `ncdu` | Quickly analyze storage usage |
| Application Launcher | `Fuzzel` | Fuzzy search for apps |

**Optional / minor TUIs** (only if frequently needed):
- File navigation: `ranger` or `lf`
- Volume / brightness scripts (wrap `pamixer` / `brightnessctl` with a small menu)

---

## 6. Lock & Idle
- **Lock screen:** `swaylock-effects`
- **Idle / dim:** `swayidle`
- Can bind to key shortcuts or run automatically on idle

---

## 7. Startup Order (example)
1. Launch SwayFX
2. Launch Waybar
3. Launch Mako
4. Launch Fuzzel
5. Start wpaperd / wallpaper picker
6. Start swayidle + swaylock-effects

---

## 8. Extras
- Fonts: JetBrainsMono, FiraCode, or other minimal UI fonts
- Themes: Catppuccin, Tokyo Night, gray-scale minimal

---

## 9. References
- [SwayFX GitHub](https://github.com/SirCmpwn/sway)
- [Waybar GitHub](https://github.com/Alexays/Waybar)
- [Fuzzel GitHub](https://github.com/andersjo/fuzzel)
- [Mako GitHub](https://github.com/emersion/mako)
- [wpaperd GitHub](https://github.com/jonaburg/wpaperd)
- [Paru GitHub](https://github.com/Morganamilo/paru)

---

End of Reference
