bash setup-home-manager.sh

which zsh | sudo tee -a /etc/shells

chsh -s $(which zsh)
