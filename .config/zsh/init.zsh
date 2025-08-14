source ~/.config/zgenom/zgenom.zsh

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="v"

eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/theme.omp.json)"

setopt auto_cd
setopt NO_BEEP
autoload compinit
compinit
_comp_options+=(globdots)
zstyle ':completion:*:default' menu yes select

bindkey -v
zgenom autoupdate

function reload() {
  zgenom reset
  source ~/.zshrc
}

if ! zgenom saved; then
  zgenom load zpm-zsh/colors
  zgenom load zpm-zsh/colorize
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load zsh-users/zsh-history-substring-search
  zgenom load hlissner/zsh-autopair
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load gmatheu/shell-plugins explain-shell


  zgenom load ~/.config/zsh/ls.zsh
  zgenom load ~/.config/zsh/history-substring-search.zsh
  zgenom load ~/.config/zsh/fzf.zsh
  zgenom load ~/.config/zsh/nvim.zsh
  zgenom load ~/.config/zsh/vimode.zsh
  zgenom load ~/.config/zsh/git.zsh
  zgenom load ~/.config/zsh/brew.zsh
  zgenom load ~/.config/zsh/ffmpeg.zsh
  zgenom load ~/.config/zsh/hear.zsh


  zgenom load ~/.config/zsh/go.zsh
  zgenom load ~/.config/zsh/python.zsh
  zgenom load ~/.config/zsh/java.zsh
  zgenom load ~/.config/zsh/javascript.zsh
  zgenom load ~/.config/zsh/android.zsh
  zgenom load ~/.config/zsh/ruby.zsh

  zgenom save
fi

