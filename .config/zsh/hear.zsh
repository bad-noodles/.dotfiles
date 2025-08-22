flow() {
  echo $(pcre2grep -o1 "ref: refs\/heads\/([a-z]+)\/" .git/HEAD)
}

branch() {
  echo $(pcre2grep -o1 "ref: refs\/heads\/(.*)$" .git/HEAD)
}

repo() {
  echo $(pcre2grep -m1 -o1 "github.com:(.*)$" .git/FETCH_HEAD)
}

ticket() {
  local key=$(pcre2grep -o1 "ref: refs\/heads\/[a-z]+\/(\w+-\d+)" .git/HEAD)

  case $1 in
    "key")
      echo $key
      ;;
    "link")
      echo "https://audibene.atlassian.net/browse/${key}"
      ;;
    "open")
      open "https://audibene.atlassian.net/browse/${key}"
      ;;
    "pr")
      open "https://github.com/$(repo)/compare/$(branch)?expand=1"
  esac
}

#Begin: managed by swing
export AUD_AWS_HOME=/usr/local/bin/aud-terraform-home
#End: managed by swing

