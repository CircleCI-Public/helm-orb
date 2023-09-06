if [ -n "${HELM_PLUGIN_URL}" ]; then
  helm plugin install "${HELM_PLUGIN_URL}"
else
  echo "no helm plugin url provided"
  exit 0
fi
