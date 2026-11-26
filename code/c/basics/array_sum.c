/* 数组与循环：求数组元素之和（含指针遍历版）
 * 编译：gcc array_sum.c -o array_sum && ./array_sum
 */
#include <stdio.h>

int main(void)
{
    int nums[] = {1, 2, 3, 4, 5};
    int n = sizeof(nums) / sizeof(nums[0]);

    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += nums[i];
    }
    printf("sum(下标) = %d\n", sum);

    /* 指针遍历版 */
    int sum2 = 0;
    for (int *p = nums; p < nums + n; p++) {
        sum2 += *p;
    }
    printf("sum(指针) = %d\n", sum2);

    return 0;
}
