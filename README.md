# DOTFILES

## Install

To install the config files clone this git repo and use the install script:

```
git clone github.com/svitaly/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` should be already executable.


## Dependencies

- [TMUX](https://github.com/tmux/tmux)
- [Alacritty](https://github.com/alacritty)
- [Neovim 0.9.5+](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [Pragmasevka Nerd Font](https://github.com/shytikov/pragmasevka)
- [Other Nerd Fonts](https://www.nerdfonts.com/font-downloads)


## Other
### Neovim installation

Uninstall all previeous nvim configs and clean cache:
```
rm -rf ~/.local/share/nvim &&
rm -rf ~/.local/state/nvim &&
rm -rf ~/.cache/nvim &&
rm -rf ~/.config/nvim
```
