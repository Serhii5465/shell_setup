if [ -d '/cygdrive/d/projects' ]; then
    alias proj='cd /cygdrive/d/projects'
fi

if [ -d '/cygdrive/e/downloads' ]; then
    alias cddown='cd /cygdrive/d/downloads'
fi

if [ "$(command -v python3)" ]; then
    alias pip='pip3'
    alias python="$(which python3)"

    alias backup_files='python ${HOME}/scripts/sync_data/main.py'
    alias upload_docs_gdrive='python ${HOME}/scripts/gdrive_backup_docs/gdrive_backup_docs.py'
    alias adb_sync_music='python ${HOME}/scripts/adb_sync_music/main.py'

    if [ -f '${HOME}/scripts/ssh-ident' ] && [ "$(command -v ssh)" ]; then
        alias ssh='python ${HOME}/scripts/ssh-ident'
    fi
fi

if [ "$(command -v ssh)" ]; then
    alias xubuntu='ssh xubuntu'
    alias ubuntu_raisnet='ssh ubuntu_raisnet'
	alias k8s_master='ssh k8s_master'
	alias k8s_node1='ssh k8s_node1'
	#alias ubuntu_develop='ssh ubuntu_develop'
fi

alias reload='source ${HOME}/.bashrc'

alias qq='exit'

alias clc='clear'
alias cls='clear'

alias cd1='cd ..; ls'
alias cd2='cd ..; cd..; ls'

alias df='df --human-readable'
alias mkdir='mkdir --parents --verbose'
alias cp='rsync --recursive --perms  --times --group --owner --specials \
            --human-readable --stats --progress --verbose --out-format="%t %f %b"'
alias mv='mv --interactive --verbose'
alias dd='dd status=progress'

alias backup_cygwin_env='bash ${HOME}/scripts/backup_env/backup_cygwin_env'
alias backup_git_env='bash ${HOME}/scripts/backup_env/backup_win_git_env'
alias backup_work_env='bash ${HOME}/scripts/backup_env/backup_work_env'