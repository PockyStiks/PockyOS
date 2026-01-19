# PockyOS

A minimal, performance-oriented Arch Linux desktop environment built around the Sway compositor with the optimized CachyOS kernel.

![Preview](./src/preview.png)

## Tech Stack

| Component | Tool |
|-----------|------|
| **Window Manager** | Sway |
| **Display Manager** | ly |
| **Status Bar** | i3status-rust |
| **Terminal** | Foot |
| **Shell** | zsh + Pure, zsh-syntax-highlighting, zoxide |
| **Application Launcher** | Fuzzel |
| **Notifications** | Mako |
| **Wallpaper** | swaybg |
| **Text Editors** | Helix, Vim |
| **File Manager** | Yazi |
| **Bootloader** | systemd-boot (UKI) |
| **Kernel** | CachyOS |
| **Network** | NetworkManager, wlctl |
| **Audio** | PipeWire, Wiremix |
| **Bluetooth** | bluez, bluetui |
| **Screenshots** | grim + slurp |
| **Power Management** | TLP |
| **System Monitoring** | btop |

## Installation

### 1. Base System Installation

Use the `archinstall` script to set up your base Arch Linux system or install manually. \

Archinstall instructions:

1. Boot from Arch Linux installation media
2. Run `archinstall`
3. Configure the following:
   - **Profile**: Select `minimal` profile
   - **Audio**: PipeWire
   - **Kernel** linux, UKI enabled
   - **Bluetooth**: Enabled (if you have it)
   - **Additional packages**: Add `git`, `vim` (or `nano`)
   - **Network**: Enable `NetworkManager`
   - Complete the rest of the installation as desired

After installation completes, reboot into your new system.

### 2. Clone the Repository
```bash
git clone https://github.com/PockyStiks/PockyOS.git
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

Edit the preset file to uncomment these lines and change `/efi` to `/boot`, unless configured otherwise during `archinstall`:
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

Clean up old kernel (only once if everything works):
```bash
sudo pacman -R linux linux-headers
sudo rm /boot/vmlinuz-linux-cachyos
sudo rm /boot/initramfs-linux-cachyos.img
sudo rm /boot/EFI/Linux/arch-linux.efi
sudo rm /boot/vmlinuz-linux
```

### 4. Install System Packages

Install all packages that are needed regardless of hardware:
```bash
sudo pacman -S --needed man-db man-pages git vim wget mesa sway foot ttf-jetbrains-mono ttf-nerd-fonts-symbols noto-fonts noto-fonts-emoji fuzzel autotiling ly btop helix zsh zsh-syntax-highlighting slurp grim wl-clipboard mako rtkit i3status-rust brightnessctl xdg-utils yazi zoxide fzf wiremix bluetui xdg-desktop-portal-wlr polkit xorg-xwayland pipewire-alsa pipewire-pulse unzip base-devel udisks2 gvfs gvfs-mtp udiskie swaybg
```
**Note:** A web browser is not included, please chose and install one.

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
sudo pacman -S --needed nvidia-open-dkms nvidia-utils nvidia-settings
```

NVIDIA does **not officially support Wayland**, so you need to launch Sway with extra configurations. To make this easy:

1. Install the Sway NVIDIA wrapper:  
```bash
paru -S sway-nvidia
```
2. At the Ly login screen, select the Sway (NVIDIA) session using the arrow keys before logging in.

Now Sway will start with the correct options for NVIDIA GPUs.

### 6. Install Paru and AUR Packages
```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru
paru -S wlctl-bin
```

#### 6b. Install optional packages (stuff I personally use)
```bash
# Pipx for python cli tools
sudo pacman -S python-pipx
pipx ensurepath
pipx install jupyterlab grip

# Language servers
pipx install ruff ty
sudo pacman -S clang typescript-language-server typescript yaml-language-server marksman
paru -S vscode-langservers-extracted

# Micromamba for virtual environments
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)

# Blue light filter
paru -S sunsetr

# Discord
sudo pacman -S discord
```

### 7. Deploy Configuration Files
```bash
# Backup existing configs if you have any
mkdir -p ~/.config/backup
cp -r ~/.config/{foot,fuzzel,helix,i3status-rust,mako,sway,yazi,btop,wallpapers} ~/.config/backup/ 2>/dev/null || true
mv ~/.zshrc ~/.zshrc.backup

# Copy configuration files scripts, and wallpapers
cp -r foot fuzzel helix i3status-rust mako sway yazi btop wallpapers scripts ~/.config/
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
mkdir -p ~/.zsh
git clone https://github.com/sindresorhus/pure.git ~/.zsh/pure
```

### 10. Configure Services

Enable audio and power management:
```bash
# Enable rtkit daemon to remove PipeWire warnings
sudo systemctl enable --now rtkit-daemon.service
systemctl --user restart pipewire pipewire-pulse wireplumber

# Automatic USB device mounting
sudo systemctl enable --now udisks2.service

# Enable TLP for power management (for laptops only)
sudo pacman -S tlp
sudo systemctl enable --now tlp.service

# Enable Bluetooth (if you have it)
sudo systemctl enable --now bluetooth.service
```

### 11. Create Required Directories
```bash
mkdir -p ~/Pictures/Screenshots
```

### 12. Regenerate microcode and Reboot
```bash
sudo mkinitcpio -P
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
| `Mod+E` | File manager |
| `Mod+D` | Open Discord |
| `Mod+Space` | Switch keyboard layout |

### TUI Menus

| Keybind | Action |
|---------|--------|
| `Mod+N` | Network manager (wlctl) |
| `Mod+A` | Audio mixer (wiremix) |
| `Mod+B` | Bluetooth manager (bluetui) |
| `Mod+S` | System info (btop) |
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
| `Mod+1` through `Mod+9` | Switch to workspace 1-9 |
| `Mod+Shift+1` through `Mod+Shift+9` | Move window to workspace 1-9 |

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

## Common configurations

### Removing battery and brightness indecators from the status bar (for desktop use)

Comment out the `# Brightness` and `# Battery` blocks in `~/.config/i3status-rust/config.toml`

### Changing monitor setup (resolution, refresh rate, position)

1. Get the output name of your monitor(s) by running `swaymsg -t get_outputs`
2. Configure the ouput options for each monitor under the `# Monitors` section in `~/.config/sway/config`

### Adding keyboard layout

1. Add the keyboard layout in `~/.config/sway/config` inside the input block
2. Uncomment the `# keyboard layout` block in `~/.config/i3status-rust/config.toml`

### Changing mouse sensitivity

Change the `pointer_accel` parameter in `~/.config/sway/config`

### Swapping Escape and Caps Lock

Uncomment `xkb_options caps:swapescape` inside the input block in `~/.config/sway/config`
