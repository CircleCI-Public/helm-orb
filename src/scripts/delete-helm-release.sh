#!/bin/bash
if [ -n "${HELM_STR_TIMEOUT}" ]; then
  set -- "$@" --timeout="${HELM_STR_TIMEOUT}"
fi
if [ -n "${HELM_STR_NAMESPACE}" ]; then
  set -- "$@" --namespace="${HELM_STR_NAMESPACE}"
fi
if [ "${HELM_BOOL_TLS}" == "true" ]; then
  set -- "$@" --tls
fi
if [ -n "${HELM_STR_TLS_CA_CERT}" ]; then
  set -- "$@" --tls-ca-cert="${HELM_STR_TLS_CA_CERT}"
fi
if [ -n "${HELM_STR_TLS_CERT}" ]; then
  set -- "$@" --tls-cert="${HELM_STR_TLS_CERT}"
fi
if [ -n "${HELM_STR_TLS_HOSTNAME}" ]; then
  set -- "$@" --tls-hostname="${HELM_STR_TLS_HOSTNAME}"
fi
if [ -n "${HELM_STR_TLS_KEY}" ]; then
  set -- "$@" --tls-key="${HELM_STR_TLS_KEY}"
fi
if [ "${HELM_BOOL_TLS_VERIFY}" == "true" ]; then
  set -- "$@" --tls-verify
fi
if [ -n "${HELM_STR_TILLER_NAMESPACE}" ]; then
  set -- "$@" --tiller-namespace "${HELM_STR_TILLER_NAMESPACE}"
fi

VERSION_2_MATCH="$(helm version --short -c | grep 'Client: v2' || true)"
if [ -n "${VERSION_2_MATCH}" ]; then
  if [ "${HELM_BOOL_PURGE}" == "true" ]; then
    set -- "$@" --purge
  fi
else
  if [ "${HELM_BOOL_KEEP_HISTORY}" == "true" ]; then
    set -- "$@" --keep-history
  fi
fi
helm delete "$@" "${HELM_STR_RELEASE_NAME}"