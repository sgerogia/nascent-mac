#!/usr/bin/env bash

# Shamelessly reverse engineered from https://github.com/lafarer/ansible-role-osx-defaults/tree/master/tasks

echo "----> Menu extras ..."
defaults write com.apple.systemuiserver menuExtras -array \
  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
  "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  "/System/Library/CoreServices/Menu Extras/Clock.menu"

### AppStore ###
echo "----> AppStore ..."
defaults write com.apple.appstore Enabled -bool true                         # Enable AppStore configuration
defaults write com.apple.appstore AutomaticCheckEnabled -bool true           # Automatically check for updates
defaults write com.apple.appstore AutomaticDownloa -bool true                # Download newly available updates in the background
defaults write com.apple.appstore AutoUpdate -bool false                     # Install app updates
defaults write com.apple.appstore AutoUpdateRestartRequired -bool false      # Install OSX updates
defaults write com.apple.appstore ConfigDataInstall -bool true                # Install system data files
defaults write com.apple.appstore CriticalUpdateInstall -bool true            # Install security updates
defaults write com.apple.appstore ScheduleFrequency -int 2                    # Check for software updates (in days)
defaults write com.apple.appstore ShowDebugMenu -bool true                    # Show debug menu

### Bluetooth ###
echo "----> Bluetooth ..."
defaults write com.apple.Bluetooth Enabled -bool true                         # Enable Bluetooth configuration
defaults write com.apple.Bluetooth ShowInMenuBar -bool true                   # Show Bluetooth in menu bar

### Dashboard ###
echo "----> Dashboard ..."
defaults write com.apple.dashboard Enabled -bool true                         # Enable Dashboard configuration
defaults write com.apple.dashboard EnabledState -int 1                        # Dashboard state (1: Off, 2: As Space, 3: As Overlay)
defaults write com.apple.dashboard DontShowAsSpace -bool true                  # Don’t show Dashboard as a Space
defaults write com.apple.dashboard DevMode -bool false                         # Enable Dashboard dev mode (allows keeping widgets on the desktop)

### Date settings ###
echo "----> Date settings ..."
defaults write com.apple.timezone.auto Active -bool false                       # Set time zome automatically using current location
defaults write com.apple.menuextra.clock DateFormat -string "H:mm"              # Menu bar clock format (e.g. "EEE d MMM HH:mm", "h:mm": Default, "HH": Use a 24-hour clock, "a": Show AM/PM, "ss": Display the time with seconds
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false        # Flash the time separators
defaults write com.apple.menuextra.clock IsAnalog -bool false                   # Analog menu bar clock
sudo sntp -sS time.apple.com                                                  # Set time server
sudo systemsetup -settimezone "Europe/London"                                   # Set the timezone; see `systemsetup -listtimezones` for other values

### Displays config ###
echo "----> Displays ..."
sudo defaults write com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool true
defaults write com.apple.BezelServices dAuto -bool true                         # Automatically adjust brightness
defaults write com.apple.airplay showInMenuBarIfPresent -bool true              # Show mirroring options in the menu bar when available
defaults write NSGlobalDomain AppleFontSmoothing -int 2                         # Subpixel font rendering on non-Apple LCDs (0:Disabled, 1:Minimal, 2:Medium, 3:Smoother, 4:Strong)
sudo defaults write com.apple.windowserver DisplayResolutionEnabled -bool true          # Enable HiDPI display modes (requires restart)

### Dock config ###
echo "----> Dock ..."
defaults write com.apple.dock tilesize -float 64                                # Dock size
defaults write com.apple.dock magnification -bool true                         # Dock magnification
defaults write com.apple.dock largesize -float 128                              # Icon size of magnified Dock items
defaults write com.apple.dock orientation -string "bottom"                       # Dock orientation: left, bottom, right
defaults write com.apple.dock mineffect -string "genie"                          # Minimization effect: genie, scale, suck
defaults write com.apple.dock AppleActionOnDoubleClick -string "Maximize"        # Double-click a window's title title bar to: None, Minimize, Maximize
defaults write com.apple.dock minimize-to-application -bool true                # Minimize windows appliction into icon (true, false)
defaults write com.apple.dock launchanim -bool true                            # Animate opening applications
defaults write com.apple.dock autohide -bool false                             # Automatically hide and show the Dock
defaults write com.apple.dock show-process-indicators -bool true                 # Show indicator for open applications
defaults write com.apple.dock showhidden -bool true                           # Display translucent Dock icons for hidden applications

### Finder ###
echo "----> Finder ..."
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowTabView -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowSidebar -bool true
defaults write com.apple.finder ColumnShowIcons -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true                 # Show All Filename Extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false      # Warning when changing file extension
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder AppleShowAllFiles -bool true                    # Show all files in Finder
defaults write com.apple.finder QLEnableTextSelection -bool true

### General settings ###
echo "----> General ..."
defaults write NSGlobalDomain AppleAquaColorVariant -int 6                 # Set appearance (1: Blue, 6: Graphite)
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"                  # Use Dark menu bar and Dock (Empty or "Dark")
defaults write NSGlobalDomain _HIHideMenuBar -bool false                   # Automatically hide and show the menu bar
defaults write NSGlobalDomain AppleHighlightColor -string "Blue"              # Highlight color (Red, Orange, Yellow, Green, Blue, Purple, Pink, Brown, Graphite)
defaults write NSGlobalDomain SidebarIconSize -int 1                       # Sidebar icon size (Small: 1, Medium: 2, Large: 3)
defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"         # Scroll bar visibility (WhenScrolling, Automatic, Always)
defaults write NSGlobalDomain AppleScrollerPagingBehavior -int 0           # Click in the scrollbar to (0: Jump to the next page, 1: Jump to the spot that's clicked)
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -bool true      # Ask to keep changes when closing documents
defaults write NSGlobalDomain CloseWindowsWhenQuittingApp -bool true       # Close windows when quitting an application
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool true           # Smooth scrolling (Disable on older Macs)

### ICloud ###
echo "----> ICloud ..."
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false   # Save to iCloud by default

### Keyboard settings ###
echo "----> Keyboard ..."
defaults write NSGlobalDomain com.apple.Keyboard_fnState -bool true             # Use F1, F2, etc. keys as standard function keys
defaults write NSGlobalDomain KeyRepeat -int 0                                  # Set key repeat rate (Off: 300000, Slow: 120, Fast: 2)
defaults write NSGlobalDomain InitialKeyRepeat -int 10                      # Set delay until repeat, in milliseconds (Long: 120, Short: 15)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool true                # Disable press-and-hold for keys in favor of key repeat
defaults write com.apple.BezelServices kDim -bool true                               # Adjust keyboard brightness in low light
defaults write com.apple.BezelServices kDimTime -int 60                               # Dim keyboard after idle time (in seconds, 0 is Never)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false    # Correct spelling automatically
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false   # Use smart quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false   # Use smart dashes
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false # Use smart periods
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3                    # Full Keyboard Access (1 : Text boxes and lists only, 3 : All controls)
defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool false            # Prevent accidental Power button presses from sleeping system

### Locale settings ###
echo "----> Locale ..."
defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=GBP"      # Locale and Currency (United States : en_US@currency=USD, Great Britian : en_GB@currency=EUR)
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"        # Measure Units (Inches, Centimeters)
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true           # Force 12/24 hour time
defaults write NSGlobalDomain AppleMetricUnits -bool true              # Set Metric Units

### Mission Control ###
echo "----> Mission Control ..."
defaults write com.apple.dock mru-spaces -bool true                     # Automatically rearrange Spaces based on most recent use
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool true            # When switching to an application, switch to a Space with open windows for the application
defaults write com.apple.dock expose-group-apps -bool true                  # Group windows by application in Mission Control
defaults write com.apple.spaces spans-displays -bool true               # Displays have separate Spaces

# Show only active apps in Dock
echo "----> Miscellaneous ..."
defaults write com.apple.dock static-only -bool TRUE

# Add 'recent apps' stack in the dock
defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'

# tap-to-click
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Sleep after inactive in mins
sudo systemsetup -setcomputersleep 30

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Wake from sleep when lid open
sudo pmset lidwake 1

echo "----> Bump Mac services ..."
# Restart services for settings to take effect
sudo killall "Activity Monitor"
sudo killall "App Store"
sudo killall SystemUIServer
sudo killall Dock
sudo killall Finder
sudo killall mds

