import argparse
import sys
import os
import subprocess
from typing import Dict, List

def get_cmd_out(command: List[str]) -> subprocess.CompletedProcess:
    return subprocess.run(command, capture_output=True, text=True)

def run_cmd(command: List[str]) -> subprocess.CompletedProcess:
    return subprocess.run(command, stderr=sys.stderr, stdout=sys.stdout)

def get_list_vms() -> subprocess.CompletedProcess:
    cmd = ['VBoxManage', 'list', 'vms']

def parse_args() -> Dict[str, any]:
    parser = argparse.ArgumentParser(description='Synchronization VMs with local/external storage')
    group = parser.add_mutually_exclusive_group()
    group.add_argument('-d', '--download', action='store_true', help='Synchronization with external storage')
    group.add_argument('-u', '--upload', action='store_true', help='Synchronization with internal storage')
    group.add_argument('--list-vms', action='store_true', help='Lists all (VMs) that are currently registered with VirtualBox')

    args = vars(parser.parse_args())

    if len(sys.argv) == 1:
        parser.parse_args(['-h'])
    else:
        return args
    
def main() -> None:
    os.environ["PATH"] += os.pathsep + os.pathsep.join(["/cygdrive/c/Program Files/Oracle/VirtualBox/"])
    # print(os.environ["PATH"])

    args = parse_args()

    print(args)
    if args['list_vms']:
        get_list_vms()
        # print(get_list_vms().stdout)
        return
    

main()