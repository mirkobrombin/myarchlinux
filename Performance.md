# Performance

## Silent boot + boot improvements
I personally prefer a silent boot without logs, messages and warnings.

**/etc/default/grub**
* avoid FS#32309 with vga=current (maybe no longer needed)
* show only the most important messages from dmesg using loglevel=3 kernel option
* avoid a possibly costly remount of the root partition by changing ro to rw on the kernel line
* set resume partition for hibernation

```
GRUB_CMDLINE_LINUX_DEFAULT="rootflags=rw quiet loglevel=3 rd.udev.log_priority=3 rd.systemd.show_status=false vga=current resume=UUID=37df436d-2605-4c9c-b3f2-153473b12e3d"
```
hide the grub menu, unless the Shift key is held down:
```
GRUB_FORCE_HIDDEN_MENU="true"
```

**/etc/grub.d/31_hold_shift**

Content [here](https://gist.githubusercontent.com/anonymous/8eb2019db2e278ba99be/raw/257f15100fd46aeeb8e33a7629b209d0a14b9975/gistfile1.sh)
```
chmod a+x /etc/grub.d/31_hold_shift
grub-mkconfig -o /boot/grub/grub.cfg
```

**/etc/fstab**
* remove `rw` from root (/) and /home options
* add `noauto,x-systemd.automount` to /home options

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