# NOTE(jl): these files are not commited locally, and are passed from the output of mttn.
TRACES := $(wildcard *.trace.txt)

.PHONY: test
all: $(TRACES:.trace.txt=.circuit)

.PHONY: test
test: $(TRACES:.trace.txt=.verify)

#
# IR Backend
#
.PHONY: %.verify
%.verify: %.circuit
	wtk-firealarm $^ $(basename $^).public_input $(basename $^).private_input

%.trace.txt: %.s
	cp $< ../mttn/test/$<
	make -C ../mttn/test $@
	mv ../mttn/test/$@ .

%.circuit %.public_input %.private_input: %.trace.txt tiny86.blif
	sv-compositor -b tiny86.blif -w $< -o $(basename $@)

.PHONY: clean
clean:
	rm -f *.trace.txt *.circuit *.*_input tiny86.blif
