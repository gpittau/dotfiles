# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return


PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

run_scripts()
{
    for script in $1/*; do
        [ -x "$script" ] || continue
        . $script
    done
}

run_scripts $HOME/.bashrc.d
