# Desktop installation
I replaced KDE Plasma with GNOME (below both installations).

## Utility
```
pacman -S linux-headers os-prober git bash-completion man-db man-pages
```

## Network manager
During the installation I installed the `networkmanager` package, let's enable the service:
```
systemctl enable NetworkManager
```

## yay installation
Yet another yogurt:
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## Xorg installation
```
pacman -S xorg-server xorg-xinit
```

## GNOME
```
sudo pacman -S gnome gnome-extra
```
The GDM Display Manager come with default GNOME installation:
```
sudo systemctl enable gdm
```

### GNOME Software integration
```
sudo pacman -S gnome-software-packagekit-plugin
```

## KDE
I use Plasma with all KDE applications.
So, let's add some bloatware:
```
sudo pacman -S plasma kde-applications kdeconnect
```
The installation includes the Display Manager SDDM, so enable the service to use it:
```
sudo systemctl enable sddm
```

## Drivers
My configuration consists of 2 video cards:
* Intel
* Nvidia

I will have to install both drivers and configure optimus-manager for the switch between the two GPUs.

### Intel drivers
```
pacman -S xf86-video-intel
```

### Nvidia drivers
```
pacman -S nvidia-dkms nvidia-settings
```
Some 32-bit libraries are required for playing games via Steam. I need to enable the multilib repository in */etc/pacman.conf* then install them:
```
pacman -Syu
pacman -S lib32-libglvnd lib32-nvidia-utils
```

### optimus-manager
```
yay -S optimus-manager
```
enable service via systemctl:
```
systemctl enable optimus-manager
```