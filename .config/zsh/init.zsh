source ~/.config/zgenom/zgenom.zsh

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/montys.omp.json)"

zgenom autoupdate

if ! zgenom saved; then
  zgenom load ~/.config/zsh/ls.zsh
  zgenom load ~/.config/zsh/fzf.zsh
  zgenom load ~/.config/zsh/tmux.sh
  zgenom load ~/.config/zsh/nvim.zsh
  zgenom load ~/.config/zsh/brew.zsh
  zgenom load ~/.config/zsh/ffmpeg.zsh


  zgenom load ~/.config/zsh/go.zsh
  zgenom load ~/.config/zsh/python.zsh
  zgenom load ~/.config/zsh/java.zsh
  zgenom load ~/.config/zsh/ruby.zsh
  zgenom load ~/.config/zsh/android.zsh

  # generate the init script from plugins above
  zgenom save
fi

