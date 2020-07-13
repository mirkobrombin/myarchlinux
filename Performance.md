# Performance

## Silent boot + boot improvements
I personally prefer a silent boot without logs, messages and warnings.

**~~/etc/default/grub~~**
GRUB replaced with systemdboot.

* ~~avoid FS#32309 with vga=current (maybe no longer needed)~~
* ~~show only the most important messages from dmesg using loglevel=3 kernel option~~
* ~~avoid a possibly costly remount of the root partition by changing ro to rw on the kernel line~~
* ~~set resume partition for hibernation~~

```
GRUB_CMDLINE_LINUX_DEFAULT="rootflags=rw quiet loglevel=3 rd.udev.log_priority=3 rd.systemd.show_status=false vga=current resume=UUID=37df436d-2605-4c9c-b3f2-153473b12e3d"
```
~~hide the grub menu, unless the Shift key is held down:~~
```
GRUB_FORCE_HIDDEN_MENU="true"
```

**~~/etc/grub.d/31_hold_shift~~**
GRUB replaced with systemdboot.

~~Content [here](https://gist.githubusercontent.com/anonymous/8eb2019db2e278ba99be/raw/257f15100fd46aeeb8e33a7629b209d0a14b9975/gistfile1.sh)~~
```
chmod a+x /etc/grub.d/31_hold_shift
grub-mkconfig -o /boot/grub/grub.cfg
```

**/boot/efi/loader/entries/arch.conf**
* avoid FS#32309 with vga=current (maybe no longer needed)
* show only the most important messages from dmesg using loglevel=3 kernel option
* avoid a possibly costly remount of the root partition by changing ro to rw on the kernel line
* set resume partition for hibernation

```
options root=UUID=1b37449b-c8e6-467a-9c28-39d5e65546d1 quiet splash loglevel=3 vga=current rd.systemd.show_status=auto rd.udev.log_priority=3 vt.global_cursor_default=0
```

**/etc/fstab**
* you can avoid a possibly costly remount of the root partition by changing `ro` to `rw` on systemdboot entry options abd removing it from `/etc/fstab`
* if **staggered spin-up** is not used, you can disable it on boot to save time
* replace `relatime` with `noatime` for efi e /home partitions

**/etc/mkinitcpio.conf**
Let systemd check the root filesystem, hide fsck messages during boot (replace udev):
```
HOOKS=( base systemd fsck ...) 
mkinitcpio -p linux
```
edit systemd-fsck-root.service and systemd-fsck@.service:
```
systemctl edit --full systemd-fsck-root.service
systemctl edit --full systemd-fsck@.service
```
adding:
```
StandardOutput=null
StandardError=journal+console
```
to the `[Service]` block:
```
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/lib/systemd/systemd-fsck
StandardOutput=null
StandardError=journal+console
TimeoutSec=0
```

**Mask lvm2-monitor service**
Since I don't use LVM, I mask the service to prevent it from running (1s gained at boot time):
```
systemctl mask lvm2-monitor
```
