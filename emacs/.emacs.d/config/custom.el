;;; custom --- Felix's .emacs
;;; commentary:
;;; author: Felix Zheng.
;;; mail:ifelixzheng@163.com
;;; date: 16:17 2022/06/03

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style
   '((c-mode . "linux") (c++-mode . "linux") (java-mode . "java")
	 (awk-mode . "awk") (other . "gnu")))
 '(cfs--current-profile "profile1" t)
 '(cfs--profiles-steps '(("profile1" . 4)) t)
 '(confirm-kill-emacs 'y-or-n-p)
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("01f347a923dd21661412d4c5a7c7655bf17fb311b57ddbdbd6fce87bd7e58de6"
	 "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"
	 default))
 '(doxymacs-doxygen-style "C++")
 '(flycheck-keymap-prefix "\3c")
 '(lsp-apply-edits-after-file-operations nil)
 '(org-babel-load-languages '((shell . t) (emacs-lisp . t)))
 '(package-selected-packages
   '(ace-jump-mode no-littering cmake-mode company-c-headers doxymacs
				   expand-region figlet flycheck go-mode
				   goto-last-change helm highlight-parentheses lsp-ui
				   lua-mode magit projectile python-mode
				   spacemacs-theme window-number yasnippet-snippets))
 '(password-cache-expiry nil)
 '(server-auth-key
   "H_#!ZB<Tjox|)DaeTk@f#*`CuCO@/b~<f^$uI<&+2l{<eryt]Z7v]v22IunOgWw}")
 '(server-use-tcp t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:background "magenta" :foreground "#0072b2"))))
 '(whitespace-tab ((t (:background "red")))))

(provide 'custom)
;;; custom.el ends here
