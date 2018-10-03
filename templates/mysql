#!/bin/sh

DB_HOST="@host"
DB_NAME="owncloud"
DB_USER="owncloud"
DB_PASS="@password"

BIN_DIR="/usr/bin"
BCK_DIR="/root/mysql_dump/data"
DATE=`date +%Y%m%d_%H%M%S`

mkdir -p $BCK_DIR
$BIN_DIR/mysqldump -u$DB_USER -p$DB_PASS -h$DB_HOST --databases $DB_NAME | gzip> $BCK_DIR/$DB_NAME.dump_$DATE.gz

find $BCK_DIR -mmin +5 -name "*.gz" -exec rm -rf {} \;
echo "========== BACKUP SUCCESSFUL =========="

