#!/bin/bash
HELM_STR_VALUES_TO_OVERRIDE="$(echo "${HELM_STR_VALUES_TO_OVERRIDE}" | circleci env subst)"
HELM_STR_NAMESPACE="$(echo "${HELM_STR_NAMESPACE}" | circleci env subst)"
HELM_STR_RELEASE_NAME="$(echo "${HELM_STR_RELEASE_NAME}" | circleci env subst)"
HELM_STR_CHART="$(echo "${HELM_STR_CHART}" | circleci env subst)"

set -x
if [ -n "${HELM_STR_VALUES_TO_OVERRIDE}" ]; then
  set -- "$@" --set "${HELM_STR_VALUES_TO_OVERRIDE}"
fi
if [ "${HELM_BOOL_WAIT_FOR_JOBS}" -eq 1 ]; then
  set -- "$@" --wait-for-jobs
fi
if [ -n "${HELM_STR_NAMESPACE}" ]; then
  set -- "$@" --namespace="${HELM_STR_NAMESPACE}"
fi
if [ "${HELM_BOOL_WAIT}" -eq 1 ]; then
  set -- "$@" --wait
fi
if [ -n "${HELM_STR_RELEASE_NAME}" ]; then
  helm install "${HELM_STR_RELEASE_NAME}" "${HELM_STR_CHART}" "$@"
else
  set -- "$@" --generate-name
  helm install "${HELM_STR_CHART}" "$@"
fi
set +x