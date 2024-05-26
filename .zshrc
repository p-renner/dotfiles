export ZSH="$HOME/.oh-my-zsh"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
HIST_STAMPS="yyyy-mm-dd"

bindkey "^E" history-incremental-search-backward

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

ZSH_THEME="robbyrussell"

if type brew &>/dev/null; then
	plugins=(git macos brew fzf)
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
	source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif type pacman &>/dev/null; then
	plugins=(git archlinux fzf)
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'

export ARCHFLAGS="-arch $(uname -m)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# start ssh agent
if [[ ! "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi

# auto start tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# ngrok completion
if command -v ngrok &>/dev/null; then
	eval "$(ngrok completion)"
fi

# Mac Specific Config
if [[ "$OSTYPE" == "darwin"* ]]; then
	export GPG_TTY=$(tty)
	# pnpm
	export PNPM_HOME="$HOME/Library/pnpm"
	case ":$PATH:" in
		*":$PNPM_HOME:"*) ;;
		*) export PATH="$PNPM_HOME:$PATH" ;;
	esac

	autoload -U +X bashcompinit && bashcompinit

	# terraform completions
	complete -o nospace -C /opt/homebrew/bin/terraform terraform

	# The next line updates PATH for the Google Cloud SDK.
	if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

	# The next line enables shell command completion for gcloud.
	if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	export PNPM_HOME="$HOME/.local/share/pnpm"
fi

case ":$PATH:" in
	*":$PNPM_HOME:"*) ;;
	*) export PATH="$PNPM_HOME:$PATH" ;;
esac

alias dot='cd $HOME/dotfiles'
alias v='nvim'
alias c='clear'
alias syu='sudo pacman -Syu'
alias vpn='sudo openvpn --config $HOME/.config/vpn/vpn.ovpn'
alias gs='git status'

