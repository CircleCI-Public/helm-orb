#!/bin/bash
set -x
if [ -n "${VALUES_TO_OVERRIDE}" ]; then
  set -- "$@" --set "$(eval "${VALUES_TO_OVERRIDE}")"
fi
if [ "${HELM_BOOL_WAIT_FOR_JOBS}" -eq "1" ]; then
  set -- "$@" --wait-for-jobs
fi
if [ -n "${NAMESPACE}" ]; then
  set -- "$@" --namespace="${NAMESPACE}"
fi
if [ "${ORB_PARAM_WAIT}" -eq "1" ]; then
  set -- "$@" --wait
fi
if [ -n "${RELEASE_NAME}" ]; then
  helm install "${RELEASE_NAME}" "${ORB_PARAM_CHART}" "$@"
else
  set -- "$@" --generate-name
  helm install "${ORB_PARAM_CHART}" "$@"
fi
set +x