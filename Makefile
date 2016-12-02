BUILD_NAME = hstatic/stack-build
VERSION = 0.1.0.0
NAME = hstatic-example
BIN_PATH := dist
TARGETS := $(BIN_PATH)/$(NAME)

# Global
.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	-@stack clean
	-@docker rmi $(BUILD_NAME)
	-@docker rmi $(BUILD_NAME):$(VERSION)
	-@docker rmi $(NAME)
	-@rm -rf dist

# Stack
$(TARGETS):
	@$(MAKE) build_docker tag_latest
	@mkdir -p dist
	@stack build --copy-bins

.PHONY: image
image: $(TARGETS)
	@stack image container --no-build

# Docker
.PHONY: build_docker
build_docker:
	docker build -t $(BUILD_NAME):$(VERSION) --rm Docker

.PHONY: tag_latest
tag_latest:
	docker tag $(BUILD_NAME):$(VERSION) $(BUILD_NAME):latest

# Runners
.PHONY: run
run: $(TARGETS)
	@stack exec $(NAME)

.PHONY: run_image
run_image: image
	@docker run -it --rm $(NAME) /usr/local/bin/$(NAME)
