which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew install 1password
brew install antigen
brew install awscli
brew install cloudapp
brew install docker
brew install firefox
brew install fnm
brew install fzf
brew install google-chrome
brew install iterm2
brew install numi
brew install slack
brew install rectangle
brew install spotify
brew install starship
brew install steam
brew install stow
brew install superfly/tap/flyctl
brew install visual-studio-code
brew install z
