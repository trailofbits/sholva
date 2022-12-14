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

<<<<<<< HEAD
<<<<<<< HEAD
.PHONY: test
test: all
	$(MAKE) -C test test

.PHONY: docker
docker: docker.nix
	nix-build docker.nix
	docker load < result

.PHONY: install
install:

=======
>>>>>>> 3742971 (TEST(jl): buffer overflow artifacts.)
.PHONY: stat
stat:
	$(MAKE) -C tiny86 stat

.PHONY: test
test:
	$(MAKE) -C test test

# generate traces for all benchmark programs/exploits.
.PHONY: benchmarks
benchmarks:
	$(MAKE) -C test buffer_overflow_benchmark
	$(MAKE) -C test nop_benchmark

# generate ZK artifacts.
.PHONY: artifacts
artifacts: tiny86/tiny86.blif
	TOP_CIRCUIT=$(abspath $<) $(MAKE) -C test artifacts

.PHONY: clean
clean:
	$(MAKE) -C tiny86 clean
	$(MAKE) -C mttn clean
	$(MAKE) -C test clean
