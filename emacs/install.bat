
echo off

set emacs_preload_path="C:\Users\zhengsw\AppData\Roaming\.emacs"
set emacs_install_dir="D:\Program Files\emacs\"
set current_dir=%~dp0

rem 1) ΪԤ�����ļ�������������
mklink %emacs_preload_path% %current_dir%win\.emacs

rem 2) Ϊ .emacs ������������
mklink %emacs_install_dir%.emacs %current_dir%.emacs

rem 3) Ϊ .emacs.d ������������
mklink /D %emacs_install_dir%.emacs.d %current_dir%.emacs.d

pause
