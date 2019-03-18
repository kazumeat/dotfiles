# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# git settings
#source /usr/share/doc/git-1.7.1/contrib/completion/git-completion.bash
#GIT_PS1_SHOWDIRTYSTATE=true
#export PS1='\t \[\033[32m\]\u@\h\]\]\[\033[0;35m\]\]$(__git_ps1)\[\033[0;32m\]\$ '

# tmux settings
#export LD_LIBRARY_PATH=${HOME}/local/lib:$LD_LIBRARY_PATH

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
function promps {
    # 色は気分で変えたいかもしれないので変す宣言しておく
    local  BLUE="\[\e[1;34m\]"
    local  RED="\[\e[1;31m\]"
    local  GREEN="\[\e[1;32m\]"
    local  WHITE="\[\e[00m\]"
    local  GRAY="\[\e[1;37m\]"

    case $TERM in
        xterm*) TITLEBAR='\[\e]0;\W\007\]';;
        *)      TITLEBAR="";;
    esac
    local BASE="\u@\h"
    PS1="${TITLEBAR}${GREEN}${BASE}${WHITE}:${BLUE}\W${GREEN}\$(parse_git_branch)${BLUE}\$${WHITE} "
}
promps

source ~/.git-completion.bash

# init nvm
export NVM_DIR="${HOME}/.nvm"
export NVM_SYMLINK_CURRENT=true
