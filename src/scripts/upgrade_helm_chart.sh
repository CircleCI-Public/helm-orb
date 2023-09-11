#!/bin/bash
HELM_STR_TIMEOUT="$(echo "${HELM_STR_TIMEOUT}" | circleci env subst)"
HELM_STR_NAMESPACE="$(echo "${HELM_STR_NAMESPACE}" | circleci env subst)"
HELM_STR_DEVEL="$(echo "${HELM_STR_DEVEL}" | circleci env subst)"
HELM_STR_VALUES="$(echo "${HELM_STR_VALUES}" | circleci env subst)"
HELM_STR_VERSION="$(echo "${HELM_STR_VERSION}" | circleci env subst)"
HELM_STR_VALUES_TO_OVERRIDE="$(echo "${HELM_STR_VALUES_TO_OVERRIDE}" | circleci env subst)"
HELM_STR_CHART="$(echo "${HELM_STR_CHART}" | circleci env subst)"
HELM_STR_RELEASE_NAME="$(echo "${HELM_STR_RELEASE_NAME}" | circleci env subst)"
HELM_STR_ADD_REPO="$(echo "${HELM_STR_ADD_REPO}" | circleci env subst)"

set -x
if [ -n "${HELM_STR_NAMESPACE}" ]; then
  if [ "${HELM_BOOL_CREATE_NAME_SPACE}" -eq "1" ]; then
    set -- "$@" --create-namespace --namespace="${HELM_STR_NAMESPACE}"
  else
    set -- "$@" --namespace="${HELM_STR_NAMESPACE}"
  fi
fi
if [ -n "${HELM_STR_TIMEOUT}" ]; then
  set -- "$@" --timeout "${HELM_STR_TIMEOUT}"
fi
if [ "${HELM_BOOL_NO_HOOKS}" = "1" ]; then
  set -- "$@" --no-hooks
fi
if [ "${HELM_BOOL_RECREATE_PODS}"  -eq 1 ]; then
  set -- "$@" --recreate-pods
fi
if [ "${HELM_BOOL_ATOMIC}" -eq 1 ]; then
  set -- "$@" --atomic
fi
if [ "${HELM_BOOL_WAIT}" -eq 1 ]; then
  set -- "$@" --wait
fi
if [ -n "${HELM_STR_DEVEL}" ]; then
  set -- "$@" --devel "${HELM_STR_DEVEL}"
fi
if [ "${HELM_BOOL_DRY_RUN}" -eq 1 ]; then
  set -- "$@" --dry-run
fi
if [ "${HELM_BOOL_RESET_VALUES}" -eq 1 ]; then
  set -- "$@" --reset-values
fi
if [ "${HELM_BOOL_REUSE_VALUES}" -eq 1 ]; then
  set -- "$@" --reuse-values
fi
if [ -n "${HELM_STR_VALUES}" ]; then
  set -- "$@" --values "${HELM_STR_VALUES}"
fi
if [ -n "${HELM_STR_VALUES_TO_OVERRIDE}" ]; then
  set -- "$@" --set "${HELM_STR_VALUES_TO_OVERRIDE}"
fi
if [ -n "${HELM_STR_VERSION}" ]; then
  set -- "$@" --version="${HELM_STR_VERSION}"
fi
if [ "${HELM_BOOL_WAIT_FOR_JOBS}" -eq 1 ]; then
  set -- "$@" --wait-for-jobs
fi
if [ "${HELM_BOOL_FORCE}" -eq 1 ]; then
  set -- "$@" --force
fi

if [ -n "${HELM_STR_ADD_REPO}" ]; then
  helm repo add "${HELM_STR_RELEASE_NAME}" "${HELM_STR_ADD_REPO}"
  helm repo update
fi

helm upgrade --install "${HELM_STR_RELEASE_NAME}" "${HELM_STR_CHART}" "$@"
set +x