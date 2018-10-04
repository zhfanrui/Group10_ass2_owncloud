#!/bin/bash
#

# run WITHOUT sudo!

# colours
COLOR_INFO='\033[0;36m'
COLOR_SUCCESS='\033[0;32m'
COLOR_ERROR='\033[0;31m'
COLOR_END='\033[0m'

# help message
usage() {
    printf "${COLOR_INFO}Usage${COLOR_END}: bash run.sh [project_id] [password] [database_host] [nfs_host]\n"
    echo "This script doesn't create a new instance on GCP, and automatically installs Gogs."
    echo "Please note, you cannot run this script as sudo (root user)."
}
if [ "$1" == "--help" ]; then
    usage
    exit
fi

# checks that the user is not root, root has UID of 0
if [ "$EUID" -eq 0 ]; then
    echo ""
    printf "${COLOR_ERROR}Error${COLOR_END}: please do not run this script as root.\n"
    exit
fi

# added check for project_id & password. Without these, it will not work.
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo ""
    printf "${COLOR_ERROR}Error${COLOR_END}: project_id and password arguments are required!\n"
    echo "Please retry using sh ./run.sh <project_id> <password> <database_host> <nfs_host>"
    exit
fi

project_id=$1
password=$2
database=$3
nfs=$4

# install latest version ansible
sudo bash -c 'echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt-get update
sudo apt-get install ansible -y --allow-unauthenticated

# generate ssh key
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa

# run play book
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook main.yml --extra-vars "project_id=$project_id password=$password database=$database_hostse nfs=$nfs"
