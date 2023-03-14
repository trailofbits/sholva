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

# general test suite.
.PHONY: test
test: all
	$(MAKE) -C test test

# tests including any development-only tooling.
.PHONY: dev-test
dev-test:
	$(MAKE) -C test artifacts

.PHONY: install
install:

.PHONY: clean
clean:
	$(MAKE) -C test clean
