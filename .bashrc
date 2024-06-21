mkdir -p '/d/projects' && cd '/d/projects';

HISTFILESIZE=10000
HISTSIZE=10000
HISTTIMEFORMAT="%d.%m.%Y %H:%M:%S - "
HISTCONTROL=ignoreboth:erasedups
HISTFILE=${HOME}/.bash_history

shopt -s extglob
HISTIGNORE='history*:clear:exit:mkdir:cd@( *|):pwd:cls:clc:reload:qq:alias'

PROMPT_COMMAND='history -a'

SCRIPTS_DIR='/d/system/scripts/'

if [ -d ${HOME}/git_scripts ]; then
    source ${HOME}/git_scripts/git-completion.bash
    source ${HOME}/git_scripts/git-prompt.sh

    GIT_PS1_SHOWDIRTYSTATE=1
    PS1='\n\[\e[32m\]\u\[\e[33m\]:[\W] \[\e[38;5;219m\]$MSYSTEM\[\e[38;5;51m\]`__git_ps1`\[\e[0m\]\n-> '
else 
    PS1='\n\[\e[32m\]\u\[\e[33m\]:[\W] \[\e[38;5;219m\]$MSYSTEM\[\e[0m\]\n-> '
fi

if [ -f ${HOME}/.bash_aliases ]; then
    source ${HOME}/.bash_aliases
fi

if [ -f ${HOME}/.git_aliases ]; then
    source ${HOME}/.git_aliases
fi