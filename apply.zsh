#!/bin/env zsh

echo "======================================="
echo "===   Installing Homebrew and Git   ==="
echo "======================================="
echo ""

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install git

echo "================================"
echo "===   Downloading dotfiles   ==="
echo "================================"
echo ""

cd ~
git clone git@github.com:bad-noodles/.dotfiles.git
cd .dotfiles

echo "========================================"
echo "===   Installing Brew Dependencies   ==="
echo "========================================"
echo ""

brew bundle

echo "========================================="
echo "===   Creating symlinks to dotfiles   ==="
echo "====                                 ===="
echo "====     .zprofile and .zshrc files  ===="
echo "====     will be backed up in the    ===="
echo "====     same directory if they      ===="
echo "====     already exist               ===="
echo "========================================="
echo ""

mv ~/.zprofile ~/.zprofile_bkp
mv ~/.zshrc ~/.zshrc_bkp
stow --target=$HOME .

echo "=========================================="
echo "===   Downloading zsh plugin manager   ==="
echo "=========================================="
echo ""

git clone https://github.com/jandamm/zgenom.git ".config/zgenom"


echo "=================================="
echo "===   Installing zsh plugins   ==="
echo "=================================="
echo ""

reload

echo "====================="
echo "===   All done!   ==="
echo "====================="
