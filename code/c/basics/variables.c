/* 变量与基本类型练习
 * 编译：gcc variables.c -o variables && ./variables
 */
#include <stdio.h>

int main(void)
{
    int    age = 30;
    double pi  = 3.14159;
    char   ch  = 'A';

    printf("age=%d, pi=%.4f, ch=%c\n", age, pi, ch);
    printf("sizeof(int)=%zu, sizeof(double)=%zu, sizeof(char)=%zu\n",
           sizeof(int), sizeof(double), sizeof(char));
    return 0;
}
