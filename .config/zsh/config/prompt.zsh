setopt prompt_subst

PURPLE=129
PINK=201
ORANGE=208
BLUE=27
RED=203
GREEN=40
NODE_GREEN=72
LIGHT_PINK=171

block() {
  local color=$1
  local content="$2"

  output=''

  if $first_block; then
    output+="%F{$color}%f"
  else
    output+="%K{$color} %k"
  fi

  output+="%f"
  output+="%K{$color}$content%k"
  output+="%F{$color}"

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
  local branch=$(git --no-pager branch 2>/dev/null | grep "\* .*$" | sed "s/\* //")

  if [ "$branch" = "" ]; then
    return
  fi

  local commits=$(git cherry 2> /dev/null | wc -l | awk '{print $1}')
  local staged=$(git diff --cached --numstat | wc -l | awk '{print $1}')
  local changes=$(git --no-pager diff --shortstat | cut -c 2)
  local untracked=$(git ls-files --others --exclude-standard | wc -l | awk '{print $1}')
  local origin=$(git remote -v | pcregrep -o1  ":([^ ]*)\.git" | head -n 1)

  block $BLUE " $origin  $branch  $commits  $changes  $untracked"
}

function exit_code() {
  if [[ $1 -ne 0 ]]; then
    block $RED $' %?'
  else
    block $GREEN $''
  fi
}

end_line() {
  echo "%f"
}

clock() {
  block $PINK "󰥔 $(date "+%H:%M:%S")"
}

nodejs() {
  # FIX: This only works at the root directory
  if [[ ! -f package.json ]]; then
    return
  fi
  
  local current_version=$(node --version | sed 's/v//')
  # local nvmrc_version=$(cat .nvmrc | sed 's/v//' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
  # local status_icon=""
  # 
  # if [[ "$current_version" == "$nvmrc_version"* ]]; then
  #   status_icon=""
  # else
  #   status_icon=""  
  # fi
  
  block $NODE_GREEN "󰎙 $current_version"
}

precmd() {
  last_exit_code=$?
  first_block=true
  PROMPT="$(clock)"
  first_block=false
  PROMPT+="$(user)$(hostname)$(cwd)$(nodejs)$(git_status)$(exit_code $last_exit_code)$(end_line)"
  PROMPT+=$'\u000a' #LINE BREAK
  PROMPT+="  "
}
