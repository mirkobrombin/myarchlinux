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
* /dev/nvme0n1p1  976M /boot/efi
* /dev/nvme0n1p2  7,6G swap
* /dev/nvme0n1p3  457,3G /

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
And let's swap the swap:
```
mkswap /dev/nvme0n1p2
```

### Mount points
Creating paths for mount points in /mnt:
```
mkdir -p /mnt/home /mnt/boot/efi
```
According with the previous configuration, mount the partitions:
```
mount /dev/nvme0n1p3 /mnt
mount /dev/nvme1n1p1 /mnt/home
mounbt /dev/nvme0n1p1 /mnt/boot/efi
```
And let's swap the swap:
```
swapon /dev/nvme0n1p2
```

## System installation
```
pacstrap /mnt base base-devel linux linux-firmware net-tools dialog netctl networkmanager wpa_supplicant grub efibootmgr dhcpcd nano
```

## fstab
Generate fstab and enter chroot:
```
genfstab -pU /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```
and enable swap in `nano /etc/fstab`.

## GRUB
Go with the grub installation:
```
grub-install /dev/nvme0n1p3
grub-mkconfig -o /boot/grub/grub.cfg
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

## Ready to reboot
```
exit
umount /mnt/home
umount /mnt/boot/efi
umount /mnt
swapoff
sync
reboot
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