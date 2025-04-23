// setup brew
which -s brew
if [[ $? != 0 ]] ; then
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew install 1password
# brew install awscli
# brew install cloudapp
# brew install docker
brew install fish
brew install fisher
# brew install google-chrome
# brew install iterm2
brew install mise
# brew install numi
# brew install slack
# brew install rectangle
# brew install spotify
# brew install steam
brew install stow
# brew install visual-studio-code
brew install z

// set up fish shell
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
