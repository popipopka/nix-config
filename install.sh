#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
read -rp "Profile to install (server/worker) [server]: " HOST
HOST="${HOST:-server}"
case "${HOST}" in
  server|worker) ;;
  *) echo "Expected server or worker." >&2; exit 1 ;;
esac
HARDWARE_CONFIG="./hosts/${HOST}/hardware.nix"
VARIABLES_FILE="./hosts/${HOST}/variables.nix"
SSH_PRIVATE_KEY="${HOME}/.ssh/main"

cd "${REPO_DIR}"

read -rp "Server IP or hostname: " SERVER_IP

if [[ -z "${SERVER_IP}" ]]; then
  echo "Server IP or hostname is required."
  exit 1
fi

TARGET_HOST="root@${SERVER_IP}"

read -rp "Build on (remote/local) [remote]: " BUILD_ON
BUILD_ON="${BUILD_ON:-remote}"
case "${BUILD_ON}" in
  remote|local) ;;
  *) echo "Expected remote or local." >&2; exit 1 ;;
esac

if [[ ! -r "${SSH_PRIVATE_KEY}" ]]; then
  echo "SSH private key must be readable: ${SSH_PRIVATE_KEY}" >&2
  exit 1
fi

echo "Installing ${HOST} on ${TARGET_HOST}; disk and network settings come from ${VARIABLES_FILE}."
echo "WARNING: installation will erase the target disk configured in ${VARIABLES_FILE}."

INSTALL_EXTRA_ARGS=()
if [[ -f "./hosts/${HOST}/part-of-install.sh" ]]; then
  source "./hosts/${HOST}/part-of-install.sh"
fi

nix run github:nix-community/nixos-anywhere -- \
  -i "${SSH_PRIVATE_KEY}" \
  --ssh-option IdentitiesOnly=yes \
  --ssh-option IdentityAgent=none \
  --no-disko-deps \
  ${INSTALL_EXTRA_ARGS[@]+"${INSTALL_EXTRA_ARGS[@]}"} \
  --generate-hardware-config nixos-generate-config "${HARDWARE_CONFIG}" \
  --flake ".#${HOST}" \
  --target-host "${TARGET_HOST}" \
  --build-on "${BUILD_ON}"

SSH_OPTIONS=(-i "${SSH_PRIVATE_KEY}" -o IdentitiesOnly=yes -o ConnectTimeout=5)

echo "Waiting for SSH after installation..."
ssh_ready=false
for attempt in {1..30}; do
  if ssh "${SSH_OPTIONS[@]}" "${TARGET_HOST}" true; then
    ssh_ready=true
    break
  fi
  sleep 2
done
if [[ "${ssh_ready}" != true ]]; then
  echo "SSH unavailable; repository and installation files were not copied."
  exit 1
fi

ssh "${SSH_OPTIONS[@]}" "${TARGET_HOST}" 'bash -s' <<'REMOTE_SCRIPT'
  set -eu
  if [ ! -d /root/nix-config/.git ]; then
    clone_dir=$(mktemp -d)
    GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_SYSTEM=/dev/null \
      git clone -b server https://github.com/popipopka/nix-config.git "$clone_dir"
    mkdir -p /root/nix-config
    cp -a "$clone_dir/." /root/nix-config/
    rm -rf "$clone_dir"
  else
    git -C /root/nix-config rev-parse --is-inside-work-tree >/dev/null
  fi
REMOTE_SCRIPT

ssh "${SSH_OPTIONS[@]}" "${TARGET_HOST}" "mkdir -p /root/nix-config/hosts/${HOST}"

scp "${SSH_OPTIONS[@]}" \
  "${VARIABLES_FILE}" "${HARDWARE_CONFIG}" \
  "${TARGET_HOST}:/root/nix-config/hosts/${HOST}/"

echo "Server configuration saved to /root/nix-config."