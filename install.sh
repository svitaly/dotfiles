#!/bin/bash

# Ask Y/n
function ask() {
    read -p "$1 (Y/n): " resp
    if [ -z "$resp" ]; then
        response_lc="y" # empty is Yes
    else
        response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
    fi

    [ "$response_lc" = "y" ]
}

# Check what shell is being used (ZSH / BASH)
SH="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"
if [ -f "$ZSHRC" ]; then
	SH="$ZSHRC"
fi

echo >> $SH
echo '# ------------ vitalii.sidorok:DOTFILES BEGIN -------------' >> $SH

# # Ask which files should be sourced
echo "Do you want $SH to source: "
for file in shell/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        if ask "${filename}?"; then
            echo "source $(realpath "$file")" >> "$SH"
        fi
    fi
done

echo '# ------------ vitalii.sidorok:DOTFILES END -------------' >> $SH

# ALACRITTY conf
if ask "Do you want to install Alacritty conf?"; then
    ln -s "$(realpath "alacritty/alacritty.toml")" ~/.config/alacritty/alacritty.toml
fi

# TMUX conf
if ask "Do you want to install .tmux.conf?"; then
    ln -s "$(realpath "tmux/.tmux.conf")" ~/.tmux.conf
fi

# NEOVIM conf
if ask "Do you want to install NVIM init.lua?"; then
    ln -s "$(realpath "nvim/init.lua")" ~/.config/nvim/init.lua
fi
