#!/bin/bash
HELM_STR_VERSION="$(echo "${HELM_STR_VERSION}" | circleci env subst)"

set -x
if command -v helm &> /dev/null; then
    echo "helm is already installed"
    exit 0
fi

if [ -n "${HELM_STR_VERSION}" ]; then
  set -- "$@" --version "${HELM_STR_VERSION}"
fi

INSTALL_SCRIPT="https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3"

curl "${INSTALL_SCRIPT}" > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh "$@"

rm -rf get_helm.sh
set +x
