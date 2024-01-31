#include <stdio.h>

int main () {
    int a = 5;
    int b = 10;

    if (a < 10 && b > 5) {
        printf("a is less than 10 and b is greater than 5\n");
    } else if (a < 10 || b > 5) {
        printf("a is less than 10 or b is greater than 5\n");
    } else if (!(a < 10)) {
        printf("a is not less than 10\n");
    } else {
        printf("a is not less than 10 and b is not greater than 5\n");
    }

    return 0;
}