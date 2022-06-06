if [ -n "${TIMEOUT}" ]; then
  set -- "$@" --timeout="$(eval ${TIMEOUT})"
fi
if [ -n "${NAMESPACE}" ]; then
  set -- "$@" --namespace="$(eval ${NAMESPACE})"
fi
if [ "${TLS}" == "true" ]; then
  set -- "$@" --tls
fi
if [ -n "${TLS_CA_CERT}" ]; then
  set -- "$@" --tls-ca-cert="$(eval ${TLS_CA_CERT})"
fi
if [ -n "${TLS_CERT}" ]; then
  set -- "$@" --tls-cert="$(eval ${TLS_CERT})"
fi
if [ -n "${TLS_HOSTNAME}" ]; then
  set -- "$@" --tls-hostname="$(eval ${TLS_HOSTNAME})"
fi
if [ -n "${TLS_KEY}" ]; then
  set -- "$@" --tls-key="$(eval ${TLS_KEY})"
fi
if [ "${TLS_VERIFY}" == "true" ]; then
  set -- "$@" --tls-verify
fi
if [ -n "${TILLER_NAMESPACE}" ]; then
  set -- "$@" --tiller-namespace "$(eval ${TILLER_NAMESPACE})"
fi

VERSION_2_MATCH="$(helm version --short -c | grep 'Client: v2' || true)"
if [ -n "${VERSION_2_MATCH}" ]; then
  if [ "${PURGE}" == "true" ]; then
    set -- "$@" --purge
  fi
else
  if [ "${KEEP_HISTORY}" == "true" ]; then
    set -- "$@" --keep-history
  fi
fi
helm delete "$@" "${PARAM_RELEASE_NAME}"
