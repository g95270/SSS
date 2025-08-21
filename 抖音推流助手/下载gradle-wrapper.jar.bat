@echo off
chcp 65001 >nul
title 下载gradle-wrapper.jar

echo ========================================
echo 下载gradle-wrapper.jar文件
echo ========================================
echo.

echo 🚀 正在下载gradle-wrapper.jar文件...
echo.

REM 创建目录
if not exist "android\gradle\wrapper" mkdir "android\gradle\wrapper"

REM 下载gradle-wrapper.jar
echo 📥 正在从GitHub下载gradle-wrapper.jar...
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/gradle/gradle/raw/v8.3.0/gradle/wrapper/gradle-wrapper.jar' -OutFile 'android\gradle\wrapper\gradle-wrapper.jar'}"

if exist "android\gradle\wrapper\gradle-wrapper.jar" (
    echo ✅ gradle-wrapper.jar下载成功！
    echo 📁 文件位置: android\gradle\wrapper\gradle-wrapper.jar
    echo.
    echo 💡 现在您可以尝试构建APK了
) else (
    echo ❌ 下载失败！
    echo 🔗 请手动下载: https://github.com/gradle/gradle/raw/v8.3.0/gradle/wrapper/gradle-wrapper.jar
    echo 📁 保存到: android\gradle\wrapper\gradle-wrapper.jar
)

echo.
echo 按任意键退出...
pause >nul
