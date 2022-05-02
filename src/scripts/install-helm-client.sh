if command -v helm &> /dev/null; then
    echo "helm is already installed"
    exit 0
fi

if [ -n "${VERSION}" ]; then
  set -- "$@" --version "${VERSION}"
fi

INSTALL_SCRIPT="https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3"

curl "${INSTALL_SCRIPT}" > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh "$@"
