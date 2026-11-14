#!/usr/bin/env bash

# Выполняется через source из install.sh до установки worker.
read -rp "Main k3s server IP or hostname: " K3S_SERVER
if [[ ! "${K3S_SERVER}" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]*$ ]]; then
  echo "Invalid k3s server address." >&2
  exit 1
fi

TOKEN_FILE="${REPO_DIR}/hosts/worker/k3s-token-file"
umask 077
TOKEN_TMP="$(mktemp "${TOKEN_FILE}.XXXXXX")"
if ! scp -i "${SSH_PRIVATE_KEY}" -o IdentitiesOnly=yes \
  "root@${K3S_SERVER}:/var/lib/rancher/k3s/server/agent-token" "${TOKEN_TMP}"; then
  rm -f "${TOKEN_TMP}"
  exit 1
fi
if [[ ! -s "${TOKEN_TMP}" ]]; then
  rm -f "${TOKEN_TMP}"
  echo "Downloaded k3s token is empty." >&2
  exit 1
fi
chmod 600 "${TOKEN_TMP}"
mv "${TOKEN_TMP}" "${TOKEN_FILE}"

EXTRA_FILES_DIR="$(mktemp -d)"
trap 'rm -rf "${EXTRA_FILES_DIR}"' EXIT
mkdir -p "${EXTRA_FILES_DIR}/root/nix-config/hosts/worker"
cp "${TOKEN_FILE}" "${EXTRA_FILES_DIR}/root/nix-config/hosts/worker/k3s-token-file"
INSTALL_EXTRA_ARGS+=(--extra-files "${EXTRA_FILES_DIR}")
