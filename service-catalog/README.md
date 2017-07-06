# Service Catalog

Service Catalog is a Kubernetes Incubator project that provides a
Kubernetes-native workflow for integrating with 
[Open Service Brokers](https://www.openservicebrokerapi.org/) 
to provision and bind to application dependencies like databases, object
storage, message-oriented middleware, and more.

For more information, [visit the project on github]
(https://github.com/kubernetes-incubator/service-catalog).

## Prerequisites

- Kubernetes 1.7+ with Beta APIs enabled
	
	_Note_: If you are using [Minikube](https://github.com/kubernetes/minikube), you may install
Kubernetes 1.7 with this command:
	
	```console
	minikube start --kubernetes-version=v1.7.0
	```

- [Helm](https://github.com/kubernetes/helm) version 2.5.0+

	_Note_: If you have a current helm install and you want to upgrade, download the new
	version of the `helm` CLI and run `helm init --upgrade`



## Installing the Chart

To install the chart, first generate TLS files and capture output environment variables:

```console
source ./aggregation-tls-setup.sh
```

Then install with the release name `catalog`:

```bash
helm install . \
--name catalog \
--namespace catalog \
--set apiserver.tls.caFileName=${SC_SERVING_CA} \
--set apiserver.tls.certFileName=${SC_SERVING_CERT} \
--set apiserver.tls.keyFileName=${SC_SERVING_KEY}
```

## Uninstalling the Chart

To uninstall/delete the `catalog` deployment:

```bash
helm delete catalog
kubectl delete apiservice v1alpha1.servicecatalog.k8s.io
```

The command removes all the Kubernetes components associated with the chart and
deletes the release.

## Configuration

The following tables lists the configurable parameters of the Service Catalog
chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `apiserver.image` | apiserver image to use | `quay.io/kubernetes-service-catalog/apiserver:v0.0.12` |
| `apiserver.imagePullPolicy` | `imagePullPolicy` for the apiserver | `Always` |
| `apiserver.insecure`  | Whether to expose an insecure endpoint; keep this enabled because there are some outstanding problems with the TLS-secured endpoint | `true` |
| `apiserver.tls.cert` | Base64-encoded x509 certificate | A self-signed certificate |
| `apiserver.tls.key` | Base64-encoded private key | The private key for the certificate above |
| `apiserver.tls.ca` | Base64-encoded CA certificate used to sign the above certificate | |
| `apiserver.tls.requestHeaderCA` | Base64-encoded CA used to validate request-header authentication, when receiving delegated authentication from an aggregator | *none (will disable requestheader authentication)* |
| `apiserver.service.type` | Type of service; valid values are `LoadBalancer` and `NodePort` | `NodePort` |
| `apiserver.service.nodePort.securePort` | If service type is `NodePort`, specifies a port in allowable range (e.g. 30000 - 32767 on minikube); The TLS-enabled endpoint will be exposed here | `30443` |
| `apiserver.service.nodePort.insecurePort` | If service type is `NodePort`, specifies a port in allowable range (e.g. 30000 - 32767 on minikube); The insecure endpoint, if enabled, will be exposed here | `30080` |
| `apiserver.storage.type` | The storage backend to use; valid values are `etcd` and `tpr` | `etcd` |
| `apiserver.storage.etcd.useEmbedded` | If storage type is `etcd`: Whether to embed an etcd container in the apiserver pod; THIS IS INADEQUATE FOR PRODUCTION USE! | `true` |
| `apiserver.storage.etcd.servers` | If storage type is `etcd`: etcd URL(s); override this if NOT using embedded etcd | `http://localhost:2379` |
| `apiserver.storage.tpr.globalNamespace` | If storage type is `tpr`: Some service catalog resources are not namespaced, but third party resources must be; setting this designates a namespace that will be treated as a container for such resources | `servicecatalog` |
| `apiserver.verbosity` | Log level; valid values are in the range 0 - 10 | `10` |
| `apiserver.auth.enabled` | Enable authentication and authorization | `false` |
| `controllerManager.image` | controller-manager image to use | `quay.io/kubernetes-service-catalog/controller-manager:v0.0.12` |
| `controllerManager.imagePullPolicy` | `imagePullPolicy` for the controller-manager | `Always` |
| `controllerManager.verbosity` | Log level; valid values are in the range 0 - 10 | `10` |
| `controllerManager.resyncInterval` | How often the controller should resync informers; duration format (`20m`, `1h`, etc) | `5m` |
| `controllerManager.brokerRelistInterval` | How often the controller should relist the catalogs of ready brokers; duration format (`20m`, `1h`, etc) | `24h` |
| `useAggregator` | whether or not to set up the controller-manager to go through the main Kubernetes API server's API aggregator (requires setting `apiserver.tls.ca` to work) | `false` |

Specify each parameter using the `--set key=value[,key=value]` argument to
`helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be
provided while installing the chart. For example:

```bash
$ helm install charts/catalog --name catalog --namespace catalog \
  --values values.yaml
```
