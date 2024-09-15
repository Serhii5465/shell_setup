if groups | grep -q sudo; then
    alias sudo='sudo '
    
    alias shutdown='sudo shutdown now'
    alias reboot='sudo shutdown -r now'

    #apt-get aliases
    alias apt-install='sudo apt install --assume-yes'
    alias apt-remove='sudo apt purge --autoremove --assume-yes'
    alias apt-fix='sudo apt install --fix-broken'
    alias apt-autoremove='sudo apt autoremove'
    alias apt-update='sudo apt update'
    alias clean_system='sudo apt-get autoremove && sudo apt-get clean && sudo apt-get autoclean'

    alias dpkg='sudo dpkg'
    if [ -r /usr/share/bash-completion/completions/dpkg ]; then
        source /usr/share/bash-completion/completions/dpkg && complete -F _dpkg dpkg
    fi

    alias sct='systemctl'
    if [ -r /usr/share/bash-completion/completions/systemctl ]; then
        source /usr/share/bash-completion/completions/systemctl && complete -F _systemctl sct
    fi

    #ssh aliases
    if [ "$(command -v sshd)" ]; then
        alias ssh_start='sudo systemctl start ssh'
        alias ssh_status='sudo systemctl status ssh'
        alias ssh_restart='sudo systemctl restart ssh'
        alias ssh_stop='sudo systemctl stop ssh'
    fi

    if [ "$(command -v timeshift)" ]; then
        alias tdelsnap='sudo timeshift --delete'
        alias tlistsnap='sudo timeshift --list'
        alias trestore='sudo timeshift --restore'

        taddsnap(){
            if [[ -z "${1}" ]]; then
                echo "Add a description of the snapshot before creating it"
                return
            else
                sudo timeshift --create --comments "$1"
            fi
        }
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

    if [ -f "${SCRIPT_DIR}/zero_space" ]; then
        alias zero_space='sudo bash ${SCRIPT_DIR}/zero_space'
    fi
    
    if [ "$(command -v nano)" ]; then
        export EDITOR=nano
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

if [ -f "${SCRIPT_DIR}/backup_home_dir" ]; then
    alias backup_home_dir='bash ${SCRIPT_DIR}/backup_home_dir' 
fi

if [ -d "${SCRIPT_DIR}/docker-volume-backups" ]; then
    SCRIPT_DIR_DOCKER_VOL_BACKUP="${SCRIPT_DIR}/docker-volume-backups"

    init_venv(){
        if [ ! -d "${SCRIPT_DIR_DOCKER_VOL_BACKUP}/.venv" ]; then
            python3 -m venv "${SCRIPT_DIR_DOCKER_VOL_BACKUP}/.venv"
        fi
        
        source "${SCRIPT_DIR_DOCKER_VOL_BACKUP}/.venv/bin/activate" && pip install -r "${SCRIPT_DIR_DOCKER_VOL_BACKUP}/requirements.txt" >> /dev/null
        python3 $@
        deactivate
    }
    
    restore_dock_vol(){
        init_venv "${SCRIPT_DIR_DOCKER_VOL_BACKUP}/restore.py" $@
    }

    backup_dock_vol(){
        init_venv "${SCRIPT_DIR_DOCKER_VOL_BACKUP}/backup.py" $@
    }
fi

alias cd1='cd ..; ls'
alias cd2='cd ..; cd ..; ls'

alias dd='dd status=progress'
alias df='df --human-readable'
alias du='du --human-readable'
alias mkdir='mkdir --parents --verbose'
alias cp='rsync --recursive --perms  --times --group --owner --specials \
            --human-readable --stats --progress --verbose --out-format="%t %f %b"'
alias mv='mv --interactive --verbose'

alias ssh-keygen-rsa='ssh-keygen -t rsa -b 4096'
alias ssh-keygen='ssh-keygen -t ed25519'