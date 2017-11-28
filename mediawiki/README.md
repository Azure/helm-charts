# MediaWiki

[MediaWiki](https://www.mediawiki.org) is an extremely powerful, scalable software and a feature-rich wiki implementation that uses PHP to process and display data stored in a database, such as MySQL.

This chart bootstraps a
[MediaWiki](https://github.com/bitnami/bitnami-docker-mediawiki) deployment on
a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh)
 package manager.

It is inspired by the
[upstream mediawiki chart](https://github.com/kubernetes/charts/tree/master/stable/mediawiki),
but, by default, utilizes the Azure Service Broker to provision an
[Azure Database for MySQL](https://azure.microsoft.com/en-us/services/mysql/)
database for the Wordpress server to use.

# Basic Installation

Installation of this chart is simple. First, ensure that you've [added the
`azure` repository](../README.md#installing-charts). Then, install from the
`azure` repo:

```console
$ helm install azure/wordpress
```

## Prerequisites

- Kubernetes 1.7+ with beta APIs enabled
- [Service-Catalog](https://github.com/kubernetes-incubator/service-catalog) installed
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release stable/mediawiki
```

The command deploys MediaWiki on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the MediaWiki chart and their default values.

|              Parameter               |               Description                |                         Default                         |
|--------------------------------------|------------------------------------------|---------------------------------------------------------|
| `image`                              | MediaWiki image                          | `bitnami/mediawiki:{VERSION}`                           |
| `imagePullPolicy`                    | Image pull policy                        | `Always` if `imageTag` is `latest`, else `IfNotPresent` |
| `mediawikiUser`                      | User of the application                  | `user`                                                  |
| `mediawikiPassword`                  | Application password                     | _random 10 character long alphanumeric string_          |
| `mediawikiEmail`                     | Admin email                              | `user@example.com`                                      |
| `mediawikiName`                      | Name for the wiki                        | `My Wiki`                                               |
| `allowEmptyPassword`                 | Allow DB blank passwords                 | `yes`                                                   |
| `smtpHost`                           | SMTP host                                | `nil`                                                   |
| `smtpPort`                           | SMTP port                                | `nil`                                                   |
| `smtpHostID`                         | SMTP host ID                             | `nil`                                                   |
| `smtpUser`                           | SMTP user                                | `nil`                                                   |
| `smtpPassword`                       | SMTP password                            | `nil`                                                   |
| `mysql.embeddedMaria`                | Whether to fulfill the dependency on MySQL using an embedded (on-cluster) MariaDB database _instead of Aure Database for MySQL. This option is available to enable local or no-cost evaluation of this chart.                    | `false`
| `mariadb.mariadbRootPassword`        | MariaDB admin password                   | `nil`                                                   |
| `mariadb.mariadbDatabase`            | Database name to create                  | `bitnami_mediawiki`                                     |
| `mariadb.mariadbUser`                | Database user to create                  | `bn_mediawiki`                                          |
| `mariadb.mariadbPassword`            | Password for the database                | _random 10 character long alphanumeric string_          |
| `serviceType`                        | Kubernetes Service type                  | `LoadBalancer`                                          |
| `persistence.enabled`                | Enable persistence using PVC             | `true`                                                  |
| `persistence.apache.storageClass`    | PVC Storage Class for Apache volume      | `nil` (uses alpha storage class annotation)             |
| `persistence.apache.accessMode`      | PVC Access Mode for Apache volume        | `ReadWriteOnce`                                         |
| `persistence.apache.size`            | PVC Storage Request for Apache volume    | `1Gi`                                                   |
| `persistence.mediawiki.storageClass` | PVC Storage Class for MediaWiki volume   | `nil` (uses alpha storage class annotation)   |
| `persistence.mediawiki.accessMode`   | PVC Access Mode for MediaWiki volume     | `ReadWriteOnce`                                         |
| `persistence.mediawiki.size`         | PVC Storage Request for MediaWiki volume | `8Gi`                                                   |
| `resources`                          | CPU/Memory resource requests/limits      | Memory: `512Mi`, CPU: `300m`                            |

The above parameters map to the env variables defined in [bitnami/mediawiki](http://github.com/bitnami/bitnami-docker-mediawiki). For more information please refer to the [bitnami/mediawiki](http://github.com/bitnami/bitnami-docker-mediawiki) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release \
  --set mediawikiUser=admin,mediawikiPassword=password,mariadb.mariadbRootPassword=secretpassword \
    stable/mediawiki
```

The above command sets the MediaWiki administrator account username and password to `admin` and `password` respectively. Additionally it sets the MariaDB `root` user password to `secretpassword`.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml stable/mediawiki
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [Bitnami MediaWiki](https://github.com/bitnami/bitnami-docker-mediawiki) image stores the MediaWiki data and configurations at the `/bitnami/mediawiki` and `/bitnami/apache` paths of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Configuration](#configuration) section to configure the PVC or to disable persistence.