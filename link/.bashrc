# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

PATH=~/.dotfiles/bin:$PATH
export PATH

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function realpath()
{
    f=$1

    if [ -d $f ]; then
        base=""
        dir=$f
    else
        base="/$(basename $f)"
        dir=$(dirname $f)
    fi

    dir=$(cd $dir && /bin/pwd)

    echo "$dir$base"
}

# Set prompt path to max 2 levels for best compromise of readability and usefulness
promptpath () {
    realpwd=$(realpath $PWD)
    realhome=$(realpath $HOME)

    # if we are in the home directory
    if echo $realpwd | grep -q "^$realhome"; then
        path=$(echo $realpwd | sed "s|^$realhome|\~|")
        if [ $path = "~" ] || [ $(dirname $path) = "~" ]; then
            echo $path
        else
            echo $(basename $(dirname $path))/$(basename $path)
        fi
        return
    fi

    path_dir=$(dirname $PWD)
    # if our parent dir is a top-level directory, don't mangle it
    if [ $(dirname $path_dir) = "/" ]; then
        echo $PWD
    else
        path_parent=$(basename $path_dir)
        path_base=$(basename $PWD)

        echo $path_parent/$path_base
    fi
}

run_scripts()
{
    for script in $1/*; do
        [ -x "$script" ] || continue
        . $script
    done
}

# Source all files in ~/.dotfiles/source/
function src() {
  local file
  if [[ "$1" ]]; then
    source "$HOME/.dotfiles/source/$1.sh"
  else
    run_scripts ~/.dotfiles/source
    #for file in ~/.dotfiles/source/*; do
    #  source "$file"
    #done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src
}

run_scripts $HOME/.bashrc.d
src

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
