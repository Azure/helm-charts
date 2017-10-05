# Helm Charts for Kubernetes Service Catalog on Azure

[![CircleCI](https://circleci.com/gh/deis/service-catalog-charts.svg?style=svg&circle-token=e4d53fc2f20c9a1980668f69e314232a479a562c)](https://circleci.com/gh/deis/service-catalog-charts)

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
