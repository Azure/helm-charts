# Service Catalog

Service Catalog is a Kubernetes Incubator project that provides a
Kubernetes-native workflow for integrating with 
[Open Service Brokers](https://www.openservicebrokerapi.org/) 
to provision and bind to application dependencies like databases, object
storage, message-oriented middleware, and more.

It is a pre-requisite for all of the Helm charts in this repository.

For more information, 
[visit the project on github](https://github.com/kubernetes-incubator/service-catalog).

To install Service Catlaog, you must have a Kubernetes 1.7 cluster with support for 
[aggregated APIs](https://kubernetes.io/docs/concepts/api-extension/apiserver-aggregation/) 
turned on. See below for instructions for configuring your Kubernetes cluster via
various tools.

# Creating your Kubernetes Cluster

## ACS Engine

If you are using [acs-engine](https://github.com/Azure/acs-engine) to install a cluster, run
the following command from this directory:

```console
acs-engine deploy \
    --subscription-id $SUB_ID \
    --dns-prefix svc-cat-test \
    --location westus2 \
    --auto-suffix \
    --api-model docs/service-catalog/acs-engine-kubernetes-config.json
```

_Note: make sure you update `keyData` and `servicePrincipalProfile` in the 
given `acs-engine-kubernetes-config.json` file_

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

## Minikube

If you are using [Minikube](https://github.com/kubernetes/minikube), ensure that you
are using version [v0.22.0](https://github.com/kubernetes/minikube/releases/tag/v0.22.0) or
above, and simply execute the following to start your Kubernetes cluster:


```console
minikube start --extra-config=apiserver.Authorization.Mode=RBAC
```

## Azure Container Service (AKS)

Currently, AKS does not fully support aggregated APIs, which are required for 
service-catalog installation.

Support is forthcoming, and this document will be updated when aggregated APIs 
are supported.

# Installing Service Catalog

After the command exits successfully, you'll need to install Service Catalog.

Do so according to the
[installation documentation](https://github.com/kubernetes-incubator/service-catalog/blob/master/docs/install.md).

## A Note on Helm

`acs-engine` will install and configure Helm for you automatically, but other
installation tools like Minikube may not.

If you don't have Helm installed already, you'll need to do it yourself. The
process, however, is easy.

Simply run the following commands:

```console
helm init --service-account tiller
kubectl create -f docs/service-catalog/helm-rbac-config.yaml
```

