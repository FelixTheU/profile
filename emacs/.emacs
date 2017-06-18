;;; package --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 04:30 2016/07/10
;;; record0 04:32 2016/07/10 -> 配置各种插件，补全、代码跳转、代码导航等
;;; record1 13:00 2016/08/29 -> 添加 expand-region 和 highlight-symbol
;;; record2 20:15 2016/12/07 -> 解决在 shell 中运行时报没有 tty 字体问题;
;;;                             重新实现 if-zero-code 对换行结尾的区域更友好
;;; record3 13:51 2016/12/15 -> 解决 tramp 打开远程文件或者 /su::/root/... 输入显示卡死问题
;;;                             加入行高亮，列高亮功能
;;;                             默认总是启用 server 模式，随时准备 emacsclient 极速连接
;;; record4 09:55 2016/12/28 -> 添加 highlight-parentheses 插件，彩色高亮配对括号
;;; record5 10:38 2016/12/30 -> 将 tab 替换为空格只在编程语言模式下生效，tab 对于Makefile 很重要
;;; code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(cfs--current-profile "profile1" t)
 '(cfs--profiles-steps (quote (("profile1" . 3))) t)
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("a8ed07d9e93f48b8ce5a2b5a0c734e8d0c851fd06b6f41e1e5d5ef95f04f844e" "dcf80f91cba25952b0848b8ff224b29c7dcc316d21a82c9cf249372cc167efef" "492f5ab818fa899269c6c1d1781646ed78c8e1100221a1a6ca3ba3f9c1e072fe" "cc152af53bde6f2ea12bf06a5ced8388370d3ae1557d27dc42e94cb89cf1073d" "4ef40cda673cf1a547c0203c9c7af5c32445975974f16edf8390ce99b552117f" "4fc466d75fc9bafea57c90159e49b6e30f1546f4aa41ee9af1f1cb66733aec9c" "8348a530d33d5bb34f8d8ef5ccbb7a82aff07cedf837d8ae04ea43de4858028f" "7f0b7f9ab6474d82b6e88d38c0891c9f69b7b6944df0da6ba908eb707cd1a4e1" "526a499cb6c3611b9021ff02facd7313f22fa16800a970b052ddc64316789829" "7cd6ab2797758c4909e924148ef0d27882f2ed37b263cb3e427ecea438fbe2bc" "0579868cfe1ae8b3c7538402f649733397047bc2be89623d14b9d257ba985bbc" "3a22fb5164fdaed60123fb5d5346455b96f8ec83e8f18d24db1168c312ece3d7" "64ca516f4288e3be9694c295f4a098802131b93dd07bfd52d8a5d578ae8f0a2e" "ed98d5f543bf9b2f8da75378eef59977a4d47a7e36410218cd4ac542fd3d7143" "7944a0d11f4b87e645b5c99c3f8072f77d0ba3b71938b31385372141ef88aad0" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(doxymacs-doxygen-style "C++")
 '(flycheck-keymap-prefix "c")
 '(package-selected-packages
   (quote
    (helm zenburn-theme yasnippet xcscope window-number tabbar srefactor sr-speedbar s projectile popup neotree mode-compile idle-highlight highlight-symbol highlight-parentheses highlight-indentation goto-last-change flycheck figlet expand-region doxymacs company-c-headers column-marker col-highlight chinese-fonts-setup async ace-jump-mode)))
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; disable welcome page
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;; 总是显示行号, 列号                                               20:26 2014/10/18
(global-linum-mode 1)
(column-number-mode)

;; 高亮当前行(上下移动时明显拖慢，放弃）                            13:12 2016/12/15
;(global-hl-line-mode 1)

;; 设置窗口默认大小                                                 15:48 2013/03/06
(setq default-frame-alist '((height . 30) (width . 80)))

;; 应用所有的目录本地变量                                           09:44 2016/09/07
(setq enable-local-variables  :all)

;; 只在编程语言模式下使用空格替换 tab，
;; 比如 Makefile 中 tab 是必须的
(add-hook 'prog-mode-hook
          '(lambda()
             (setq-default indent-tabs-mode nil)
             ))

;; 将备份文件保存到指定目录
(setq backup-directory-alist (quote (("." . "~/.backups"))))

;; 总是启动 server 模式，应对每次 emacs 启动缓慢问题                10:52 2016/12/15
; (server-start)

(put 'upcase-region 'disabled nil)

;;; Always do syntax highlighting 打开高亮
(global-font-lock-mode 1)

;;; Also highlight parens 括号配对高亮
;; (setq show-paren-delay 0
;;       show-paren-style 'parenthesis)
;; (show-paren-mode 1)


;; 设置远程连接的默认方法                                           11:51 2016/12/15
(setq tramp-default-method "ssh")
;; 解决输入冒号时卡死问题                                           13:00 2016/12/15
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
;; 将当前文件以管理员权限重新打开                                   16:04 2016/12/15
(defun find-alternative-file-with-sudo ()
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
	     buffer-file-name))))
(global-set-key (kbd "C-x C-r") 'find-alternative-file-with-sudo)

;; 快速跳转到 .emacs文件
(defun to-dotemacs ()
  "Swich to the buffer that can edit the file .emacs."
  (interactive)
  (find-file "~/.emacs"))
(global-set-key (kbd "C-x p") 'to-dotemacs)   ;; means profile.

;; buffer 切换快捷键                                                14:33 2014/09/27
(global-set-key (kbd "C-c n") 'next-buffer)
(global-set-key (kbd "C-c p") 'previous-buffer)

;; set mArk                                                         14:56 2014/09/27
(global-set-key (kbd "C-c a") 'set-mark-command)

;; 执行当前缓冲中的脚本                                             12:03 2013/03/19
(defun run-script-without-input ()
  "Run current script that needn't input on shell command."
  (interactive)
  (save-buffer)
  (shell-command (concat "./"
			  (buffer-name))))
(global-set-key (kbd "C-x c") 'run-script-without-input)
(fset 'enter-macro [return])

(defun run-script-in-shell ()
  "Run current script in a shell and it will not return back to current buffer."
  (interactive)
  (save-buffer)
  (let ((script-file (buffer-file-name)))
    (other-window 1)
    (shell)
    (insert "\"" script-file "\"")
    (execute-kbd-macro 'enter-macro)))

;; 为执行脚本设置快捷键                                             12:39 2013/03/19
(global-set-key (kbd "C-c C-c") 'run-script-in-shell)
(global-set-key (kbd "C-c C-s") 'replace-string)

;; 插入当前时间                                                     16:58 2012/11/13
(defun insert-current-time ()
  "Print the current time and date."
  (interactive)
  (insert (format-time-string "%H:%M %Y/%m/%d" (current-time))))
(global-set-key (kbd "C-x t") 'insert-current-time)

;; 编译快捷键
(global-set-key [(f7)] 'compile)

;; 选中一个函数（c-mode）
(global-set-key (kbd "C-c f") 'c-mark-function)

;; 显示所在函数                                                     17:52 2016/12/15
(add-hook 'prog-mode-hook 'which-function-mode)

;; 添加新的 ELPA 插件源                                             03:41 2016/07/10
(require 'package)
(add-to-list 'package-archives'
	     ("elpa" . "http://tromey.com/elpa/") t)
;; (add-to-list 'package-archives'
;; 	     ("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives'
     ("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; 括号配对高亮
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; yasnippet 模板系统
(require 'yasnippet)
;;; 启动后自动启用补全
(add-hook 'after-init-hook 'yas-global-mode)

;; helm (ELPA 安装) 管理文件与buffer（与ido 类型）
(require 'helm-config)
(global-set-key (kbd "M-X") 'helm-M-x)

;; company 补全配置
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

;; electric-mode (emacs 24自带)自动括号配对补全
(require 'electric)
;; 编辑时智能缩进，类似于C-j的效果——这个C-j中，zencoding和electric-pair-mode冲突
(electric-indent-mode t)
;; 系统本身内置的智能自动补全括号(felix 表示爱死啦！！！)
(electric-pair-mode t)
;; 特定条件下插入新行
;; (electric-layout-mode t)

;; xcscope 代码跳转
(require 'xcscope)
(cscope-setup)

;; ace-jump jump easily （跳转真棒）
(require 'ace-jump-mode)
;; ace jump mode major function;;
(autoload  'ace-jump-mode  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c i") 'ace-jump-char-mode) ; i for
(define-key global-map (kbd "C-c h") 'ace-jump-mode)	  ; h for word's head char
;; enable a more powerful jump back function from ace jump mode-compile;;
(autoload  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; imenu jump (跳转当前文件中函数)
(define-key global-map (kbd "C-c o") 'imenu)

;; flycheck 实时语法检查
(require 'flycheck)
;;; (add-hook 'c-mode-commmn-hook 'flycheck-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; doxymacs
(require 'doxymacs)
;; 注释高亮，针对C和C++程序
(defun my-doxymacs-font-lock-hook ()
  "Doxymacs fonts lock."
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(add-hook 'c++-mode-common-hook 'doxymacs-mode)

;; sr-speedbar show in current frame
;; 目录树文件、代码管理
(require 'sr-speedbar)
;; (setq sr-speedbar-right-side nil)
 (setq sr-speedbar-width 42)
 (global-set-key (kbd "<f8>") 'sr-speedbar-toggle)
(setq speedbar-use-images nil)
;; 在speedbar 中关闭显示行号功能
(add-hook 'speedbar-mode-hook '(lambda () (linum-mode -1)))

;; neotree 项目文件管理
;; (不能查看代码中函数，但可以管理文件的创建与删除)
;; 作为 sr-speedbar 的补充
(require 'neotree)
(global-set-key (kbd "M-8") 'neotree-toggle)

;; 符号语法高亮
;; (require 'highlight-symbol)
;; (global-set-key [(control f3)] 'highlight-symbol)
;; (global-set-key [f3] 'highlight-symbol-next)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;; (add-hook 'c-mode-common-hook 'highlight-symbol-mode)

;; expand-region
;(require 'expand-region)
(global-set-key (kbd "C-c m") 'er/expand-region)

;; zenburn-theme 主题
(require 'zenburn-theme)

;; color-theme 主题
;(require 'color-theme)

;; idle-highlight 高亮当前选中符号 自动对所有语言开启
(require 'idle-highlight)
(add-hook 'prog-mode-hook 'idle-highlight)

;; 高亮缩进(影响翻页速度，放弃)                                              13:41 2016/12/15
;; (require 'highlight-indentation)
;; (set-face-background 'highlight-indentation-face "#666666")
;; (add-hook 'c-mode-common-hook 'highlight-indentation-current-column-mode)

;; 显示列高亮线
(require 'col-highlight)

;; 高亮指定列
(require 'column-marker)
(global-set-key (kbd "C-c C-y") 'column-marker-1)

;; multiple-cursors 多点编辑
;(require 'multiple-cursors)

;; expand-region mark 再也不是麻烦了
;; 似乎已经内置了呀
;; (require 'expand-region)
(global-set-key (kbd "C-c m") 'er/expand-region)

;; figlet 得到醒目的文本
;;  ___ _      _     _
;; | __(_)__ _| |___| |_
;; | _|| / _` | / -_)  _|
;; |_| |_\__, |_\___|\__|
;;       |___/
(require 'figlet)

;; goto-last-change
;; 回到上次编辑的地方
(require 'goto-last-change)
(global-set-key (kbd "C-c ,") 'goto-last-change)

;; 注释，在没有 region 的时候注释当前行
(defun my-comment-or-uncomment-region (beg end &optional arg)
  "Comment a line when there is no region marked.BEG END ARG."
  (interactive
   (if	(use-region-p)
       (list (region-beginning) (region-end) nil)
     (list (line-beginning-position) (line-beginning-position 2))
     ))
  (comment-or-uncomment-region beg end arg))
;; 替换原有注释命令
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)
(global-set-key (kbd "C-c y") 'comment-or-uncomment-region)

;; 使用 if 0 屏蔽掉
(defun if-zero-code ()
  "Invalid the code with '#if 0 ... #endif' in the region."
  (interactive)
  (let ((region-text (buffer-substring (region-beginning) (region-end))))
    (kill-region (region-beginning) (region-end))
    (insert "#if 0\n"
:            region-text
            (if (equal (substring region-text -1) "\n") "" "\n") ; 最后一个字符是否是换行
            "#endif")))
(global-set-key (kbd "C-c 0") 'if-zero-code)

;; 块注释快捷键                    16:05 2013/03/06
(global-set-key (kbd "C-c C-r") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)

;; 将被 if 屏蔽掉的代码置为灰色
(require 'hideif)
(setq hide-ifdef-initially t)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (setq hide-ifdef-shadow t)
	    (setq hide-ifdef-mode t)
	    (hide-ifdefs)
		))

;; 代码折叠 09:28 2016/11/14
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(global-set-key (kbd "C-c C-j") 'hs-toggle-hiding)
(global-set-key (kbd "C-c C-k") 'hs-hide-level)

;; 跳转到关联文件，.c 跳到 .h等
(global-set-key (kbd "C-c k") 'ff-find-other-file)

;; window number, 使用 M-num 即可进行窗口切换
(require 'window-number)
(add-hook 'after-init-hook 'window-number-meta-mode)

;; 对齐
(global-set-key (kbd "C-c l") 'align)

;; projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
(global-set-key [f5] 'projectile-find-file)

;; 中文等宽字体设置插件
;; (require 'chinese-fonts-setup)
;; 让 chinese-fonts-setup 随着 emacs 自动生效。
;; (chinese-fonts-setup-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;; (cfs-set-spacemacs-fallback-fonts)

;; 设置中文等宽字体，有中英文对齐的功效
(set-face-attribute
 'default nil
 :font (font-spec :name "-APPL-Monaco-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 11.5))

; 仅在图形界面下设置字体                        19:26 2016/12/07
(if (display-graphic-p)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font
       (frame-parameter nil 'font)
       charset
       (font-spec :name "-WenQ-文泉驿等宽正黑-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 13.5))))

; 总是打开符号链接指向的文件，别老问我了        14:04 2017/06/18
(setq vc-follow-symlinks t)
;;; .emacs ends here
