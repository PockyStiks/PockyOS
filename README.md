# PockyOS

## Tech Stack

### Window Manager
river

### Greeter
ly \
`sudo systemctl enable ly@tty1.service` \
If you get FileNotFound error, run `mkdir -p ~/.local/state`

### Stus Bar
gbar
gBar bar 0 &

### Terminal
foot

### App launcher
wofi

### Wallpaper
swaybg

### Bootloader
systemd-boot with UKI

### Network
NetworkManager \
wifitui

### Audio
pipewire \
wiremix

### Bluetooth
bluez \
bluetuith

### Fonts
ttf-jetbrains-mono \
ttf-nerd-fonts-symbols \
noto-fonts \
noto-fonts-emoji

## Addning CachyOS repositories:
``` bash
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh
```

## Swapping Kernel
```bash
sudo pacman -S linux-cachyos linux-cachyos-headers
sudo vim /etc/mkinitcpio.d/linux-cachy.preset
```
make sure these lines are uncomented, and the rest is comented. Also change /efi to /boot in the path
```bash
ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux-cachyos"

PRESETS=('default')

default_uki="/boot/EFI/Linux/arch-linux-cachyos.efi"
default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"
```
You should see `arch-linux-cachyos.efi` in `/boot/efi/Linux`
```bash
bootctl list
sudo bootctl set-default arch-linux-cachyos.efi
reboot
uname -r # should see cachyos
sudo pacman -R linux # if everything works, remove the old kernel, remove linux-headers too if you installed it
sudo rm /boot/vmlinuz-linux-cachyos
sudo rm /boot/initramfs-linux-cachyos.img
```

## Installed packages so far:
### After archinstall with minimal profile and NetworkManager selected
git \
vim \
wget \
amd-ucode \
mesa \
vulkan-radeon \
libva-utils (optional, might remove) \
river \
foot \
ttf-jetbrains-mono \
lttf-nerd-fonts-symbols \
noto-fonts \
noto-fonts-emoji \
firefox \
wofi \
mako \
paru \
ly \
gbar-git (AUR) \
htop \
btop 

