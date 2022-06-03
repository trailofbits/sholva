#include <cstdlib>

#include <verilated.h>

#include "Valu.h"

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);

  Valu *top = new Valu;

  while(!Verilated::gotFinish()) {
    top->eval();
  }

  top->final();

  delete top;

  return EXIT_SUCCESS;
}

