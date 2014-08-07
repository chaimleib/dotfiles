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
    return result

def show_file(file, opts=None):
    if opts is None:
        opts = {}
    plist = pll.readPlist(file)
    pprint(plist)

main(sys.argv)

