if [ -n "${VALUES_TO_OVERRIDE}" ]; then
  set -- "$@" --set "${VALUES_TO_OVERRIDE}"
fi
if [ -n "${NAMESPACE}" ]; then
  set -- "$@" --namespace="${NAMESPACE}"
fi
# if [ "${TLS}" == "true" ]; then
#   set -- "$@" --tls
# fi
# if [ -n "${TLS_CA_CERT}" ]; then
#   set -- "$@" --tls-ca-cert="${TLS_CA_CERT}"
# fi
# if [ -n "${TLS_CERT}" ]; then
#   set -- "$@" --tls-cert="${TLS_CERT}"
# fi
# if [ -n "${TLS_HOSTNAME}" ]; then
#   set -- "$@" --tls-hostname="${TLS_HOSTNAME}"
# fi
# if [ -n "${TLS_KEY}" ]; then
#   set -- "$@" --tls-key="${TLS_KEY}"
# fi
# if [ "${TLS_VERIFY}" == "true" ]; then
#   set -- "$@" --tls-verify
# fi
# if [ -n "${TILLER_NAMESPACE}" ]; then
#   set -- "$@" --tiller-namespace "${TILLER_NAMESPACE}"
# fi
if [ "${ORB_PARAM_WAIT}" == "true" ]; then
  set -- "$@" --wait
fi

# VERSION_2_MATCH="$(helm version --short -c | grep 'Client: v2' || true)"
# if [ -n "${VERSION_2_MATCH}" ]; then
#   if [ -n "${RELEASE_NAME}" ]; then
#     set -- "$@" --name "${RELEASE_NAME}"
#   fi
#   helm install "${ORB_PARAM_CHART}" "$@"
# else
if [ -n "${RELEASE_NAME}" ]; then
  helm install "${RELEASE_NAME}" "${ORB_PARAM_CHART}" "$@"
else
  set -- "$@" --generate-name
  helm install "${ORB_PARAM_CHART}" "$@"
fi
# fi