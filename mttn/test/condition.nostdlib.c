int add(int x, int y) {
  return x + y;
}

int main(int argc, char const *argv[]) {
  int sum = add(5, 6);

  if (sum > 10) {
    sum += add(3, 4);
  } else {
    sum += add(1, 2);
  }

  // HACK: Call exit(2) explicitly so that we don't fall off the end of the world.
  __asm__(
    "mov $1, %eax\n\t"
    "xor %ebx,%ebx\n\t"
    "int $0x80\n\t"
  );

  return 0; // unreachable
}
