# Dotfiles export helpers.
#
# `make dotfiles` builds a host's home-manager file tree and copies it into a
# plain directory (OUT) so it can be pushed into a separate dotfiles repo.

HOST ?= laptop
OUT  ?= ./dotfiles
USER ?= ntreml

# macbook is a standalone home-manager (darwin) config; every other host is a
# NixOS system with home-manager integrated.
ifeq ($(HOST),macbook)
ATTR = homeConfigurations."$(USER)@macbook".config.home-files
else
ATTR = nixosConfigurations.$(HOST).config.home-manager.users.$(USER).home-files
endif

.PHONY: help dotfiles

help:
	@echo "Targets:"
	@echo "  dotfiles   Export a host's dotfiles into OUT (default ./dotfiles)"
	@echo ""
	@echo "Variables:"
	@echo "  HOST   Source host: laptop|desktop|vm|wsl|macbook (default laptop)"
	@echo "  OUT    Output directory (default ./dotfiles)"
	@echo "  USER   Home-manager user (default ntreml)"
	@echo ""
	@echo "Examples:"
	@echo "  make dotfiles"
	@echo "  make dotfiles HOST=wsl"
	@echo "  make dotfiles HOST=desktop OUT=~/code/dotfiles"

dotfiles:
	@test -n "$(OUT)" || { echo "OUT must not be empty"; exit 1; }
	@echo ">> Building home-manager files for host '$(HOST)' (user '$(USER)')..."
	@storepath=$$(nix build --no-link --print-out-paths ".#$(ATTR)") || exit 1; \
	echo ">> Store path: $$storepath"; \
	echo ">> Exporting to '$(OUT)'..."; \
	mkdir -p "$(OUT)"; \
	find "$(OUT)" -mindepth 1 -maxdepth 1 -not -name .git -exec rm -rf {} +; \
	cp -RL "$$storepath"/. "$(OUT)/"; \
	chmod -R u+w "$(OUT)"; \
	count=$$(grep -rlI /nix/store "$(OUT)" 2>/dev/null | wc -l); \
	echo ">> Done. Dotfiles written to '$(OUT)'."; \
	if [ "$$count" -gt 0 ]; then \
		echo ""; \
		echo "WARNING: $$count file(s) reference /nix/store and will not work on a non-Nix machine."; \
		echo "         Review them before pushing:"; \
		echo "           grep -rlI /nix/store '$(OUT)'"; \
	fi
