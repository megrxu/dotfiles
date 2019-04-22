autoload -U compinit promptinit

promptinit
prompt pure

# Auto Completion
compinit
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# History Share
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# Plugins
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bindkeys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# Load motd
if [[ -d ~/.motd/cat.d ]];then
  ls ~/.motd.d/cat.d | sort -R |tail -$N | while read file;do
    cat $file
  done
fi

# User configuration

#alias
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias ..="cd .."

#lang
export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# path
export PATH=$HOME/.scripts:$PATH
export TEXMFHOME=$HOME/.texmf
