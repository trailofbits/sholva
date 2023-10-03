# circuitous artifacts

documenting the process of consuming a circuitous artifact with the sholva ZK
proof compilation pipeline.

## end-to-end testing via iVerilog

use the tiny86 tooling,

```sh
$ nix develop .#tiny86
```

From a given trace, compile a test vector:

```sh
$ e2egen circuit.trace.txt > circuit.e2e.tv
```

In `circuit.tb.yml`, configure the DUT to point to the module's Verilog with the
appropriate signature, using the generated test vector:

```yaml
module: circuit
file: ./circuit.v
inputs:
  - "1526 current"
  - "1526 next"
outputs:
  - "1 result"

vector_specs: []

extra_vectors: circuit.e2e.tv
```

Compile the test configuration into a Verilog test bench,

```sh
$ tbgen circuit.tb.yml
```

Check the `$readmemb` macro in the compiled Verilog (`circuit.tb.gen.v`) points to the test vector:

```verilog
    $readmemb("circuit.e2e.tv", test_vectors);
```

Finally, compile the Verilog test bench into an executable VVP file with
iVerilog,

```sh
$ iverilog circuit.tb.gen.v circuit.v
```

(this may also reveal useful errors related to `circuit.v`.)
