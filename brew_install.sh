which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew install 1password
brew install awscli
brew install firefox
brew install fnm
brew install google-chrome
brew install iterm2
brew install spectacle
brew install spotify
brew install steam
brew install visual-studio-code
brew install yamllint
