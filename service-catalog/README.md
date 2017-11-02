# Service Catalog

Service Catalog is a Kubernetes Incubator project that provides a
Kubernetes-native workflow for integrating with 
[Open Service Brokers](https://www.openservicebrokerapi.org/) 
to provision and bind to application dependencies like databases, object
storage, message-oriented middleware, and more.

For more information, 
[visit the project on github](https://github.com/kubernetes-incubator/service-catalog).

To install, you must have a Kubernetes 1.7 cluster with support for 
[aggregated APIs](https://kubernetes.io/docs/concepts/api-extension/apiserver-aggregation/) 
turned on. See below for instructions for configuring your Kubernetes cluster via
various tools.

# ACS Engine

If you are using [acs-engine](https://github.com/Azure/acs-engine) to install a cluster, run
the following command from this directory:

```console
acs-engine deploy \
    --subscription-id $SUB_ID \
    --dns-prefix svc-cat-test \
    --location westus2 \
    --auto-suffix \
    --api-model acs-engine-kubernetes-config.json
```

When your cluster becomes available, see the 
[service-catalog installation documentation](https://github.com/kubernetes-incubator/service-catalog/blob/master/docs/install.md).

# Minikube

If you are using [Minikube](https://github.com/kubernetes/minikube), ensure that you
are using version [v0.22.0](https://github.com/kubernetes/minikube/releases/tag/v0.22.0) or
above, and simply execute the following to start your Kubernetes cluster:


```console
minikube start --extra-config=apiserver.Authorization.Mode=RBAC
```

# Azure Container Service (AKS)

Currently, AKS does not fully support aggregated APIs. Support is forthcoming, and this
document will be updated when aggregated APIs are supported.
