# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

autoload -U compinit promptinit

promptinit
zstyle ':prompt:pure:prompt:success' color cyan
zstyle ':prompt:pure:prompt:error' color yellow
prompt pure

# Auto Completion
compinit
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fpath=( ~/.zfunc "${fpath[@]}" )

# History Share
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bindkeys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" kill-word
bindkey '^H' backward-kill-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# Load motd
if [[ -d ~/.motd/cat.d ]];then
  ls ~/.motd.d/cat.d | sort -R |tail -$N | while read file;do
    cat $file
  done
fi

# dotfiles functions
DOTFILES=~/dotfiles
dotfiles-count() {
        pushd >/dev/null 2>&1
        cd $HOME
        ls -ald .* | grep -v ^l | tee >(wc -l)
        popd >/dev/null 2>&1
}

dotfiles-init() {
        pushd >/dev/null 2>&1
        cd $HOME
        ls -ald .$1*;
        mkdir -p $DOTFILES/$1;
        mv .$1* $DOTFILES/$1;
        stow --dir=$DOTFILES --target=$HOME -vv $1
        popd >/dev/null 2>&1
}

dotfiles-config() {
	pushd > /dev/null 2>&1
	cd $HOME
	ls -ald .config/$1*;
	mkdir -p $DOTFILES/$1/.config;
	mv .config/$1* $DOTFILES/$1/.config/
	stow --dir=$DOTFILES --target=$HOME -vv $1
	popd > /dev/null 2>&1
}

dotfiles-rebuild() {
        stow --dir=$DOTFILES --target=$HOME -vv $@
}

# User configuration

#alias
alias bat="bat --style='grid' --color='always' --paging never"
alias pro="proxychains -q"
alias ls=exa
alias pacman="sudo pacman"
alias netctl="sudo netctl"
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'

alias ll='ls -la'
alias la='ls -a'
alias ..="cd .."

# true color
export TERM=xterm-256color

#lang
export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# gopath
export GOPATH=$HOME/.go/

# path
export PATH=$HOME/.cabal/bin:$HOME/.local/bin:$HOME/.scripts:$HOME/.cargo/bin:$HOME/.npm-global/bin:$GOPATH/bin:$PATH
export TEXMFHOME=$HOME/.texmf


PATH="$HOME/.perl5/bin:$HOME/.config/yarn/global/node_modules/.bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ray/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ray/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ray/.perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ray/.perl5"; export PERL_MM_OPT;

# okteto
export KUBECONFIG="$HOME/Documents/Tools/okteto/okteto-kube.config"
#export KUBECONFIG="$HOME/Documents/Tools/okteto/okteto-kube.config;$KUBECONFIG;$HOME/.kube/config"



. "$HOME/.acme.sh/acme.sh.env"

# utils

eval "$(pyenv init -)"
eval $(thefuck --alias)

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
