SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules


help:
	@printf "Usage: make [target] [VARIABLE=value]\nTargets:\n"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

hooks: ## Setup pre commit.
	@pre-commit install
	@pre-commit gc
	@pre-commit autoupdate

validate: ## Validate files with pre-commit hooks
	@pre-commit run --all-files

build: ## Docker build
	@docker build -t opa .

check-cmd:
ifndef name
		$(error The name variable is not set)
endif
ifneq ($(findstring ex,$(name)),ex)
		$(error The name variable does not contain 'ex')
endif

check-num:
ifndef num
		$(error The num variable is not set)
endif

create: ## Create new template name=exN. Should fail if exercise exists.
create: check-cmd
	@mkdir playground/$(name)
	@cp -r playground/template/ playground/$(name)/
	@tree playground/$(name)

run: ## Run tests
	@opa eval --format pretty --data playground/ex1/apply.rego --input apply.json 'data.terraform.apply'

ex: EXERCISES = $(shell cd playground; find . -type d -maxdepth 1 | grep 'ex' | sed 's@./@@')
ex: ## Exercices
	@echo $(EXERCISES)

tests: ## Run tests for num=1...99.
tests: check-num
	@opa test -v ./playground/ex$(num)
