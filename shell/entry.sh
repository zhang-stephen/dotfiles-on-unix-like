########################################################################################
#
# the entry of shell configurations
#
########################################################################################

parent_dir=$(dirname $BASH_SOURCE)

if [[ $SHELL =~ 'bash' ]]; then
    # for bash
    source $parent_dir/bash.sh
elif [[ $SHELL =~ 'zsh' ]]; then
    # for z shell
    source $parent_dir/zsh.sh
fi


# EOF
