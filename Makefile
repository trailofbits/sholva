.PHONY: all
all:

.PHONY: lint
lint:
	$(MAKE) -C tiny86 lint
	$(MAKE) -C mttn lint

.PHONY: format
format:
	$(MAKE) -C mttn format

.PHONY: test
test:
	$(MAKE) -C test test

.PHONY: docker
docker: docker.nix
	nix-build docker.nix
	docker load < result

.PHONY: install
install:

clean:
	$(MAKE) -C tiny86 clean
	$(MAKE) -C mttn clean
	$(MAKE) -C test clean
