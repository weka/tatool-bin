#!/bin/sh
set -e

REPO="weka/tatool-go"
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
  x86_64)  ARCH="amd64" ;;
  aarch64) ARCH="arm64" ;;
  arm64)   ARCH="arm64" ;;
  *)       echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

URL="https://github.com/${REPO}/releases/latest/download/tatool-${OS}-${ARCH}"

# Use /usr/bin (always in PATH) over /usr/local/bin
DEST="/usr/bin/tatool"

echo "Downloading tatool for ${OS}/${ARCH}..."

if [ -w "$(dirname "$DEST")" ]; then
  curl -fsSL -o "$DEST" "$URL"
  chmod +x "$DEST"
else
  sudo curl -fsSL -o "$DEST" "$URL"
  sudo chmod +x "$DEST"
fi

echo "Installed tatool to ${DEST}"
"$DEST" version
