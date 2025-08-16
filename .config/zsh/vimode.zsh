bindkey -v

COLOR_NORMAL=69
COLOR_INSERT=205
COLOR_VISUAL=141
COLOR_REPLACE=198

call_widget() {
  local func=$1
  shift

  zle "$@" && shift 2 && $func "$@"
}

hook_widget() {
  # The name of the widget to create/decorate.
  local widget=$1
  # The name of the OMP function.
  local func=$2

  # Back up the original widget. The leading dot in widget name is to work around bugs when used with zsh-syntax-highlighting in Zsh v5.8 or lower.
  zle -A $widget ._original::$widget
  eval "_decorated_${(q)widget}() { call_widget ${(q)func} ._original::${(q)widget} -- \"\$@\" }"
  zle -N $widget _decorated_$widget
}

redraw-prompt() {
  prompt_render
  zle reset-prompt
}

vimode-cmd() {
  export VI_MODE="NORMAL"
  redraw-prompt
}

vimode-insert() {
  export VI_MODE="INSERT"
  redraw-prompt
}

vimode-visual() {
  export VI_MODE="VISUAL"
  redraw-prompt
}

vimode-visual-line() {
  export VI_MODE="V-LINE"
  redraw-prompt
}

vimode-replace() {
  export VI_MODE="REPLACE"
  redraw-prompt
}


# CMD/Normal mode
hook_widget vi-cmd-mode vimode-cmd
hook_widget deactivate-region vimode-cmd

# Insert mode
hook_widget vi-insert vimode-insert
hook_widget vi-insert-bol vimode-insert
hook_widget vi-add-eol vimode-insert
hook_widget vi-add-next vimode-insert
hook_widget vi-change vimode-insert
hook_widget vi-change-eol vimode-insert
hook_widget vi-change-whole-line vimode-insert
hook_widget vi-open-line-above vimode-insert
hook_widget vi-open-line-below vimode-insert


# Replace mode
hook_widget vi-replace vimode-replace
hook_widget vi-replace-chars vimode-replace

# Visual mode
hook_widget visual-mode vimode-visual
hook_widget visual-line-mode vimode-visual-line


# reset to default mode at the end of line input reading
line-finish() {
    export VI_MODE="INSERT"
}
hook_widget zle-line-finish line-finish

# Fix a bug when you C-c in CMD mode, you'd be prompted with CMD mode indicator
# while in fact you would be in INS mode.
# Fixed by catching SIGINT (C-c), set mode to INS and repropagate the SIGINT,
# so if anything else depends on it, we will not break it.
TRAPINT() {
  vimode-insert
  return $(( 128 + $1 ))
}

export VI_MODE="INSERT"
