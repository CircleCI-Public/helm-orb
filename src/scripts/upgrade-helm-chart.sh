#!/bin/bash
if [ -n "${HELM_STR_NAMESPACE}" ]; then
  set -- "$@" --namespace="${HELM_STR_NAMESPACE}"
fi
if [ -n "${HELM_STR_TIMEOUT}" ]; then
  set -- "$@" --timeout "${HELM_STR_TIMEOUT}"
fi
if [ -n "${HELM_BOOL_NO_HOOKS}" ]; then
  set -- "$@" --no-hooks="${HELM_BOOL_NO_HOOKS}"
fi
if [ "${HELM_BOOL_RECREATE_PODS}"  -eq "1" ]; then
  set -- "$@" --recreate-pods
fi
if [ "${HELM_BOOL_ATOMIC}" -eq "1" ]; then
  set -- "$@" --atomic
fi
if [ "${HELM_BOOL_WAIT}" -eq "1" ]; then
  set -- "$@" --wait
fi
if [ -n "${HELM_STR_DEVEL}" ]; then
  set -- "$@" --devel "${HELM_STR_DEVEL}"
fi
if [ "${HELM_BOOL_DRY_RUN}" -eq "1" ]; then
  set -- "$@" --dry-run
fi
if [ "${HELM_BOOL_RESET_VALUES}" -eq "1" ]; then
  set -- "$@" --reset-values
fi
if [ "${HELM_BOOL_REUSE_VALUES}" -eq "1" ]; then
  set -- "$@" --reuse-values
fi
if [ -n "${HELM_STR_VALUES}" ]; then
  set -- "$@" --values "$(eval ${HELM_STR_VALUES})"
fi
if [ -n "${HELM_STR_VALUES_TO_OVERRIDE}" ]; then
  set -- "$@" --set "$(eval ${HELM_STR_VALUES_TO_OVERRIDE})"
fi
if [ -n "${HELM_STR_VERSION}" ]; then
  set -- "$@" --version="${HELM_STR_VERSION}"
fi

helm repo add "${HELM_STR_RELEASE_NAME}" "${HELM_STR_ADD_REPO}"
helm repo update

helm upgrade --install "${HELM_STR_RELEASE_NAME}" "${HELM_STR_CHART}" "$@"