#!/usr/bin/env bash

# Add the new shell to the list of allowed shells
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell
chsh -s /usr/local/bin/bash

# Change computer name on the command line and Bonjour services
scutil --set ComputerName "unicorn_v2"
scutil --set LocalHostName "unicorn_v2"
