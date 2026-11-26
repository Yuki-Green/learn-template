#!/usr/bin/env bash
# 一键编译并运行 learn-template 下所有 C 示例
# 不需要 make：只要有 gcc 即可（Windows 用 Git Bash / WSL）。
# 用法:
#   bash scripts/run_examples.sh
#   bash scripts/run_examples.sh --only c/basics   # 只跑某个目录
#
# 它等价于 `make test`，方便没有 make 的环境。

set -u

CC="${CC:-gcc}"
CFLAGS="${CFLAGS:--std=c11 -Wall -Wextra -O2}"
SRC_ROOT="code"
BUILD="build"

# 解析 --only 限制范围
PREFIX=""
if [ "${1:-}" = "--only" ] && [ -n "${2:-}" ]; then
  PREFIX="$2"
fi

# 跨平台探测可执行后缀
case "$(uname -s 2>/dev/null)" in
  MINGW*|MSYS*|CYGWIN*|Windows_NT) EXE=".exe" ;;
  *) EXE="" ;;
esac

# 定位仓库根目录（脚本放在 scripts/ 下）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.." || exit 1

if ! command -v "$CC" >/dev/null 2>&1; then
  echo "!! 未找到 C 编译器 ($CC)。请先安装 gcc（Windows 可用 Git Bash + MinGW）。" >&2
  exit 1
fi

SRCS=()
while IFS= read -r f; do
  [ -n "$f" ] && SRCS+=("$f")
done < <(find "$SRC_ROOT" -name '*.c' 2>/dev/null | sort)

if [ ${#SRCS[@]} -eq 0 ]; then
  echo "!! 在 $SRC_ROOT/ 下未找到任何 .c 文件。" >&2
  exit 1
fi

if [ -n "$PREFIX" ]; then
  FILTERED=()
  for f in "${SRCS[@]}"; do
    case "$f" in
      *"$PREFIX"*) FILTERED+=("$f") ;;
    esac
  done
  SRCS=("${FILTERED[@]}")
  if [ ${#SRCS[@]} -eq 0 ]; then
    echo "!! 没有匹配 '$PREFIX' 的 .c 文件。" >&2
    exit 1
  fi
fi

mkdir -p "$BUILD"
fail=0
for src in "${SRCS[@]}"; do
  # 用相对路径生成可执行名: code/c/basics/hello.c -> build/code/c/basics/hello.exe
  bin="$BUILD/${src%.c}$EXE"
  mkdir -p "$(dirname "$bin")"
  echo ">> 编译 $src"
  if ! "$CC" $CFLAGS "$src" -o "$bin" 2>err.tmp; then
    echo "   !! 编译失败:"; cat err.tmp; fail=1; continue
  fi
  echo "---- 运行 $bin ----"
  if ! "$bin"; then
    echo "   !! 运行失败 ($src)"; fail=1
  fi
done
rm -f err.tmp

if [ $fail -ne 0 ]; then
  echo "!! 有示例编译/运行失败。" >&2
  exit 1
fi
echo ">> 全部示例通过 ✓"
