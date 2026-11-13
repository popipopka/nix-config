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

read -rp "Interface IPv4 address [${SERVER_IP}]: " NETWORK_ADDRESS
NETWORK_ADDRESS="${NETWORK_ADDRESS:-${SERVER_IP}}"
read -rp "Network interface [ens3]: " NETWORK_INTERFACE
NETWORK_INTERFACE="${NETWORK_INTERFACE:-ens3}"
read -rp "Prefix length for ${NETWORK_ADDRESS} [32]: " NETWORK_PREFIX
NETWORK_PREFIX="${NETWORK_PREFIX:-32}"
read -rp "IPv4 gateway: " NETWORK_GATEWAY

valid_ipv4() {
  local octet
  local -a octets
  [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] || return 1
  IFS=. read -r -a octets <<< "$1"
  for octet in "${octets[@]}"; do
    [[ ${#octet} -le 3 ]] && (( 10#$octet <= 255 )) || return 1
  done
}

if ! valid_ipv4 "$NETWORK_ADDRESS" || ! valid_ipv4 "$NETWORK_GATEWAY"; then
  printf 'Interface address and gateway must be valid IPv4 addresses.\n' >&2
  exit 1
fi
if [[ ! "$NETWORK_INTERFACE" =~ ^[a-zA-Z0-9_.:-]+$ ]] ||
   [[ ! "$NETWORK_PREFIX" =~ ^([0-9]|[12][0-9]|3[0-2])$ ]]; then
  printf 'Invalid interface name or IPv4 prefix (expected 0-32).\n' >&2
  exit 1
fi

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
echo "Network: ${NETWORK_INTERFACE} ${NETWORK_ADDRESS}/${NETWORK_PREFIX}, gateway ${NETWORK_GATEWAY}"
echo "Root SSH public key file: ${ROOT_SSH_PUBLIC_KEY_SOURCE}"

read -rp "Install? [y/N] " confirmation

if [[ "${confirmation}" != "y" ]]; then
  echo "Aborted."
  exit 1
fi

escaped_target_disk="$(printf '%s\n' "${TARGET_DISK}" | sed 's/[\/&|]/\\&/g')"
tmp_variables_file="$(mktemp "${VARIABLES_FILE}.XXXXXX")"

sed -e "s|^[[:space:]]*disk = \".*\";|  disk = \"${escaped_target_disk}\";|" \
  -e "s|^[[:space:]]*interface = .*;|    interface = \"${NETWORK_INTERFACE}\";|" \
  -e "s|^[[:space:]]*address = .*;|    address = \"${NETWORK_ADDRESS}\";|" \
  -e "s|^[[:space:]]*prefixLength = .*;|    prefixLength = ${NETWORK_PREFIX};|" \
  -e "s|^[[:space:]]*gateway = .*;|    gateway = \"${NETWORK_GATEWAY}\";|" \
  "${VARIABLES_FILE}" > "${tmp_variables_file}"

mv "${tmp_variables_file}" "${VARIABLES_FILE}"
cp "${ROOT_SSH_PUBLIC_KEY_SOURCE}" "${ROOT_SSH_PUBLIC_KEY_FILE}"

nix run github:nix-community/nixos-anywhere -- \
  --no-disko-deps \
  --generate-hardware-config nixos-generate-config "${HARDWARE_CONFIG}" \
  --flake .#server \
  --target-host "${TARGET_HOST}"
