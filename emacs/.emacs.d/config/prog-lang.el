;;; prog-lang --- Felix's .emacs
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
(use-package lsp-ui)
(use-package lsp-mode
  :hook ((c-mode c++-mode python-mode) . lsp)
  :custom (lsp-completion-enable (not (derived-mode-p 'c-mode 'c++-mode)) "use company-mode to do completion")
  )

;;
;; cmake-ide
;; 自动设置 company, flycheck 等插件需要的 flags,十分贴心.
;; 15:20 2020/05/30
;;
(use-package cmake-ide
  :hook (c-mode-common . cmake-ide-setup)
  :bind ([(f7)] . cmake-ide-compile)
  :custom (cmake-ide-header-search-other-file nil "do not find other file for header file"))
(use-package cmake-mode)

;;  ___   _____  ____   ____  __   _   ___ ___
;; |   \ / _ \ \/ /\ \ / /  \/  | /_\ / __/ __|
;; | |) | (_) >  <  \ V /| |\/| |/ _ \ (__\__ \
;; |___/ \___/_/\_\  |_| |_|  |_/_/ \_\___|___/

;; doxymacs
(use-package doxymacs
  :ensure nil
  :hook (font-lock-mode . doxymacs-font-lock))

;;   ___  ___      __  __  ___  ___  ___
;;  / __|/ _ \ ___|  \/  |/ _ \|   \| __|
;; | (_ | (_) |___| |\/| | (_) | |) | _|
;;  \___|\___/    |_|  |_|\___/|___/|___|

;; 保存文件的时候对该源文件做一下gofmt                                      09:30 2017/09/10
(use-package go-mode
  :hook (before-save . (lambda() (when (derived-mode-p 'go-mode) (gofmt-before-save)))))

;;  _____   _______ _  _  ___  _  _
;; | _ \ \ / /_   _| || |/ _ \| \| |
;; |  _/\ V /  | | | __ | (_) | .` |
;; |_|   |_|   |_| |_||_|\___/|_|\_|
(use-package python-mode
  :custom (tab-width 4))

(provide 'prog-lang)
;;; prog-c-cpp.el ends here
