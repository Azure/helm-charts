#!/bin/bash

# About
#
# This script installs the Azure CLI. It copies the steps from the following link:
#
# https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
#
# under the "Install with apt package manager" section

# first do an update and install apt-transport-https
apt-get update
apt-get install -y apt-transport-https

# the add keys for the MSFT apt repo
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | tee /etc/apt/sources.list.d/azure-cli.list
apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893

# then update again and install azure-cli
apt-get update
apt-get install -y azure-cli
