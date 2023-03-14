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

# tests including any development-only tooling.
.PHONY: dev-test
dev-test:
	$(MAKE) -C test _test-dev

# general test suite.
.PHONY: test
test: all
	$(MAKE) -C test test

.PHONY: install
install:

# generate ZK artifacts.
.PHONY: artifacts
artifacts:
	$(MAKE) -C test artifacts

.PHONY: clean
clean:
	$(MAKE) -C test clean
