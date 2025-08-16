setopt prompt_subst

PURPLE=129
PINK=201
ORANGE=208
BLUE=27
RED=203
GREEN=40
LIGHT_PINK=171

block() {
  local color=$1
  local content="$2"

  output=''

  if $first_block; then
    output+=$(tput setaf $color)
    output+=''  
  else
    output+=$(tput setab $color)
    output+=' '
  fi

  output+=$(tput sgr0)
  output+=$(tput setab $color)
  output+=$content
  output+=$(tput sgr0)
  output+=$(tput setaf $color)

  echo -e $output
}

user() {
  block $PURPLE ' %n'
}

hostname() {
  block $LIGHT_PINK ' %m'
}

cwd() {
  block $ORANGE ' %~'
}

git_status() {
  if [ ! -d ".git" ]; then
    return
  fi
  local branch=$(git branch | sed "s/\* //")
  local commits=$(git cherry | wc -l | awk '{print $1}')
  local staged=$(git diff --cached --numstat | wc -l | awk '{print $1}')
  local changes=$(git --no-pager diff --shortstat | cut -c 2)
  local untracked=$(git ls-files --others --exclude-standard | wc -l | awk '{print $1}')
  local origin=$(cat .git/FETCH_HEAD | egrep -o ":.*$" | cut -c 2-)

  local output=' '
  output+=$origin
  output+='  '
  output+=$branch
  output+='  '
  output+=$commits
  output+='  '
  output+=$staged
  output+='  '
  output+=$changes
  output+='  '
  output+=$untracked


  block $BLUE $output
}

function exit_code() {
  if [[ $1 -ne 0 ]]; then
    block $RED $' %?'
  else
    block $GREEN $''
  fi
}

end_line() {
  output=''
  output+=$(tput sgr0)
  echo $output
}

vi_mode() {
  local color=$COLOR_INSERT

  case $VI_MODE in
    "NORMAL")
      color=$COLOR_NORMAL
      ;;
    "VISUAL" | "V-LINE")
      color=$COLOR_VISUAL
      ;;
    "REPLACE")
      color=$COLOR_REPLACE
      ;;
  esac

  block $color $VI_MODE
}

clock() {
  block $PINK " $(date "+%H:%M:%S")"
}

precmd() {
  last_exit_code=$?
  first_block=true
  PROMPT="$(clock)"
  first_block=false
  PROMPT+="$(user)$(hostname)$(cwd)$(git_status)$(exit_code $last_exit_code)$(end_line)"
  PROMPT+=$'\u000a' #LINE BREAK
  PROMPT+="  "
}
