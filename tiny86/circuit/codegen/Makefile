ENCODINGS_SPEC = encodings.spec
COMMANDS_JSON = commands.json
GENS = commands.gen.v opc_map.gen.v

.PHONY: all
all: $(GENS)

$(GENS): codegen.py $(COMMANDS_JSON)
	python3 codegen.py

$(COMMANDS_JSON): parse_encodings.py $(ENCODINGS_SPEC)
	python3 parse_encodings.py


.PHONY: clean
clean:
	rm -rf $(GENS) $(COMMANDS_JSON)
