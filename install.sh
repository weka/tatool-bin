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
DEST="/usr/local/bin/tatool"

echo "Downloading tatool for ${OS}/${ARCH}..."

if [ -w /usr/local/bin ]; then
  curl -fsSL -o "$DEST" "$URL"
  chmod +x "$DEST"
else
  sudo curl -fsSL -o "$DEST" "$URL"
  sudo chmod +x "$DEST"
fi

echo "Installed tatool to ${DEST}"
tatool version
