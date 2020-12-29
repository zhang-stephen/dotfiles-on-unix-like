#!/bin/python3]
#-*-coding: utf-8-*-

import platform, re

__all__ = ['get_platform', 'Stack']

def get_platform() -> str:
    pf = platform.platform()

    if re.search(r'(?i)cygwin|mingw|linux|bsd', pf):
        _type = 'Unix-like'
    elif re.search(r'(?i)windows', pf):
        _type = 'WinNT'
    else:
        _type = 'Unknown'

    return _type

# A simple implementation of Stack, for json pre-order traversing
class Stack:
    def __init__(self): self._true_storage = []

    def push(self, val): self._true_storage.append(val)

    def pop(self):
        if self.depth()  > 0:
            return self._true_storage.pop()

    def drop(self): self.pop()

    def top(self): return self._true_storage[-1]

    def depth(self): return len(self._true_storage)

