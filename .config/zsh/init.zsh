source ~/.config/zgenom/zgenom.zsh

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/montys.omp.json)"

setopt auto_cd
autoload compinit
compinit
zstyle ':completion:*:default' menu yes select

zgenom autoupdate

function reload() {
  zgenom reset
  source ~/.zshrc
}

if ! zgenom saved; then
  zgenom load ~/.config/zsh/ls.zsh
  zgenom load ~/.config/zsh/fzf.zsh
  zgenom load ~/.config/zsh/nvim.zsh
  zgenom load ~/.config/zsh/git.zsh
  zgenom load ~/.config/zsh/brew.zsh
  zgenom load ~/.config/zsh/ffmpeg.zsh


  zgenom load ~/.config/zsh/go.zsh
  zgenom load ~/.config/zsh/python.zsh
  zgenom load ~/.config/zsh/java.zsh
  zgenom load ~/.config/zsh/android.zsh
  zgenom load ~/.config/zsh/ruby.zsh

  zgenom load zpm-zsh/colors
  zgenom load zpm-zsh/colorize

  # generate the init script from plugins above
  zgenom save
fi

