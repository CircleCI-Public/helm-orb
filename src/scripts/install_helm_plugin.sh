#!/bin/bash
HELM_STR_PLUGIN_URL="$(echo "${HELM_STR_PLUGIN_URL}" | circleci env subst)"
HELM_STR_PLUGIN_VERSION="$(echo "${HELM_STR_PLUGIN_VERSION}" | circleci env subst)"

INSTALL_ARGS=("${HELM_STR_PLUGIN_URL}")

if [ -n "$HELM_STR_PLUGIN_VERSION" ]; then
  INSTALL_ARGS+=("--version" "${HELM_STR_PLUGIN_VERSION}")
fi

if [ "${HELM_BOOL_SKIP_VERIFY}" = "true" ]; then
  INSTALL_ARGS+=("--verify=false")
fi

STATUS="$(helm plugin install "${INSTALL_ARGS[@]}")"

if echo "${STATUS}" | grep "Installed plugin:"; then
  echo "Installation successful"
  exit 0
else
  echo "Installation failed. Please check the Helm plugin URL"
  exit 1
fi
