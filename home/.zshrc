export PATH="$HOME/.local/bin:$HOME/.local/share/dotfiles/nvim/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
export EDITOR=nvim
source "$HOME/.zsh_aliases"
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd z)"
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
