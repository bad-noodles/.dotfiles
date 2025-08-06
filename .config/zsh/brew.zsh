brew() {
  # List installed packages
  if [[ $@ == "i" ]]; then
    command brew leaves --installed-on-request | xargs brew desc --eval-all
  else
    command brew $@
  fi
}

alias xbrew='arch -x86_64 /usr/local/homebrew/bin/brew'
