# Performance

## Silent boot + boot improvements
I personally prefer a silent boot without logs, messages and warnings.

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
