if [ -d '/cygdrive/e/downloads' ]; then
    alias down='cd /cygdrive/e/downloads'
elif [ -d '/cygdrive/d/downloads' ]; then
    alias down='cd /cygdrive/d/downloads'
fi

if [ "$(command -v ssh)" ]; then
    alias xubuntu='ssh xubuntu'
    alias ubuntu_raisnet='ssh ubuntu_raisnet'
    alias ubuntu_k8s='ssh ubuntu_k8s'
fi

alias reload='source ${HOME}/.bashrc'

alias clc='clear'
alias cls='clear'

alias cd1='cd ..; ls'
alias cd2='cd ..; cd ..; ls'

alias qq='exit'

alias df='df --human-readable'
alias mkdir='mkdir --parents --verbose'
alias cp='rsync --recursive --perms  --times --group --owner --specials \
            --human-readable --stats --progress --verbose --out-format="%t %f %b"'
alias mv='mv --interactive --verbose'
alias dd='dd status=progress'