which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew install yamllint
brew install neofetch
brew install fnm

# brew install firefox
# brew install spotify
# brew install iterm2
# brew install 1password
# brew install spectacle
# brew install steam

