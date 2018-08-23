#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# dotfiles script by James Swineson
export DOTFILES=~/dotfiles

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

dotfiles-rebuild() {
        stow --dir=$DOTFILES --target=$HOME -vv $@
}
