
echo off

set emacs_preload_path="C:\Users\zhengsw\AppData\Roaming\.emacs"
set emacs_install_dir="D:\Program Files\emacs\"
set current_dir=%~dp0

rem 1) 为预加载文件建立符号链接
mklink %emacs_preload_path% %current_dir%win\.emacs

rem 2) 为 .emacs 建立符号链接
mklink %emacs_install_dir%.emacs %current_dir%.emacs

rem 3) 为 .emacs.d 建立符号链接
mklink /D %emacs_install_dir%.emacs.d %current_dir%.emacs.d

pause
