#!/bin/bash

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | tee /etc/apt/sources.list.d/azure-cli.list
apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
apt-get install -y apt-transport-https
# update package lists so we get the Microsoft packages (including azure-cli)
apt-get update
apt-get install -y azure-cli
