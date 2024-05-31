# if not in a tmux session
if ! {[ -n "$TMUX" ]}; then
	# Create or attach to default session "0"
	command tmux new -As0
fi
