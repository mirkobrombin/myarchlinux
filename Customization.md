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
