@echo off
chcp 65001 >nul
title 抖音推流助手 - 一键构建APK

echo ========================================
echo 🎥 抖音推流助手 - 一键构建APK
echo ========================================
echo.

echo 🚀 正在检查构建环境...
echo.

REM 检查Java环境
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 未检测到Java环境！
    echo 💡 请先安装Java JDK 11或更高版本
    echo 🔗 下载地址: https://adoptium.net/
    echo.
    pause
    exit /b 1
)

echo ✅ Java环境检查通过

REM 检查Android SDK环境
if not defined ANDROID_HOME (
    echo ❌ 未检测到Android SDK环境！
    echo 💡 请先安装Android Studio或设置ANDROID_HOME环境变量
    echo 🔗 下载地址: https://developer.android.com/studio
    echo.
    pause
    exit /b 1
)

echo ✅ Android SDK环境检查通过
echo.

echo 🏗️ 开始构建APK...
echo 📁 项目路径: %cd%\android
echo.

REM 进入Android目录
cd android

REM 清理项目
echo 🧹 清理项目...
call gradlew clean
if %errorlevel% neq 0 (
    echo ❌ 项目清理失败！
    pause
    exit /b 1
)

echo ✅ 项目清理完成
echo.

REM 构建Debug APK
echo 🔨 构建Debug APK...
call gradlew assembleDebug
if %errorlevel% neq 0 (
    echo ❌ APK构建失败！
    echo 💡 请检查错误信息并修复问题
    pause
    exit /b 1
)

echo ✅ APK构建成功！
echo.

REM 查找生成的APK文件
set APK_PATH=app\build\outputs\apk\debug\app-debug.apk
if exist "%APK_PATH%" (
    echo 📱 APK文件位置: %cd%\%APK_PATH%
    echo 📊 文件大小: 
    for %%A in ("%APK_PATH%") do echo    %%~zA 字节
    
    echo.
    echo 🎉 构建完成！APK文件已生成
    echo 💡 您可以将APK文件传输到手机进行安装
    echo.
    
    REM 询问是否打开文件夹
    set /p choice="是否打开APK所在文件夹？(y/n): "
    if /i "%choice%"=="y" (
        explorer "app\build\outputs\apk\debug"
    )
) else (
    echo ❌ 未找到生成的APK文件！
    echo 💡 请检查构建日志
)

echo.
echo 按任意键退出...
pause >nul
