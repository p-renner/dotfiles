export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

if type brew &>/dev/null; then
	plugins=(git macos brew)
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
elif type pacman &>/dev/null; then
	plugins=(git archlinux)
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
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
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
fi

alias dot='cd $HOME/dotfiles'
alias v='nvim'
alias c='clear'
alias syu='sudo pacman -Syu'
alias vpn='sudo openvpn --config $HOME/.config/vpn/vpn.ovpn'
