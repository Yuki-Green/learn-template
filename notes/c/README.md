# C 语言学习笔记

> 把 C 的关键知识点、坑、示例代码片段记在这里。按主题分文件（如 `pointers.md`、`arrays.md`），
> 或直接在本文件里追加。每条笔记尽量配一段可运行的小例子。

## 入门要点速记

- **编译运行**：`gcc hello.c -o hello && ./hello`
- **入口函数**：`int main(void) { ... return 0; }`
- **头文件**：标准库用 `#include <stdio.h>`，自定义用 `#include "my.h"`
- **printf 占位符**：`%d`(int) `%f`(double) `%c`(char) `%s`(字符串) `%p`(指针) `%ld`(long)
- **内存模型**：栈（局部变量）/ 堆（`malloc`/`free`）/ 全局/静态区

## 易错点

- 数组名在多数语境下**退化成指针**，但 `sizeof(arr)` 仍是数组总字节数。
- 字符串字面量是**只读**的，改它会未定义行为；要改请用字符数组。
- `scanf("%d", &x)` 必须传**地址**；漏 `&` 是常见段错误来源。
- 指针未初始化就解引用 = 野指针，先 `NULL` 或指向有效内存。

## 示例：交换两个数（指针版）

```c
void swap(int *a, int *b) {
    int t = *a; *a = *b; *b = t;
}
```

详见 `../code/c/basics/`。
