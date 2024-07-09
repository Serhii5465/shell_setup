if [ -d '/e/downloads' ]; then
    alias down='cd /e/downloads'
elif [ -d '/d/downloads' ]; then
    alias down='cd /d/downloads'
fi

if [ "$(command -v python)" ]; then
    alias pip='pip3'
    # alias python="$(which python3)"
       
    # if [ -f "${HOME}/scripts/ssh-ident" ] && [ "$(command -v ssh)" ]; then
    #     alias ssh='python ${HOME}/scripts/ssh-ident'
    # fi

    if [ -d "${PYTHON_SCRIPTS_DIR}/gdrive_backup_docs" ]; then
        alias upload_docs_gdrive='python ${PYTHON_SCRIPTS_DIR}/gdrive_backup_docs/gdrive_backup_docs.py'
    fi

    if [ -d "${PYTHON_SCRIPTS_DIR}/sync_data" ]; then
        alias backup_files='python ${PYTHON_SCRIPTS_DIR}/sync_data/main.py'
    fi

    if [ -d "${PYTHON_SCRIPTS_DIR}/backup_env" ]; then
        alias backup_work_env='python ${PYTHON_SCRIPTS_DIR}/backup_env/work_env.py'
        alias backup_git_env='python ${PYTHON_SCRIPTS_DIR}/backup_env/git_env.py'
    fi

    if [ "$(command -v adb)" ]; then
        alias adb_sync_music='MSYS_NO_PATHCONV=1 adbsync --show-progress --del push E:\\media\\Music\\ /storage/F32E-95B4/Music'
    fi
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