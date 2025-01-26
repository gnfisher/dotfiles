# Homebrew path configuration
if [[ -d "/opt/homebrew/bin" ]]; then
    # M1/M2 Mac
    export PATH="/opt/homebrew/bin:$PATH"
elif [[ -d "/usr/local/bin" ]]; then
    # Intel Mac
    export PATH="/usr/local/bin:$PATH"
fi

# History configuration
HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_VERIFY               # Don't execute immediately upon history expansion
setopt SHARE_HISTORY            # Share history between sessions
setopt EXTENDED_HISTORY         # Add timestamps to history
setopt APPEND_HISTORY           # Adds history incrementally
setopt HIST_IGNORE_ALL_DUPS     # Don't record duplicates in history
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks from history

# Basic auto/tab completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select                 # Highlight selection
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case insensitive matching
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # Colored completion
zstyle ':completion:*' special-dirs true          # Complete . and ..

# Directory navigation
setopt AUTO_CD                  # Just type directory name to cd
setopt AUTO_PUSHD              # Push directories to stack
setopt PUSHD_IGNORE_DUPS       # No duplicates in dir stack
setopt PUSHD_SILENT            # Don't print dir stack after pushd/popd

# Colors and prompt
autoload -Uz colors && colors   # Load colors
export CLICOLOR=1              # Enable colors for ls
export LSCOLORS=ExFxCxDxBxegedabagacad
# Git status in prompt
autoload -Uz vcs_info
precmd() { vcs_info }

# Configure vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' formats '(%b)'
setopt PROMPT_SUBST
precmd() { vcs_info }

setopt PROMPT_SUBST            # Enable prompt substitution

# Function to get host display name
function get_host_display() {
    if [[ -n "$CODESPACES" ]]; then
        echo "%F{magenta}${${CODESPACE_NAME}##*-}"  # Magenta for Codespaces
    elif [[ -n "$SSH_CONNECTION" ]]; then
        echo "%F{cyan}%m"  # Cyan for remote SSH hosts
    else
        echo "%F{green}%m"  # Green for local hostname
    fi
}

# Prompt format: hostname directory(branch)*+$
PROMPT='$(get_host_display):%1~${vcs_info_msg_0_} $%f '

# Key bindings
bindkey -e                     # Emacs key bindings
bindkey '^[[A' up-line-or-search    # Up arrow for history search
bindkey '^[[B' down-line-or-search  # Down arrow for history search
bindkey '^[[H' beginning-of-line    # Home key
bindkey '^[[F' end-of-line          # End key
bindkey '^[[3~' delete-char         # Delete key

# Basic aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
