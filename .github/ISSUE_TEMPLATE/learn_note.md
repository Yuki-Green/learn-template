name: 📝 学习记录 / 疑问
description: 记录一次学习、一个疑问或想深入的主题
title: "[learn]: "
labels: ["learning"]
body:
  - type: dropdown
    id: lang
    attributes:
      label: 语言 / 主题
      options:
        - C
        - (其他，请在正文说明)
    validations:
      required: true
  - type: textarea
    id: what
    attributes:
      label: 学了什么 / 想搞懂什么
    validations:
      required: true
  - type: textarea
    id: code
    attributes:
      label: 相关代码 / 笔记片段
      render: c
