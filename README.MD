# helm Orb [![CircleCI status](https://circleci.com/gh/CircleCI-Public/helm-orb.svg "CircleCI status")](https://circleci.com/gh/CircleCI-Public/helm-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/circleci/helm)](https://circleci.com/orbs/registry/orb/circleci/helm) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/circleci-public/helm-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/orbs)

A CircleCI Orb to simplify deployments to Kubernetes using Helm.

Here are the features that the Helm orb provides:

- Installing the helm client (`install-helm-client`)
- Installing helm on a cluster (`install-helm-on-cluster`)
- Installing helm charts (`install-helm-chart`) and deleting releases (`delete-helm-release`)

## Usage

See the [orb registry listing](http://circleci.com/orbs/registry/orb/circleci/helm) for usage guidelines.

## Requirements

- `curl` should be present in `PATH`.

## Examples

Full usage examples can be found on the Helm orb's page in the orb registry, [here](https://circleci.com/orbs/registry/orb/circleci/helm#usage-examples).

```
version: 2.1

orbs:
  helm: circleci/helm@0.1.0
  kubernetes: circleci/kubernetes@0.2.0

workflows:
  deployment:
    jobs:
      # Install on existing cluster
      - helm/install-helm-on-cluster:
          cluster-name: my-helm-demo
          enable-cluster-wide-admin-access: true
      - helm/install-helm-chart:
          cluster-name: my-helm-demo
          chart: stable/grafana
          release-name: grafana-release
          requires:
            - helm/install-helm-on-cluster
      - helm/delete-helm-release:
          cluster-name: my-helm-demo
          release-name: grafana-release
          requires:
            - helm/install-helm-chart
```

## Contributing

We welcome [issues](https://github.com/CircleCI-Public/helm-orb/issues) to and [pull requests](https://github.com/CircleCI-Public/helm-orb/pulls) against this repository!

For further questions/comments about this or other orbs, visit [CircleCI's orbs discussion forum](https://discuss.circleci.com/c/orbs).
