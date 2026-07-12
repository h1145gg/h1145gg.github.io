---
title: 【Linux环境配置】实验报告
date: 2026-07-7 15:09:16
tags: 实验报告
---
分工：杨天瑞
## 1、实验目的
本次实验旨在通过命令行方式深入操作 Linux 系统，掌握文件目录管理、用户与权限控制、环境变量配置等基础运维技能。理解 /etc/passwd、/etc/group、~/.bashrc 等关键配置文件的作用，并学会区分用户级环境变量与系统级环境变量的加载机制。

## 2、实验环境
| 项目 | 配置 |
|------|------|
| 操作系统 | Ubuntu Server 22.04.5 LTS（基于实验五克隆的 node1 节点）|
| 连接方式 | 本地终端直接操作（或通过 SSH 连接）|
| 权限 | 具备 sudo 提权权限的普通用户（如 dev） |
## 3、实验过程
### 步骤一：系统基础信息查看
登录 node1 后，使用 whoami、uname -a、lsb_release -a 查看当前用户、内核版本和发行版信息。

bash
whoami
uname -a
lsb_release -a
![基础信息](./images/系统内核信息.png)
### 步骤二：文件与目录基本操作
在用户目录下练习增删改查操作。创建 test_dir 目录，新建 test.txt 文件，执行复制、移动和删除操作。

bash
mkdir test_dir
touch test.txt
cp test.txt test_copy.txt
mv test.txt /tmp/
rm -f test_copy.txt
### 步骤三：查看系统资源状态
使用 free -h 查看内存，df -h 查看磁盘分区使用率，top 查看实时进程。
![查看系统资源状态](./images/内存使用与磁盘使用情况.png)
### 步骤四：用户管理与权限查看
首先使用 cat /etc/passwd 观察用户账户记录的结构（用户名:密码占位:UID:GID:描述:家目录:Shell）。接着创建新用户 testuser，赋予其 sudo 权限，并验证权限切换。

bash
sudo adduser testuser
sudo usermod -aG sudo testuser
su - testuser
sudo whoami  # 验证 sudo 可用
![用户所属组查看](./images/用户创建及所属组查看.png)
### 步骤五：环境变量的查看与临时设置
查看系统已有的环境变量，并尝试临时新增一个变量 MY_VAR。

bash
env | grep PATH
export MY_VAR="Hello_Linux"
echo $MY_VAR
[在此处插入截图：echo $MY_VAR 输出 Hello_Linux 的界面]
![临时环境变量](./images/临时环境变量的创建与输出.png)
### 步骤六：永久配置用户级环境变量（~/.bashrc）
编辑 ~/.bashrc 文件，在末尾添加一个自定义别名和一个自定义变量，保存后使用 source ~/.bashrc 使其立即生效。

bash
nano ~/.bashrc
添加：alias ll='ls -alF'
添加：export MY_CUSTOM_PATH="/home/dev/mybin"
source ~/.bashrc
![用户级环境变量](./images/用户级环境变量创建与使用.png)
### 步骤七：永久配置系统级环境变量（/etc/profile.d）
使用 sudo 在 /etc/profile.d/ 目录下创建自定义脚本 myenv.sh，设置全局变量。

bash
sudo nano /etc/profile.d/myenv.sh
添加：export GLOBAL_VAR="System_Level_Var"
source /etc/profile.d/myenv.sh
echo $GLOBAL_VAR

## 4、实验结果
成功完成了 Linux 基础命令操作、用户创建与权限委派，并清晰区分了环境变量的三种作用域。

|  配置项 | 配置位置 | 作用范围	| 是否生效 |
|---------|----------|----------|----------|
|alias |ll='ls -alF' | ~/.bashrc | 当前用户	| ✅ 成功|
|MY_CUSTOM_PATH	|~/.bashrc | 当前用户 | ✅ 成功|
|GLOBAL_VAR	|/etc/profile.d/myenv.sh | 所有用户 | ✅ 成功|
## 5、知识总结
| 配置文件 / 命令 | 作用与说明 | 加载时机 |
|----------------|-----------|----------|
|/etc/passwd | 存储用户账户信息（不含密码），包含 UID 和 GID | 系统启动及用户管理时读取 |
|/etc/shadow | 存储用户加密后的密码（需 sudo 查看） | 用户登录认证时读取 |
|/etc/group	| 存储用户组信息，用于权限分组管理 | 系统启动及权限检查时读取 |
|~/.bashrc | 用户级 Shell 配置文件，用于别名、函数和用户私有变量 | 每次打开新的非登录终端（交互式 Shell） |
|/etc/profile.d/*.sh | 系统级环境变量扩展目录，推荐使用	|　用户登录时执行 |
|chmod 755 | 数字法修改权限（7=rwx, 5=r-x），表示所有者全权，组和其他只读+执行 | 即时生效 |
## 6、出现问题与解决方案
| 问题现象 | 可能原因 | 解决方法 |
|----------|----------|---------|
|修改 ~/.bashrc 后，新开的终端未生效 | 未执行 source ~/.bashrc | 执行 source ~/.bashrc 或重新登录当前用户 |
| sudo adduser 提示用户已存在 | 之前实验创建过同名用户 | 先用 sudo deluser -r 用户名 删除后再创建 |
|chmod 400 后自己也无法读取文件	| 权限设置过严（去掉了所有者和组的读权限） | 使用 sudo chmod 644 恢复默认权限，或更换文件所有者 |
|输入 echo $MY_VAR 输出为空	| 变量为临时设置，当前终端关闭已丢失 | 若需持久化，应将其写入 ~/.bashrc 或 ~/.profile|
## 7、心得体会
以前用 Linux 总觉得只能点点鼠标，这次实验逼着自己全用命令行，反而发现命令行才是最高效的。尤其是理解 PATH 和 ~/.bashrc 后，才明白为什么安装某些软件后要“重启终端”或“source 一下”——原来是在刷新环境变量的加载。这种刨根问底的感觉很棒。此外，在练习用户管理时，我意识到 Linux 的权限模型设计得非常精巧，把权限分散到用户、组和其他，既保证了安全又兼顾了协作。作为未来的开发者，熟练掌握这些底层运维知识，对排查线上问题会有极大帮助。