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
    printf "${COLOR_INFO}Usage${COLOR_END}: bash restore.sh [database_host] [password] [file_dir]\n"
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
if [ -z "$1" ] || [ -z "$2" ]; then
    echo ""
    printf "${COLOR_ERROR}Error${COLOR_END}: project_id and password arguments are required!\n"
    echo "Please retry using sh ./run.sh <database_host> <password> <file_dir>"
    exit
fi

username="owncloud"
dbname="owncloud"
password=$1
database=$2
file_dir=$3

mysql -u$username -p$password -database_host $dbname < gzip -d file_dir
