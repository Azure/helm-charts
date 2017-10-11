#!/bin/bash

for dir in `ls ..`;do
    if [ ! -f ../$dir/Chart.yaml ];then
        echo "skipping directory '$dir' because it lacks a Chart.yaml file"
    # skip the meta-azure-service-broker-classic dir for now because its sql-server
    # dependency contains a 'fail' directive in its deployment.yaml that fails the
    # linter. See https://github.com/kubernetes/helm/issues/3026
    elif [ "$dir" == "meta-azure-service-broker-classic" ]; then
        echo "skipping the meta-azure-service-broker-classic dir"
    else
        echo "linting $dir"
        helm lint ../$dir
    fi
done
