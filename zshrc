#! /usr/local/bin/zsh

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

autoload -Uz colors
colors

# VARIABLES
RED="%{$fg[red]%}"
GREEN="%{$fg[green]%}"
BLUE="%{$fg[blue]%}"
GREY="%{$fg[grey]%}"
MAGENTA="%{$fg[magenta]%}"
CYAN="%{$fg[cyan]%}"
WHITE="%{$fg[white]%}"
YELLOW="%{$fg[yellow]%}"
BLACK="%{$fg[black]%}"

BRED="%{$fg_bold[red]%}"
BGREEN="%{$fg_bold[green]%}"
BBLUE="%{$fg_bold[blue]%}"
BGREY="%{$fg_bold[grey]%}"
BMAGENTA="%{$fg_bold[magenta]%}"
BCYAN="%{$fg_bold[cyan]%}"
BWHITE="%{$fg_bold[white]%}"
BYELLOW="%{$fg_bold[yellow]%}"

RESET="%{$reset_color%}"

setopt null_glob

# Keep lots of history within the shell and save it to ~/.zsh_history:
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
export HISTSIZE=65536
export SAVEHIST=60000
export HISTFILESIZE=$HISTSIZE
export HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

export EDITOR="vim"

# Use vim keybindings.
bindkey -v
export KEYTIMEOUT=1

# Binded ^R to history search, like bash.
bindkey '^R' history-incremental-pattern-search-backward

# To enable ^E and ^A macros.
bindkey -M viins '^A' vi-beginning-of-line
bindkey -M viins '^E' vi-end-of-line

# Global
alias reload="source ~/.zshrc"
alias quit="exit"
alias ll="ls -lsah"
alias zshrc="vim ~/.zshrc && reload"
alias ag="rg"

if [ "`uname`" = 'Linux' ]; then
  alias ls="ls --color=always"
else
  alias ls="ls -G"
fi

# PROMPT
# get the name of the branch or commit (short SHA) we are on
function git_prompt_info() {
  ref=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) || return
  echo "${ref}"
}

# PS1
setopt promptsubst

local full_path='${GREEN}%c'
local git_stuff='${RESET}$(git_prompt_info)'

local context="${full_path} ${git_stuff}"
local insert_dollar_sign="%B$%b "
local normal_dollar_sign="%B${YELLOW}\$${RESET}%b "

# Change the color of the $ when in normal mode.
function zle-line-init zle-keymap-select {
  if [ "$KEYMAP" = "vicmd" ]; then
    PROMPT="$context $normal_dollar_sign"
  else
    PROMPT="$context $insert_dollar_sign"
  fi

  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# By default in vi, the backspace when entering insert mode after a `c*` command
# does not delete characters. This fixes that.
bindkey "^?" backward-delete-char

setopt interactivecomments

# Make `less` quit if the output has only one page (-FX).
# Make `less` parse ansii colors (-R).
export LESS="-RFX"

# Load secrets.
if [[ -f ~/.zshrc_private ]]; then; . ~/.zshrc_private; fi

# Custom binaries
export PATH=~/bin:$PATH

# Homebrew's bin path
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export PATH=$HOME/.vim/pack/minpac/start/fzf/bin:$PATH
export FZF_DEFAULT_COMMAND='rg --files | sort'
export NVM_DIR="$HOME/.nvm"
export ERL_AFLAGS="-kernel shell_history enabled"

eval "$(rbenv init -)"

# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
