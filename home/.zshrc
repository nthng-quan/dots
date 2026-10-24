export PATH="$HOME/.local/bin:$HOME/.local/share/dotfiles/nvim/bin:$PATH"
# Mason-installed language servers (used by omp's LSP auto-detection)
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
# omp images through tmux need kitty Unicode placeholders; enable when the tmux client is kitty
[[ -n $TMUX && $(tmux display -p '#{client_termname}' 2>/dev/null) == xterm-kitty ]] && { export PI_FORCE_IMAGE_PROTOCOL=kitty PI_KITTY_PLACEHOLDERS=1; unset PI_NO_KITTY_PLACEHOLDERS; }
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
