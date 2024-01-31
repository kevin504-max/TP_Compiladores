#include <stdio.h>

int main () {
    int sum = 0;

    for (int i = 0; i < 10; i++) {
        sum += i;
    }

    printf("Sum: %d\n", sum);
    printf("Mean: %d\n", sum / 10);

    return 0;
}