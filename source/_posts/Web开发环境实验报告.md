---
title: 【Web开发环境】实验报告
date: 2026-07-11 10:56:39
tags: 实验报告
---
分工：施博韬
## 一、实验目标
1.安装Web开发环境并构建一个静态站点
2.了解并实践Web服务器，软件包及管理器等工具与概念
## 二、背景知识
### 2.1 什么是Web开发环境
简单来说，Web开发环境就是你在自己电脑或远程服务器上搭建的一套工具和配置，用来编写、运行、调试和预览网站或Web应用。它的目标，是让你在代码上线前，能像用户一样看到效果，同时高效地排查问题。
### 2.2 Web开发环境的核心组成部分
| 组件 | 作用 | 常见工具举例 |
|------|------|--------------|
| **代码编辑器 / IDE** | 编写和编辑代码 | VS Code、WebStorm、Sublime Text |
| **运行时环境** | 执行后端代码 | Node.js、Python、PHP、Java (JDK) |
| **Web 服务器** | 处理 HTTP 请求，提供页面 | Nginx、Apache，或语言自带的开发服务器 (如 `npm run dev`) |
| **数据库系统** | 存储和管理数据 | MySQL、PostgreSQL、MongoDB、SQLite |
| **浏览器 & 开发者工具** | 查看页面效果，调试前端代码 | Chrome DevTools、Firefox Developer Edition |
| **版本控制** | 管理代码变更，协作开发 | Git + GitHub / GitLab / Gitee |
| **包管理器** | 安装和管理第三方库 | npm、Yarn、pnpm (前端/Node)；pip、Composer 等 |
| **调试工具** | 定位后端或前端逻辑错误 | 浏览器断点调试、VS Code 调试器、Postman (接口测试) |
## 三、实验环境
| 项目 | 配置 |
|------|------|
| **操作系统** | Windows 11专业版22H2 |
| **运行时环境** | Node.js v24.18.0 (LTS 版本) |
| **包管理器** | npm(随Node.js安装，版本10.x.x) |
| **版本控制** | Git for Windows 2.55.0 |
| **构建工具** | Hexo CLI 4.3.2(全局安装) |
| **npm镜像源** | https://registry.npmmirror.com (国内加速) |
| **网络环境** | 互联网连接(用于下载Node.js、Git和npm包) |
## 四、操作步骤

### 准备工作
- 确保操作系统为 Windows 11 专业版 22H2
- 保持互联网连接畅通
- 具有管理员权限（部分安装需要）

---

### 4.1 安装 Node.js v24.18.0 (LTS)

1. 访问 Node.js 官方网站：https://nodejs.org  
   或直接进入下载页面：https://nodejs.org/en/download/prebuilt-binaries
2. 找到 **v24.18.0 LTS** 对应的 Windows 安装包  
   （通常为 `node-v24.18.0-x64.msi`）
3. 下载后双击运行安装程序。
4. 安装过程中务必勾选 **“Automatically install the necessary tools...”**  
   并确保 **“Add to PATH”** 选项已选中。
5. 一路点击 **Next** 完成安装。
6. 验证安装：打开 **命令提示符** 或 **PowerShell**，执行：
   ```
   node -v
   ```
   应输出 `v24.18.0`
   ```bash
   npm -v
   ```
   应输出类似 `10.x.x` 的版本号。

### 4.2 配置 npm 国内镜像源

为了加速包下载，将 npm 源设置为淘宝镜像。

在命令行中执行：
```bash
npm config set registry https://registry.npmmirror.com
```
验证是否设置成功：
```bash
npm config get registry
```
应返回 `https://registry.npmmirror.com/`

> 以后若需恢复官方源，执行：  
> `npm config set registry https://registry.npmjs.org/`

---

### 4.3 安装 Git for Windows 2.55.0

1. 前往 Git 官方下载页面：https://git-scm.com/download/win  
   选择 **64-bit Git for Windows Setup**。
2. 下载指定版本 `v2.55.0`（可在页面右侧 `releases` 中查找）。
3. 运行安装程序，建议选择以下关键配置：
   - **Default editor**: 选择自己熟悉的编辑器（如 VS Code）
   - **Adjusting your PATH environment**: 选择 **“Git from the command line and also from 3rd-party software”**
   - **HTTPS transport backend**: 选择 **“Use the OpenSSL library”**
   - **Line ending conversions**: 选择 **“Checkout Windows-style, commit Unix-style line endings”**
   - 其他选项保持默认即可。
4. 完成安装后，打开命令行验证：
   ```bash
   git --version
   ```
   应输出 `git version 2.55.0.windows.1`

5. 配置 Git 用户信息（后续提交必备）：
   ```bash
   git config --global user.name "你的姓名"
   git config --global user.email "你的邮箱@example.com"
   ```

---

### 4.4 全局安装 Hexo CLI 4.3.2

1. 在命令行中执行：
   ```bash
   npm install -g hexo-cli@4.3.2
   ```
   （`-g` 表示全局安装，以后在任何目录都能使用 `hexo` 命令）
2. 安装完成后验证：
   ```bash
   hexo version
   ```
   应输出包含 `hexo-cli: 4.3.2` 的信息。

---

### 4.5 初始化并运行 Hexo 博客（可选测试）

1. 在合适的位置创建一个项目文件夹，例如：
   ```bash
   cd C:\Users\你的用户名\Desktop
   mkdir my-blog
   cd my-blog
   ```
2. 初始化 Hexo 站点：
   ```bash
   hexo init
   ```
   等待依赖下载完成。
3. 启动本地开发服务器：
   ```bash
   hexo server
   ```
   或简写 `hexo s`。
4. 打开浏览器，访问 `http://localhost:4000`，看到默认 Hexo 页面即表示环境搭建成功。
5. 在命令行按 `Ctrl + C` 可停止服务器。
## 五.实验结果
![基础软件配置成功](./images/基本软件配置成功.png)
## 六.知识总结
| 知识点 | 核心内容 |
|--------|----------|
| Node.js | JavaScript 运行时环境，用于执行 Hexo 等前端工具 |
| npm | Node.js 包管理器，用于安装、管理项目依赖 |
| 镜像源配置 | `npm config set registry https://registry.npmmirror.com` 加速国内下载 |
| Git | 版本控制工具，配置用户信息 `git config --global user.name/email` |
| Hexo CLI | 博客框架命令行工具，全局安装 `npm install -g hexo-cli` |
## 七.出现问题及解决方案
| 问题描述 | 原因分析 | 解决方案 |
|----------|----------|----------|
| `npm install` 速度极慢 | 默认使用国外镜像源 | `npm config set registry https://registry.npmmirror.com`  |
## 八.心得体会
国产工具的思考：实验中也接触到国内的技术平台（如 Gitee、清华大学镜像源等），它们在特定场景下起到了重要作用。但我也注意到，在生态完整度、国际化程度等方面，国内平台与国际平台仍有差距。作为未来的软件开发者，我应当积极学习和使用国际先进工具，同时关注和支持国内技术生态的发展