# Function to add directories to PATH if not already present
path_add() {
  [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}

export ZSH="$HOME/.oh-my-zsh"

# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(ls|pwd|exit|cd)*"
HIST_STAMPS="yyyy-mm-dd"

# Key bindings
bindkey "^E" history-incremental-search-backward

# History options
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file (Default)
setopt HIST_NO_STORE             # Don't store history commands
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks from each command line being added to the history list.

export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export EDITOR='nvim'
export ARCHFLAGS="-arch $(uname -m)"

ZSH_THEME="robbyrussell"

# Detect package manager and set plugins + syntax highlighting
if type brew &>/dev/null; then
	plugins=(git macos brew fzf)
	FPATH="$(brew --prefix)/share/zsh/site-functions${FPATH:+":$FPATH"}"
	HIGHLIGHT_PATH="/opt/homebrew/share/zsh-syntax-highlighting"
elif type pacman &>/dev/null; then
	plugins=(git archlinux fzf)
	HIGHLIGHT_PATH="/usr/share/zsh/plugins/zsh-syntax-highlighting"
fi

[[ -n $HIGHLIGHT_PATH ]] && source "$HIGHLIGHT_PATH/zsh-syntax-highlighting.zsh"

source $ZSH/oh-my-zsh.sh

# NVM Setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bun Setup
export BUN_INSTALL="$HOME/.bun"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
path_add "$BUN_INSTALL/bin"

# Start SSH agent if needed
if [[ -z "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi

# Auto-start tmux (only in interactive shell)
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# Ngrok completion
if command -v ngrok &>/dev/null; then
	eval "$(ngrok completion)"
fi

# Mac Specific Config
if [[ "$OSTYPE" == "darwin"* ]]; then
	export GPG_TTY=$(tty)

	# pnpm setup
	export PNPM_HOME="$HOME/Library/pnpm"

	autoload -U +X bashcompinit && bashcompinit

	# Terraform completions
	complete -o nospace -C /opt/homebrew/bin/terraform terraform

	# Google Cloud SDK setup
	for file in "$HOME/google-cloud-sdk/path.zsh.inc" "$HOME/google-cloud-sdk/completion.zsh.inc"; do
		[ -f "$file" ] && source "$file"
	done
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	export PNPM_HOME="$HOME/.local/share/pnpm"
fi

# Add necessary paths
path_add "$PNPM_HOME"
path_add "$HOME/.local/bin"

alias dot='cd $HOME/dotfiles'
alias v='nvim'
alias c='clear'
alias syu='sudo pacman -Syu'
alias vpn='sudo openvpn --config $HOME/.config/vpn/vpn.ovpn --mute-replay-warnings'
alias gs='git status'


