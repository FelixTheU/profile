;;; prog-etc --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 16:18 2022/06/03

;;   ___  ___      __  __  ___  ___  ___
;;  / __|/ _ \ ___|  \/  |/ _ \|   \| __|
;; | (_ | (_) |___| |\/| | (_) | |) | _|
;;  \___|\___/    |_|  |_|\___/|___/|___|

;; 保存文件的时候对该源文件做一下gofmt                                      09:30 2017/09/10
(require 'go-mode)
(add-hook 'before-save-hook '(lambda() (when (derived-mode-p 'go-mode) (gofmt-before-save))))


;;  _____   _______ _  _  ___  _  _
;; | _ \ \ / /_   _| || |/ _ \| \| |
;; |  _/\ V /  | | | __ | (_) | .` |
;; |_|   |_|   |_| |_||_|\___/|_|\_|

(add-hook 'python-mode-hook
          (lambda () (setq tab-width 4)))

(provide 'prog-etc)
;;; prog-etc.el ends here
