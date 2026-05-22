# Variables
DOTBOT_DIR := dotbot
DOTBOT_BIN := $(DOTBOT_DIR)/bin/dotbot
CONFIG := dotbot.yaml

# Dry Run setting
DRY_RUN ?=
ifdef DRY_RUN
	DOTBOT_FLAGS := -n
	MACKUP_FLAGS := -n
else
	DOTBOT_FLAGS :=
	MACKUP_FLAGS :=
endif

.PHONY: all brew_dump brew_install clean install help link update mackup

# Default target
all: install

install: update install_public install_private install_work

backup: brew_dump mackup

update:
	@git pull
	@git submodule sync --quiet --recursive
	@git submodule update --init --recursive
	@git submodule update --remote private

clean:
	@$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v --only clean -d . -c $(CONFIG)

link:
	@$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v --only link -d . -c $(CONFIG)

brew_install:
	@$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v --only brew -d . -c $(CONFIG)

brew_dump:
	@brew bundle dump -g --force
	@./scripts/make/brew-exclude.sh private/work/Brewfile

mackup:
	@./scripts/make/sync-mackup.sh
	@./scripts/make/mackup-run.sh backup $(MACKUP_FLAGS)
	@./scripts/make/mackup-run.sh backup $(MACKUP_FLAGS) private/mackup/mackup-work.cfg

install_public:
	@$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v -c $(CONFIG)

install_private:
	@$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v -d private -c private/$(CONFIG)
	@./scripts/make/mackup-run.sh restore $(MACKUP_FLAGS)

install_work:
	@if ./scripts/make/check-hostname.sh private/work_hostnames; then \
		$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v -d private -c private/dotbot-work.yaml; \
		./scripts/make/mackup-run.sh restore $(MACKUP_FLAGS) private/mackup/mackup-work.cfg; \
	else \
		echo "⚠ Skipping work install (not a work machine)"; \
	fi

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install         Install all dotfiles (public + private + work)"
	@echo "  install_public  Install only public dotfiles"
	@echo "  install_private Install private dotfiles + mackup restore"
	@echo "  install_work    Install work dotfiles + mackup restore"
	@echo "  link            Run public dotfiles link only"
	@echo "  brew_install    Install Brewfile packages"
	@echo "  brew_dump       Dump current brew packages to Brewfile"
	@echo "  mackup          Sync mackup ignore list and run backup"
	@echo "  backup          Backup files/apps with Brew and Mackup"
	@echo "  update          Update repositories from git"
	@echo "  clean           Remove dead symlinks"
	@echo "  help            Show this help"
