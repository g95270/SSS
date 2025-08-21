@echo off
chcp 65001 >nul
title 抖音推流助手 - 一键上传GitHub构建APK

echo ========================================
echo 🎥 抖音推流助手 - 一键上传GitHub构建APK
echo ========================================
echo.

echo 🚀 在线构建APK - 无需本地环境！
echo 💡 此方法将自动在GitHub上构建APK
echo ⏱️ 预计时间: 15-20分钟
echo.

echo 📋 使用说明:
echo 1. 需要GitHub账号
echo 2. 需要创建新的仓库
echo 3. 自动上传代码并触发构建
echo 4. 构建完成后自动下载APK
echo.

set /p choice="是否继续？(y/n): "
if /i "%choice%" neq "y" (
    echo 操作已取消
    pause
    exit /b 0
)

echo.
echo 🔍 检查Git环境...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 未检测到Git环境！
    echo 💡 请先安装Git
    echo 🔗 下载地址: https://git-scm.com/
    echo.
    pause
    exit /b 1
)

echo ✅ Git环境检查通过
echo.

echo 📝 请输入GitHub仓库信息:
echo.

set /p repo_name="仓库名称 (例如: douyin-streaming-assistant): "
if "%repo_name%"=="" (
    echo ❌ 仓库名称不能为空！
    pause
    exit /b 1
)

set /p repo_description="仓库描述 (可选): "
if "%repo_description%"=="" set repo_description=抖音推流助手 - 支持多种推流方式的Android应用

echo.
echo 🎯 仓库信息确认:
echo   名称: %repo_name%
echo   描述: %repo_description%
echo.

set /p confirm="确认创建仓库？(y/n): "
if /i "%confirm%" neq "y" (
    echo 操作已取消
    pause
    exit /b 0
)

echo.
echo 🚀 开始创建GitHub仓库并上传代码...
echo.

REM 创建临时目录
set temp_dir=%TEMP%\douyin_streaming_%random%
mkdir "%temp_dir%"
cd /d "%temp_dir%"

echo 📁 创建临时工作目录: %temp_dir%
echo.

REM 复制项目文件
echo 📋 复制项目文件...
xcopy /E /I /Y "%cd%\.." . >nul
echo ✅ 文件复制完成
echo.

REM 初始化Git仓库
echo 🔧 初始化Git仓库...
git init
git add .
git commit -m "Initial commit: 抖音推流助手 v1.0"

REM 创建GitHub仓库
echo 🌐 创建GitHub仓库...
echo 💡 请在弹出的浏览器中完成GitHub授权和仓库创建
echo.

REM 使用GitHub CLI或手动创建
echo 📝 请手动在GitHub上创建仓库: %repo_name%
echo 🔗 地址: https://github.com/new
echo.

REM 等待用户创建仓库
set /p continue="仓库创建完成后，按回车继续..."

echo.
echo 🔗 添加远程仓库...
git remote add origin https://github.com/%USERNAME%/%repo_name%.git

echo 📤 推送代码到GitHub...
git branch -M main
git push -u origin main

if %errorlevel% neq 0 (
    echo ❌ 代码推送失败！
    echo 💡 请检查GitHub仓库设置和网络连接
    pause
    exit /b 1
)

echo ✅ 代码推送成功！
echo.

echo 🏗️ 触发GitHub Actions构建...
echo ⏱️ 构建过程大约需要15-20分钟
echo 📱 构建完成后，APK文件将自动生成
echo.

echo 🔗 查看构建状态:
echo   https://github.com/%USERNAME%/%repo_name%/actions
echo.

echo 📥 下载APK文件:
echo   https://github.com/%USERNAME%/%repo_name%/releases
echo.

echo 🎉 在线构建已启动！
echo 💡 请等待构建完成，然后下载APK文件
echo.

REM 清理临时目录
cd /d "%cd%"
rmdir /S /Q "%temp_dir%"

echo 按任意键退出...
pause >nul
