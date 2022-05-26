PROJ = Project
MAIN = topEntity
TOP = $(PROJ).$(MAIN)

verilog/$(TOP)/$(MAIN).v: src/$(PROJ).hs
	stack run -- clash src/$(PROJ).hs --verilog

.PHONY: test
test:
	stack test

.PHONY: clashi
clashi:
	stack run -- clashi

.PHONY: clean
clean:
	stack clean
	rm -rf verilog/
