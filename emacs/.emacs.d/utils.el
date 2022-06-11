;;; utils --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 16:18 2022/06/03

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
  (find-file "~/.emacs.d/init.el"))
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

(provide 'misc)
;;; misc.el ends here
