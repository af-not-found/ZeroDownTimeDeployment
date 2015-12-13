#!/bin/bash

set -eu

cd /var/zdtd/ZeroDownTimeDeployment/

mvn clean install spring-boot:repackage -Dmaven.test.skip=true

cp -f /var/zdtd/ZeroDownTimeDeployment/target/zdtd.jar /var/zdtd/zdtd-next.jar

ln -f /var/zdtd/zdtd-next.jar /var/zdtd/zdtd-8081.jar

/etc/init.d/zdtd-8081 start

echo "starting 8081, sleeping 60sec"
sleep 60s;

/etc/init.d/zdtd-8080 stop

ln -f /var/zdtd/zdtd-next.jar /var/zdtd/zdtd-8080.jar

/etc/init.d/zdtd-8080 start

echo "starting 8080, sleeping 60sec"
sleep 60s;

/etc/init.d/zdtd-8081 stop

mv /var/zdtd/zdtd-next.jar /var/zdtd/zdtd-current.jar

