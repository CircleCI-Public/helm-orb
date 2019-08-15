# helm Orb [![CircleCI status](https://circleci.com/gh/CircleCI-Public/helm-orb.svg "CircleCI status")](https://circleci.com/gh/CircleCI-Public/helm-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/circleci/helm)](https://circleci.com/orbs/registry/orb/circleci/helm) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/circleci-public/helm-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

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

```
version: 2.1

orbs:
  aws-eks: circleci/aws-eks@0.2.1
  helm: circleci/helm@0.1.1

jobs:
  install-helm-on-cluster:
    executor: aws-eks/python
    parameters:
      cluster-name:
        type: string
        description: Cluster name
    steps:
      - aws-eks/update-kubeconfig-with-authenticator:
          cluster-name: << parameters.cluster-name >>
          install-kubectl: true
      - helm/install-helm-on-cluster:
          enable-cluster-wide-admin-access: true
  install-helm-chart:
    executor: aws-eks/python
    parameters:
      cluster-name:
        type: string
        description: Cluster name
    steps:
      - aws-eks/update-kubeconfig-with-authenticator:
          cluster-name: << parameters.cluster-name >>
      - helm/install-helm-chart:
          chart: stable/grafana
          release-name: grafana-release
  delete-helm-release:
    executor: aws-eks/python
    parameters:
      cluster-name:
        type: string
        description: Cluster name
    steps:
      - aws-eks/update-kubeconfig-with-authenticator:
          cluster-name: << parameters.cluster-name >>
      - helm/delete-helm-release:
          release-name: grafana-release
          purge: true
          timeout: 600

workflows:
  deployment:
    jobs:
      - aws-eks/create-cluster:
          cluster-name: test-cluster
      - install-helm-on-cluster:
          cluster-name: test-cluster
          requires:
            - aws-eks/create-cluster
      - install-helm-chart:
          cluster-name: test-cluster
          requires:
            - install-helm-on-cluster
      - delete-helm-release:
          cluster-name: test-cluster
          requires:
            - install-helm-chart
      - aws-eks/delete-cluster:
          cluster-name: test-cluster
          wait: true
          requires:
            - delete-helm-release
```

## Contributing

Development notes for building, testing and orb publishing are located [here](docs/dev-notes.md).

We welcome [issues](https://github.com/CircleCI-Public/helm-orb/issues) to and [pull requests](https://github.com/CircleCI-Public/helm-orb/pulls) against this repository!

For further questions/comments about this or other orbs, visit [CircleCI's orbs discussion forum](https://discuss.circleci.com/c/orbs).
