#!/usr/bin/env bash

# Add the new shell to the list of allowed shells
bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell
chsh -s /usr/local/bin/bash

# Change computer name on the command line and Bonjour services
scutil --set ComputerName "unicorn"
scutil --set LocalHostName "unicorn"

# Show only active apps in Dock
defaults write com.apple.dock static-only -bool TRUE

# Click on a single app hides all others
defaults write com.apple.dock single-app -bool TRUE

# Add 'recent apps' stack in the dock
defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'

# Indicate hidden apps in Dock
defaults write com.apple.dock showhidden -bool TRUE

# tap-to-click
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Sleep after inactive in mins
systemsetup -setcomputersleep 10

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


# Wake from sleep when lid open
pmset lidwake 1

# Restart dock
killall Dock
