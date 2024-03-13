# helm Orb [![CircleCI status](https://circleci.com/gh/CircleCI-Public/helm-orb.svg "CircleCI status")](https://circleci.com/gh/CircleCI-Public/helm-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/circleci/helm)](https://circleci.com/developer/orbs/orb/circleci/helm) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/CircleCI-Public/helm-orb/blob/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

A CircleCI Orb to simplify deployments to Kubernetes using Helm.

Here are the features that the Helm orb provides:

- Installing the helm client (`install_helm_client`)
- Installing helm charts (`install_helm_chart`) and deleting releases (`delete_helm_release`)
- Installing helm plugin (`install_helm_plugin`)

Table of Contents
=================
* [Usage](#usage)
* [Requirements](#requirements)
* [Examples](#examples)
* [Contributing](#contributing)

## Usage

See the [orb registry listing](https://circleci.com/developer/orbs/orb/circleci/helm) for usage guidelines.

## Requirements

- `curl` should be present in `PATH`.

## Examples

Refer to the usage examples [here](https://circleci.com/developer/orbs/orb/circleci/helm#usage-install-helm-chart-with-helm3).

## Contributing

Development notes for building, testing and orb publishing are located [here](docs/dev-notes.md).

We welcome [issues](https://github.com/CircleCI-Public/helm-orb/issues) to and [pull requests](https://github.com/CircleCI-Public/helm-orb/pulls) against this repository!

For further questions/comments about this or other orbs, visit [CircleCI's orbs discussion forum](https://discuss.circleci.com/c/orbs).
