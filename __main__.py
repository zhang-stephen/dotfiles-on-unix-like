#!/bin/python3
#-*-coding: utf-8 -*-

import subprocess, json, sys
from pathlib import Path
from manager.HostsAssist import get_ip_from_domain
import manager.utility as util

PATH_OF_SELF = Path(__file__).absolute()
PLATFORM = util.get_platform()

class Action:
    def __init__(self, cmd: str = '', options: list = [], skipped = True):
        self.skipped = skipped
        self.operation = [cmd] + options        # for subprocess.run

    def run(self):
        if not self.skipped:
            return subprocess.run(self.operation)

class ProcessDependencies(Action):
    def __init__(self, cmd: str = '', options: list = [], skipped = True, identifier: str = None):
        super(ProcessDependencies, self).__init__(cmd, options, skipped)
        self.identifier = identifier

class SetupConfigs(Action):
    def __init__(self, cmd: str = '', options: list = [], skipped = True, identifier: str = None):
        super(SetupConfigs, self).__init__(cmd, options, skipped)
        self.identifier = identifier

class Preparing(Action):
    def __init__(self, cmd: str = '', options: list = [], skipped = True, identifier: str = None):
        super(Preparing, self).__init__(cmd, options, skipped)
        self.identifier = identifier

class PreTraversing:
    def __init__(self):
        self.urls_to_require_ip = []
        self.preparing = []
        self.setup_configs = []
        self.process_deps = []
        self.cache_of_keys = util.Stack()

    def traverse(self, src):
        for key, value in src:
            if isinstance(src, dict):
                self.traverse(value)
            else:
                pass
                # TODO: do another to get useful data

def main():
    # read the configuration via config.json
    with open(sys.argv[1], 'r', encoding = 'utf-8') as config:
        params = json.load(config)

if __name__ == '__main__':
    sys.exit(main())
