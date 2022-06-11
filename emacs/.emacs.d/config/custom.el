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
   '((c-mode . "linux")
     (c++-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu")))
 '(cfs--current-profile "profile1" t)
 '(cfs--profiles-steps '(("profile1" . 4)) t)
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(doxymacs-doxygen-style "C++")
 '(flycheck-keymap-prefix "c")
 '(org-babel-load-languages '((shell . t) (emacs-lisp . t)))
 '(package-selected-packages
   '(no-littering spacemacs-theme lsp-ui lsp-mode cmake-ide cmake-mode multi-term magit go-mode helm yasnippet yasnippet-snippets tabbar srefactor s projectile popup mode-compile highlight-parentheses goto-last-change flycheck figlet expand-region company-c-headers async ace-jump-mode))
 '(password-cache-expiry nil)
 '(server-auth-key
   "H_#!ZB<Tjox|)DaeTk@f#*`CuCO@/b~<f^$uI<&+2l{<eryt]Z7v]v22IunOgWw}")
 '(server-use-tcp t)
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:background "red")))))

(provide 'custom)
;;; custom.el ends here
