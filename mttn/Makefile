.PHONY: all
all:
	cargo build

.PHONY: format
format:
	cargo fmt && git diff --exit-code

.PHONY: lint
lint:
	cargo-clippy -Dwarnings

.PHONY: test
test:
	cargo test

.PHONY: clean
clean:
	cargo clean
