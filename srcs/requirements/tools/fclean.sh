#!/bin/bash

volume_path="/home/dayun/data"
if [ "$(uname)" == "Darwin" ]; then
    volume_path="/Users/dayun/goinfree/docker_study/inception2/data"
fi
wordpress_path="${volume_path}/wordpress"
mariadb_path="${volume_path}/mariadb"

conf="127.0.0.1 dayun.42.fr"
hosts_path="/etc/hosts"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

rm -rf "$wordpress_path" "$mariadb_path"

sed -i.bak "/${conf}/d" "$hosts_path" 2>/dev/null || \
sed -i "/${conf}/d" "$hosts_path"

echo -e "--------------------"
echo -e "${GREEN}@fclean done${NC}"
echo -e "--------------------"