# app_jenkins task
**Purpose:** To install and setup Jenkins 2.x and Sonarqube as containerized Kubernetes services (non-HA).

**Parent** `preload-apps-k8s.yml`

**Dependencies:** The task expects and depends upon an NFS Server (*not* an NFS Provisioner) that shares `/datadrive` as a local volume on the worker, so it can be used to provision persistent volumes and claims using local-storage against the path.
> The task **will** create the paths as long as /datadrive exists on the node where the workload is deployed.

## Structure
```
app_jenkins
|- manifests
|- meta
|- scripts
|- tasks
README.md
```

### Manifests
The manifests sub-directory includes a set of k8s manifests to declare:
* Namespaces (`namespace.yaml`)
* Persistent volumes and claims (`*-pv.yaml` and `*-pvc.yaml`) for Docker, Jenkins and Sonarqube (conf, data and logs)
* Services (`*-service.yaml`) for Jenkins, JNLP and Sonarqube
* Ingresses (`*-ingress.yaml`) for Jenkins and Sonarqube ingresses

### Meta
empty main.yaml

### Scripts
The scripts sub-directory includes a set of Linux shell scripts used for various purposes:
* `getcreds.sh` writes the k8s cluster credentials to a set of temporary files and generates a pfx which can be uploaded to Jenkins

### Tasks
The main tasks sub-directory which includes a number of tasks:
* `main.yml` imports all tasks from checks, copy, debug, kubectl and volumes
* `checks.yml` performs a number of checks and registers outcomes in variables which are used to decide to conduct certain tasks (or not). The checks can be overridden by passing an extra-arg **force**; e.g. `ansible-play preload-apps-k8s.yml --tags=app_jenkins -e force=yes`
> The force value is *not* case sensitive.
* `copy.yml` copies the manifests and templates them if required to the master where the kubectl commands will be executed.
* `debug.yml` uses a debug play to show the values of all checks and runs when verbosity is 2 or higher; e.g. when `-vv` is used
* `kubectl.yml` contains the tasks to apply the manifests to the targeted cluster.
* `volumes.yml` contains the tasks to create the required sub-directories under `/datadrive` if they do not already exist.