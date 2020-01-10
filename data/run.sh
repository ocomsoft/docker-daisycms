#!/bin/bash
export DAISY_HOME=/daisy/daisy-2.4.2
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-oracle-x64

/usr/bin/mysqld_safe &
sleep 10s

echo Starting Repo
$DAISY_HOME/repository-server/bin/daisy-repository-server /daisy/repo &
sleep 30s

echo Starting Wiki
$DAISY_HOME/daisywiki/bin/daisy-wiki /daisy/wiki
# Wait for this to exit to stop the container
