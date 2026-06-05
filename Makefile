# Variables
DOTBOT_DIR := dotbot
DOTBOT_BIN := $(DOTBOT_DIR)/bin/dotbot
CONFIG := dotbot.yaml

# Colors (auto-disabled if make output is piped)
RED     := $(shell printf '\033[31m')
GREEN   := $(shell printf '\033[32m')
YELLOW  := $(shell printf '\033[33m')
BLUE    := $(shell printf '\033[34m')
MAGENTA := $(shell printf '\033[35m')
CYAN    := $(shell printf '\033[36m')
RESET   := $(shell printf '\033[0m')

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

install: update install_public install_private install_personal install_work

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
	@./scripts/make/mackup-run.sh backup $(MACKUP_FLAGS) ~/.config/mackup/mackup-work.cfg

install_public:
	@$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v -c $(CONFIG)

install_private:
	@$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v -d private -c private/$(CONFIG)
	@./scripts/make/mackup-run.sh restore $(MACKUP_FLAGS)

install_work:
	@if ./scripts/make/check-hostname.sh private/work_hostnames; then \
		$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v -d private -c private/dotbot-work.yaml; \
		./scripts/make/mackup-run.sh restore $(MACKUP_FLAGS) ~/.config/mackup/mackup-work.cfg; \
	else \
		echo "$(YELLOW) Skipping work install (not a work machine)$(RESET)"; \
	fi

install_personal:
	@if ! ./scripts/make/check-hostname.sh private/work_hostnames; then \
		$(DOTBOT_BIN) $(DOTBOT_FLAGS) -v -d private -c private/dotbot-personal.yaml; \
	else \
		echo "$(YELLOW) Skipping personal install (work machine)$(RESET)"; \
	fi

help:
	@echo "$(GREEN)Usage:$(RESET) $(MAGENTA)make $(BLUE)[target]$(RESET)"
	@echo ""
	@echo "$(GREEN)Targets:$(RESET)"
	@echo "  $(BLUE)install$(RESET)            Install all dotfiles (public + private + work)"
	@echo "  $(BLUE)install_public$(RESET)     Install only public dotfiles"
	@echo "  $(BLUE)install_private$(RESET)    Install private dotfiles + mackup restore"
	@echo "  $(BLUE)install_personal$(RESET)   Install personal configs only"
	@echo "  $(BLUE)install_work$(RESET)       Install work dotfiles + mackup restore"
	@echo "  $(BLUE)update$(RESET)             Update repositories from git"
	@echo "  $(BLUE)link$(RESET)               Run public dotfiles link only"
	@echo "  $(BLUE)clean$(RESET)              Remove dead symlinks"
	@echo "  $(BLUE)brew_install$(RESET)       Install Brewfile packages"
	@echo "  $(BLUE)backup$(RESET)             Backup files/apps with Brew and Mackup"
	@echo "  $(BLUE)mackup$(RESET)             Sync mackup ignore list and run backup"
	@echo "  $(BLUE)brew_dump$(RESET)          Dump current brew packages to Brewfile"
	@echo "  $(BLUE)help$(RESET)               Show this help"
