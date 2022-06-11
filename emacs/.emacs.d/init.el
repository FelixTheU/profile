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
(setq custom-file "~/.emacs.d/custom.el")

;; 加载各类配置
(load "~/.emacs.d/custom.el")
(load "~/.emacs.d/settings.el")
(load "~/.emacs.d/utils.el")
(load "~/.emacs.d/editing.el")
(load "~/.emacs.d/prog-basic.el")
(load "~/.emacs.d/prog-lang.el")

;;; init.el ends here
