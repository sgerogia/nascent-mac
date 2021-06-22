#!/usr/bin/env bash

SRC_DIR=~/src/github.com/sgerogia
SETTINGS_PROJECT=nascent-mac

echo "----> Updating XCode..."
xcode-select --install || true

sudo xcodebuild -license accept

chmod +x ./scripts/*.sh

echo "----> Updating Mac. Hold on tight!..."

./scripts/shell.sh

./scripts/homebrew.sh

./scripts/osx.sh

./scripts/post_setup.sh