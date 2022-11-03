MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(MAKEFILE_PATH)))
IMAGE_NAME := trailofbits/openjdk-i386

.PHONY: run
run: docker
	docker run -it --rm --mount type=bind,source="$(shell pwd)",target=/workdir $(IMAGE_NAME) /bin/bash

.PHONY: docker
docker: .last_built

.last_built: Dockerfile
	docker build -t $(IMAGE_NAME) -f $(MAKEFILE_DIR)/Dockerfile $(MAKEFILE_DIR)
	@touch .last_built
	@echo Built $(IMAGE_NAME)

.PHONY: rebuild
rebuild:
	docker build --no-cache -t $(IMAGE_NAME) -f $(MAKEFILE_DIR)/Dockerfile $(MAKEFILE_DIR)
	@touch .last_built
	@echo Built $(IMAGE_NAME)

.PHONY: clean
clean:
	@rm -f .last_built
	-docker image rm $(IMAGE_NAME)
