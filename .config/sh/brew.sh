brew() {
	if [[ $@ == "i" ]]; then
		command brew leaves --installed-on-request | xargs brew desc --eval-all
	else
		command brew $@
	fi
}
