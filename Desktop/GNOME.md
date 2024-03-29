# GNOME 
```
pacman -S gnome gnome-extra
```
The GDM Display Manager come with default GNOME installation:
```
sudo systemctl enable gdm
```

### GNOME Software integration
```
pacman -S gnome-software-packagekit-plugin
```

## Customization
### Theme & Icons
I'm using Materia dark theme:
```
sudo paru -S materia-gtk-theme
```

The only problem with most of GTK3 themes is the large size of the CSD/Titlebar. I solved this problem with a custom rule.

To do this I've created the file in location `~/.config/gtk-3.0/gtk.css` with content:
```
headerbar {
    min-height: 38px;
    padding-left: 4px;                                                               
    padding-right: 4px;
}
headerbar entry,
headerbar spinbutton,
headerbar button,
headerbar separator {
    margin-top: 2px;                                                           
    margin-bottom: 2px;
}
.default-decoration {
    min-height: 0;                                                       
    padding: 2px
}
.default-decoration .titlebutton {
    min-height: 26px;                                                  
    min-width: 26px;
}
```
Thanks to Reddit user LapoC.

### Extensions
Let's integrate Brave Browser with GNOME:
```
pacman -S chrome-gnome-shell 
```
#### Installed Extensions
- Smart transparent topbar
- Kstatusnotifieritem/appindicator support
- Straight top bar
- Arch Linux Updates Indicator
- NoAnnoyance
- ~~AlternateTab~~ [How to set up the window switcher without using the extension](https://blogs.gnome.org/fmuellner/2018/10/11/the-future-of-alternatetab-and-why-you-need-not-worry/)
- Workspace Scroll

### GNOME Tweaks
```
pacman -S gnome-tweaks
```
