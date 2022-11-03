.PHONY: all
all:
	$(MAKE) -C tiny86 all
	$(MAKE) -C mttn all

.PHONY: lint
lint:
	$(MAKE) -C tiny86 lint
	$(MAKE) -C mttn lint

.PHONY: format
format:
	$(MAKE) -C mttn format

.PHONY: test
test:
	# mttn self tests
	$(MAKE) -C mttn test
	# integration tests
	$(MAKE) -C test test

clean:
	$(MAKE) -C tiny86 clean
	$(MAKE) -C mttn clean
	$(MAKE) -C test clean
