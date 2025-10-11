#zmodload zsh/zprof
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"

setopt auto_cd
setopt NO_BEEP
autoload compinit
compinit
_comp_options+=(globdots)
zstyle ':completion:*' menu yes select=long interactive
zstyle ':completion:*' completer _extensions _complete _approximate

eval "$(zoxide init zsh --cmd cd)"

source ~/.config/zsh/plugins.zsh

for f (~/.config/zsh/config/*.zsh(N.))  . $f

# zprof
