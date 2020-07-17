# Drivers

## Utility
```
pacman -S linux-zen-headers os-prober git bash-completion man-db man-pages
```

## Network manager
During the installation I installed the `networkmanager` package, let's enable the service:
```
systemctl enable NetworkManagersi
```

## Xorg installation
```
pacman -S xorg-server xorg-xinit
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
