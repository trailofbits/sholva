MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(MAKEFILE_PATH)))
REPO_DIR := $(abspath $(MAKEFILE_DIR)/../..)
IMAGE_NAME := trailofbits/mttn

forcedentry.trace: forcedentry.elf compile
	docker run -it --rm --cap-add SYS_PTRACE --security-opt seccomp=unconfined --mount type=bind,source="$(REPO_DIR)",target=/app/mttn \
		-e RUST_LOG=info \
		--workdir=/app/mttn/test/forcedentry $(IMAGE_NAME) \
		mttn --ignore-unsupported-memops -F inst-count ./forcedentry.elf \
		> $@

forcedentry.elf: forcedentry.cpp
	docker run -it --rm --mount type=bind,source="$(REPO_DIR)",target=/app/mttn \
		--workdir=/app/mttn/test/forcedentry $(IMAGE_NAME) \
	g++ -fno-pic -g -m32 -mtune=i386 -Wl,-emain -static -mpreferred-stack-boundary=2 \
		$< -o $@ \
		-fno-stack-protector -z execstack

.PHONY: compile
compile: docker
	docker run -it --rm --security-opt seccomp=unconfined --mount type=bind,source="$(REPO_DIR)",target=/app/mttn $(IMAGE_NAME) cargo build

.PHONY: docker
docker: .last_built

.last_built: $(REPO_DIR)/Dockerfile
	docker build -t $(IMAGE_NAME) -f $(REPO_DIR)/Dockerfile $(MAKEFILE_DIR)
	@touch .last_built
	@echo Built $(IMAGE_NAME)

.PHONY: rebuild
rebuild:
	docker build --no-cache -t $(IMAGE_NAME) -f $(REPO_DIR)/Dockerfile $(MAKEFILE_DIR)
	@touch .last_built
	@echo Built $(IMAGE_NAME)

.PHONY: clean
clean:
	@rm -f .last_built
	-docker image rm $(IMAGE_NAME)
