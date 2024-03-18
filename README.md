# sympauthy-helm

Official Helm chart to deploy SympAuthy inside a Kubernetes cluster.

This chart will deploy every component of SymAuthy:
- ```auth```: the [authorization server](https://github.com/sympauthy/sympauthy)
- ```admin```: the administration interface (Work in progress).

Each component will be deployed in its own dedicated [deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).

> SympAuthy is not stable yet. Compatibilty between pre-1.0 release of this chart and nightly builds of SympAuthy may break at any time.

## Installation

### Add the Helm repository

```bash
helm repo add sympauthy https://sympauthy.github.io/sympauthy-helm --force-update
```

### Update your local cache

```bash
helm repo update
```

### Install sympauthy

```bash
helm install sympauthy sympauthy/sympauthy \
  --namespace sympauthy \
  --create-namespace \
  ...
```

## Configuration

List of configurations that are available for every ```<component>```:

| Config | Description | Default value |
| - | - | - |
| ```<component>.enabled``` |  | |
