# Customization

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

### Starship
```
yay -S starship
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
