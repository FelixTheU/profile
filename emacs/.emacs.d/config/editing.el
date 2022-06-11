;;; editing --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 16:18 2022/06/03

;;    _   ___ ___       _ _   _ __  __ ___
;;   /_\ / __| __|__ _ | | | | |  \/  | _ \
;;  / _ \ (__| _|___| || | |_| | |\/| |  _/
;; /_/ \_\___|___|   \__/ \___/|_|  |_|_|

;; ace-jump jump easily （跳转真棒）
(require 'ace-jump-mode)
;; ace jump mode major function;;
(autoload  'ace-jump-mode  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c i") 'ace-jump-char-mode) ; i for where i want
(define-key global-map (kbd "C-c h") 'ace-jump-mode)      ; h for word's head char
;; enable a more powerful jump back function from ace jump mode-compile;;
(autoload  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;  ___ ___ ___ _    ___ _____
;; | __|_ _/ __| |  | __|_   _|
;; | _| | | (_ | |__| _|  | |
;; |_| |___\___|____|___| |_|

(require 'figlet)
(define-key global-map (kbd "C-c C-f") 'figlet-comment)

;;  _____  _____  _   _  _ ___      ___ ___ ___ ___ ___  _  _
;; | __\ \/ / _ \/_\ | \| |   \ ___| _ \ __/ __|_ _/ _ \| \| |
;; | _| >  <|  _/ _ \| .` | |) |___|   / _| (_ || | (_) | . ` |
;; |___/_/\_\_|/_/ \_\_|\_|___/    |_|_\___\___|___\___/|_|\_|

;; expand-region
(require 'expand-region)
(defun er/mark-line ()
  "Marks this line."
  (interactive)
  (move-beginning-of-line 1)
  (set-mark (point))
  (move-end-of-line 1))
(global-set-key (kbd "C-c m") 'er/expand-region)
(global-set-key (kbd "C-c l") 'er/mark-line)
(global-set-key (kbd "C-c [") 'er/mark-word)
(global-set-key (kbd "C-c ]") 'er/mark-symbol)

;;  __  __ _   _ _  _____ ___ ___ _    ___     ___ _   _ ___  ___  ___  ___  ___
;; |  \/  | | | | ||_   _|_ _| _ \ |  | __|__ / __| | | | _ \/ __|/ _ \| _ \/ __|
;; | |\/| | |_| | |__| |  | ||  _/ |__| _|___| (__| |_| |   /\__ \ (_) |   /\__ \
;; |_|  |_|\___/|____|_| |___|_| |____|___|   \___|\___/|_|_\|___/\___/|_|_\|___/

;; multiple-cursors 多点编辑
;(require 'multiple-cursors)

;;   ___  ___ _____ ___      _      _   ___ _____     ___ _  _   _   _  _  ___
;;  / __|/ _ \_   _/ _ \ ___| |    /_\ / __|_   _|__ / __| || | /_\ | \| |/ __|
;; | (_ | (_) || || (_) |___| |__ / _ \\__ \ | ||___| (__| __ |/ _ \| .` | (_ |
;;  \___|\___/ |_| \___/    |____/_/ \_\___/ |_|     \___|_||_/_/ \_\_|\_|\___|

;; goto-last-change
;; 回到上次编辑的地方
(require 'goto-last-change)
(global-set-key (kbd "C-c ,") 'goto-last-change)

;; __   ___   ___ _  _ ___ ___ ___ ___ _____
;; \ \ / /_\ / __| \| |_ _| _ \ _ \ __|_   _|
;;  \ V / _ \\__ \ .` || ||  _/  _/ _|  | |
;;   |_/_/ \_\___/_|\_|___|_| |_| |___| |_|

;; yasnippet 模板系统
(require 'yasnippet)
(add-hook 'after-init-hook 'yas-global-mode) ;; 启动后自动启用补全
(global-set-key (kbd "C-c C-y") 'yas-insert-snippet)
(setq yas-wrap-around-region t)              ;; 在有region 时将其内容替换到 $0 占位符处

;;  _  _ ___ ___ _  _ _    ___ ___ _  _ _____    ___  _   ___ ___ _  _ _____ _  _
;; | || |_ _/ __| || | |  |_ _/ __| || |_   _|__| _ \/_\ | _ \ __| \| |_   _| || |
;; | __ || | (_ | __ | |__ | | (_ | __ | | ||___|  _/ _ \|   / _|| .` | | | | __ |
;; |_||_|___\___|_||_|____|___\___|_||_| |_|    |_|/_/ \_\_|_\___|_|\_| |_| |_||_|

;; 括号配对高亮
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;;  ___ _    ___ ___ _____ ___ ___ ___
;; | __| |  | __/ __|_   _| _ \_ _/ __|
;; | _|| |__| _| (__  | | |   /| | (__
;; |___|____|___\___| |_| |_|_\___\___|

;; electric-mode 自动括号配对补全
;; (require 'electric)
;; 编辑时智能缩进，类似于C-j的效果——这个C-j中，zencoding和electric-pair-mode冲突
(electric-indent-mode t)
;; 系统本身内置的智能自动补全括号(felix 表示爱死啦！！！)
(electric-pair-mode t)
;; 特定条件下插入新行
;; (electric-layout-mode t)

;; idle-highlight 高亮当前选中符号 自动对所有语言开启
;; 由于高亮使用了和“mark”一样的颜色，有时会有干扰，在无法修改其颜色之前，屏蔽 -- 23:03 2018/03/21
;; (require 'idle-highlight)
;; (add-hook 'prog-mode-hook 'idle-highlight)

;;  _  _ ___ ___ _  _ _    ___ ___ _  _ _____    _____   ____  __ ___  ___  _
;; | || |_ _/ __| || | |  |_ _/ __| || |_   _|__/ __\ \ / /  \/  | _ )/ _ \| |
;; | __ || | (_ | __ | |__ | | (_ | __ | | ||___\__ \\ V /| |\/| | _ \ (_) | |__
;; |_||_|___\___|_||_|____|___\___|_||_| |_|    |___/ |_| |_|  |_|___/\___/|____|

;; 符号语法高亮
;; 欢迎使用 highlight-symbol 提供的 C-x w . 高亮当前 symbol，表示手动更好使
;; (require 'highlight-symbol)
;; (global-set-key [(control f3)] 'highlight-symbol)
;; (global-set-key (kbd "C-c w") 'highlight-symbol-at-point)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;; (add-hook 'prog-mode-hook 'highlight-symbol-mode)

;; 高亮缩进(影响翻页速度，放弃)                                              13:41 2016/12/15
;; (require 'highlight-indentation)
;; (set-face-background 'highlight-indentation-face "#666666")
;; (add-hook 'c-mode-common-hook 'highlight-indentation-current-column-mode)

;;; Always do syntax highlighting 打开高亮
(global-font-lock-mode 1)

;; 高亮当前行(上下移动时明显拖慢，放弃）                            13:12 2016/12/15
;(global-hl-line-mode 1)

;;; Also highlight parens 括号配对高亮, 有 highlight-parentheses 就不用它了
;; (setq show-paren-delay 0
;;       show-paren-style 'parenthesis)
;; (show-paren-mode 1)

(provide 'editing)
;;; editing.el ends here
