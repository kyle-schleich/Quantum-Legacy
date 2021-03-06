#!/bin/bash

# Expects to be ran with the ip/host of the target.
if ! [ $1 ]; then
    echo Expects a destination as argument
fi

# Change things that can't be set before the central server is setup.
# This will be done by the deploy script/pre deploy per honeypot
# as apposed to at the deploy of the server.
sed -i "/  hosts: \[\"\"\]/s/.*/  hosts: [\"${CENTRAL_IP}\"]/g" ./client/filebeat/filebeat.yml

rsync -r -e "ssh" ./client root@$1:/opt

ssh root@$1 bash /opt/client/deploy_client.sh
