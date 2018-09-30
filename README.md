# Group10_ass2_owncloud

## Machines and steps

1. Create all the instances (including firewall rules and disks) and store all the ip address in a runtime inventory file (can be accessed by a module).
3. Setup database
    - mysql
2. Setup nfs-server.
    - php
    - owncloud (/var/www/owncloud)
    - xfsprogs
    - glusterfs-server
4. Setup 2 web servers.
    - apache
    - php
    - glusterfs-client
5. Setup loadbalancer
    - nginx
