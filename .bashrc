mkdir -p '/d/projects' && cd '/d/projects';

HISTFILESIZE=10000
HISTSIZE=10000
HISTTIMEFORMAT="%d.%m.%Y %H:%M:%S - "
HISTCONTROL=ignoreboth:erasedups
HISTFILE=${HOME}/.bash_history

shopt -s extglob
HISTIGNORE='ls@( *|):history*:clear:exit:mkdir:cd@( *|):pwd:cls:clc:relbrc*'

PROMPT_COMMAND='history -a'

source ${HOME}/git_scripts/git-completion.bash
source ${HOME}/git_scripts/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
PS1='\n\[\e[32m\]\u\[\e[33m\]:[\W]\[\033[36m\]`__git_ps1`\[\e[0m\]\n-> '

if [ -f ${HOME}/.bash_aliases ]; then
    source ${HOME}/.bash_aliases
fi