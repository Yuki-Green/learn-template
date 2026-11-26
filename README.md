# {{LANG}} 学习模板 (learn-template)

> 一个**可持续积累**的语言/技术学习仓库：每次学到新东西，就往这里加代码、笔记、记录。
> 本仓库已附带 **C 语言** 的起步示例，学习其他语言时，复制 `code/<lang>/`、`notes/<lang>/` 即可。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🎯 这个仓库用来做什么

- **系统化学一门语言**：把零散的知识点沉淀成可检索的笔记与可运行的代码。
- **留下成长轨迹**：`log/` 里按日期记录每次学了什么、卡在哪、解决了什么。
- **可一键复用**：它是 GitHub Template 仓库，学下一门语言时直接 "Use this template"。

## 📁 目录结构

```
learn-template/
├── code/            # 练习代码，按语言分目录
│   └── c/           #   C 示例（basics/ 放基础练习）
├── notes/           # 笔记，按语言分目录
│   └── c/           #   C 知识点笔记
├── log/             # 学习记录（按日期，见 log/YYYY-MM-DD.md）
├── scripts/         # 一键构建/运行脚本（无需 make 也能跑）
│   └── run_examples.sh
├── Makefile         # make test 统一入口（自动遍历并运行所有示例）
├── resources.md     # 书单 / 教程 / 文档链接
├── .gitignore
├── LICENSE
└── README.md
```

## 🏃 一键编译并运行所有代码

每写好一个 `.c`，都能一键编译运行，省去手敲 `gcc`：

```bash
# 方式一：用 make（已装 make 时）
make test            # 编译并运行 code/ 下所有 C 示例，任一失败则报错退出
make build           # 仅编译，产物在 build/
make clean           # 删除 build/

# 方式二：用脚本（无需 make，Windows 用 Git Bash / WSL）
bash scripts/run_examples.sh
bash scripts/run_examples.sh --only basics/hello   # 只跑某个示例
```

- 编译器默认 `gcc`，可用环境变量覆盖：`CC=clang make test`。
- 示例产物输出到 `build/`（已在 `.gitignore` 忽略，不会污染仓库）。
- **扩展其他语言**：在 `Makefile` 里参照 `C_SRCS`/`C_BINS` 加一组 `<lang>_SRCS`/`<lang>_BINS` 即可；脚本目前聚焦于 C，可作为模板改写。

## 🔁 每次学习，照这个流程加东西

1. **写代码**：在 `code/<lang>/<主题>/` 下新建 `.c`（或其他语言文件）。
2. **写笔记**：在 `notes/<lang>/` 下记录要点、易错点、示例代码片段。
3. **记一条日志**：在 `log/` 新建或追加 `YYYY-MM-DD.md`，写「今天学了 / 卡住 / 解决」。
4. **提交**：
   ```bash
   git add -A
   git commit -m "learn(c): 指针与数组"
   ```
   提交信息建议用 `learn(<lang>): <主题>`，方便日后按主题检索历史。

> 小技巧：`git log --oneline` 就是你的学习时间线；想回看某主题，搜 `learn(c):`。

## 🚀 学一门新语言时

1. 复制本仓库（Use this template）→ 新仓库名如 `learn-rust`。
2. 把 `{{LANG}}` 改成语言名，`code/c`、`notes/c` 改名为 `code/rust`、`notes/rust`。
3. 在 `log/` 写下第一天计划。

## 📄 许可证

基于 [MIT License](LICENSE) 开源，笔记与代码可自由复用、改写、分享。
