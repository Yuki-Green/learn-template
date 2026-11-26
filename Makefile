# learn-template 统一构建 / 测试入口
# 一键编译并运行所有 C 示例:  make test   (默认目标)
# 需要本机安装 gcc（及可选的 make / git-bash）
#
# 设计原则：每新增一门语言，加一个 <lang>_SRCS / <lang>_BINS 即可，
#           当前已内置 C。其余语言按需照此扩展。

CC      ?= gcc
CFLAGS  ?= -std=c11 -Wall -Wextra -O2
BUILD   := build
SRC_DIR := code

# 收集所有 .c 源文件 -> 对应的可执行文件（Windows 下加 .exe）
ifeq ($(OS),Windows_NT)
  EXE := .exe
else
  EXE :=
endif

C_SRCS  := $(shell find $(SRC_DIR) -name '*.c' 2>/dev/null)
C_BINS  := $(patsubst %.c,$(BUILD)/%$(EXE),$(C_SRCS))

.PHONY: help all build test run clean

help:
	@echo "learn-template 构建 / 测试入口"
	@echo "  make            (= make test) 编译并运行所有 C 示例"
	@echo "  make test       编译并运行所有 C 示例，任一失败则非零退出"
	@echo "  make build      仅编译，产物输出到 $(BUILD)/"
	@echo "  make run        运行已编译的可执行"
	@echo "  make clean      删除 $(BUILD)/"
	@echo ""
	@echo "当前支持语言: C  (匹配 $(SRC_DIR)/c/**/*.c)"

all: test

build: $(C_BINS)
	@echo ">> 编译完成，产物在 $(BUILD)/"

# 规则: build/code/c/basics/hello[.exe]  <-  code/c/basics/hello.c
$(BUILD)/%$(EXE): %.c
	@mkdir -p $(dir $@)
	@echo ">> 编译 $<"
	@$(CC) $(CFLAGS) $< -o $@

test: build
	@echo ">> 运行所有示例:"; fail=0; \
	for bin in $(C_BINS); do \
		echo "---- $$bin ----"; \
		$$bin || fail=1; \
	done; \
	if [ $$fail -ne 0 ]; then echo "!! 有示例运行失败"; exit 1; fi; \
	echo ">> 全部示例通过 ✓"

run: build
	@for bin in $(C_BINS); do \
		echo "---- $$bin ----"; \
		$$bin; \
	done

clean:
	@rm -rf $(BUILD)
	@echo ">> 已清理 $(BUILD)/"
