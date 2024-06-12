#!/usr/bin/env bash

if [[ ! -f "/Users/sgerogia/.bash_profile" ]]; then
  echo "----> Creating .bash_profile"
  cp ../dotfiles/bash_profile.local "/Users/sgerogia/.bash_profile"
else
  echo "----> .bash_profile already exists"
fi

echo "----> Installing SDKMan"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"


echo "----> Replacing .bash_sgerogia"
cp ../dotfiles/bash_sgerogia.local "/Users/sgerogia/.bash_sgerogia"

echo "----> Replacing .inputrc"
cp ../dotfiles/inputrc.local "/Users/sgerogia/.inputrc"


if [[ ! -f "/private/etc/sudoers.d/mysudo" ]]; then
  echo "----> Enabling passwordless sudo"
  sudo bash -c 'echo "sgerogia            ALL = (ALL) NOPASSWD: ALL" > "/private/etc/sudoers.d/mysudo"'
else
  echo "----> Passwordless sudo is already enabled"
fi