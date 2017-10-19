# Service Catalog

Service Catalog is a Kubernetes Incubator project that provides a
Kubernetes-native workflow for integrating with 
[Open Service Brokers](https://www.openservicebrokerapi.org/) 
to provision and bind to application dependencies like databases, object
storage, message-oriented middleware, and more.

For more information, 
[visit the project on github](https://github.com/kubernetes-incubator/service-catalog).

To install, you must have a Kubernetes 1.7 cluster. If you are using 
[acs-engine](https://github.com/Azure/acs-engine) to install a cluster, run
the following command from this directory:

```console
acs-engine deploy \
    --subscription-id $SUB_ID \
    --dns-prefix svc-cat-test \
    --location westus2 \
    --auto-suffix \
    --api-model acs-engine-kubernetes-config.json
```

When your cluster becomes available, see the 
[service-catalog installation documentation](https://github.com/kubernetes-incubator/service-catalog/blob/master/docs/install-1.7.md).
