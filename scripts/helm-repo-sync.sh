#!/bin/bash

if [ -z "$AZURE_STORAGE_CONNECTION_STRING" ]; then
    echo "AZURE_STORAGE_CONNECTION_STRING env var required"
    exit 1
fi

#####
# set up the repo dir, and package up all charts
#####
AZURE_STORAGE_CONTAINER=azure
REPO_DIR=repo
mkdir -p $REPO_DIR
echo "entering $REPO_DIR"
cd $REPO_DIR
for dir in `ls ../..`;do
    if [ ! -f ../../$dir/Chart.yaml ];then
        echo "skipping $dir because it lacks a Chart.yaml file"
    else
        echo "packaging $dir"
        helm dep build ../../$dir
        helm package ../../$dir
    fi
done

#####
# upload packaged charts to Azure blob storage
#####

# AZURE_STORAGE_CONNECTION_STRING will be used for auth in the following command
echo "uploading packaged charts from $PWD"
az storage blob upload-batch \
  --source . \
  --destination $AZURE_STORAGE_CONTAINER

# attempt to acquire a lock on the container
az storage container lease acquire \
  --container-name $AZURE_STORAGE_CONTAINER \
  --lease-duration 60

# download the existing repo's index.yaml so that we can merge it later
echo "downloading existing index.yaml"
az storage blob download \
  --container-name $AZURE_STORAGE_CONTAINER \
  --name index.yaml \
  --file index.yaml

#####
# index the charts, merging with the old index.yaml so charts are versioned
#####
REPO_ROOT=https://kubernetescharts.blob.core.windows.net
helm repo index --url "$REPO_ROOT/$AZURE_STORAGE_CONTAINER" --merge index.yaml .

#####
# upload updated index to Azure blob storage
#####

# AZURE_STORAGE_CONNECTION_STRING will be used for auth in the following command
echo "uploading updated index from $PWD"
az storage blob upload \
  --container-name $AZURE_STORAGE_CONTAINER \
  --file index.yaml \
  --name index.yaml
