#include <sys/random.h>
#include <errno.h>

int main(int ac, char *av[]) {
    unsigned char buf[4];
    ssize_t r = getrandom(&buf, 4, 0);
    return r == 4 ? 0 : errno;
}
