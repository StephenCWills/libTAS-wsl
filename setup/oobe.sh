#!/bin/bash

set -ue

DEFAULT_GROUPS='adm,cdrom,sudo,dip,plugdev'
DEFAULT_UID='1000'

echo 'Please create a default UNIX user account. The username does not need to match your Windows username.'
echo 'For more information visit: https://aka.ms/wslusers'

while true; do
    read -p 'Enter new UNIX username: ' username

    /usr/sbin/useradd -mu 1000 -s /bin/bash "$username" && \
        /usr/bin/passwd "$username" && \
        /usr/sbin/usermod "$username" -aG "$DEFAULT_GROUPS" && \
        break

    /usr/sbin/userdel -r "$username" 2> /dev/null
done

chmod 700 /mnt/wslg/runtime-dir

