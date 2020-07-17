# XFCE4
```
sudo pacman -S xfce4 xfce4-goodies pavucontrol
```

## LightDM
```
sudo pacman -S lightdm lightdm-gtk-greeter
```

## Taskbar
Let's add icons in a taskbar style container with:
```
yay -S xfce4-taskbar-plugin-git
```

## Systemtray
I'm using a different applet for systemtray that use the correct GTK context menu:
```
yay -S xfce4-statusnotifier-plugin
```

## Customization
### Theme
I'm in love with Materia theme:
```
yay -S materia-gtk-theme
```

### Icons
Using the papirus icon pack:
```
papirus-icon-theme
```

### germon
Use germon for custom indicator/scripts:
```
yay -S genmon-plugin-common-git
```

### compositor_indicator
Indicator and toggle for xfce compositor.
Download script from my [dotfiles](https://github.com/mirkobrombin/myarchlinux/tree/master/dotfiles/local/scripts) then place in path:
```
/home/YOUR_USERNAME/.local/scripts
```
so add script on a new germon indicator.

### Lightdm Theme
Edit `/etc/lightdm/lightdm-gtk-greeter.conf` and set:
```
theme-name=Materia-dark
icon-theme-name=Papirus-dark
```
