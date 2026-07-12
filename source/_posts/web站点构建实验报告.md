---
title: Web站点构建实验报告
date: 2026-07-9 13:09:42
tags: 实验报告
---
分工：黄慕秦
## 1.实验目标：
使用 Hexo 初始化博客项目，完成内容编写、主题更换和本地预览。
## 2.实验环境:
| 项目 | 配置 |
|-------|-------|
| 操作系统 | Windows 11 专业版 22H2 |
| 博客框架 | Hexo 8.1.2（基于 Node.js） |
| 项目主题 | landscape（默认主题，从 GitHub 克隆） |
| 项目路径 | D:\Blog\my-blog |
| 依赖管理 | npm|
| 本地预览 | hexo server（监听 http://localhost:4000） |
## 3.核心操作记录：
（1）初始化博客项目：在 D:\Blog 目录下执行 hexo init my-blog，进入项目目录后执行 npm install。
（2）安装主题：由于 themes 目录为空，执行 git clone https://github.com/hexojs/hexo-theme-landscape.git themes/landscape，并删除其中的 .git 文件夹，使其成为普通文件夹。
（3）配置主题：修改根目录的 _config.yml，将 theme 字段设置为 landscape。
（4）创建并编写文章：执行 hexo new "我的第一篇博客"，编辑 source/_posts/ 下的 .md 文件，填写正确的 Front-matter（--- 开头，英文冒号）。
## 4.实验结果:
![博客页面](./images/博客页面.png)
## 5.知识总结:
| 知识点 | 核心内容 |
|--------|----------|
| 静态站点生成器（SSG） | 预先生成 HTML 页面，访问速度快、无需数据库 |
| Hexo 初始化 | `hexo init my-blog` 创建项目骨架 |
| 主题管理 | 下载主题到 `themes/` 目录，修改 `_config.yml` 中的 `theme` 字段 |
| 文章创建 | `hexo new "标题"` 生成 Markdown 文件，Front-matter 使用 `---` 包裹 |
| 本地预览 | `hexo server` 启动预览服务，监听 `http://localhost:4000` |
| 静态生成 | `hexo generate` 生成 `public` 目录 |
## 6.体会心得:
静态站点生成器的理解：通过 Hexo，我理解了 SSG 的核心优势——将 Markdown 预编译为 HTML，访问时无需查数据库，速度快、安全性高。与 WordPress 这类动态站点相比，SSG 更适合博客、文档这类内容相对固定的场景