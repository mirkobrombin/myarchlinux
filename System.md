# System installation

## Set keymap/console font
```
loadkeys us
setfont /usr/share/kbd/consolefonts/sun12x22.psfu.gz
```

## Partition scheme
I have 2 SSDs in my current configuration:
* /dev/nvme1n1: 238,49 GiB,
* /dev/nvme0n1: 465,78 GiB

I use the first disk for the path / home while the other for the root (/), the final result is:
* /dev/nvme1n1p1  238,5G /home
* /dev/nvme0n1p1  976M /boot
* /dev/nvme0n1p3  464,3G /

## File systems
For my configuration I use the ext4 file system for the root and home paths:
```
mkfs.ext4 /dev/nvme1n1p1
mkfs.ext4 /dev/nvme0n1p3
```
The EFI partition requires the FAT file system:
```
mkfs.fat /dev/nvme0n1p1
```

### Mount points
Creating paths for mount points in /mnt:
```
mkdir -p /mnt/home /mnt/boot
```
According with the previous configuration, mount the partitions:
```
mount /dev/nvme0n1p3 /mnt
mount /dev/nvme1n1p1 /mnt/home
mount /dev/nvme0n1p1 /mnt/boot
```

## System installation
```
pacstrap /mnt base base-devel linux linux-firmware net-tools dialog netctl networkmanager wpa_supplicant efibootmgr dhcpcd nano lvm2
```

## fstab
Generate fstab and enter chroot:
```
genfstab -pU /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

## Systemdboot
Go with systemdboot configuration:
```
bootctl --path=/boot install
```
creating a new loader for archlinux installation in `/boot/loader/entries/arch.conf`:
```
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=UUID=1b37449b-c8e6-467a-9c28-39d5e65546d1
```
add loader at `/boot/loader/loader.conf`:
```
default arch.conf
```

Replace `udev` with `systemd` in `/etc/mkinitcpio.conf`, in `HOOKS` section.

## paru installation (AUR)
Yet another yogurt:
```
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

### Linux Zen Kernel (optional)
Result of a collaborative effort of kernel hackers to provide the best Linux kernel possible for everyday systems. 
```
paru -S linux-zen linux-zen-headers
```

Create a new entry for systemdboot:
```
title Arch Linux Zen
linux /vmlinuz-linux-zen
initrd /initramfs-linux-zen.img
options root=UUID=1b37449b-c8e6-467a-9c28-39d5e65546d1
```

### LVM (optional)
For LVM2 instalaltions edit `/etc/mkinitcpio.conf`, add `lvm2` in `HOOKS`, regenerate the initramfs:
```
mkinitcpio -p linux
```
in `/boot/loader/entries/arch.conf`: the `root` options should be set to mapper:
```
options root=/dev/mapper/volume-root quiet rw
```

## Hostname
Set hostname:
```
echo "mi" > /etc/hostname
```

## Locale/Timezone
Set locale variables in `/etc/locale.conf` to it_IT.UTF-8:
```
LANG=it_IT.UTF-8
LC_NUMERIC=it_IT.UTF-8
LC_TIME=it_IT.UTF-8
LC_MONETARY=it_IT.UTF-8
LC_PAPER=it_IT.UTF-8
LC_NAME=it_IT.UTF-8
LC_ADDRESS=it_IT.UTF-8
LC_TELEPHONE=it_IT.UTF-8
LC_MEASUREMENT=it_IT.UTF-8
LC_IDENTIFICATION=it_IT.UTF-8
```

Link Europe/Rome timezone ti localtime:
```
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
```

## Users
After reboot I've added a new user:
```
useradd -m -g users -G wheel,video,audio,sys,lp,storage,scanner,games,network,disk,input -s /bin/bash my_new_user
passwd my_new_user
```
and decommented on visudo:
```
export EDITOR=nano
visudo
```
the line:
```
wheel ALL=(ALL) ALL
```

## Ethernet
I'm using a cabled connection, so I need to boot up the card with the system.

Enable and start the `dhcpd` service:
```bash
systemctl enable dhcpcd.service
systemctl start dhcpcd.service
```

Find the card name (`enp4s0` in my case):

```bash
ip addr | sed '/^[0-9]/!d;s/: <.*$//'
```

Adjust the `/etc/rc.conf` to fit your setup:

```
interface="enp4s0"
address=
netmask=
gateway=
```

Only the `interface` parameter is needed.

## PipeWire
It provides a low-latency, graph based processing engine on top of audio and 
video devices that can be used to support the use cases currently handled by 
both pulseaudio and JACK. 

```
pacman -S pipewire pipewire-pulse --needed
```

## Ready to reboot
Don't reboot right away if you have anything else to install (e.g. a Desktop Environment).

```
exit
umount /mnt/home
umount /mnt/boot
umount /mnt
sync
reboot
```