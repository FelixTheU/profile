;;; prog-basic --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 16:18 2022/06/03

;; 在 prog-mode 下才显示行号                                        23:13 2021/06/15
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(column-number-mode)

;; 块注释快捷键                                                     16:05 2013/03/06
(global-set-key (kbd "C-c C-r") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)

;; 选中一个函数 (c-mode)
(global-set-key (kbd "C-c f") 'c-mark-function)

;; 显示所在函数                                                     17:52 2016/12/15
(add-hook 'prog-mode-hook 'which-function-mode)

;; imenu jump (跳转当前文件中函数)
(define-key global-map (kbd "C-c o") 'imenu)

;; 代码折叠 09:28 2016/11/14
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(global-set-key (kbd "C-c C-j") 'hs-toggle-hiding)
(global-set-key (kbd "C-c C-k") 'hs-hide-level)

;; 跳转到关联文件，.c 跳到 .h等
(global-set-key (kbd "C-c k") 'ff-find-other-file)

;; 对齐
(global-set-key (kbd "C-c \\") 'align)
(global-set-key (kbd "C-c |") 'align-regexp)

;; 注释，在没有 region 的时候注释当前行
(defun my-comment-or-uncomment-region (beg end &optional arg)
  "Comment a line when there is no region marked.BEG END ARG."
  (interactive
   (if  (use-region-p)
       (list (region-beginning) (region-end) nil)
     (list (line-beginning-position) (line-beginning-position 2))
     ))
  (comment-or-uncomment-region beg end arg))
;; 替换原有注释命令
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)
(global-set-key (kbd "C-c y") 'comment-or-uncomment-region)

;; 使用 if 0 禁用 C 代码
(defun if-zero-code ()
  "Invalid the code with '#if 0 ... #endif' in the region."
  (interactive)
  (let ((region-text (buffer-substring (region-beginning) (region-end))))
    (kill-region (region-beginning) (region-end))
    (insert "#if 0\n"
            region-text
            (if (equal (substring region-text -1) "\n") "" "\n") ; 最后一个字符是否是换行
            "#endif")))
(global-set-key (kbd "C-c 0") 'if-zero-code)

;; 将被 if 屏蔽掉的代码置为灰色
(require 'hideif)
(setq hide-ifdef-initially t)
(add-hook 'c-mode-common-hook
      (lambda ()
        (setq hide-ifdef-shadow t)
        (setq hide-ifdef-mode t)
        (hide-ifdefs)
        ))

;;  ___ _ __   _____ _  _ ___ ___ _  __
;; | __| |\ \ / / __| || | __/ __| |/ /
;; | _|| |_\ V / (__| __ | _| (__| ' <
;; |_| |____|_| \___|_||_|___\___|_|\_\

;; flycheck 实时语法检查
;; 需要搭配 clang 使用效果方好
;; update comment at 20:47 2020/05/24
(require 'flycheck)
(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(save idle-change mode-enabled))
(setq flycheck-idle-change-delay 3)

;;  __  __   _   ___ ___ _____
;; |  \/  | /_\ / __|_ _|_   _|
;; | |\/| |/ _ \ (_ || |  | |
;; |_|  |_/_/ \_\___|___| |_|

;; (require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;;  _  _ ___ _    __  __
;; | || | __| |  |  \/  |
;; | __ | _|| |__| |\/| |
;; |_||_|___|____|_|  |_|

;; helm (ELPA 安装) 管理文件与buffer（与ido 类型）
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-X") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(helm-mode 1)

;;   ___ ___  __  __ ___  _   _  ___   __
;;  / __/ _ \|  \/  | _ \/_\ | \| \ \ / /
;; | (_| (_) | |\/| |  _/ _ \| .` |\ V /
;;  \___\___/|_|  |_|_|/_/ \_\_|\_| |_|

;; company 补全配置
;; c/c++ mode 下搭配 clang 可发挥较好的补全效果
;; update comment at 20:46 2020/05/24
(add-hook 'prog-mode-hook 'company-mode)
(setq company-idle-delay 0)    ; 无延迟，总是自动进行补全
;; 绑定补全快捷键
(global-set-key (kbd "C-c j") 'company-complete-common)
;; 添加补全后端，补全头文件
;; 或者 hook global-company-mode-hook
(add-hook 'c-mode-common-hook
          '(lambda()
             (add-to-list 'company-backends
                          'company-c-headers)))

;;  ___ ___     ___ ___ ___ ___ ___  ___   _   ___
;; / __| _ \___/ __| _ \ __| __|   \| _ ) /_\ | _ \
;; \__ \   /___\__ \  _/ _|| _|| |) | _ \/ _ \|   /
;; |___/_|_\   |___/_| |___|___|___/|___/_/ \_\_|_\

;; sr-speedbar show in current frame
;; 目录树文件、代码管理
(require 'sr-speedbar)
;; (setq sr-speedbar-right-side nil)
 (setq sr-speedbar-width 42)
 (global-set-key (kbd "<f8>") 'sr-speedbar-toggle)
(setq speedbar-use-images nil)
;; 在speedbar 中关闭显示行号功能
(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))

;;  _  _ ___ ___ _____ ___ ___ ___
;; | \| | __/ _ \_   _| _ \ __| __|
;; | .` | _| (_) || | |   / _|| _|
;; |_|\_|___\___/ |_| |_|_\___|___|

;; neotree 项目文件管理
;; (不能查看代码中函数，但可以管理文件的创建与删除)
;; 作为 sr-speedbar 的补充
(require 'neotree)
(global-set-key (kbd "M-8") 'neotree-toggle)

;; __  ____  ____  ____  ____  ____  ____  ____  __  ____  _______     __ __  ____  ____  ____  ____  ____  ____  ____  __
;; \ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ / |  _ \| ____\ \   / / \ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /
;;  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  | | | |  _|  \ \ / /   \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /
;;  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  | |_| | |___  \ V /    /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \
;; /_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\ |____/|_____|  \_/    /_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\

;;  ___ ___  ___     _ ___ ___ _____ ___ _    ___
;; | _ \ _ \/ _ \ _ | | __/ __|_   _|_ _| |  | __|
;; |  _/   / (_) | || | _| (__  | |  | || |__| _|
;; |_| |_|_\\___/ \__/|___\___| |_| |___|____|___|

;; projectile
(require 'projectile)
(setq projectile-enable-caching t)
(add-hook 'c-mode-common-hook 'projectile-mode)
(global-set-key [f5] 'projectile-find-file)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (projectile-global-mode)

(provide 'prog-basic)
;;; prog-basic.el ends here
