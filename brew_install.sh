which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew install 1password
brew install awscli
brew install datagrip
brew install docker
brew install firefox
brew install fnm
brew install google-backup-and-sync
brew install google-chrome
brew install iterm2
brew install numi
brew install slack
brew install spectacle
brew install spotify
brew install steam
brew install visual-studio-code
brew install yamllint
