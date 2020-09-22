#!/bin/bash

# README!
# This script may be unstable, be very careful.

# ==================================================================
# There are some changes needed:
# 1) first of all set partitions variables to fit your notes:
root_partition="/dev/nvme0n1p3"
swap_partition="/dev/nvme0n1p2"
efi_partition="/dev/nvme0n1p1"

# 2) set your graphics drivers:
intel=false
amd=true
nvidia=true
optimus_intel_nvidia=false # enable if your device have dual GPU (intel iGPU and nvidia dGPU)
amd_nvidia=true # enable if your device have dual GPU (amd iGPU and nvidia dGPU)

# 3) choose hostname:
device_hostname="myarchlinux"

# 4) configure your new admin user:
user_name="admin"
user_groups="wheel,video,audio,sys,lp,storage,scanner,games,network,disk,input"
user_shell="zsh" # bash | zsh

# 5) choose language:
your_language="en_US.UTF-8" # follow the locale syntax

# 6) choose timezone:
your_timezone="Europe/Rome" # follow the path in /usr/share/zoneinfo

# 7) choose your desktop:
desktop="gnome" # (plasma | gnome | xfce4 | none)

# 8) then save with (CTRL+X)
# ==================================================================

# generating variables
printf "${info}Generating script variables..${end}\n"
root_uuid=$(blkid $root_partition | sed -n 's/.*UUID=\"\([^\"]*\)\".*/\1/p')
graphics_drivers_packages=""

# define message colors
info='\033[0;36m'
success='\033[0;32m'
danger='\033[0;31m'
warning='\033[1;33m'
end='\033[0m'

if ! [ -f "install.lock" ]; then
    # welcome message
    printf "__________ \n\n"
    printf "${danger}This installation script is limited to a small number of hardware.${end}\n"
    printf "${danger}Be careful and make sure to have the official Arch Linux Wiki in your hands!${end}\n"
    printf "__________ \n\n"

    # printing fdisk -l output
    printf "__________ \n\n"
    printf "${info}This installation script is limited to a small number of hardware.${end}\n"
    printf "${info}Be careful and make sure to have the official Arch Linux Wiki in your hands!${end}\n"
    printf "__________ \n\n"

    # check for lock file
    if [ -f "install.lock" ]; then
        printf "${info}Lock file found, the installation will continue now..${end}\n"
    else
        printf "${info}These are your partitions, take a note of partition names (/dev/diskX) for the next step:${end}\n"
        fdisk -l
        read -p "Did you take note? " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            printf "${info}\nOpening install.sh with nano..${end}\n"
            nano install.sh
            touch install.lock
        else
            printf "${danger}\nThe installation will be stopped.${end}\n"
            exit 1 || return 1
        fi
    fi

    # preparing partitions
    printf "__________ \n\n"
    printf "${info}Configuring partitions:${end}\n"
    printf "${info}- ${root_partition} as root partition${end}\n"
    printf "${info}- ${swap_partition} as swap partition${end}\n"
    printf "${info}- ${efi_partition} as efi partition${end}\n"
    printf "${info}Making ext4 file system in ${root_partition}:${end}\n"
    mkfs.ext4 ${root_partition}
    printf "${info}Making swap file system in ${root_partition}:${end}\n"
    mkswap ${swap_partition}
    printf "__________ \n\n"

    # preparing mount points
    printf "__________ \n\n"
    printf "${info}Mounting ${root_partition} in /mnt..${end}\n"
    mount ${root_partition} /mnt
    printf "${info}Creating /mnt/boot mount point for ${efi_partition} partition${end}..\n"
    mkdir -p /mnt/boot
    printf "${info}Mounting ${efi_partition} in /mnt/boot..${end}\n"
    mount ${efi_partition} /mnt/boot
    printf "__________ \n\n"

    # enabling swap
    printf "__________ \n\n"
    printf "${info}Enabling swap partition ${swap_partition}{end}\n"
    swapon ${swap_partition}
    printf "__________ \n\n"

    # system installation
    printf "__________ \n\n"
    printf "${info}Running pacstrap in /mnt, following packages/groups will be installed:{end}\n"
    printf "${info}- base${end}\n"
    printf "${info}- base-devel${end}\n"
    printf "${info}- os-prober${end}\n"
    printf "${info}- bash-completion${end}\n"
    printf "${info}- zsh${end}\n"
    printf "${info}- linux${end}\n"
    printf "${info}- linux-headers${end}\n"
    printf "${info}- linux-firmware${end}\n"
    printf "${info}- net-tools${end}\n"
    printf "${info}- dialog${end}\n"
    printf "${info}- netctl${end}\n"
    printf "${info}- networkmanager${end}\n"
    printf "${info}- wpa_supplicant${end}\n"
    printf "${info}- efibootmgr${end}\n"
    printf "${info}- dhcpcd${end}\n"
    printf "${info}- nano${end}\n"
    printf "${info}- git${end}\n"
    printf "${info}- wget${end}\n"
    swapon ${swap_partition}
    printf "__________ \n\n"
    pacstrap /mnt base base-devel linux linux-firmware net-tools dialog netctl networkmanager wpa_supplicant efibootmgr dhcpcd nano os-prober bash-completion zsh git wget

    # generating fstab
    printf "__________ \n\n"
    printf "${info}Generating fstab..{end}\n"
    genfstab -pU /mnt >> /mnt/etc/fstab
    printf "__________ \n\n"

    # creating lock file for chroot
    printf "__________ \n\n"
    printf "${info}Copyng install.sh and lock file to /mnt..{end}\n"
    cp install.sh /mnt
    cp install.lock /mnt
    printf "${info}Moving to /mnt..{end}\n"
    cd /mnt
    printf "${info}Locking installation to chroot..{end}\n"
    touch chroot.lock
    printf "__________ \n\n"

    # entering chroot environment
    printf "__________ \n\n"
    printf "${info}Entering chroot environment..{end}\n"
    arch-chroot /mnt
    printf "__________ \n\n"
else
    # resuming installation
    printf "__________ \n\n"
    printf "${info}Resuming installation inside chroot environment..{end}\n"
    arch-chroot /mnt <<"EOT"
bash install.sh
EOT
    printf "__________ \n\n"

    # configuring systemdboot
    printf "__________ \n\n"
    printf "${info}Configuring systemdboot..{end}\n"
    bootctl --path=/boot install
    printf "${info}Creating a new boot entry..{end}\n"
    cat <<EOF >/boot/loader/entries/arch.conf
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=UUID=${root_uuid} quiet splash loglevel=3 vga=current rd.systemd.show_status=auto rd.udev.log_priority=3 vt.global_cursor_default=0
EOF
    printf "__________ \n\n"

    # configuring default entry
    printf "__________ \n\n"
    printf "${info}Configuring default boot entry..{end}\n"
    cat <<EOF >/boot/loader/loader.conf
timeout 3
default arch.conf
EOF
    printf "__________ \n\n"

    # configuring hostname
    printf "__________ \n\n"
    printf "${info}Configuring device hostname to ${device_hostname}..{end}\n"
    echo ${device_hostname} > /etc/hostname
    printf "__________ \n\n"

    # configuring timezone
    printf "__________ \n\n"
    printf "${info}Configuring timezone to ${your_timezone}..{end}\n"
    ln -sf /usr/share/zoneinfo/${your_timezone} /etc/localtime
    printf "__________ \n\n"

    # configuring locale
    printf "__________ \n\n"
    printf "${info}Configuring locale to ${your_language}..{end}\n"
    echo ${your_language} >> /etc/locale.gen
    printf "${info}Generating locale..{end}\n"
    locale-gen
    printf "__________ \n\n"

    # creating new user
    printf "__________ \n\n"
    printf "${info}Creating your new ${user_name} user..{end}\n"
    useradd -m -g users -G wheel,video,audio,sys,lp,storage,scanner,games,network,disk,input -s /bin/${user_shell} ${user_name}
    printf "${info}Set a password for ${user_name} user..{end}\n"
    passwd ${user_name}
    printf "__________ \n\n"

    # configuring sudoers
    printf "__________ \n\n"
    printf "${info}Configuring sudoers..{end}\n"
    sed -i '/## Uncomment to allow members of group wheel to execute any command/a %wheel ALL=(ALL) ALL' /etc/sudoers

    # enabling pacman multilib
    printf "__________ \n\n"
    printf "${info}Enabling pacman multilib..{end}\n"
    sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
    printf "${info}Synchronizing database..{end}\n"
    pacman -Sy

    # installing desktop
    printf "__________ \n\n"
    printf "${info}Installing ${desktop} Desktop..{end}\n"
    printf "${info}Following packages will be installed:{end}\n"
    if [ $desktop = "gnome"]; then
        printf "${info}- gnome"
        printf "${info}- gdm"
        printf "${info}- geary"
        pacman -S gnome gdm geary --no-confirm
        printf "${info}Installing ${desktop} Enabling gdm service..{end}\n"
        systemctl enable gdm
    fi
    if [ $desktop = "plasma"]; then
        printf "${info}- plasma"
        printf "${info}- sddm"
        printf "${info}- konsole"
        printf "${info}- dolphin"
        printf "${info}- ksysguard"
        printf "${info}- spectacle"
        pacman -S plasma sddm konsole dolphin ksysguard spectacle --no-confirm
        printf "${info}Installing ${desktop} Enabling sddm service..{end}\n"
        systemctl enable sddm
    fi

    # installing drivers
    printf "__________ \n\n"
    printf "${info}Installing drivers..{end}\n"
    printf "${info}Following packages will be installed:{end}\n"
    if $intel; then
        printf "${info}- xf86-video-intel\n"
        graphics_drivers_packages="$(graphics_drivers_packages) xf86-video-intel"
    fi
    if $amd; then
        printf "${info}- amd-ucode\n"
        printf "${info}- xf86-video-amdgpu\n"
        graphics_drivers_packages="$(graphics_drivers_packages) amd-ucode xf86-video-amdgpu"
    fi
    if $nvidia; then
        printf "${info}- nvidia-dkms\n"
        printf "${info}- nvidia-prime\n"
        printf "${info}- nvidia-settings\n"
        printf "${info}- nvidia-utils\n"
        printf "${info}- lib32-nvidia-utils\n"
        graphics_drivers_packages="$(graphics_drivers_packages) nvidia-dkms nvidia-prime nvidia-settings nvidia-utilz lib32-nvidia-utils"
    fi
    pacman -S ${graphics_drivers_packages} --no-confirm
    if $amd; then
        printf "${info}Adding amd-ucode.img to boot entry..\n"
        sed -i '/initramfs-linux-zen.img/a initrd /amd-ucode.img' /boot/loader/entries/arch.conf
        sed -i -e 's/MODULES()/MODULES(amdgpu)/g' /etc/mkinitcpio.conf
    fi

    # configuring drivers
    if [ $optimus_intel_nvidia ] || [ $amd_nvidia ]; then
        printf "__________ \n\n"
        if $optimus_intel_nvidia; then
            printf "${info}Configuring drivers for Optimus Technology..{end}\n"
            git clone https://aur.archlinux.org/optimus-manager.git
            cd optimus-manager
            makepkg -si --no-confirm
            printf "${info}Enabling optimus-manager service..{end}\n"
            systemctl enable optimus-manager
        fi
        if $amd_nvidia; then
            printf "${info}Configuring drivers for AMD+Nvidia..{end}\n"
            echo "blacklist nouveau" > /etc/modprobe.d/nouveau-blacklist.conf
            sed -i '${s/$/ nvidia-drm.modeset=1/}' /boot/loader/entries/arch.conf
            sed -i -e 's/MODULES(amdgpu)/MODULES(amdgpu nvidia nvidia_modeset nvidia_uvm nvidia_drm)/g' /etc/mkinitcpio.conf
            cat <<EOF >/etc/X11/xorg.conf
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
EOF
        fi
    fi
fi