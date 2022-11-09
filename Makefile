.PHONY: all
all:
	$(MAKE) -C tiny86 all
	$(MAKE) -C mttn all

lint:
	$(MAKE) -C tiny86 lint
	$(MAKE) -C mttn lint

format:
	$(MAKE) -C mttn format

test:
	$(MAKE) -C tiny86 check
	$(MAKE) -C mttn test

clean:
	$(MAKE) -C tiny86 clean
	$(MAKE) -C mttn clean
