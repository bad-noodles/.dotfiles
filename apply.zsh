#!/bin/env zsh

# Stop execution if any command fails
set -eo pipefail

echo ""
echo "======================================="
echo "===   Installing Homebrew and Git   ==="
echo "======================================="
echo ""

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install git

echo ""
echo "================================"
echo "===   Downloading dotfiles   ==="
echo "================================"
echo ""

cd ~
git clone https://github.com/bad-noodles/.dotfiles.git
cd .dotfiles

echo ""
echo "========================================"
echo "===   Installing Brew Dependencies   ==="
echo "========================================"
echo ""

brew bundle

echo ""
echo "========================================="
echo "===   Creating symlinks to dotfiles   ==="
echo "========================================="
echo ""

stow --target=$HOME .

echo ""
echo "=========================================="
echo "===   Downloading zsh plugin manager   ==="
echo "=========================================="
echo ""

git clone https://github.com/jandamm/zgenom.git ".config/zgenom"


echo ""
echo "===================================================="
echo "===   Zsh plugins will be installed in WezTerm   ==="
echo "===================================================="
echo ""

open /Applications/WezTerm.app

