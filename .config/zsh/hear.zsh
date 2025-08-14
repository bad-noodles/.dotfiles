flow() {
  echo $(pcre2grep -o1 "ref: refs\/heads\/([a-z]+)\/" .git/HEAD)
}

ticket() {
  echo $(pcre2grep -o1 "ref: refs\/heads\/[a-z]+\/(\w+-\d+)" .git/HEAD)
}

#Begin: managed by swing
export AUD_AWS_HOME=/usr/local/bin/aud-terraform-home
#End: managed by swing

