#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HARDWARE_CONFIG="./hosts/server/hardware.nix"

cd "${REPO_DIR}"

read -rp "Server IP or hostname: " SERVER_IP

if [[ -z "${SERVER_IP}" ]]; then
  echo "Server IP or hostname is required."
  exit 1
fi

TARGET_HOST="root@${SERVER_IP}"

read -rp "Install? [y/N] " confirmation

if [[ "${confirmation}" != "y" ]]; then
  echo "Aborted."
  exit 1
fi

nix run github:nix-community/nixos-anywhere -- \
  --generate-hardware-config nixos-generate-config "${HARDWARE_CONFIG}" \
  --flake .#server \
  --target-host "${TARGET_HOST}"
