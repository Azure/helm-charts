# Prerequisites

In order to use the charts in this repository, you must have the following components installed:

1. A compatible [Kubernetes](https://github.com/kubernetes/kubernetes) cluster 
(version 1.7 or later)
1. [Helm](https://github.com/kubernetes/helm)
1. [Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog)
1. [Open Service Broker for Azure](https://github.com/azure/open-service-broker-azure)

This document describes how to install all these pre-requisities.

# Step 1: Create a Compatible Kubernetes Cluster

Please choose your preferred Kubernetes installation method below.

## Minikube

If you are using [Minikube](https://github.com/kubernetes/minikube), ensure that you
are using version [v0.22.0](https://github.com/kubernetes/minikube/releases/tag/v0.22.0) or
above, and simply execute the following to start your Kubernetes cluster:


```console
minikube start --extra-config=apiserver.Authorization.Mode=RBAC
```

Note: If you're using 
[v0.23.0](https://github.com/kubernetes/minikube/releases/tag/v0.23.0),
execute the following after you install Minikube:

```console
kubectl create clusterrolebinding cluster-admin:kube-system \
       --clusterrole=cluster-admin \
       --serviceaccount=kube-system:default
```


## ACS Engine

If you are using [acs-engine](https://github.com/Azure/acs-engine) to install a cluster, run
the below command from the root of this repository.

_Note: make sure you update `keyData` and `servicePrincipalProfile` in the 
given `acs-engine-kubernetes-config.json` file_

```console
acs-engine deploy \
    --subscription-id $SUB_ID \
    --dns-prefix $DNS_PREFIX \
    --location westus2 \
    --auto-suffix \
    --api-model docs/service-catalog/acs-engine-kubernetes-config.json
```

In the above command, `SUB_ID` is the ID for your Azure subscription and `DNS_PREFIX` is 
a unique string that will prefix all cluster related DNS entries (to avoid collisions 
with other clusters).

This command will generate a series of Kubernetes configuration files, named
according to the Azure region. Choose the one named for the region into which
you installed your cluster (by default, the new cluster will be installed
into the subscription's default region) and merge it into your
standard kubeconfig file.

Here's an easy way to do that merge:

```console
KUBECONFIG=$KUBECONFIG_PATH:_output/$CLUSTER_NAME/kubeconfig/kubeconfig.$REGION.json \
    kubectl config view --flatten > $KUBECONFIG_PATH
```

## Azure Container Service (AKS)

Currently, AKS does not support aggregated APIs, which are required for 
service-catalog installation.

Support is forthcoming, and this document will be updated when aggregated APIs 
are supported.

# Step 2: Initialize Helm on the Cluster

If you created your Kubernetes cluster using `acs-engine` in the previous step, Helm
is already installed and you can skip this section.

Otherwise, you'll need to install the Helm componentry onto your cluster 
yourself. Simply run the following commands to complete the installation:

```console
kubectl create -f https://raw.githubusercontent.com/Azure/helm-charts/master/docs/prerequisities/helm-rbac-config.yaml
helm init --service-account tiller
helm init --upgrade
```

# Step 3: Install Service Catalog

After you've successfully installed your Kubernetes cluster and installed Helm, 
you'll need to install Service Catalog.

Do so by executing the following command:

```console
helm repo add svc-cat https://svc-catalog-charts.storage.googleapis.com
helm install svc-cat/catalog --name catalog --namespace catalog
```

_If you'd like a more advanced installation, see the 
[Service Catalog installation documentation](https://github.com/kubernetes-incubator/service-catalog/blob/master/docs/install.md)._

# Step 4: Install Open Service Broker For Azure

After you've successfully installed service catalog, you'll need to install
[Open Service Broker for Azure](https://github.com/azure/open-service-broker-azure).

To do so, please follow the 
[installation instructions for Open Service Broker for Azure](https://github.com/Azure/helm-charts/tree/master/open-service-broker-azure).
