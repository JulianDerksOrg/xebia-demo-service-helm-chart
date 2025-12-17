# Helm Chart Makefile
CHART_DIR := chart
CHART_NAME := $(shell helm show chart $(CHART_DIR) | awk -F': ' '/^name:/{print $$2; exit}')
CHART_VERSION := $(shell helm show chart $(CHART_DIR) | awk -F': ' '/^version:/{print $$2; exit}')
REGISTRY := europe-west4-docker.pkg.dev/sandbox-9456/helm

# Colors
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m

.PHONY: help setup lint generate package push clean build status

help: ## Display this help message
	@echo "$(BLUE)Available targets:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: ## Set up development environment
	@echo "$(YELLOW)Setting up development environment...$(NC)"
	@if ! command -v readme-generator &> /dev/null; then \
		echo "Installing readme-generator-for-helm..."; \
		npm install -g @bitnami/readme-generator-for-helm; \
	fi
	@echo "$(GREEN)✓ Development environment ready$(NC)"

lint: ## Lint the Helm chart
	@echo "$(YELLOW)Linting chart...$(NC)"
	@helm lint $(CHART_DIR)
	@echo "$(GREEN)✓ Linting completed$(NC)"

template: ## Template the Helm chart
	@echo "$(YELLOW)Templating chart...$(NC)"
	@helm template $(CHART_DIR)
	@echo "$(GREEN)✓ Templating completed$(NC)"

generate: ## Generate schema and documentation
	@echo "$(YELLOW)Generating docs and schema...$(NC)"
	@readme-generator --values=$(CHART_DIR)/values.yaml --readme=$(CHART_DIR)/README.md --schema=$(CHART_DIR)/values.schema.json --config=docs/.readme-generator.json
	@echo "$(GREEN)✓ Generation completed$(NC)"

package: ## Package the Helm chart
	@echo "$(YELLOW)Packaging chart...$(NC)"
	@helm package $(CHART_DIR)
	@echo "$(GREEN)✓ Chart packaged$(NC)"

push: package ## Push chart to registry
	@echo "$(YELLOW)Pushing to registry...$(NC)"
	@gcloud auth print-access-token | helm registry login -u oauth2accesstoken --password-stdin https://europe-west4-docker.pkg.dev
	@helm push $(CHART_NAME)-$(CHART_VERSION).tgz oci://$(REGISTRY)
	@echo "$(GREEN)✓ Chart pushed to $(REGISTRY)$(NC)"

clean: ## Clean up generated files
	@echo "$(YELLOW)Cleaning up...$(NC)"
	@rm -f *.tgz
	@echo "$(GREEN)✓ Cleanup completed$(NC)"

build: generate lint package ## Build pipeline (generate, lint, package)

ci-release: build push clean ## CI release pipeline

status: ## Show chart information
	@echo "$(BLUE)Chart Information:$(NC)"
	@echo "  Name: $(CHART_NAME)"
	@echo "  Version: $(CHART_VERSION)"
	@echo "  Registry: $(REGISTRY)"
