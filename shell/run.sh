########################################################################################
#
# a simple script to provide a command to run commands repeatly
#
########################################################################################
function run()
{
    parent_dir=$(dirname $(readlink -f $BASH_SOURCE))

    if [[ $# -eq 0 ]]; then
        python3 $parent_dir/pyhelper/run.py -h
    else
        python3 $parent_dir/pyhelper/run.py $@ 
    fi
}

# EOF

