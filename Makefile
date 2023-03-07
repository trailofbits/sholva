.PHONY: all
all:
	$(MAKE) -C tiny86 all

.PHONY: lint
lint:
	$(MAKE) -C tiny86 lint
	$(MAKE) -C mttn lint

.PHONY: format
format:
	$(MAKE) -C mttn format

.PHONY: test
test: all
	$(MAKE) -C test test

.PHONY: docker
docker: docker.nix
	nix-build docker.nix
	docker load < result

.PHONY: install
install:

.PHONY: dev-test
	$(MAKE) -C test _test-dev

clean:
	$(MAKE) -C tiny86 clean
	$(MAKE) -C mttn clean
	$(MAKE) -C test clean
