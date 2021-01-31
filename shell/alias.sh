########################################################################################
#
# Useful alias of some commands, only for unix-like
#
########################################################################################

# @brief    determin if a command exists
# @param    a string, the exeutable filename
# @retval   0 -> exist and 1 -> not exist
# @note     None
function has_cmd()
{
    # set the sperator as ':'
    IFS=':'

    # traverse, return 0 if cmd exists
    for p in $PATH; do
        if [[  -x $p/$1 ]]; then
            return 0
        fi
    done

    return 1
}

########################################################################################
# basic alias of bulit-in commands
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias lx='ls -ahil'

########################################################################################
# extended alias of 3rd-party commands

has_cmd git
if [[ $? -eq 0 ]]; then
    has_cmd fzf
    if [[ $? -eq 0 ]]; then
        alias gck='git checkout $(git branch | fzf)'
    fi
fi

has_cmd bat
if [[ $? -eq 0 ]]; then
    alias cat='bat'
fi

has_cmd tmux
if [[ $? -eq 0 ]]; then
    alias tnw='tmux new-window'
fi

has_cmd htop
if [[ $? -eq 0 ]]; then
    alias htop='htop -t'
fi

# EOF
