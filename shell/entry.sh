########################################################################################
#
# the entry of shell configurations
#
########################################################################################

parent_dir=$(dirname $BASH_SOURCE)

# user's prompt
if [[ $SHELL =~ 'bash' ]]; then
    # for bash
    source $parent_dir/bash.sh
elif [[ $SHELL =~ 'zsh' ]]; then
    # for z shell
    source $parent_dir/zsh.sh
fi

# user's alias
source $parent_dir/alias.sh

# followings are user-defined command with shell/python3
source $parent_dir/run.sh

# EOF
