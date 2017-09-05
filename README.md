# Helm Charts for Kubernetes Service Catalog on Azure

This repository contains [Helm](https://helm.sh/) charts for use with the
[Kubernetes Service Catalog](https://github.com/kubernetes-incubator/service-catalog)
and the Microsoft Azure Service Broker.

Each chart has one or more dependencies on Azure services (e.g. Azure SQL, CosmosDB, ...)
which it fulfills with the Kubernetes Service Catalog.

Please see [here](https://github.com/kubernetes-incubator/service-catalog) for more detail
on the Service Catalog project.

If you are looking to create a chart, please see 
[our Github Project](https://github.com/deis/service-catalog-charts/projects/1) for a
prioritized list of charts to create.
