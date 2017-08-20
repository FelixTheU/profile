;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; �����������գ���Windows�£�emacs25�汾��Ƶ�������������գ���ɿ���
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect)
  ;; (setq garbage-collection-messages t)           ;; ��ʾ����������Ϣ�����������Ϊ������
)

;; config for windows
(setenv "HOME" "D:/Program Files/emacs-25.2")
(setenv "PATH" "D:/Program Files/emacs-25.2")
(setq default-directory "~/")
(load-file "~/.emacs")
