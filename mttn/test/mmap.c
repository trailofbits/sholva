#include <stddef.h>
#include <sys/mman.h>

int main(int ac, char *av[]) {
    int *ptr = mmap(NULL, 10 * sizeof(int), PROT_READ | PROT_WRITE, MAP_ANONYMOUS, 0, 0);
    return munmap(ptr, 10 * sizeof(int));
}
