#include <unistd.h>

int main(int ac, char *av[]) {
    int base = sbrk(0);
    return 0;
}
