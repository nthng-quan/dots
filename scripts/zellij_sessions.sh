zellij a $(zellij list-sessions --no-formatting | fzf | awk '{print $1}')
