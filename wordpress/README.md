# WordPress

[WordPress](https://wordpress.org/) is one of the most versatile open source 
content management and publishing platforms on the market for building blogs 
and websites.

This chart bootstraps a 
[WordPress](https://github.com/bitnami/bitnami-docker-wordpress) deployment on 
a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh)
 package manager.

It is inspired by the 
[upstream wordpress chart](https://github.com/kubernetes/charts/tree/master/stable/wordpress),
but utilizes the Azure Service Broker to provision an 
[Azure Database for MySQL](https://azure.microsoft.com/en-us/services/mysql/) 
database for the Wordpress server to use.

# Basic Installation

Installation of this chart is simple. First, ensure that you've [added the
`azure` repository](../README.md#installing-charts). Then, install from the
`azure` repo:

```console
$ helm install azure/wordpress
```

# Prerequisites

To install this chart, you must have:

- Kubernetes 1.7+ with beta APIs enabled
- [Service-Catalog](https://github.com/kubernetes-incubator/service-catalog) installed
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release` in the namespace `wp`:

```console
$ helm install --name my-release --namespace wp azure/wordpress
```

The command deploys WordPress on the Kubernetes cluster in the default 
configuration. The [configuration](#configuration) section lists the parameters 
that can be configured during installation.

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

The following tables lists the configurable parameters of the WordPress chart and their default values.

| Parameter                            | Description                                | Default                                                    |
| -------------------------------      | -------------------------------            | ---------------------------------------------------------- |
| `image`                              | WordPress image                            | `bitnami/wordpress:{VERSION}`                              |
| `imagePullPolicy`                    | Image pull policy                          | `IfNotPresent`                                             |
| `wordpressUsername`                  | User of the application                    | `user`                                                     |
| `wordpressPassword`                  | Application password                       | _random 10 character long alphanumeric string_             |
| `wordpressEmail`                     | Admin email                                | `user@example.com`                                         |
| `wordpressFirstName`                 | First name                                 | `FirstName`                                                |
| `wordpressLastName`                  | Last name                                  | `LastName`                                                 |
| `wordpressBlogName`                  | Blog name                                  | `User's Blog!`                                             |
| `allowEmptyPassword`                 | Allow DB blank passwords                   | `yes`                                          |
| `smtpHost`                           | SMTP host                                  | `nil`                                                      |
| `smtpPort`                           | SMTP port                                  | `nil`                                                      |
| `smtpUser`                           | SMTP user                                  | `nil`                                                      |
| `smtpPassword`                       | SMTP password                              | `nil`                                                      |
| `smtpUsername`                       | User name for SMTP emails                  | `nil`                                                      |
| `smtpProtocol`                       | SMTP protocol [`tls`, `ssl`]               | `nil`                                                      |
| `serviceType`                        | Kubernetes Service type                    | `LoadBalancer`                                             |
| `healthcheckHttps`                   | Use https for liveliness and readiness     | `false`                                             |
| `ingress.enabled`                    | Enable ingress controller resource         | `false`                                                    |
| `ingress.hostname`                   | URL to address your WordPress installation | `wordpress.local`                                          |
| `ingress.tls`                        | Ingress TLS configuration                  | `[]`                                          |
| `persistence.enabled`                | Enable persistence using PVC               | `true`                                                     |
| `persistence.storageClass`           | PVC Storage Class                          | `nil` (uses alpha storage class annotation)                |
| `persistence.accessMode`             | PVC Access Mode                            | `ReadWriteOnce`                                            |
| `persistence.size`                   | PVC Storage Request                        | `10Gi`                                                      |                                              |

The above parameters map to the env variables defined in [bitnami/wordpress](http://github.com/bitnami/bitnami-docker-wordpress). For more information please refer to the [bitnami/wordpress](http://github.com/bitnami/bitnami-docker-wordpress) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install azure/wordpress \
  --name my-release \
  --set wordpressUsername=admin \
  --set wordpressPassword=password  
```

The above command sets the WordPress administrator account username and password to `admin` and `password` respectively.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml stable/wordpress
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [Bitnami WordPress](https://github.com/bitnami/bitnami-docker-wordpress) image stores the WordPress data and configurations at the `/bitnami` path of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Configuration](#configuration) section to configure the PVC or to disable persistence.

## Ingress

This chart provides support for Ingress resource. If you have available an Ingress Controller such as Nginx or Traefik you maybe want to set up `ingress.enabled` to true and choose a `ingress.hostname` for the URL. Then, you should be able to access the installation using that address.
