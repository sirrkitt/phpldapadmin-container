#!/bin/sh

set -e

/usr/sbin/unitd --control unix:/var/run/control.unit.sock

while [ ! -S /var/run/control.unit.sock ]; do echo "$0: Waiting for control socket to be created..."; /bin/sleep 0.1; done
/usr/bin/curl -s -X GET --unix-socket /var/run/control.unit.sock http://localhost/

curl -X PUT --data-binary @/config.json --unix-socket /var/run/control.unit.sock http://localhost/config
kill -TERM `/bin/cat /var/run/unit.pid`
while [ -S /var/run/control.unit.sock ]; do echo "$0: Waiting for control socket to be removed..."; /bin/sleep 0.1; done

if [ ! -e /config/config.php ]
then
        cp /config.php.example /config/config.php
fi

ln -s /config/config.php /www/config/config.php

exec /usr/sbin/unitd --no-daemon --control unix:/var/run/control.unit.sock
