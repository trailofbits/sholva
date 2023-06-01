.PHONY: all
all:
	$(MAKE) -C tiny86 all

.PHONY: lint
lint:
	$(MAKE) -C tiny86 lint
	$(MAKE) -C mttn lint
	verible-verilog-lint tiny86/*.v

.PHONY: format
format:
	$(MAKE) -C mttn format
	verible-verilog-format src/*.v

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
