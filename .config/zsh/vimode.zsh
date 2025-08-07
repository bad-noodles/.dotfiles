bindkey -v

redraw-prompt() {
  _omp_precmd
  zle .reset-prompt
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
_omp_create_widget vi-cmd-mode vimode-cmd
_omp_create_widget deactivate-region vimode-cmd

# Insert mode
_omp_create_widget vi-insert vimode-insert
_omp_create_widget vi-insert-bol vimode-insert
_omp_create_widget vi-add-eol vimode-insert
_omp_create_widget vi-add-next vimode-insert
_omp_create_widget vi-change vimode-insert
_omp_create_widget vi-change-eol vimode-insert
_omp_create_widget vi-change-whole-line vimode-insert
_omp_create_widget vi-open-line-above vimode-insert
_omp_create_widget vi-open-line-below vimode-insert


# Replace mode
_omp_create_widget vi-replace vimode-replace
_omp_create_widget vi-replace-chars vimode-replace

# Visual mode
_omp_create_widget visual-mode vimode-visual
_omp_create_widget visual-line-mode vimode-visual-line


# reset to default mode at the end of line input reading
line-finish() {
    export VI_MODE="INSERT"
}
_omp_create_widget zle-line-finish line-finish

# Fix a bug when you C-c in CMD mode, you'd be prompted with CMD mode indicator
# while in fact you would be in INS mode.
# Fixed by catching SIGINT (C-c), set mode to INS and repropagate the SIGINT,
# so if anything else depends on it, we will not break it.
TRAPINT() {
  vimode-insert
  return $(( 128 + $1 ))
}

export VI_MODE="INSERT"
