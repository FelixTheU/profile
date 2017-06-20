;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，造成卡顿
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect)
  ;; (setq garbage-collection-messages t)           ;; 显示垃圾回收信息，这个可以作为调试用
)

;; config for windows
(setenv "HOME" "D:/Program Files/emacs-25.2")
(setenv "PATH" "D:/Program Files/emacs-25.2")
(setq default-directory "~/")
(load-file "~/.emacs")
