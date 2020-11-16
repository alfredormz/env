#! /usr/local/bin/zsh

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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

export PATH=/usr/local/sbin:/usr/local/bin:$PATH
export PATH=$HOME/.vim/pack/minpac/start/fzf/bin:$PATH
export FZF_DEFAULT_COMMAND='rg --files | sort'
export ERL_AFLAGS="-kernel shell_history enabled"
export ASDF_DIR=~/.asdf

source $ASDF_DIR/asdf.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Add Visual Studio Code (code)
export PATH=$PATH:$HOME/Applications/Visual\ Studio\ Code.app/Contents/Resourses/app/bin
