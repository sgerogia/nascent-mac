#!/usr/bin/env bash

# Shamelessly adapted from https://github.com/pathikrit/mac-setup-script/blob/master/install.sh

brews=(
  awscli
  bash
  "bash-snippets --without-all-tools --with-cheat --with-cryptocurrency --with-currency --with-geo --with-qrify --with-siteciphers --with-stocks --with-weather"
  bat
  cockroachdb/tap/cockroach
  coreutils
  dfc
  exa
  findutils
  "fontconfig --universal"
  fpp
  gh
  git
  git-extras
  git-filter-repo
  git-fresh
  git-lfs
  "gnuplot --with-qt"
  "gnu-sed --with-default-names"
  go
  gpg
  gradle
  grpcurl
  helm
  heroku
  htop
  httpie
  iftop
  "imagemagick --with-webp"
  jenv
  jq
  kind
  kubectl
  lnav
  m-cli
  mackup
  maven
  micro
  moreutils
  mtr
  ncdu
  neofetch
  nmap
  node
  nvm
  pdfgrep
  poppler
  postgresql
  protobuf
  pgcli
  pv
  python
  python3
  rbenv
  ruby
  ruby-build
  shellcheck
  stormssh
  tmux
  tree
  trash
  truffle
  yarn
  "vim --with-override-system-vi"
  "wget --with-iri"
)

# Install some stuff before others!
important_casks=(
  google-chrome
  hyper
  istat-menus
  visual-studio-code
  slack
)

casks=(
  1password
  aerial
  adobe-acrobat-pro
  cakebrew
  cleanmymac
  clocker
  discord
  docker
  expressvpn
  ganache
  geekbench
  google-cloud-sdk
  github
  goland
  intellij-idea-ce
  iterm2
  kap
  keka
  launchrocket
  macvim
  monitorcontrol
  notion
  qlcolorcode
  qlmarkdown
  qlstephen
  quicklook-json
  quicklook-csv
  satellite-eyes
  sidekick
  signal
  skype
  sloth
  stats
  sublime-text
  virtualbox
  vlc
  whatsapp
)

pips=(
  pip
  glances
  ohmu
  pythonpy
)

gems=(
  bundler
  travis
)

git_email='sgerogia@gmail.com'
git_name='Stelios Gerogiannakis'
git_configs=(
  "branch.autoSetupRebase always"
  "color.ui auto"
  "core.autocrlf input"
  "credential.helper osxkeychain"
  "merge.ff false"
  "pull.rebase true"
  "push.default simple"
  "rebase.autostash true"
  "rerere.autoUpdate true"
  "remote.origin.prune true"
  "rerere.enabled true"
  "user.name ${git_name} "
  "user.email ${git_email}"
)

vscode=(
  alanz.vscode-hie-server
  ms-vsonline.vsonline
  rebornix.Ruby
  redhat.java
  rust-lang.rust
)

fonts=(
  font-fira-code
  font-source-code-pro
)

######################################## End of app list ########################################
set +e
set -x

function prompt {
  if [[ -z "${CI}" ]]; then
    read -p "Hit Enter to $1 ..."
  fi
}

function install {
  cmd=$1
  shift
  for pkg in "$@";
  do
    exec="$cmd $pkg"
    if ${exec} ; then
      echo "Installed $pkg"
    else
      echo "Failed to execute: $exec"
      if [[ ! -z "${CI}" ]]; then
        exit 1
      fi
    fi
  done
}

function brew_install_or_upgrade {
  if brew ls --versions "$1" >/dev/null; then
    if (brew outdated | grep "$1" > /dev/null); then
      echo "Upgrading already installed package $1 ..."
      brew upgrade "$1"
    else
      echo "Latest $1 is already installed"
    fi
  else
    brew install "$1"
  fi
}

if [[ -z "${CI}" ]]; then
  sudo -v # Ask for the administrator password upfront
  # Keep-alive: update existing `sudo` time stamp until script has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

if test ! "$(command -v brew)"; then
  echo "----> Install Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  if [[ -z "${CI}" ]]; then
    echo "----> Update Homebrew"
    brew update
    brew upgrade
    brew doctor
  fi
fi
export HOMEBREW_NO_AUTO_UPDATE=1

echo "----> Install software ..."
brew tap homebrew/cask-versions
install 'brew install --cask ' "${important_casks[@]}"

echo "----> Install packages ..."
brew tap heroku/brew
install 'brew_install_or_upgrade ' "${brews[@]}"
brew link --overwrite ruby

echo "----> Set git defaults ..."
for config in "${git_configs[@]}"
do
  git config --global ${config}
done

if [[ ! -f "/Users/sgerogia/.ssh/id_rsa.pub" ]]; then
  echo "----> Export key to Github ..."
  ssh-keygen -t rsa -b 4096 -C ${git_email}
  pbcopy < ~/.ssh/id_rsa.pub
  open https://github.com/settings/ssh/new
fi

echo "----> Upgrade bash ..."
brew install bash bash-completion2 fzf
sudo bash -c "echo $(brew --prefix)/bin/bash >> /private/etc/shells"
sudo chsh -s "$(brew --prefix)"/bin/bash
# Install https://github.com/twolfson/sexy-bash-prompt
touch ~/.bash_profile #see https://github.com/twolfson/sexy-bash-prompt/issues/51
(cd /tmp && git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt && cd sexy-bash-prompt && make install) && source ~/.bashrc

echo "----> Install software ..."
install 'brew install --cask ' "${casks[@]}"

echo "----> Install secondary packages ..."
install 'pip3 install --upgrade ' "${pips[@]}"
install 'sudo gem install ' "${gems[@]}"
install 'npm install --global ' "${npms[@]}"
install 'code --install-extension ' "${vscode[@]}"

echo "----> Update packages ..."
pip3 install --upgrade pip setuptools wheel
if [[ -z "${CI}" ]]; then
  m update install all
fi

echo "----> Cleanup ..."
brew cleanup
