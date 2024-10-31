SHELL := /bin/bash
.PHONY: help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

clean: ## Clean the project using cargo
	cargo clean

build: ## Build the project using cargo
	cargo build

run: ## Run the project using cargo
	cargo run

test: ## Run the tests using cargo
	cargo test

lint: ## Run the linter using cargo
	@rustup component add clippy 2> /dev/null
	cargo clippy

format: ## Format the code using cargo
	@rustup component add rustfmt 2> /dev/null
	cargo fmt

bump: ## Bump the version of the project
	@echo "Current version is $(shell cargo pkgid | cut -d# -f2)"
	@read -p "Enter the new version: " version; \
	updated_version=$$(cargo pkgid | cut -d# -f2 | sed "s/$(shell cargo pkgid | cut -d# -f2)/$$version/"); \
	sed -i -E "s/^version = .*/version = \"$$updated_version\"/" Cargo.toml
	@echo "Version bumped to $$(cargo pkgid | cut -d# -f2)"
	rm Cargo.toml-e