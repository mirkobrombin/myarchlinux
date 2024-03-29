# Customization

## Terminal/Zsh
As shell I am using ZSH with oh-my-zsh and Powerlevel10K.

I'm using the Nerd font in Konsole:
```
paru -S nerd-fonts-hack
```

### ZSH
```
paru -S zsh
```

### Oh my ZSH
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Starship
```
paru -S starship
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
paru -S plymouth
```

we also need `gdm-plymouth` for installation with GDM as Desktop Manager:

```
paru -S gdm-plymouth
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

### Fonts
#### Emoji
I'm using `noto-fonts-emoji` for CBDT/CBLC, `ttf-twemoji-color` for SVG and `ttf-symbola` for outline:

```
paru -S noto-fonts-emoji ttf-twemoji-color ttf-symbola
```

#### Chinese, Japanese, Korean, Vietnamese
This is a large collection of fonts which comprehensively support Simplified Chinese, Traditional Chinese, Japanese, and Korean, with a consistent design and look:

```
paru -S noto-fonts-cjk 
```
