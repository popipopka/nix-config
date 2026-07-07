#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HARDWARE_CONFIG="./hosts/server/hardware.nix"
VARIABLES_FILE="./hosts/server/variables.nix"
ROOT_SSH_PUBLIC_KEY_FILE="./hosts/server/ssh-public-key.pub"
DEFAULT_ROOT_SSH_PUBLIC_KEY_SOURCE="${HOME}/.ssh/main.pub"

cd "${REPO_DIR}"

read -rp "Server IP or hostname: " SERVER_IP

if [[ -z "${SERVER_IP}" ]]; then
  echo "Server IP or hostname is required."
  exit 1
fi

TARGET_HOST="root@${SERVER_IP}"

read -rp "Target disk [/dev/sda]: " TARGET_DISK
TARGET_DISK="${TARGET_DISK:-/dev/sda}"

read -rp "Root SSH public key file [${DEFAULT_ROOT_SSH_PUBLIC_KEY_SOURCE}]: " ROOT_SSH_PUBLIC_KEY_SOURCE
ROOT_SSH_PUBLIC_KEY_SOURCE="${ROOT_SSH_PUBLIC_KEY_SOURCE:-${DEFAULT_ROOT_SSH_PUBLIC_KEY_SOURCE}}"
ROOT_SSH_PUBLIC_KEY_SOURCE="${ROOT_SSH_PUBLIC_KEY_SOURCE/#\~/${HOME}}"

if [[ ! -r "${ROOT_SSH_PUBLIC_KEY_SOURCE}" ]]; then
  echo "Root SSH public key file is required and must be readable: ${ROOT_SSH_PUBLIC_KEY_SOURCE}"
  exit 1
fi

echo "Target host: ${TARGET_HOST}"
echo "Target disk: ${TARGET_DISK}"
echo "Root SSH public key file: ${ROOT_SSH_PUBLIC_KEY_SOURCE}"

read -rp "Install? [y/N] " confirmation

if [[ "${confirmation}" != "y" ]]; then
  echo "Aborted."
  exit 1
fi

escaped_target_disk="$(printf '%s\n' "${TARGET_DISK}" | sed 's/[\/&|]/\\&/g')"
tmp_variables_file="$(mktemp "${VARIABLES_FILE}.XXXXXX")"

sed "s|^[[:space:]]*disk = \".*\";|  disk = \"${escaped_target_disk}\";|" \
  "${VARIABLES_FILE}" > "${tmp_variables_file}"

mv "${tmp_variables_file}" "${VARIABLES_FILE}"
cp "${ROOT_SSH_PUBLIC_KEY_SOURCE}" "${ROOT_SSH_PUBLIC_KEY_FILE}"

nix run github:nix-community/nixos-anywhere -- \
  --no-disko-deps \
  --generate-hardware-config nixos-generate-config "${HARDWARE_CONFIG}" \
  --flake .#server \
  --target-host "${TARGET_HOST}"
