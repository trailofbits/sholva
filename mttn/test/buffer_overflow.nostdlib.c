#ifndef BUF_LEN
#error "-DBUF_LEN undefined! Define a length in CFLAGS."
#endif

char *strcpy(char *dst, const char *src) {
  char *temp = dst;
  while ((*dst++ = *src++))
    ;
  return temp;
}

void f(char *str) {
  char buffer[BUF_LEN / 2];
  strcpy(buffer, str);
}

int main() {
  char buf[BUF_LEN];

  for (unsigned int i = 0; i < BUF_LEN - 1; i++)
    buf[i] = 'A';
  f(buf);

  // forced exit
  __asm__(
    "mov $1, %eax\n\t"
    "int $0x80\n\t"
  );

  return 0;
}
