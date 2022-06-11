;;; init --- Felix's emacs profile
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 04:30 2016/07/10

;;; code:

(require 'package)                               ;; 03:41 2016/07/10
(add-to-list 'package-archives '("melpa"     . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu"       . "http://elpa.gnu.org/packages/") t)
(package-initialize)

;; 设置 emacs custom-file
;; 该文件会被 emacs 定制变量时进行修改
(setq custom-file "~/.emacs.d/config/custom.el")

;; 加载各类配置
(load "~/.emacs.d/config/custom.el")
(load "~/.emacs.d/config/settings.el")
(load "~/.emacs.d/config/utils.el")
(load "~/.emacs.d/config/editing.el")
(load "~/.emacs.d/config/prog-basic.el")
(load "~/.emacs.d/config/prog-lang.el")

;;; init.el ends here
