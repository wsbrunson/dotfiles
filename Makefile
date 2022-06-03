include stow/.env

.DEFAULT: install

install: preinstall install_brew stow

preinstall:
	@echo "updated submodules"
	git submodule update --init --recursive
	@echo "copying fonts"
	cp -v ./fonts/* ~/Library/Fonts

install_brew:
	./scripts/brew_install.sh

setup_node_manager:
ifeq ($(NODE_MANAGER), "fnm")
	@echo "Use fnm as node manager"
	stow -R -d node_manager -t ~/ fnm
else
	@echo "Use nvm as node manager"
	stow -R -d node_manager -t ~/ nvm
endif

.PHONY: stow
stow: setup_node_manager
	stow -R -t ~/ stow
