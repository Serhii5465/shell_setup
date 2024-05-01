if groups | grep -q sudo; then
    alias sudo='sudo '
    
    alias shutdown='sudo shutdown now'
    alias reboot='sudo shutdown -r now'

    #apt-get aliases
    alias apt-inst='sudo apt install --assume-yes'
    alias apt-rem='sudo apt purge --autoremove --assume-yes'
    alias apt-fix='sudo apt install --fix-broken'
    alias autoremove='sudo apt autoremove'
    alias update='sudo apt update'
    alias dpkg='sudo dpkg'
    alias clean_system='sudo apt-get autoremove && sudo apt-get clean && sudo apt-get autoclean'

    #systemd aliases
    alias sdinit='sudo systemctl start'
    alias sdstat='sudo systemctl status'
    alias sdreboot='sudo systemctl restart'
    alias sdkill='sudo systemctl stop'

    #ssh aliases
    if [ "$(command -v sshd)" ]; then
        alias ssh_start='sudo systemctl start ssh'
        alias ssh_status='sudo systemctl status ssh'
        alias ssh_restart='sudo systemctl restart ssh'
        alias ssh_stop='sudo systemctl stop ssh'
    fi

    #qbittorrent-nox aliases
    if [ "$(command -v qbittorrent-nox)" ]; then
        alias qb_start='sudo systemctl start qbittorrent-nox'
        alias qb_status='sudo systemctl status qbittorrent-nox'
        alias qb_restart='sudo systemctl restart qbittorrent-nox'
        alias qb_stop='sudo systemctl stop qbittorrent-nox'
    fi

    if [ "$(command -v gedit)" ]; then
        alias gedit='sudo gedit'
    fi

    if [ "$(command -v mousepad)" ]; then
        alias mousepad='sudo mousepad'
    fi

    if [ "$(command -v featherpad)" ]; then
        alias featherpad='sudo featherpad'
    fi

    if [ -f ${HOME}/scripts/zero_space ]; then
        alias zero_space='sudo bash ${HOME}/scripts/zero_space'
    fi

    if [ "$(command -v nano)" ]; then
        export EDITOR=nano
        # alias nano='sudo nano'
    fi  
fi

alias clc='clear'
alias cls='clear'

alias qq='exit'

alias reload='source ${HOME}/.bashrc'

if [ -d ${HOME}/Downloads/ ]; then
    alias cddown='cd ${HOME}/Downloads/'
fi

if [ -d ${HOME}/projects/ ]; then
    alias proj='cd ${HOME}/projects/'
fi

if [ -f ${HOME}/scripts/backup_home_dir ]; then
    alias backup_home_dir='bash ${HOME}/scripts/backup_home_dir' 
fi

alias cd1='cd ..; ls'
alias cd2='cd ..; cd ..; ls'
alias cd3='cd ..; cd ..; cd ..; ls'

alias dd='dd status=progress'
alias df='df --human-readable'
alias du='du --human-readable'
alias mkdir='mkdir --parents --verbose'
alias cp='rsync --recursive --perms  --times --group --owner --specials \
            --human-readable --stats --progress --verbose --out-format="%t %f %b"'
alias mv='mv --interactive --verbose'