#!/bin/bash
HELM_STR_TIMEOUT="$(echo "${HELM_STR_TIMEOUT}" | circleci env subst)"
HELM_STR_NAMESPACE="$(echo "${HELM_STR_NAMESPACE}" | circleci env subst)"
HELM_STR_TLS_CA_CERT="$(echo "${HELM_STR_TLS_CA_CERT}" | circleci env subst)"
HELM_STR_TLS_CERT="$(echo "${HELM_STR_TLS_CERT}" | circleci env subst)"
HELM_STR_TLS_HOSTNAME="$(echo "${HELM_STR_TLS_HOSTNAME}" | circleci env subst)"
HELM_STR_TLS_KEY="$(echo "${HELM_STR_TLS_KEY}" | circleci env subst)"
HELM_STR_RELEASE_NAME="$(echo "${HELM_STR_RELEASE_NAME}" | circleci env subst)"
HELM_STR_TILLER_NAMESPACE="$(echo "${HELM_STR_TILLER_NAMESPACE}" | circleci env subst)"

set -x
if [ -n "${HELM_STR_TIMEOUT}" ]; then
  set -- "$@" --timeout="${HELM_STR_TIMEOUT}"
fi
if [ -n "${HELM_STR_NAMESPACE}" ]; then
  set -- "$@" --namespace="${HELM_STR_NAMESPACE}"
fi
if [ "${HELM_BOOL_TLS}" -eq "1" ]; then
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
if [ "${HELM_BOOL_TLS_VERIFY}" -eq "1" ]; then
  set -- "$@" --tls-verify
fi
if [ -n "${HELM_STR_TILLER_NAMESPACE}" ]; then
  set -- "$@" --tiller-namespace "${HELM_STR_TILLER_NAMESPACE}"
fi

VERSION_2_MATCH="$(helm version --short -c | grep 'Client: v2' || true)"
if [ -n "${VERSION_2_MATCH}" ]; then
  if [ "${HELM_BOOL_PURGE}" -eq "1" ]; then
    set -- "$@" --purge
  fi
else
  if [ "${HELM_BOOL_KEEP_HISTORY}" -eq "1" ]; then
    set -- "$@" --keep-history
  fi
fi
helm delete "$@" "${HELM_STR_RELEASE_NAME}"
set +x