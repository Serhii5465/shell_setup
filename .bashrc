PS1="\n\[\e[32m\]\u\[\e[33m\]:[\W] \[\e[38;5;219m\]$(uname -o) \[\e[0m\]\n-> "

HISTFILESIZE=10000
HISTSIZE=10000
HISTTIMEFORMAT="%d.%m.%Y %H:%M:%S - "
HISTCONTROL=ignoreboth:erasedups

shopt -s extglob
HISTIGNORE='history*:clear:exit:mkdir*:cd@( *|):pwd:cls:clc:proj:cddown:df:reload:qq'

PROMPT_COMMAND='history -a'

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/scripts/vbox_sync/config ]; then
    source ~/scripts/vbox_sync/config
fi