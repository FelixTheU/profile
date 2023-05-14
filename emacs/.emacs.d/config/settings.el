;;; settings --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 16:17 2022/06/03

;; disable welcome page
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
(setq read-process-output-max (* 1024 1024))

;; Lower threshold back to 250 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 28))))

;; 设置窗口默认大小                                                 15:48 2013/03/06
(setq default-frame-alist '((height . 30) (width . 150)))

;; 应用所有的目录本地变量                                           09:44 2016/09/07
(setq enable-local-variables  :all)

;; 总是打开符号链接指向的文件，别老问我了                           14:04 2017/06/18
(setq vc-follow-symlinks t)

;; 将备份文件保存到指定目录
(setq backup-directory-alist (quote (("." . "~/.backups"))))

;; 保持 .emacs.d 干净，必要的内容会放到 etc 目录下
;; 需要及早加载，为其它 package 准备好目录设置
(use-package no-littering
  :demand t)

;; 启动后默认全屏显示  默认已经绑定到 F11 了                        23:58 2017/06/18
;; (toggle-frame-fullscreen)

;; 禁用 region 大写功能，为了获得 C-x C-u
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; 设置垃圾回收，在Windows下，emacs25 版本会频繁出发垃圾回收，造成卡顿
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect)
  ;; (setq garbage-collection-messages t)           ;; 显示垃圾回收信息，这个可以作为调试用
)

;; 总是启动 server 模式，应对每次 emacs 启动缓慢问题                10:52 2016/12/15
;; (setq server-auth-dir "~/server";)
;; (setq server-name "emacs_server")
;; (defadvice server-ensure-safe-dir (around
;;                     my-around-server-ensure-safe-dir
;;                     activate)
;;        "Ignores any errors raised from server-ensure-safe-dir"
;;        (ignore-errors ad-do-it))
;;  (server-start)

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

;;  _____ _   ___                _   ___ ___  _   ___ ___
;; |_   _/_\ | _ )  __ _ _ _  __| | / __| _ \/_\ / __| __|
;;   | |/ _ \| _ \ / _` | ' \/ _` | \__ \  _/ _ \ (__| _|
;;   |_/_/ \_\___/ \__,_|_||_\__,_| |___/_|/_/ \_\___|___|
;; 14:37 2019/11/24
(add-hook 'prog-mode-hook
          '(lambda()
             (setq-default indent-tabs-mode nil)
             ))

;; 保存时删除行尾的空白                                             09:07 2017/09/10
;; 通过 before-save-delete-trailing-whitespace 控制是否删除行尾空白
(setq-default before-save-delete-trailing-whitespace nil)
(make-variable-buffer-local 'before-save-delete-trailing-whitespace)
(add-hook 'before-save-hook '(lambda()
                               (when before-save-delete-trailing-whitespace (delete-trailing-whitespace))
                               ))

;; 保存时将 tab 调整为 空格
;; 只在编程语言模式下使用空格替换 tab, 比如 Makefile 中 tab 是必须的
;; ref: https://www.emacswiki.org/emacs/UntabifyUponSave
(defvar untabify-this-buffer)
(defun untabify-all ()
  "Untabify the current buffer, unless `untabify-this-buffer' is nil."
  (and untabify-this-buffer (untabify (point-min) (point-max))))
(define-minor-mode untabify-mode
  "Untabify buffer on save." nil " untab" nil
  (make-variable-buffer-local 'untabify-this-buffer)
  (setq untabify-this-buffer nil)
  ;; (setq untabify-this-buffer (not (derived-mode-p 'makefile-mode)))
  (add-hook 'before-save-hook #'untabify-all))
 (add-hook 'prog-mode-hook 'untabify-mode)

;; Highlight tabs and trailing whitespace everywhere
;; ref: https://gist.github.com/kzar/7397117c70b3a9bbf212
(setq whitespace-style '(face trailing tabs))
(global-whitespace-mode)

;;   ___ _  _ ___ _  _ ___ ___ ___    ___ ___  _  _ _____ ___     ___ ___ _____
;;  / __| || |_ _| \| | __/ __| __|__| __/ _ \| \| |_   _/ __|___/ __| __|_   _|
;; | (__| __ || || .` | _|\__ \ _|___| _| (_) | .` | | | \__ \___\__ \ _|  | |
;;  \___|_||_|___|_|\_|___|___/___|  |_| \___/|_|\_| |_| |___/   |___/___| |_|

;; 中文等宽字体设置插件
;; (require 'chinese-fonts-setup)
;; 让 chinese-fonts-setup 随着 emacs 自动生效。
;; (chinese-fonts-setup-enable)
;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
;; (cfs-set-spacemacs-fallback-fonts)

;; 设置中文等宽字体，有中英文对齐的功效
;; (set-face-attribute
;;  'default nil
;;  :font (font-spec :name "-APPL-Monaco-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
;;                   :weight 'normal
;;                   :slant 'normal
;;                   :size 11.5))          ;; ever 12

; 仅在图形界面下设置字体                        19:26 2016/12/07
;; (if (display-graphic-p)
;;     (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;       (set-fontset-font
;;        (frame-parameter nil 'font)
;;        charset
;;        (font-spec :name "-WenQ-文泉驿等宽正黑-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1"
;;                   :weight 'normal
;;                   :slant 'normal
;;                   :size 13.0))))        ;; ever 14

(provide 'settings)
;;; settings.el ends here
