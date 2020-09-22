# Openbox
I'm using openbox with polybar as bar and rofi for menu creation.
```
yay -S openbox rofi polybar qtconfig-qt4 qt5ct obconf gnome-keyring xfce4-notifyd networkmanager-dmenu-git xdg-menu spectacle thunar lxappearance feh
```
Copy my [dotfiles](https://github.com/mirkobrombin/myarchlinux/tree/master/dotfiles/config/openbox) to:
```
/home/YOUR_USER/.config/openbox
```
edit `rc.xml` keybinds with your paths.

## networkmanager-dmenu
Copy my [dotfiles](https://github.com/mirkobrombin/myarchlinux/tree/master/dotfiles/config/networkmanager-dmenu) to:
```
/home/YOUR_USER/.config/networkmanager-dmenu
```

## SDDM
I'm using SDDM as display manager with my Slate theme.
```
sudo pacman -S sddm
```

## Polybar
Copy my [dotfiles](https://github.com/mirkobrombin/myarchlinux/tree/master/dotfiles/config/polybar) to:
```
/home/YOUR_USER/.config/polybar
```
edit `config.ini` options.

## Customization
### Theme & Icons
Use `qtconfig-qt4` to change Qt4 themes and `qt5ct` for Qt5.
Then set env variable to *qt5ct* on `/etc/environment`:
```
QT_QPA_PLATFORMTHEME=qt5ct
```
Use `lxappearance` to change GTK Themes.

For openbox menu theme I'm using my slate theme, so download from [dotfiles](https://github.com/mirkobrombin/myarchlinux/tree/master/dotfiles/themes/Slate) and place in path:
```
/home/YOUR_USERNAME/.themes
```
Open `obconf` and select the new theme.

### SDDM Theme
Download slate theme from my [dotfiles](https://github.com/mirkobrombin/myarchlinux/tree/master/dotfiles/sddm/slate) and place it in:
```
/usr/share/sddm/themes/slate
```

Install `sddm-config-editor-git` and use it to change default theme to `slate`.