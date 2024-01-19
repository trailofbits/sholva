#include <stdlib.h>

int main(int ac, char *av[]) {
    for (int ii = 0; ii < 1000; ii++) {
        void* _ = malloc(1);
    }
    return 0;
}
