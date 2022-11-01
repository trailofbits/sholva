/* seteip.c: set EIP from the command line
 *
 *  $(CC) -g -m32 -mtune=i386 -Wl,-emain -nostdlib -static -std=c99 seteip.c \
 *        -o seteip.elf -mpreferred-stack-boundary=2 -fno-stack-protector \
 *        -z execstack
 */

char *strcpy(char *dst, const char *str);

// note that argv is a raw string here, since we're in nostdlib.
int main(int argc, char const *argv) {
  char lol[8];

  // saved EIP is 12 bytes (thanks to padding) from ESP, so we write directly
  // here instead of expecting padding in the input
  strcpy(lol + 12, argv);
  return 0;
}

char *strcpy(char *dst, const char *src) {
  char *temp = dst;
  while (*dst++ = *src++)
    ;
  return temp;
}
