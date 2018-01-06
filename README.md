# Helm charts for Kubernetes Service Catalog on Azure

[![CircleCI](https://circleci.com/gh/Azure/helm-charts.svg?style=svg&circle-token=e8c9c6863d2aac35c678888ca7346618be17aeb8)](https://circleci.com/gh/Azure/helm-charts)

This repository contains [Helm](https://helm.sh/) charts for use with the
[Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog)
and
[Microsoft Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure).

| 🚨  | The project is in **alpha** status. This means that no assurances are made about backwards compatibility or stability until [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure) has reached v1. |
|---|---|

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

You'll need a [Kubernetes](https://kubernetes.io) cluster, version 1.7 or later,
with [Service Catalog](https://github.com/kubernetes-incubator/service-catalog)
and [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure)
installed on it.

Please see the [prerequisities guide](./docs/prerequisities/README.md) for
details on how to install all of these prerequisities.

## Installing charts

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

## Creating a new chart

If you have an idea for an application you'd like to see in this repository,
we'd love to see it! We welcome all pull requests.

If you're looking for some ideas for charts to write, we have a list of interesting
ones under the
[`Help Wanted`](https://github.com/Azure/helm-charts/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22)
label in our issues list.

Please follow these guidelines when creating your new chart:

- Look at the [upstream charts repository](https://github.com/kubernetes/charts) for prior art
- Wherever possible, ensure that your chart has the option to install the service to be
provisioned locally, in the cluster
    - For example, if your chart provisions Azure MySQL, ensure that the chart can be
    installed with the option to create a MySQL instance in the cluster. The default should
    be to provision on Azure
- Include a detailed README.md and NOTES.txt file for your chart
    - Example [README.md](./wordpress/README.md) and [NOTES.txt](./wordpress/templates/NOTES.txt)

## Contributing

For details on how to contribute to this project, please see [contributing.md](./docs/contributing.md).

This project welcomes contributions and suggestions. All contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
