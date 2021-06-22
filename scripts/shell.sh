#!/usr/bin/env bash

echo "----> Installing SDKMan"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

if [[ ! -f "~/.bash_profile"]]; then
  echo "----> Creating .bash_profile"
  cp ./dotfiles/bash_profile.local "~/.bash_profile"
else
  echo "----> .bash_profile already exists"
fi

echo "----> Replacing .bash_sgerogia"
cp ./dotfiles/bash_sgerogia.local "~/.bash_sgerogia"

if [[ ! -f "/private/etc/sudoers.d/mysudo"]]; then
  echo "----> Enabling passwordless sudo"
  sudo touch "/private/etc/sudoers.d/mysudo"
  sudo echo "sgerogia            ALL = (ALL) NOPASSWD: ALL" > "/private/etc/sudoers.d/mysudo"
else
  echo "----> Passwordless sudo is already enabled"
fi