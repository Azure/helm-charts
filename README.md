
## **This repo is no longer being actively maintained. We recommend that you look at the [Bitnami Helm charts repo](https://github.com/bitnami/charts) instead.**

# Helm Charts for Kubernetes Service Catalog on Azure

This repository contains [Helm](https://helm.sh/) charts for use with the
[Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog)
and
[Microsoft Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure).

Each chart has one or more dependencies on Azure services (e.g. Azure SQL, CosmosDB, ...)
which are fulfilled by [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure) and
the [Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog) working
in tandem.

The following charts are available:

- [Concourse CI](./concourse)
- [Drupal](./drupal)
- [Ghost Blog](./ghost)
- [phpBB](./phpbb)
- [Wordpress](./wordpress)

## Prerequisites

You'll need a [Kubernetes](https://kubernetes.io) cluster, version 1.9 or later,
with [Service Catalog](https://github.com/kubernetes-incubator/service-catalog)
and [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure)
installed on it.

Please see the [prerequisities guide](./docs/prerequisities/README.md) for
details on how to install all of these prerequisities.

## Installing Charts

All of the charts herein are stored in a
[Helm chart repository](https://github.com/kubernetes/helm/blob/master/docs/chart_repository.md).

First, add the Azure charts repository to your local list:

```console
helm repo add azure https://kubernetescharts.blob.core.windows.net/azure
```

After you've added the Azure charts repository, you'll have access to the charts you see here.
For example, you can search for charts:

```console
$ helm search wordpress
NAME            	VERSION	DESCRIPTION
azure/wordpress 	0.6.12 	Web publishing platform for building blogs and ...
local/wordpress 	0.6.12 	Web publishing platform for building blogs and ...
stable/wordpress	0.6.10 	Web publishing platform for building blogs and ...
```

The `azure/wordpress` chart shown in the output above is the chart that you see in this Github repository.