#!/bin/bash

#####
# download the helm CLI & initialize the helm dir
#####
HELM_URL=https://storage.googleapis.com/kubernetes-helm
HELM_TARBALL=helm-v2.5.1-linux-amd64.tar.gz
STABLE_REPO_URL=https://kubernetes-charts.storage.googleapis.com/
INCUBATOR_REPO_URL=https://kubernetes-charts-incubator.storage.googleapis.com/
wget -q ${HELM_URL}/${HELM_TARBALL}
tar xzfv ${HELM_TARBALL}

cp ./linux-amd64/helm /usr/local/bin/helm
helm init --client-only
