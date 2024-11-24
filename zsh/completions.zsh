zstyle ':completion:*' menu select search

# Partial match highlighting
zstyle -e ':completion:*:default' list-colors \
  'reply=("${PREFIX:+=(#bi)($PREFIX:t)()*==34=34}:${(s.:.)LS_COLORS}")'

# Setup corrections to ignore case and correct me when I'm wrong
zstyle ':completion:*' menu completer _extensions _complete _approximate _files
zstyle ':completion:*' scroll true
zstyle ':completion:*:*:*:*:corrections' ignore-case true
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}Corrected command%f'
zstyle ':completion:*:warnings' format '%F{red}No matches found%f'

# Enable descriptions for completion
zstyle ':completion:*:descriptions' format '%B%d%b'

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes