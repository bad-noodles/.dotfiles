source ~/.config/zgenom/zgenom.zsh

zgenom autoupdate

if ! zgenom saved; then
  zgenom load zpm-zsh/colors
  zgenom load zpm-zsh/colorize
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load gmatheu/shell-plugins explain-shell
  zgenom load MichaelAquilina/zsh-you-should-use

  zgenom save
fi

function reload() {
  zgenom reset
  source ~/.zshrc
}
