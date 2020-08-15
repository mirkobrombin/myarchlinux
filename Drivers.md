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

## Driver (Ryzen+Nvidia)
In this configuration we have:
* AMD Ryzen
* Nvidia

There are several ways to make the two GPUs work:
* Hybrid
* Only AMD
* Only Nvidia

in my case I need to run the Hybrid mode, so Arch will default to AMD and I can force software to run with Nvidia by using `prime-run`.

First of all we need to install propietary AMD microcode and graphics drivers:

```
pacman -S amd-ucode xf86-video-amdgpu
```

We need to include `amd-ucode` on boot, on systemdboot edit `../loader/entries/arch.conf`:

```
..
initrd /amd-ucode.img
..
```

Install Nvidia propietary drivers (and pray that the future is bright with the nouveau drivers):

```
pacman -S nvidia-dkms nvidia-prime nvidia-settings nvidia-utils lib32-nvidia-utils
```

Blacklist nouveau driver, add:

```
blacklist nouveau
```

to `/etc/modprobe.d/nouveau-blacklist.conf`.

Add `nvidia-drm.modeset=1` to the boot flags.

We need to populate `/etc/X11/xorg.conf` with the following content:

```
Section "Device"
  Identifier "iGPU"
  Driver "modesetting"
  BusID "PCI:5:0:0"
EndSection

Section "Screen"
  Identifier "iGPU"
  Device "iGPU"
EndSection

Section "Device"
  Identifier "dGPU"
  Driver "nvidia"
  BusID "PCI:1:0:0"
EndSection
```

`BusID` should be changed with yours, check them with `lspci -nnk | grep VGA`.

After reboot the Xorg server will run on AMD, then use `prime-run` to run applications with Nvidia:

```
prime-run steam
```

## Drivers (Optimus Intel+Nvidia)
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
