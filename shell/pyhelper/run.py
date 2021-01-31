#!/bin/python3
#-*-coding: utf-8-*-

import sys
import time
import argparse
import subprocess

_parser = argparse.ArgumentParser(prog = 'run', description = 'a simple wrapper for running commands repeatly')

_parser.add_argument('-t', '--times', dest = 'times', type = int, metavar = 'N', default = 1, help = 'times to be executed')
_parser.add_argument('-c', '--command', dest = 'cmds', action = 'append', metavar = "CMD", help = 'one command after per this option')
_parser.add_argument('-e', '--exit-on-failed', action = 'store_true', help = 'exit or not if command failed')

def _echo_separator(proc_stat: bool, counter: int):
    sep = '\n============================[{}] [{}]: run for {} time(s)============================\n'
    if proc_stat:
        sep = sep.format(time.strftime(r'%Y/%m/%d-%H:%M:%S', time.localtime()), 'T', counter)
    else:
        sep = sep.format(time.strftime(r'%Y/%m/%d-%H:%M:%S', time.localtime()), 'F', counter)

    return sep

def run(parsed: argparse.Namespace):
    stat_of_proc = True                 # False for failed
    for i in range(parsed.times):
        stat_of_proc = True             # reset the flags
        for cmd in parsed.cmds:
            cmd = cmd.split(' ')
            result = subprocess.run(cmd)
            if result.returncode != 0 or not stat_of_proc:
                stat_of_proc = False

        print(_echo_separator(stat_of_proc, i))
        if not stat_of_proc and parsed.exit_on_failed:
            sys.exit(-1)

if __name__ == '__main__':
    args = _parser.parse_args(sys.argv[1:])
    run(args)

# EOF
