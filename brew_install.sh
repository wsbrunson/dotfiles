which -s brew
if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

// install cask
brew tap caskroom/cask
brew install caskroom/cask/brew-cask

brew install yamllint
brew install neofetch

brew install --cask firefox
brew install --cask spotify
brew install --cask iterm2
brew install --cask 1password
brew install --cask spectacle
brew install --cask steam

