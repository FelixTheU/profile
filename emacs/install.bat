
echo off

set emacs_win_home="C:\Users\zhengsw\AppData\Roaming\"
set current_dir=%~dp0

rem 1) 配置 home 目录下的 .emacs 文件
mklink %emacs_win_home%.emacs %current_dir%.emacs

rem 2) 配置 home 目录下的 .emacs.d 文件
rem    mklink 产生的软链接可以被 babun 版本的程序识别，
rem    但 ln -s 创建的软链接却不能被 windows 版本 gui emacs 识别
mklink /D %emacs_win_home%.emacs.d %current_dir%.emacs.d

pause
