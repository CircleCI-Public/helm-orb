#!/bin/bash
HELM_STR_PLUGIN_URL="$(echo "${HELM_STR_PLUGIN_URL}" | circleci env subst)"

STATUS="$(helm plugin install "${HELM_STR_PLUGIN_URL}")"

if echo "${STATUS}" | grep "Installed plugin:"; then
  echo "Installation successful"
  exit 0
else
  echo "Installation failed. Please check the Helm plugin URL"
  exit 1
fi