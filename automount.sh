#!/bin/bash

INSTALL=$1

mountpoint -q $INSTALL/proc

if [ $? -eq 1 ]; then
echo "Chroot system not mounted. Mounting."
cat <<EOT>> /etc/fstab
/proc $INSTALL/proc none rbind 0 0 # Can just be mounted, comments?
/dev $INSTALL/dev none rbind 0 0 # Good thing to do, but not secure.
/sys $INSTALL/sys none rbind 0 0 # Same as proc?
/tmp $INSTALL/tmp none rbind 0 0 # This opens a lot of doors, namly X sockets are here... DRI should work assuming bits match.
/media $INSTALL/media none rbind 0 0 # Your USB stick.
/var/run/dbus/ $INSTALL/var/run/dbus/ none rbind 0 0 # Gnome likes this.
EOT
    mount -a
else
    echo "Chroot system already mounted. Do nothing."
fi
