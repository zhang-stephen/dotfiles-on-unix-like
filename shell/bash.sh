########################################################################################
#
# user-defined bash configuration for working effciency
#
########################################################################################

function get_current_git_branch()
{
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# DIY the CLI prompt
export PS1="\u@\H [\w] [\A] \$(get_current_git_branch) \n-> % "

# EOF
