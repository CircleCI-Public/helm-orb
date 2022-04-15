if [ -n "${ORB_PARAM_NAMESPACE}" ]; then
  set -- "$@" --namespace="${ORB_PARAM_NAMESPACE}"
fi
if [ -n "${TIMEOUT}" ]; then
  set -- "$@" --timeout "${TIMEOUT}"
fi
if [ -n "${NO_HOOKS}" ]; then
  set -- "$@" --no-hooks="${NO_HOOKS}"
fi
if [ "${RECREATE_PODS}"  == "true" ]; then
  set -- "$@" --recreate-pods
fi
if [ "${ATOMIC}" == "true" ]; then
  set -- "$@" --atomic
fi
if [ "${ORB_PARAM_WAIT}" == "true" ]; then
  set -- "$@" --wait
fi
if [ "${TLS}" == "true" ]; then
  set -- "$@" --tls
fi
if [ -n "${TLS_CA_CERT}" ]; then
  set -- "$@" --tls-ca-cert="${TLS_CA_CERT}"
fi
if [ -n "${TLS_CERT}" ]; then
  set -- "$@" --tls-cert="${TLS_CERT}"
fi
if [ -n "${TLS_HOSTNAME}" ]; then
  set -- "$@" --tls-hostname="${TLS_HOSTNAME}"
fi
if [ -n "${TLS_KEY}" ]; then
  set -- "$@" --tls-key="${TLS_KEY}"
fi
if [ "${TLS_VERIFY}" == "true" ]; then
  set -- "$@" --tls-verify
fi
if [ -n "${TILLER_NAMESPACE}" ]; then
  set -- "$@" --tiller-namespace "${TILLER_NAMESPACE}"
fi
if [ -n "${DEVEL}" ]; then
  set -- "$@" --devel "${DEVEL}"
fi
if [ "${DRY_RUN}" == "true" ]; then
  set -- "$@" --dry-run
fi
if [ "${RESET_VALUES}" == "true" ]; then
  set -- "$@" --reset-values
fi
if [ "${REUSE_VALUES}" == "true" ]; then
  set -- "$@" --reuse-values
fi
if [ -n "${VALUES}" ]; then
  set -- "$@" --values "${VALUES}"
fi
if [ -n "${VALUES_TO_OVERRIDE}" ]; then
  set -- "$@" --set "${VALUES_TO_OVERRIDE}"
fi
if [ -n "${VERSION}" ]; then
  set -- "$@" --version="${VERSION}"
fi
helm upgrade --install "${ORB_PARAM_RELEASE_NAME}" "${ORB_PARAM_CHART}" "$@"