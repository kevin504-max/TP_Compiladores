#include <stdio.h>

int main () {
    int count = 0;

    while (count < 10) {
        printf("Count: %d\n", count);
        count++;
    }

    printf("\nFinal Count: %d\n", count);

    return 0;
}