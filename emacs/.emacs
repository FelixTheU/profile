;;; package --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 04:30 2016/07/10
;;; record_00 04:32 2016/07/10 -> 配置各种插件，补全、代码跳转、代码导航等
;;; record_01 13:00 2016/08/29 -> 添加 expand-region 和 highlight-symbol
;;; record_02 20:15 2016/12/07 -> 解决在 shell 中运行时报没有 tty 字体问题;
;;;                               重新实现 if-zero-code 对换行结尾的区域更友好
;;; record_03 13:51 2016/12/15 -> 解决 tramp 打开远程文件或者 /su::/root/... 输入显示卡死问题
;;;                               加入行高亮，列高亮功能
;;;                               默认总是启用 server 模式，随时准备 emacsclient 极速连接
;;; record_04 09:55 2016/12/28 -> 添加 highlight-parentheses 插件，彩色高亮配对括号
;;; record_05 10:38 2016/12/30 -> 将 tab 替换为空格只在编程语言模式下生效，tab 对于 Makefile 很重要
;;; record_06 12:50 2017/09/10 -> 添加 slime，go-mode 以及 exec-path-from-shell.并且重新调整文件结构，进行分类整理
;;; record_07 13:15 2018/01/29 -> 配置 windows 版本下的 tramp 默认使用 plink 进行远程连接
;;; record_08 23:44 2018/01/30 -> 添加 gtags, magit, 以及配置 python-mode 下缩进为4个空格
;;; record_09 00:14 2018/03/22 -> 添加 align-regexp 快捷键(C-c |), 调整 align 快捷键为 C-c \;
;;;                               添加一众 er/mark-xxx 快捷键；
;;;                               屏蔽 idle-highlight, 总是高亮光标所在处的话又和选中一个颜色，不太友好
;;; record_10 00:16 2018/03/23 -> 添加 yasnippet ya-insert-snippet 快捷键为 C-c C-y, 当有 region 使用 ya-insert-snippet 时
;;;                               默认将 region 使用 $0 内容保留.
;;; record_11 17:30 2018/05/09 -> 调整 align 快捷键为 C-c \, align-regexp 为 C-c |;
;;;                               打开 (require 'expand-region)，虽然内置了，还是需要加载;
;;;                               设置 C++ 默认编码风格为 linux style;
;;;                               使用 highlight-symbol 提供的 C-x w . 手动高亮当前 symbol 更好的哟
;;; record_12 11:13 2018/07/14 -> highlight-symbol-at-point 快捷键调整为 C-c w
;;;                               er/mark-word   快捷键设置为 C-c [
;;;                               er/mark-symbol 快捷键设置为 C-c ]
;;;                               projectile-compile-project 快捷键设置为 F7
;;; record_13 18:59 2018/07/21 -> 将 win/.emacs 中对 windows 的特别处理代码(主要为解决 emacs25 卡顿问题)合并到本文件
;;;                               设置 password-cache-expiry 为 nil(默认值为 16), tramp 模式下的远程密码将不再失效
;;; record_14 14:54 2019/11/24 -> 添加 "TAB and SPACE" 一节，高亮显示 buffer 中的 tab 与 trailing space;
;;;                               在 buffer 保存时自动进行 a) 移除 trailing space, b) 将 tab 转换为 空格;
;;; record_15 20:50 2020/05/24 -> 添加 cmake-mode 与 flycheck-clangcheck, multi-term:
;;;                               cmake-mode 用于编辑 CMakeLists.txt 文件，补全比较方便；
;;;                               flycheck-clangcheck 使用 clang-check 进行静态代码分析，可读入 compile_commands.json 文件配置编译参数;
;;;                               添加"c/c++ offset settings." 一节，对于 class 中的 inline member function 不进行缩进;
;;; record_16 15:24 2020/05/30 -> 1. [aha] 移除 flycheck-clangcheck, 发现了更好用的 cmake-ide 自动为 company, flycheck(clang) 设置相应 flags;
;;;                                  无需额外配置，补全与静态代码检查就能很好地工作;
;;;                               2. 将 "TAB and SPACE" 一节调整位置，与 "custom-set-face 将 whitespace 与 tab 设置颜色"放到一起;
;;; code:

;;   ___ _   _ ___ _____ ___  __  __     ___ ___ _____  __   ___   ___ ___   _
;;  / __| | | / __|_   _/ _ \|  \/  |___/ __| __|_   _|_\ \ / /_\ | _ \_ _| /_\
;; | (__| |_| \__ \ | || (_) | |\/| |___\__ \ _|  | ||___\ V / _ \|   /| | / _ \
;;  \___|\___/|___/ |_| \___/|_|  |_|   |___/___| |_|     \_/_/ \_\_|_\___/_/ \_\

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (c++-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(cfs--current-profile "profile1" t)
 '(cfs--profiles-steps (quote (("profile1" . 4))) t)
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("a8ed07d9e93f48b8ce5a2b5a0c734e8d0c851fd06b6f41e1e5d5ef95f04f844e" "dcf80f91cba25952b0848b8ff224b29c7dcc316d21a82c9cf249372cc167efef" "492f5ab818fa899269c6c1d1781646ed78c8e1100221a1a6ca3ba3f9c1e072fe" "cc152af53bde6f2ea12bf06a5ced8388370d3ae1557d27dc42e94cb89cf1073d" "4ef40cda673cf1a547c0203c9c7af5c32445975974f16edf8390ce99b552117f" "4fc466d75fc9bafea57c90159e49b6e30f1546f4aa41ee9af1f1cb66733aec9c" "8348a530d33d5bb34f8d8ef5ccbb7a82aff07cedf837d8ae04ea43de4858028f" "7f0b7f9ab6474d82b6e88d38c0891c9f69b7b6944df0da6ba908eb707cd1a4e1" "526a499cb6c3611b9021ff02facd7313f22fa16800a970b052ddc64316789829" "7cd6ab2797758c4909e924148ef0d27882f2ed37b263cb3e427ecea438fbe2bc" "0579868cfe1ae8b3c7538402f649733397047bc2be89623d14b9d257ba985bbc" "3a22fb5164fdaed60123fb5d5346455b96f8ec83e8f18d24db1168c312ece3d7" "64ca516f4288e3be9694c295f4a098802131b93dd07bfd52d8a5d578ae8f0a2e" "ed98d5f543bf9b2f8da75378eef59977a4d47a7e36410218cd4ac542fd3d7143" "7944a0d11f4b87e645b5c99c3f8072f77d0ba3b71938b31385372141ef88aad0" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" default)))
 '(doxymacs-doxygen-style "C++")
 '(flycheck-keymap-prefix "c")
 '(org-babel-load-languages (quote ((shell . t) (emacs-lisp . t))))
 '(package-selected-packages
   (quote
    (cmake-ide cmake-mode multi-term ggtags magit exec-path-from-shell go-mode helm zenburn-theme yasnippet xcscope window-number tabbar srefactor sr-speedbar s projectile popup neotree mode-compile idle-highlight highlight-symbol highlight-parentheses highlight-indentation goto-last-change flycheck figlet expand-region doxymacs company-c-headers column-marker col-highlight chinese-fonts-setup async ace-jump-mode)))
 '(password-cache-expiry nil)
 '(server-auth-key
   "H_#!ZB<Tjox|)DaeTk@f#*`CuCO@/b~<f^$uI<&+2l{<eryt]Z7v]v22IunOgWw}")
 '(server-use-tcp t)
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil))

;; c/c++ offset settings.
;; -- 20:43 2020/05/24
(c-set-offset 'inline-open '0)
(c-set-offset 'innamespace '0)
(c-set-offset 'inextern-lang '0)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:background "red")))))

;;  _____ _   ___                _   ___ ___  _   ___ ___
;; |_   _/_\ | _ )  __ _ _ _  __| | / __| _ \/_\ / __| __|
;;   | |/ _ \| _ \ / _` | ' \/ _` | \__ \  _/ _ \ (__| _|
;;   |_/_/ \_\___/ \__,_|_||_\__,_| |___/_|/_/ \_\___|___|
;; 14:37 2019/11/24
;; 只在编程语言模式下使用空格替换 tab, 比如 Makefile 中 tab 是必须的
(add-hook 'prog-mode-hook
          '(lambda()
             (setq-default indent-tabs-mode nil)
             ))

;; 保存时删除行尾的空白                                             09:07 2017/09/10
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 保存时将 tab 调整为 空格
;; ref: https://www.emacswiki.org/emacs/UntabifyUponSave
(defvar untabify-this-buffer)
(defun untabify-all ()
  "Untabify the current buffer, unless `untabify-this-buffer' is nil."
  (and untabify-this-buffer (untabify (point-min) (point-max))))
(define-minor-mode untabify-mode
  "Untabify buffer on save." nil " untab" nil
  (make-variable-buffer-local 'untabify-this-buffer)
  (setq untabify-this-buffer (not (derived-mode-p 'makefile-mode)))
  (add-hook 'before-save-hook #'untabify-all))
 (add-hook 'prog-mode-hook 'untabify-mode)

;; Highlight tabs and trailing whitespace everywhere
;; ref: https://gist.github.com/kzar/7397117c70b3a9bbf212
(setq whitespace-style '(face trailing tabs))
(global-whitespace-mode)

;;  ___ __  __   _   ___ ___   ___   _   ___ ___ ___
;; | __|  \/  | /_\ / __/ __| | _ ) /_\ / __|_ _/ __|
;; | _|| |\/| |/ _ \ (__\__ \ | _ \/ _ \\__ \| | (__
;; |___|_|  |_/_/ \_\___|___/ |___/_/ \_\___/___\___|


;; 设置垃圾回收，在Windows下，emacs25 版本会频繁出发垃圾回收，造成卡顿
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect)
  ;; (setq garbage-collection-messages t)           ;; 显示垃圾回收信息，这个可以作为调试用
)

;; 总是启动 server 模式，应对每次 emacs 启动缓慢问题                10:52 2016/12/15
 ;(setq server-auth-dir "~/server";)
 ;(setq server-name "emacs_server")
(defadvice server-ensure-safe-dir (around
				    my-around-server-ensure-safe-dir
				    activate)
	   "Ignores any errors raised from server-ensure-safe-dir"
	   (ignore-errors ad-do-it))
 (server-start)

;; disable welcome page
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;; 设置窗口默认大小                                                 15:48 2013/03/06
(setq default-frame-alist '((height . 30) (width . 150)))

;; 总是显示行号, 列号                                               20:26 2014/10/18
(global-linum-mode 1)
(column-number-mode)

;;; Always do syntax highlighting 打开高亮
(global-font-lock-mode 1)

;; 将备份文件保存到指定目录
(setq backup-directory-alist (quote (("." . "~/.backups"))))

;; 高亮当前行(上下移动时明显拖慢，放弃）                            13:12 2016/12/15
;(global-hl-line-mode 1)

;; 应用所有的目录本地变量                                           09:44 2016/09/07
(setq enable-local-variables  :all)

;; 总是打开符号链接指向的文件，别老问我了                           14:04 2017/06/18
(setq vc-follow-symlinks t)

;; 启动后默认全屏显示  默认已经绑定到 F11 了                        23:58 2017/06/18
;; (toggle-frame-fullscreen)

;; 禁用 region 大写功能，为了获得 C-x C-u
(put 'upcase-region 'disabled nil)

;;; Also highlight parens 括号配对高亮, 有 highlight-parentheses 就不用它了
;; (setq show-paren-delay 0
;;       show-paren-style 'parenthesis)
;; (show-paren-mode 1)


;;  _____ ___    _   __  __ ___
;; |_   _| _ \  /_\ |  \/  | _ \
;;   | | |   / / _ \| |\/| |  _/
;;   |_| |_|_\/_/ \_\_|  |_|_|
;; 设置远程连接的默认方法                                           11:51 2016/12/15
(setq tramp-default-method "ssh")
;; windows gui 版本 emacs 无法使用 ssh，使用 plink 好了             12:41 2018/01/29
(when (eq window-system 'w32)
  (setq tramp-default-method "plink"))

;; 解决登入远程 shell 输入冒号时卡死问题                            13:00 2016/12/15
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

;; 将当前文件以管理员权限重新打开                                   16:04 2016/12/15
(defun find-alternative-file-with-sudo ()
  "Reopen current file with sudo."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
         buffer-file-name))))
(global-set-key (kbd "C-x C-r") 'find-alternative-file-with-sudo)

;;  _  _______   __   ___ ___ _  _ ___ ___ _  _  ___ ___
;; | |/ / __\ \ / /__| _ )_ _| \| |   \_ _| \| |/ __/ __|
;; | ' <| _| \ V /___| _ \| || .` | |) | || .` | (_ \__ \
;; |_|\_\___| |_|    |___/___|_|\_|___/___|_|\_|\___|___/

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

;; 插入当前时间                                                     16:58 2012/11/13
(defun insert-current-time ()
  "Print the current time and date."
  (interactive)
  (insert (format-time-string "%H:%M %Y/%m/%d" (current-time))))
(global-set-key (kbd "C-x t") 'insert-current-time)

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

;;   ___ ___  ___ ___ _  _  ___
;;  / __/ _ \|   \_ _| \| |/ __|
;; | (_| (_) | |) | || .` | (_ |
;;  \___\___/|___/___|_|\_|\___|

;; 编译快捷键
(global-set-key [(f7)] 'compile)

;; 块注释快捷键                                                     16:05 2013/03/06
(global-set-key (kbd "C-c C-r") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)

;; 选中一个函数（c-mode）
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

;;                                                          ____   _    ____ _  __    _    ____ _____ ____
;;    _     _     _     _     _     _     _     _     _    |  _ \ / \  / ___| |/ /   / \  / ___| ____/ ___|     _     _     _     _     _     _     _     _     _     _     _
;;  _| |_ _| |_ _| |_ _| |_ _| |_ _| |_ _| |_ _| |_ _| |_  | |_) / _ \| |   | ' /   / _ \| |  _|  _| \___ \   _| |_ _| |_ _| |_ _| |_ _| |_ _| |_ _| |_ _| |_ _| |_ _| |_ _| |_
;; |_   _|_   _|_   _|_   _|_   _|_   _|_   _|_   _|_   _| |  __/ ___ \ |___| . \  / ___ \ |_| | |___ ___) | |_   _|_   _|_   _|_   _|_   _|_   _|_   _|_   _|_   _|_   _|_   _|
;;   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |_| /_/   \_\____|_|\_\/_/   \_\____|_____|____/    |_|   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |_|

;;  ___  _   ___ _  __   _   ___ ___   ___ _    ___  _
;; | _ \/_\ / __| |/ /  /_\ / __| __| | __| |  | _ \/_\
;; |  _/ _ \ (__| ' <  / _ \ (_ | _|  | _|| |__|  _/ _ \
;; |_|/_/ \_\___|_|\_\/_/ \_\___|___| |___|____|_|/_/ \_\

;; 添加新的 ELPA 插件源                                             03:41 2016/07/10
(require 'package)
(add-to-list 'package-archives'
             ("elpa" . "http://tromey.com/elpa/") t)
;; (add-to-list 'package-archives'
;;       ("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives'
             ("melpa"    . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; __  ____  ____  ____  ____  ____  ____  ____  __  ____    _    ____ ___ ____  __  ____  ____  ____  ____  ____  ____  ____  __
;; \ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ / | __ )  / \  / ___|_ _/ ___| \ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /
;;  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  |  _ \ / _ \ \___ \| | |      \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /
;;  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  | |_) / ___ \ ___) | | |___   /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \
;; /_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\ |____/_/   \_\____/___\____| /_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\

;;  _____  _____ ___    ___  _ _____ _  _     ___ ___  ___  __  __     ___ _  _
;; | __\ \/ / __/ __|__| _ \/_\_   _| || |___| __| _ \/ _ \|  \/  |___/ __| || |
;; | _| >  <| _| (_|___|  _/ _ \| | | __ |___| _||   / (_) | |\/| |___\__ \ __ |
;; |___/_/\_\___\___|  |_|/_/ \_\_| |_||_|   |_| |_|_\\___/|_|  |_|   |___/_||_|

;; PATH env set same as the shell                                   00:40 2017/09/10
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;  _______ _  _ ___ _   _ ___ _  _    _____ _  _ ___ __  __ ___
;; |_  / __| \| | _ ) | | | _ \ \| |__|_   _| || | __|  \/  | __|
;;  / /| _|| .` | _ \ |_| |   / .` |___|| | | __ | _|| |\/| | _|
;; /___|___|_|\_|___/\___/|_|_\_|\_|    |_| |_||_|___|_|  |_|___|

;; zenburn-theme 主题
(require 'zenburn-theme)

;;   ___ _  _ ___ _  _ ___ ___ ___    ___ ___  _  _ _____ ___     ___ ___ _____
;;  / __| || |_ _| \| | __/ __| __|__| __/ _ \| \| |_   _/ __|___/ __| __|_   _|
;; | (__| __ || || .` | _|\__ \ _|___| _| (_) | .` | | | \__ \___\__ \ _|  | |
;;  \___|_||_|___|_|\_|___|___/___|  |_| \___/|_|\_| |_| |___/   |___/___| |_|

;; 中文等宽字体设置插件
(require 'chinese-fonts-setup)
;; 让 chinese-fonts-setup 随着 emacs 自动生效。
(chinese-fonts-setup-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
(cfs-set-spacemacs-fallback-fonts)

;; 设置中文等宽字体，有中英文对齐的功效
(set-face-attribute
 'default nil
 :font (font-spec :name "-APPL-Monaco-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 11.5))          ;; ever 12

; 仅在图形界面下设置字体                        19:26 2016/12/07
(if (display-graphic-p)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font
       (frame-parameter nil 'font)
       charset
       (font-spec :name "-WenQ-文泉驿等宽正黑-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 13.0))))        ;; ever 14

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
(require 'electric)
;; 编辑时智能缩进，类似于C-j的效果——这个C-j中，zencoding和electric-pair-mode冲突
(electric-indent-mode t)
;; 系统本身内置的智能自动补全括号(felix 表示爱死啦！！！)
(electric-pair-mode t)
;; 特定条件下插入新行
;; (electric-layout-mode t)

;;   ___ ___  _    ___  ___    _____ _  _ ___ __  __ ___
;;  / __/ _ \| |  / _ \| _ \__|_   _| || | __|  \/  | __|
;; | (_| (_) | |_| (_) |   /___|| | | __ | _|| |\/| | _|
;;  \___\___/|____\___/|_|_\    |_| |_||_|___|_|  |_|___|

;; color-theme 主题
;; (require 'color-theme)

;;  ___ ___  _    ___    _  _ ___ ___ _  _ _    ___ ___ _  _ _____
;; |_ _|   \| |  | __|__| || |_ _/ __| || | |  |_ _/ __| || |_   _|
;;  | || |) | |__| _|___| __ || | (_ | __ | |__ | | (_ | __ | | |
;; |___|___/|____|___|  |_||_|___\___|_||_|____|___\___|_||_| |_|


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
(require 'highlight-symbol)
;; (global-set-key [(control f3)] 'highlight-symbol)
(global-set-key (kbd "C-c w") 'highlight-symbol-at-point)
;; (global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;; (add-hook 'c-mode-common-hook 'highlight-symbol-mode)

;; 高亮缩进(影响翻页速度，放弃)                                              13:41 2016/12/15
;; (require 'highlight-indentation)
;; (set-face-background 'highlight-indentation-face "#666666")
;; (add-hook 'c-mode-common-hook 'highlight-indentation-current-column-mode)

;;   ___ ___  _       _  _ ___ ___ _  _ _    ___ ___ _  _ _____
;;  / __/ _ \| |  ___| || |_ _/ __| || | |  |_ _/ __| || |_   _|
;; | (_| (_) | |_|___| __ || | (_ | __ | |__ | | (_ | __ | | |
;;  \___\___/|____|  |_||_|___\___|_||_|____|___\___|_||_| |_|

;; 显示列高亮线
(require 'col-highlight)

;;   ___ ___  _   _   _ __  __ _  _     __  __   _   ___ _  _____ ___
;;  / __/ _ \| | | | | |  \/  | \| |___|  \/  | /_\ | _ \ |/ / __| _ \
;; | (_| (_) | |_| |_| | |\/| | .` |___| |\/| |/ _ \|   / ' <| _||   /
;;  \___\___/|____\___/|_|  |_|_|\_|   |_|  |_/_/ \_\_|_\_|\_\___|_|_\

;; 高亮指定列
(require 'column-marker)
;; C-u 前缀可以取消列高亮
(global-set-key (kbd "C-c C-o") 'column-marker-1)

;; __  ____  ____  ____  ____  ____  ____  ____  __  _____ _  __   __ __  ____  ____  ____  ____  ____  ____  ____  __
;; \ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ / |  ___| | \ \ / / \ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /\ \/ /
;;  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  | |_  | |  \ V /   \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /
;;  /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \  |  _| | |___| |    /  \  /  \  /  \  /  \  /  \  /  \  /  \  /  \
;; /_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\ |_|   |_____|_|   /_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\/_/\_\

;; __      _____ _  _ ___   _____      __   _  _ _   _ __  __ ___ ___ ___
;; \ \    / /_ _| \| |   \ / _ \ \    / /__| \| | | | |  \/  | _ ) __| _ \
;;  \ \/\/ / | || .` | |) | (_) \ \/\/ /___| .` | |_| | |\/| | _ \ _||   /
;;   \_/\_/ |___|_|\_|___/ \___/ \_/\_/    |_|\_|\___/|_|  |_|___/___|_|_\

;; window number, 使用 M-num 即可进行窗口切换
(require 'window-number)
(add-hook 'after-init-hook 'window-number-meta-mode)

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

;;  _  _ ___ _    __  __
;; | || | __| |  |  \/  |
;; | __ | _|| |__| |\/| |
;; |_||_|___|____|_|  |_|

;; helm (ELPA 安装) 管理文件与buffer（与ido 类型）
(require 'helm-config)
(global-set-key (kbd "M-X") 'helm-M-x)
(helm-mode 1)

;;  _____  _____  _   _  _ ___      ___ ___ ___ ___ ___  _  _
;; | __\ \/ / _ \/_\ | \| |   \ ___| _ \ __/ __|_ _/ _ \| \| |
;; | _| >  <|  _/ _ \| .` | |) |___|   / _| (_ || | (_) | . ` |
;; |___/_/\_\_|/_/ \_\_|\_|___/    |_|_\___\___|___\___/|_|\_|

;; expand-region
;; 似乎已经内置了呀
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
(setq projectile-enable-caching t)
(global-set-key [f5] 'projectile-find-file)
(global-set-key [f7] 'projectile-compile-project)
(add-hook 'c-mode-common-hook
          'projectile-mode)
;; (projectile-global-mode)

;; __  _____ ___  ___ ___  ___ ___
;; \ \/ / __/ __|/ __/ _ \| _ \ __|
;;  >  < (__\__ \ (_| (_) |  _/ _|
;; /_/\_\___|___/\___\___/|_| |___|

;; xcscope 代码跳转
(require 'xcscope)
(add-hook 'c-mode-common-hook
          '(lambda()
             (cscope-setup)
             ))

;;   ___ _____ _   ___ ___
;;  / __|_   _/_\ / __/ __|
;; | (_ | | |/ _ \ (_ \__ \
;;  \___| |_/_/ \_\___|___/

(require 'ggtags)
(add-hook 'c-mode-common-hook
          '(lambda()
             (ggtags-mode)
             ))
(setq gtags-suggested-key-mapping t)

;;  ___ _ __   _____ _  _ ___ ___ _  __
;; | __| |\ \ / / __| || | __/ __| |/ /
;; | _|| |_\ V / (__| __ | _| (__| ' <
;; |_| |____|_| \___|_||_|___\___|_|\_\

;; flycheck 实时语法检查
;; 需要搭配 clang 使用效果方好
;; update comment at 20:47 2020/05/24
(require 'flycheck)
(add-hook 'prog-mode-hook 'flycheck-mode)
;;; (add-hook 'after-init-hook #'global-flycheck-mode)

;;
;; cmake-ide
;; 自动设置 company, flycheck 等插件需要的 flags,十分贴心.
;; 15:20 2020/05/30
;;
(cmake-ide-setup)

;; __   ___   ___ _  _ ___ ___ ___ ___ _____
;; \ \ / /_\ / __| \| |_ _| _ \ _ \ __|_   _|
;;  \ V / _ \\__ \ .` || ||  _/  _/ _|  | |
;;   |_/_/ \_\___/_|\_|___|_| |_| |___| |_|

;; yasnippet 模板系统
(require 'yasnippet)
;; 启动后自动启用补全
(add-hook 'after-init-hook 'yas-global-mode)
(global-set-key (kbd "C-c C-y") 'yas-insert-snippet)
;; 在有region 时将其内容替换到 $0 占位符处
(setq yas-wrap-around-region t)


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

;;   ___  ___      __  __  ___  ___  ___
;;  / __|/ _ \ ___|  \/  |/ _ \|   \| __|
;; | (_ | (_) |___| |\/| | (_) | |) | _|
;;  \___|\___/    |_|  |_|\___/|___/|___|

;; 保存文件的时候对该源文件做一下gofmt                                      09:30 2017/09/10
(require 'go-mode)
(add-hook 'before-save-hook #'gofmt-before-save)

;;  ___ _    ___ __  __ ___
;; / __| |  |_ _|  \/  | __|
;; \__ \ |__ | || |\/| | _|
;; |___/____|___|_|  |_|___|

(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-to-list 'load-path "~/.emacs.d/slime-2.19/")
(require 'slime)
(slime-setup)

;;  __  __   _   ___ ___ _____
;; |  \/  | /_\ / __|_ _|_   _|
;; | |\/| |/ _ \ (_ || |  | |
;; |_|  |_/_/ \_\___|___| |_|

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;;  _____   _______ _  _  ___  _  _
;; | _ \ \ / /_   _| || |/ _ \| \| |
;; |  _/\ V /  | | | __ | (_) | .` |
;; |_|   |_|   |_| |_||_|\___/|_|\_|

(add-hook 'python-mode-hook
          (lambda () (setq tab-width 4)))

;;
;; downcase-region
;;
(put 'downcase-region 'disabled nil)
;;; .emacs ends here
