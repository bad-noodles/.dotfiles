flow() {
  echo $(branch | sed "s/\/.*//")
}

branch() {
  echo $(git --no-pager branch | grep "^\*.*" | sed "s/\* //")
}

repo() {
  echo $(pcre2grep -m1 -o1 "github.com:(.*)$" .git/FETCH_HEAD)
}

key() {
  echo $(branch | pcre2grep -o1 "^.*\/(\w+-\d+).*")
}

ticket() {
  open "https://audibene.atlassian.net/browse/$(key)"
}

pr() {
  open "https://github.com/$(repo)/compare/$(branch)?expand=1"
}

#Begin: managed by swing
export AUD_AWS_HOME=/usr/local/bin/aud-terraform-home
#End: managed by swing

