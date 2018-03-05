# Ghost

[Ghost](https://ghost.org/) is one of the most versatile open source content management systems on the market.

This chart bootstraps a [Ghost](https://github.com/bitnami/bitnami-docker-ghost) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It is inspired by the 
[upstream ghost chart](https://github.com/kubernetes/charts/tree/master/stable/ghost), but, by default, utilizes Open Service Broker For Azure to provision an [Azure Database for MySQL](https://azure.microsoft.com/en-us/services/mysql/) database for the Ghost server to use.

# Basic Installation

Installation of this chart is simple. First, ensure that you've [added the
`azure` repository](../README.md#installing-charts). Then, install from the `azure` repo:

```console
$ helm install azure/ghost
```

# Prerequisites

To install this chart, you must have:

- Kubernetes 1.7+ with beta APIs enabled
- [Service-Catalog](https://github.com/kubernetes-incubator/service-catalog) installed
- [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure) version v0.9.0-alpha or later installed
- PV provisioner support in the underlying infrastructure

Please see the [prerequisities document](https://github.com/Azure/helm-charts/blob/master/docs/prerequisities/README.md) for details on how to install everything.

## Installing the Chart

To install the chart with the release name `my-release` in the namespace `ghost`:

```console
$ helm install --name my-release --namespace ghost azure/ghost
```

The command deploys Ghost on the Kubernetes cluster in the default 
configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

You also may want to use the `--purge` command line flag to delete the release
name from the helm deployments list.

## Configuration

The following tables lists the configurable parameters of the Ghost chart and their default values.

| Parameter                         | Description                                           | Default                                                   |
| --------------------------------- | ----------------------------------------------------- | --------------------------------------------------------- |
| `image`                           | Ghost image                                           | `bitnami/ghost:{VERSION}`                                 |
| `imagePullPolicy`                 | Image pull policy                                     | `Always` if `image` tag is `latest`, else `IfNotPresent`  |
| `ghostHost`                       | Ghost host to create application URLs                 | `nil`                                                     |
| `ghostPort`                       | Ghost port to create application URLs along with host | `80`                                                      |
| `ghostLoadBalancerIP`             | `loadBalancerIP` for the Ghost Service                | `nil`                                                     |
| `ghostUsername`                   | User of the application                               | `user@example.com`                                        |
| `ghostPassword`                   | Application password                                  | Randomly generated                                        |
| `ghostEmail`                      | Admin email                                           | `user@example.com`                                        |
| `ghostBlogTitle`                  | Ghost Blog name                                       | `User's Blog`                                             |
| `mysql.embeddedMaria`             | Whether to fulfill the dependency on MySQL using an embedded (on-cluster) MariaDB database _instead of Azure Database for MySQL_. This option is available to enable local or no-cost evaluation of this chart.                    | `false`                                                   |
| `serviceType`                     | Kubernetes Service type                               | `LoadBalancer`                                            |
| `persistence.enabled`             | Enable persistence using PVC                          | `true`                                                    |
| `persistence.storageClass`        | PVC Storage Class for Ghost volume                    | `nil` (uses alpha storage annotation)                     |
| `persistence.accessMode`          | PVC Access Mode for Ghost volume                      | `ReadWriteOnce`                                           |
| `persistence.size`                | PVC Storage Request for Ghost volume                  | `8Gi`                                                     |
| `resources`                       | CPU/Memory resource requests/limits                   | Memory: `512Mi`, CPU: `300m`                              |

The following configuration options are utilized only if `mysql.embeddedMaria` is set to `false` (the default):

| Parameter                         | Description                                           | Default                                                   |
| --------------------------------- | ----------------------------------------------------- | --------------------------------------------------------- |
| `mysql.azure.location`            | The Azure region in which to deploy Azure Database for MySQL | `eastus`                                           |
| `mysql.azure.servicePlan`         | The plan to request for Azure Database for MySQL      | `standard100`                                             |

The following configuration options are utilized only if `mysql.embeddedMaria` is set to `true`:

| Parameter                         | Description                                           | Default                                                   |
| --------------------------------- | ----------------------------------------------------- | --------------------------------------------------------- |
| `mariadb.mariadbRootPassword`     | MariaDB admin password                                | `nil`                                                     |
| `mariadb.mariadbDatabase`         | Database name to create                               | `bitnami_ghost`                                           |
| `mariadb.mariadbUser`             | Database user to create                               | `bn_ghost`                                                |
| `mariadb.mariadbPassword`         | Password for the database                             | _random 10 character long alphanumeric string_            |

The above parameters map to the env variables defined in [bitnami/ghost](http://github.com/bitnami/bitnami-docker-ghost). For more information please refer to the [bitnami/ghost](http://github.com/bitnami/bitnami-docker-ghost) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example, for embedded MySQL,

```console
$ helm install azure/ghost \
  --name my-release \
  --namespace ghost \
  --set mysql.embeddedMaria=true \
  --set mariadb.mariadbRootPassword=Password12345 \
  --set mariadb.mariadbPassword=Password12
```

For example, for external MySQL,

```console
$ helm install azure/ghost \
  --name my-release \
  --namespace ghost
```

Alternatively, a YAML file that specifies the values for all the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release --namespace ghost -f values.yaml stable/ghost
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [Bitnami Ghost](https://github.com/bitnami/bitnami-docker-ghost) image stores the Ghost data and configurations at the `/bitnami/ghost` and `/bitnami/apache` paths of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, Azure, and minikube.
See the [Configuration](#configuration) section to configure the PVC or to disable persistence.
