import argparse
import sys
import os
from typing import Dict

def parse_args() -> Dict[str, any]:
    parser = argparse.ArgumentParser(description='Synchronization files between local storage and external HDD')
    group = parser.add_mutually_exclusive_group()
    group.add_argument('-d', '--download', action='store_true', help='Synchronization of VMs with external storage')
    group.add_argument('-u', '--upload', action='store_true', help='Synchronization of VMs with internal storage')

    args = vars(parser.parse_args())

    if len(sys.argv) == 1:
        parser.parse_args(['-h'])
    else:
        return args
    
def main() -> None:
    os.environ["PATH"] += os.pathsep + os.pathsep.join(["/cygdrive/c/Program Files/Oracle/VirtualBox/"])
    # print(os.environ["PATH"])
    args = parse_args()




main()