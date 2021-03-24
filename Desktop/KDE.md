# KDE
I use Plasma with all KDE applications.
So, let's add some bloatware:
```
pacman -S plasma kde-applications kdeconnect
```
The installation includes the Display Manager SDDM, so enable the service to use it:
```
sudo systemctl enable sddm
```

## Customization
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
pary -S kvantum
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
`````
