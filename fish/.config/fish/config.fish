export DOTFILES=~/dotfiles

function dotfiles-count 
        pushd >/dev/null 2>&1
        cd $HOME
        ls -ald .* | grep -v ^l | tee >(wc -l)
        popd >/dev/null 2>&1
end

