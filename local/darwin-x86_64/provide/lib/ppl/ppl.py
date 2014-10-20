import plistlib as pll
import sys
from pprint import pprint


def main(argv):
    args = parse_args(argv)
    if 'file' in args:
        show_file(args['file'])
    else:
        print("No file provided!")

def parse_args(args):
    result = {}
    if len(args) == 2:
        result['file'] = args[1]
    elif len(args) == 1:
        result['file'] = sys.stdin
    return result

def show_file(file, opts=None):
    if opts is None:
        opts = {}
    plist = pll.readPlist(file)
    pprint(plist)

def show_string(str, opts=None):
    if opts is None:
        opts = {}
    plist = pll.readPlistFromString(str)
    pprint(plist)

main(sys.argv)

