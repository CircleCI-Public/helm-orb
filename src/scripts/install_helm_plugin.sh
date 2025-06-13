#!/bin/bash
HELM_STR_PLUGIN_URL="$(echo "${HELM_STR_PLUGIN_URL}" | circleci env subst)"
HELM_STR_PLUGIN_VERSION="$(echo "${HELM_STR_PLUGIN_VERSION}" | circleci env subst)"

if [ -n "$HELM_STR_PLUGIN_VERSION" ]; then
  STATUS="$(helm plugin install "${HELM_STR_PLUGIN_URL}" --version "${HELM_STR_PLUGIN_VERSION}")"
else
  STATUS="$(helm plugin install "${HELM_STR_PLUGIN_URL}")"
fi

if echo "${STATUS}" | grep "Installed plugin:"; then
  echo "Installation successful"
  exit 0
else
  echo "Installation failed. Please check the Helm plugin URL"
  exit 1
fi
