#!/bin/bash

set -e

BIN_DIR=~/.local/bin
APP_NAME="gh"
REPO_NAME="cli/cli"
[[ -d $BIN_DIR ]] || mkdir -p $BIN_DIR

DIR=$(dirname "$(readlink -f "$0")")

# Download the latest release for Linux amd64 to tmp folder
curl -s curl -s https://api.github.com/repos/"$REPO_NAME"/releases/latest | grep -P 'browser_download_url.*linux_amd64.tar.gz' | cut -d '"' -f 4 | xargs curl -L -o "/tmp/$APP_NAME.tar.gz"

# Extract the downloaded tar.gz file
tar -xzf "/tmp/$APP_NAME.tar.gz" -C "/tmp/gh"

#search for the gh binary in the extracted files
GH_BINARY=$(find /tmp/gh -type f -name "gh" -executable | head -n 1)

# Move the gh binary to the bin directory
mv "/$GH_BINARY" "$BIN_DIR/$APP_NAME"

#Make the binary executable
chmod +x $BIN_DIR/$APP_NAME


