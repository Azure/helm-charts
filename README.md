# Helm Charts for Kubernetes Service Catalog on Azure

[![CircleCI](https://circleci.com/gh/Azure/helm-charts.svg?style=svg&circle-token=e8c9c6863d2aac35c678888ca7346618be17aeb8)](https://circleci.com/gh/Azure/helm-charts)

# Overview

This repository contains [Helm](https://helm.sh/) charts for use with the
[Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog)
and the Microsoft Azure Service Broker.

Each chart has one or more dependencies on Azure services (e.g. Azure SQL, CosmosDB, ...)
which are fulfilled by the [Azure Service Broker](https://github.com/Azure/azure-service-broker) and
the [Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog) working
in tandem.

# Prerequisites

In order to install any of these charts, you'll need the following:

- A [Kubernetes](https://kubernetes.io) cluster, version 1.7 or above with support for
    Service Catalog. See 
    [service-catalog](https://github.com/Azure/helm-charts/tree/master/service-catalog) for
    more information on how to turn on support for aggregated APIs
- [Service Catalog](https://github.com/kubernetes-incubator/service-catalog), version 0.1.0 or above
    - [Installation documentation](https://github.com/kubernetes-incubator/service-catalog/blob/master/docs/install.md)
- [Azure Service Broker](https://github.com/Azure/azure-service-broker)
    - [Installation documentation](https://github.com/Azure/azure-service-broker/blob/master/contrib/k8s/charts/azure-service-broker/README.md)

# Installing Charts

All of the charts herein are stored in a 
[Helm chart repository](https://github.com/kubernetes/helm/blob/master/docs/chart_repository.md). 

First, add the Azure charts repository to your local list:

```console
helm repo add azure https://kubernetescharts.blob.core.windows.net/azure
```

After you've added the Azure charts repository, you'll have access to the charts you see here.
For example, you can search for charts:

```console
$helm search wordpress
NAME            	VERSION	DESCRIPTION
azure/wordpress 	0.6.12 	Web publishing platform for building blogs and ...
local/wordpress 	0.6.12 	Web publishing platform for building blogs and ...
stable/wordpress	0.6.10 	Web publishing platform for building blogs and ...
```

Notice that `azure/wordpress` is listed above. This is the chart that you see in this
Github repository.

# Creating a New Chart


If you are looking to create a chart, please see the list of with the `Help Wanted`
label [here](https://github.com/Azure/helm-charts/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22).

# Contributing

This project welcomes contributions and suggestions. All contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
