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

success_helm_download=false
retry_count=0
while [ "$retry_count" -lt "$HELM_RETRIES" ]; do
  curl -sSf "${INSTALL_SCRIPT}" -o get_helm.sh
  if [ $? -eq 0 ]; then
    echo "Script downloaded succesfully"
    success_helm_download=true
    break
  else
    echo "Error downloading. Retying..."
    retry_count=$((retry_count + 1))
    sleep 5
  fi
done
if [ "$success_helm_download" = false ]; then
  echo "Max retries reached"
  exit 1
fi
chmod 700 get_helm.sh
./get_helm.sh "$@"

rm -rf get_helm.sh
set +x
