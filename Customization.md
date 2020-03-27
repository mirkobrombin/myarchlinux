# Customization

## Openbox
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

## GNOME
### Theme & Icons
I'm using Materia dark theme:
```
sudo yay -S materia-gtk-theme
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
sudo pacman -S chrome-gnome-shell 
```
#### Installed Extensions
- Fully Transparent Top Bar
- Kstatusnotifieritem/appindicator support
- Straight top bar
- Arch Linux Updates Indicator
- NoAnnoyance
- AlternateTab

### GNOME Tweaks
```
sudo pacman -S gnome-tweaks
```

## KDE
### Theme
I'm using Layan Theme in variant Nayal (by me owo), this version uses the stock Breeze icons and remove some pony-style effects.

https://github.com/mirkobrombin/Nayal/releases

It includes:
* Plasma theme
* Kvantum theme
* Colors style

#### Icons
I am a bad person and I'm using the standard Breeze icons. I definitely have a place in hell for this.

#### GTK theme
I'm using 2 different themes:
* GTK2 use the Adapta-DeepPurple theme
* GTK3 use the Layan-dark theme

### Kvantum
I'm using kvantum to add some blur to the windows:
```
yay -S kvantum
```

### Panels
In my configuration I'm using 2 panels:
* one with menu applications, global menu, window title, popup launcher, systemtray, time (with date) and logout
* one centered without fullsize with process manager in only icons version

#### First panel
This panel is placed on top the screen.

**Layout**
```
_______________________________________________________________________________________
|X|Window title|Global menu|Fullsized space|Popup Launcher|Systemtray|Date/Time|Logout|
```

**Window title**
The widget need to be installed, its name is Window title.

My configuration:
* Text style: Application
* Icon: Show when available[]
* Icon: Fill thickness[x]
* Font: Bold[x]
* Font: Italic[]
* Font: First letters capital[x]
* Length: Fill available space[]
* 4px, 0px, 0px

**Popup Launcher**
I'm using this widget to simple switch from Intel and Nvidia GPUs.

First I've created 2 desktop entry in applications menu:
```
[Desktop Entry]
Comment=
Exec=konsole -e optimus-manager --switch intel
Icon=yast-hardware-group
Name=Switch Intel GPU
NoDisplay=false
Path[$e]=
StartupNotify=true
Terminal=0
TerminalOptions=
Type=Application
X-KDE-SubstituteUID=false
X-KDE-Username=

[Desktop Entry]
Comment=
Exec=konsole -e optimus-manager --switch nvidia
Icon=yast-hardware-group
Name=Switch Nvidia GPU
NoDisplay=false
Path[$e]=
StartupNotify=true
Terminal=0
TerminalOptions=
Type=Application
X-KDE-SubstituteUID=false
X-KDE-Username=
```

then I've selected them applications list in Popup Launcher.

**Date/Time format**
The widget is Digital Clock.

I need a format like `Mon 30 | 18:26`:
```
ddd d
```

**Logout widget**
The widget is Lock/Logout.

I've disabled everything except the logout button.

#### Second panel
This panel is placed on the screen bottom.

**Layout**
```
____________________________
|Process manager only icons|
```

### Devilspie
This tool help performs actions on windows as they are created.
```
yay -S devilspie
```
create rules path `~/.devilspie`.

### Example rules
Example for Visual Studio Code, file `~/.devilspie/vscode.ds`:
```
(if (contains (window_class) "code-oss")

    (begin

        (spawn_async (str "xprop -id " (window_xid) " -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 "))

        (spawn_async (str "xprop -id " (window_xid) " -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY 0xdfffffff"))

    )

)
```

## Terminal/Zsh
As shell I am using ZSH with oh-my-zsh and Powerlevel10K.

I'm using the Nerd font in Konsole:
```
yay -S nerd-fonts-hack
```

### ZSH
```
yay -S zsh
```

### Oh my ZSH
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Powerlevel10K
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
and set as theme on `~/.zshrc`:
```
ZSH_THEME=powerlevel10k/powerlevel10k
```

### ZSH plugins
**zsh-syntax-highlighting**
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
add to `.zshrc':
```
plugins=( [plugins...] zsh-syntax-highlighting)
```

### Colors
I'm using the Breeze colors with 23% trasparency and blur enabled.

## ~~GRUB~~
Replaced by systemdboot.

~~I'm using the Vimix theme from vinceliuice:~~
```
git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes
./install.sh -v -2
```