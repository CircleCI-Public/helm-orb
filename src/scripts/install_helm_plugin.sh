#!/bin/bash
HELM_STR_PLUGIN_URL="$(echo "${HELM_STR_PLUGIN_URL}" | circleci env subst)"
HELM_STR_PLUGIN_VERSION="$(echo "${HELM_STR_PLUGIN_VERSION}" | circleci env subst)"

if [ -n "$HELM_STR_PLUGIN_VERSION" ]; then
  PLUGIN_VERSION="--version $HELM_STR_PLUGIN_VERSION"
fi

STATUS="$(helm plugin install "${HELM_STR_PLUGIN_URL}" "$PLUGIN_VERSION")"

if echo "${STATUS}" | grep "Installed plugin:"; then
  echo "Installation successful"
  exit 0
else
  echo "Installation failed. Please check the Helm plugin URL"
  exit 1
fi
