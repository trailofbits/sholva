int sum(int x, int y) {
  return x + y;
}

int main(int argc, char** argv) {
  sum(3, 4);

  // HACK: Call exit(2) explicitly so that we don't fall off the end of the world.
  __asm__(
    "mov $1, %eax\n\t"
    "int $0x80\n\t"
  );

  return 0; // unreachable
}
