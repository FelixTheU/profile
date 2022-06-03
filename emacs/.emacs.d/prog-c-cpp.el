;;; prog-c-cpp --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 16:18 2022/06/03

;; c/c++ offset settings.
;; -- 20:43 2020/05/24
(c-set-offset 'inline-open '0)
(c-set-offset 'innamespace '0)
(c-set-offset 'inextern-lang '0)

;;
;; lsp-mode
;; - lsp-completion-enable 启用后配合 company-capf 补全，
;;   在 '#include <vector>' 补全时会出来了许多全局符号，禁用;
;;   company-mode 配合 clang 已经够用了.
;;
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(setq lsp-completion-enable nil)

;;
;; cmake-ide
;; 自动设置 company, flycheck 等插件需要的 flags,十分贴心.
;; 15:20 2020/05/30
;;
(cmake-ide-setup)
(setq cmake-ide-header-search-other-file nil)
(global-set-key [(f7)] 'cmake-ide-compile) ;; 编译快捷键

;;  ___   _____  ____   ____  __   _   ___ ___
;; |   \ / _ \ \/ /\ \ / /  \/  | /_\ / __/ __|
;; | |) | (_) >  <  \ V /| |\/| |/ _ \ (__\__ \
;; |___/ \___/_/\_\  |_| |_|  |_/_/ \_\___|___/

;; doxymacs
(require 'doxymacs)
;; 注释高亮，针对C和C++程序
(defun my-doxymacs-font-lock-hook ()
  "Doxymacs fonts lock . "
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(add-hook 'c++-mode-common-hook 'doxymacs-mode)

(provide 'prog-c-cpp)
;;; prog-c-cpp.el ends here
