# Prerequisites

In order to use the charts in this repository, you must have the following components installed:

1. A compatible [Kubernetes](https://github.com/kubernetes/kubernetes) cluster 
(version 1.9 or later)
1. [Helm](https://github.com/kubernetes/helm)
1. [Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog)
1. [Open Service Broker for Azure](https://github.com/azure/open-service-broker-azure)

This document describes how to install all these pre-requisities.

# Step 1: Create a Compatible Kubernetes Cluster

Please choose your preferred Kubernetes installation method below.

## Minikube

Some older versions of Minikube, as well as some newer ones, suffer from bugs
that can be worked around, but only with moderate effort. We therefore
recommend that if you are using Minikube that you use [v0.25.2](https://github.com/kubernetes/minikube/releases/tag/v0.25.2).


```console
minikube start --extra-config=apiserver.Authorization.Mode=RBAC
```

After your Minikube cluster starts, execute the following:

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

## Azure Kubernetes Service (AKS)

If you would like to use Service Catalog and Open Service Broker for Azure with
AKS, create a cluster as outlined in the AKS [quickstart](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough).

# Step 2: Initialize Helm on the Cluster

Installing Service Catalog and Open Service Broker for Azure is accomplished 
using Helm. If you created your Kubernetes cluster using `acs-engine` in the previous step,
Helm is already installed. However, you may need to upgrade the Tiller 
component. To check the version, use the `helm version` command. You need 
helm version `2.7.0` or later in order to install Service Catalog and Open
Service Broker for Azure. If you need to upgrade Helm, you can upgrade Tiller
by executing the following command:

```console
helm init --upgrade
```

Otherwise, you'll need to install the Helm componentry onto your cluster
yourself. 

If you are using AKS or Minikube, run the following commands to complete the installation:

```console
kubectl create -f https://raw.githubusercontent.com/Azure/helm-charts/master/docs/prerequisities/helm-rbac-config.yaml
helm init --service-account tiller
```

# Step 3: Install Service Catalog

After you've successfully installed your Kubernetes cluster and installed Helm, 
you'll need to install Service Catalog.

To install Service Catalog, execute the following commands:

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
[installation instructions for Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure/tree/master/contrib/k8s/charts/open-service-broker-azure).
