#!/bin/env zsh

echo "===   Installing Homebrew   ==="
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew shellenv

echo "===   Installing Brew Dependencies   ==="
brew bundle

# Download dotfiles
cd ~
git clone git@github.com:bad-noodles/.dotfiles.git
git clone https://github.com/jandamm/zgenom.git "${HOME}/.config/zgenom"

# Backup existing config and apply
mv .zprofile .zprofile_bkp
cd ./dotfiles
stow --target=$HOME .

# Triggers the zgenom package manager to update dependencies
reload
