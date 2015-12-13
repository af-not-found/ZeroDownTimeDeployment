#!/bin/bash

set -eu

echo my-version=`date '+%Y_%m%d_%H%M_%S'` > /var/zdtd/ZeroDownTimeDeployment/src/main/resources/application.properties

cd /var/zdtd/ZeroDownTimeDeployment/

mvn clean install spring-boot:repackage -Dmaven.test.skip=true

cp -f /var/zdtd/ZeroDownTimeDeployment/target/zdtd.jar /var/zdtd/zdtd-next.jar
