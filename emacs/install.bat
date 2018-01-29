
echo off

set emacs_preload_path="C:\Users\zhengsw\AppData\Roaming\.emacs"
set babun_home_dir="D:\Programs\.babun\cygwin\home\zhengsw\"
set current_dir=%~dp0

rem 1) 配置预加载 .emacs 文件
mklink %emacs_preload_path% %current_dir%win\.emacs

rem 2) 配置 home 目录下的 .emacs 文件
mklink %babun_home_dir%.emacs %current_dir%.emacs

rem 3) 配置 home 目录下的 .emacs.d 文件
rem    mklink 产生的软链接可以被 babun 版本的程序识别，
rem    但 ln -s 创建的软链接却不能被 windows 版本 gui emacs 识别
mklink /D %babun_home_dir%.emacs.d %current_dir%.emacs.d

pause
