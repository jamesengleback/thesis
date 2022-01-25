#!/usr/bin/env python
import re
import sys


def rep_hypertgt(data):
    p = '\\\\hypertarget{.+}{%'
    return re.sub(p, '', data)

def rep_title_labels(data):
    p = '\\\\label{.+}'
    return re.sub(p, '', data)

FNS = [
      rep_hypertgt,
      ]

def fns(data):
    for fn in FNS:
        _data = fn(data)
    return _data

def main():
    with open('_thesis.tex','r') as f:
        data = f.read()

    output = fns(data)
    sys.stdout.write(output)

if __name__ == '__main__':
    main()
