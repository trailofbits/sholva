# cλash icebreaker template

[clash-starters](https://github.com/clash-lang/clash-starters) adapted to build for [iCEBreaker FPGA](https://icebreaker-fpga.org/).

## usage

for some top-level module (here in `Project.hs`),

```sh
$ mkdir -p build/Project.topEntity/
$ make
```

see `verilog/Project.topEntity/topEntity.v` for the copmiled verilog.
see `build/Project.topEntity/topEntity.bin` for the bitstream.

```sh
$ make prog
```

program FPGA.


## see also

example lifted from the highly recommended [Retrocomputing with Clash](https://gergo.erdi.hu/retroclash/).
