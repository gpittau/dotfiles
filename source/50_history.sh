# History settings

# Allow use to re-edit a faild history substitution.
shopt -s histreedit
# Make Bash append rather than overwrite the history on disk.
shopt -s histappend
# Whenever displaying the prompt, write the previous line to disk.
PROMPT_COMMAND='history -a'
# History expansions will be verified before execution.
shopt -s histverify

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
HISTCONTROL="ignorespace:erasedups:ignorespace"
# Give history timestamps.
HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
HISTSIZE=10000
HISTFILESIZE=10000

# Easily re-execute the last history command.
#alias r="fc -s"
