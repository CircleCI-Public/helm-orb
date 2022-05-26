if [ -n "${VALUES_TO_OVERRIDE}" ]; then
  set -- "$@" --set "$(echo eval ${VALUES_TO_OVERRIDE})"
fi
if [ -n "${NAMESPACE}" ]; then
  set -- "$@" --namespace="${NAMESPACE}"
fi
if [ "${ORB_PARAM_WAIT}" == "true" ]; then
  set -- "$@" --wait
fi
if [ -n "${RELEASE_NAME}" ]; then
  helm install "${RELEASE_NAME}" "${ORB_PARAM_CHART}" "$@"
else
  set -- "$@" --generate-name
  helm install "${ORB_PARAM_CHART}" "$@"
fi