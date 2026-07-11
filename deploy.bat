@echo off
echo 当前目录: %cd%
echo 正在生成静态文件...
call hexo generate
if %errorlevel% neq 0 (
    echo Hexo generate 失败，错误码: %errorlevel%
    pause
    exit /b %errorlevel%
)

echo 正在同步到虚拟机...
call scp -r public/* vboxuser@192.168.56.101:/var/www/html/
if %errorlevel% neq 0 (
    echo SCP 同步失败，错误码: %errorlevel%
    pause
    exit /b %errorlevel%
)

echo 部署完成！
pause