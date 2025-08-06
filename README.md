# Setup

```sh
# Install Homebrew and deps
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git stow

# Download dotfiles
cd ~
git clone git@github.com:bad-noodles/.dotfiles.git
git clone https://github.com/jandamm/zgenom.git "${HOME}/.config/zgenom"

# Backup existing config and apply
mv .zprofile .zprofile_bkp
cd ./dotfiles
stow --target=$HOME .
brew bundle
gem install colorls
```
