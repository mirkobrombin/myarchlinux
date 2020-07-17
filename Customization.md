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

