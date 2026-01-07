# PockyOS

A minimal, performance-oriented Arch Linux desktop environment built around the Sway compositor with the optimized CachyOS kernel.

## Tech Stack

| Component | Tool |
|-----------|------|
| **Window Manager** | Sway |
| **Display Manager** | ly |
| **Status Bar** | i3status-rust |
| **Terminal** | Foot |
| **Shell** | zsh + Pure |
| **Application Launcher** | Fuzzel |
| **Notifications** | Mako |
| **Wallpaper** | swaybg |
| **Text Editors** | Helix, Vim |
| **File Manager** | Yazi |
| **Browser** | Firefox |
| **Bootloader** | systemd-boot (UKI) |
| **Kernel** | CachyOS |
| **Network** | NetworkManager, wlctl |
| **Audio** | PipeWire, Wiremix |
| **Bluetooth** | bluez, bluetui |
| **Screenshots** | grim + slurp |
| **Power Management** | TLP |
| **System Monitoring** | htop, btop |

## Installation

### 1. Base System Installation

Use the `archinstall` script to set up your base Arch Linux system or install manually. \

Archinstall instructions:

1. Boot from Arch Linux installation media
2. Run `archinstall`
3. Configure the following:
   - **Profile**: Select `minimal` profile
   - **Network**: Enable `NetworkManager`
   - **Bluetooth**: Enabled *(if you have it)*
   - **Additional packages**: Add `git`, `vim` (or `nano`)
   - Complete the rest of the installation as desired

After installation completes, reboot into your new system.

### 2. Clone the Repository
```bash
git clone https://github.com/yourusername/PockyOS.git
cd PockyOS
```

### 3. Switch to CachyOS Kernel

Add CachyOS repositories:
```bash
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh
cd ..
```

Install CachyOS kernel:
```bash
sudo pacman -S linux-cachyos linux-cachyos-headers
sudo vim /etc/mkinitcpio.d/linux-cachyos.preset
```

Edit the preset file to uncomment these lines and change `/efi` to `/boot`:
```bash
ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux-cachyos"
PRESETS=('default')
default_uki="/boot/EFI/Linux/arch-linux-cachyos.efi"
default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"
```

Generate the UKI and set as default:
```bash
sudo mkinitcpio -p linux-cachyos
bootctl list
sudo bootctl set-default arch-linux-cachyos.efi
```

Reboot and verify:
```bash
reboot
uname -r  # Should show cachyos kernel
```

Clean up old kernel (if everything works):
```bash
sudo pacman -R linux linux-headers
sudo rm /boot/vmlinuz-linux-cachyos
sudo rm /boot/initramfs-linux-cachyos.img
```

### 4. Install System Packages

Install all packages that are needed regardless of hardware:
```bash
sudo pacman -S --needed git vim wget mesa sway foot ttf-jetbrains-mono \
    ttf-nerd-fonts-symbols noto-fonts noto-fonts-emoji firefox fuzzel mako \
    ly htop btop helix zsh zsh-syntax-highlighting slurp grim wl-clipboard \
    rtkit i3status-rust brightnessctl xdg-utils yazi zoxide fzf wiremix \
    bluetui paru xdg-desktop-portal-wlr polkit xorg-xwayland pipewire-alsa \
    pipewire-pulse unzip tlp
```

### 5. Install Hardware-Specific Packages

Choose the appropriate commands based on your hardware. You can combine multiple selections (e.g., AMD CPU + NVIDIA GPU).

#### CPU Microcode

**AMD CPU:**
```bash
sudo pacman -S --needed amd-ucode
```

**Intel CPU:**
```bash
sudo pacman -S --needed intel-ucode
```

#### GPU Drivers

**AMD GPU (dedicated or integrated):**
```bash
sudo pacman -S --needed vulkan-radeon libva-mesa-driver mesa-vdpau
```

**Intel GPU (dedicated or integrated):**
```bash
sudo pacman -S --needed vulkan-intel libva-intel-driver intel-media-driver
```

**NVIDIA GPU:**
```bash
sudo pacman -S --needed nvidia nvidia-utils nvidia-settings
```

**Note for NVIDIA users:** Add `nvidia_drm.modeset=1` to your kernel parameters. Wayland support on NVIDIA is improving but may have issues.

### 6. Install AUR Packages
```bash
paru -S wlctl-bin
```

### 7. Deploy Configuration Files
```bash
# Backup existing configs if you have any
mkdir -p ~/.config/backup
cp -r ~/.config/{foot,fuzzel,helix,i3status-rust,mako,sway,yazi} ~/.config/backup/ 2>/dev/null || true
mv ~/.zshrc ~/.zshrc.backup

# Copy configuration files and wallpapers
cp -r foot fuzzel helix i3status-rust mako sway yazi wallpapers ~/.config/
cp .zshrc ~

# Make all scripts executable
chmod +x ~/.config/scripts/*.sh
```

### 8. Configure Display Manager

Enable ly display manager:
```bash
mkdir -p ~/.local/state # Needed for log file
sudo systemctl enable ly@tty1.service
```

### 9. Setup Shell

Switch to zsh:
```bash
chsh -s /usr/bin/zsh
```

Install Pure zsh theme:
```bash
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
```

### 10. Configure Services

Enable audio and power management:
```bash
# Enable rtkit daemon to remove PipeWire warnings
sudo systemctl enable --now rtkit-daemon.service
systemctl --user restart pipewire pipewire-pulse wireplumber

# Enable TLP for power management (laptops)
sudo systemctl enable tlp.service
sudo systemctl start tlp.service

# Enable Bluetooth (optional)
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
```

### 11. Create Required Directories
```bash
mkdir -p ~/Pictures/Screenshots
```

### 12. Reboot
```bash
reboot
```

## How to Use

PockyOS uses Sway as the window manager with a keyboard-driven workflow. The default Mod key is the super/windows key.

### Basic Controls

| Keybind | Action |
|---------|--------|
| `Mod+Shift+/` | Show help menu |
| `Mod+Shift+R` | Reload Sway configuration |
| `Mod+Return` | Open terminal |
| `Mod+Q` | Kill focused window |
| `Mod+R` | Launch application launcher |
| `Mod+I` | Open browser |
| `Mod+D` | Open Discord |

### TUI Menus

| Keybind | Action |
|---------|--------|
| `Mod+N` | Network manager (wlctl) |
| `Mod+S` | Audio mixer (wiremix) |
| `Mod+B` | Bluetooth manager (bluetui) |
| `Mod+P` | Power menu |
| `Mod+U` | Update menu |
| `Mod+C` | Config menu |
| `Mod+M` | General menu |

### Screenshots

| Keybind | Action |
|---------|--------|
| `Print` | Select area → save and copy to clipboard |
| `Mod+Shift+S` | Select area → save and copy to clipboard |

### Window Navigation

| Keybind | Action |
|---------|--------|
| `Mod+H/J/K/L` | Focus window (left/down/up/right) |
| `Mod+Arrow Keys` | Focus window (directional) |

### Moving Windows

| Keybind | Action |
|---------|--------|
| `Mod+Shift+H/J/K/L` | Move window (left/down/up/right) |
| `Mod+Shift+Arrow Keys` | Move window (directional) |
| `Mod+Left Mouse Button` | Drag window with mouse |

### Workspaces

| Keybind | Action |
|---------|--------|
| `Mod+1` through `Mod+0` | Switch to workspace 1-10 |
| `Mod+Shift+1` through `Mod+Shift+0` | Move window to workspace 1-10 |

### Window Layout

| Keybind | Action |
|---------|--------|
| `Mod+F` | Toggle fullscreen |
| `Mod+V` | Toggle floating/tiling mode |
| `Mod+Space` | Cycle keyboard layout |

### Scratchpad

| Keybind | Action |
|---------|--------|
| `Mod+-` | Send window to scratchpad |
| `Mod+=` | Show/cycle scratchpad windows |

### Resizing Windows

| Keybind | Action |
|---------|--------|
| `Mod+Ctrl+H/J/K/L` | Resize window (width/height) |
| `Mod+Ctrl+Arrow Keys` | Resize window (directional) |
| `Mod+Right Mouse Button` | Resize window with mouse |
