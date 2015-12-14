#!/bin/bash

set -eu

ln -f /var/zdtd/zdtd-next.jar /var/zdtd/zdtd-8081.jar

/etc/init.d/zdtd-8081 start
echo "starting 8081, sleeping 30sec..."
sleep 30s;

/etc/init.d/zdtd-8080 stop
echo "stopping 8080, sleeping 10sec..."
sleep 10s;

ln -f /var/zdtd/zdtd-next.jar /var/zdtd/zdtd-8080.jar
/etc/init.d/zdtd-8080 start
echo "starting 8080, sleeping 30sec..."
sleep 30s;

/etc/init.d/zdtd-8081 stop
mv /var/zdtd/zdtd-next.jar /var/zdtd/zdtd-current.jar
echo "finished."
