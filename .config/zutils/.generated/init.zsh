if [ -z "$ZUTIL_HOME" ]; then
  export ZUTIL_HOME=~/.config/zutils
fi
export PATH=$PATH:$ZUTIL_HOME/commands
if [ $(date +%s) -gt 1762377692 ];
then
  (zplugin auto-update > $ZUTIL_HOME/.generated/stdout 2> $ZUTIL_HOME/.generated/stderr &)
fi
source /Users/rafa/.config/zutils/.plugins/zpm-zsh/colors/colors.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/zpm-zsh/colorize/colorize.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/MichaelAquilina/zsh-you-should-use/you-should-use.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/goarano/zsh-fzf-packagemanager/packagemanager-fzf.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/martvdmoosdijk/zsh-nvm-auto-use/zsh-nvm-auto-use.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/wfxr/forgit/forgit.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/aemonge/zsh-cycle-jobs/zsh-cycle-jobs.plugin.zsh
source /Users/rafa/.config/zutils/.plugins/Aloxaf/fzf-tab/fzf-tab.plugin.zsh
