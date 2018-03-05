# phpBB

[phpBB](https://www.phpbb.com/) is an Internet forum package written in the PHP scripting language. The name "phpBB" is an abbreviation of PHP Bulletin Board.

This chart bootstraps a 
[phpBB](https://github.com/bitnami/bitnami-docker-phpbb) deployment on 
a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh)
 package manager.

It is inspired by the 
[upstream phpBB chart](https://github.com/kubernetes/charts/tree/master/stable/phpbb),
but, by default, utilizes Open Service Broker For Azure to provision an 
[Azure Database for MySQL](https://azure.microsoft.com/en-us/services/mysql/) 
database for the Wordpress server to use.

# Basic Installation

Installation of this chart is simple. First, ensure that you've added the azure repository. Then, install from the Azure repo:

```console
$ helm install azure/phpbb
```

# Prerequisites

To install this chart, you must have:

- Kubernetes 1.7+ with beta APIs enabled
- [Service-Catalog](https://github.com/kubernetes-incubator/service-catalog) installed
- [Open Service Broker for Azure](https://github.com/Azure/open-service-broker-azure) version v0.9.0-alpha or later installed
- PV provisioner support in the underlying infrastructure

For details on setting up these prerequisites, please see the [prerequisites doc](https://github.com/Azure/helm-charts/tree/master/docs/prerequisities)

## Installing the Chart

To install the chart with the release name `my-release` in the namespace phpbb:

```console
$ helm install --name my-release --namespace phpbb azure/phpbb
```

The command deploys phpBB on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the phpBB chart and their default values.

|             Parameter             |              Description              |                         Default                         |
|-----------------------------------|---------------------------------------|---------------------------------------------------------|
| `image`                           | phpBB image                           | `bitnami/phpbb:{VERSION}`                               |
| `imagePullPolicy`                 | Image pull policy                     | `IfNotPresent`                                          |
| `phpbbUser`                       | User of the application               | `user`                                                  |
| `phpbbPassword`                   | Application password                  | _random 10 character long alphanumeric string_          |
| `phpbbEmail`                      | Admin email                           | `user@example.com`                                      |
| `smtpHost`                        | SMTP host                             | `nil`                                                   |
| `smtpPort`                        | SMTP port                             | `nil`                                                   |
| `smtpUser`                        | SMTP user                             | `nil`                                                   |
| `smtpPassword`                    | SMTP password                         | `nil`                                                   |                                                 |
| `mysql.embeddedMaria`             | Whether to fulfill the dependency on MySQL using an embedded (on-cluster) MariaDB database _instead of Azure Database for MySQL_. This option is available to enable local or no-cost evaluation of this chart.                    | `false`
        |
| `serviceType`                     | Kubernetes Service type               | `LoadBalancer`                                          |
| `persistence.enabled`             | Enable persistence using PVC          | `true`                                                  |
| `persistence.apache.storageClass` | PVC Storage Class for Apache volume   | `nil` (uses alpha storage class annotation)             |
| `persistence.apache.accessMode`   | PVC Access Mode for Apache volume     | `ReadWriteOnce`                                         |
| `persistence.apache.size`         | PVC Storage Request for Apache volume | `1Gi`                                                   |
| `persistence.phpbb.storageClass`  | PVC Storage Class for phpBB volume    | `nil` (uses alpha storage class annotation)             |
| `persistence.phpbb.accessMode`    | PVC Access Mode for phpBB volume      | `ReadWriteOnce`                                         |
| `persistence.phpbb.size`          | PVC Storage Request for phpBB volume  | `8Gi`                                                   |
| `resources`                       | CPU/Memory resource requests/limits   | Memory: `512Mi`, CPU: `300m`                            |

The following configuration options are utilized only if `mysql.embeddedMaria` is set to `false` (the default):

| Parameter                         | Description                                           | Default                                                   |
| --------------------------------- | ----------------------------------------------------- | --------------------------------------------------------- |
| `mysql.azure.location`            | The Azure region in which to deploy Azure Database for MySQL | `eastus`                                           |
| `mysql.azure.servicePlan`         | The plan to request for Azure Database for MySQL      | `standard100`                                             |

The following configuration options are utilized only if `mysql.embeddedMaria` is set to `true`:

| Parameter                         | Description                                           | Default                                                   |
| --------------------------------- | ----------------------------------------------------- | --------------------------------------------------------- |
| `mariadb.mariadbRootPassword`     | MariaDB admin password                                | `nil`                                                     |
| `mariadb.mariadbDatabase`         | Database name to create                               | `bitnami_phpbb`                                           |
| `mariadb.mariadbUser`             | Database user to create                               | `bn_phpbb`                                                |
| `mariadb.mariadbPassword`         | Password for the database                             | _random 10 character long alphanumeric string_            |


The above parameters map to the env variables defined in [bitnami/phpbb](http://github.com/bitnami/bitnami-docker-phpbb). For more information please refer to the [bitnami/phpbb](http://github.com/bitnami/bitnami-docker-phpbb) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set phpbbUser=admin,
  --set phpbbPassword=password \
    azure/phpbb
```

The above command sets the phpBB administrator account username and password to `admin` and `password` respectively. 

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml azure/phpbb
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [Bitnami phpBB](https://github.com/bitnami/bitnami-docker-phpbb) image stores the phpBB data and configurations at the `/bitnami/phpbb` and `/bitnami/apache` paths of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Configuration](#configuration) section to configure the PVC or to disable persistence.