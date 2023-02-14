help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
LDFLAGS ?=

build: ## golang build
	env CGO_ENABLED=0 GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o 'bin/proxy' ./main.go


docker-build: ## build docker image
	docker build . -f Dockerfile -t kiser/chatgpt-proxy:v0.0.5