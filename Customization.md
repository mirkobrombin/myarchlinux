# Customization

## Terminal/Zsh
As shell I am using ZSH with oh-my-zsh and Powerlevel10K.

I'm using the Nerd font in Konsole:
```
pary -S nerd-fonts-hack
```

### ZSH
```
pary -S zsh
```

### Oh my ZSH
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Starship
```
pary -S starship
```
add to the end of `~/.zshrc` file:
```
eval "$(starship init zsh)"
```

#### Config
Create `~/.config/starship.toml`, rules [here](https://starship.rs/config/).

## Nano Syntax
To enable syntax create `~/.nanorc` with content:
```
include /usr/share/nano/*
```

### Markdown syntax
Create `/usr/share/nano/markdown.nanorc` file with content: 
```
syntax "markdown" "\.md$" "\.markdown$"

## Quotations
color cyan "^>.*"

## Emphasis
color green "_[^_]*_"
color green "\*[^\*]*\*"

## Strong emphasis
color brightgreen "\*\*[^\*]*\*\*"
color brightgreen "__[\_]*__"

## Underline headers
color brightblue "^====(=*)"
color brightblue "^----(-*)"

## Hash headers
color brightblue "^#.*"

## Linkified URLs (and inline html tags)
color brightmagenta start="<" end=">"

## Links
color brightmagenta "\[.*\](\([^\)]*\))?"

## Link id's:
color brightmagenta "^\[.*\]:( )+.*"

## Code spans
color brightyellow "`[^`]*`"

## Links and inline images
color brightmagenta start="!\[" end="\]"
color brightmagenta start="\[" end="\]"

## Lists
color yellow "^( )*(\*|\+|\-|[0-9]+\.) "

```

## Plymouth
Install `plymouth` from AUR:

```
pary -S plymouth
```

we also need `gdm-plymouth` for installation with GDM as Desktop Manager:

```
pary -S gdm-plymouth
```

Edit `/etc/mkinitcpio.conf`, add `sd-plymouth` after `systemd` in `HOOKS` section:

```
...
HOOKS=(base systemd sd-plymouth ..)
...
```

Edit the boot entry to add `splash` kernel option after `quiet`.

### Theme
I'm using the BGRT theme that show a spinner with the bios logo. 

In `/etc/plymouth/plymouthd.conf` :

```
[Daemon]
Theme=bgrt
ShowDelay=0
DeviceTimeout=8
```

set `ShowDelay` to `0`, then regenerate the theme:

```
plymouth-set-default-theme -R bgrt
```