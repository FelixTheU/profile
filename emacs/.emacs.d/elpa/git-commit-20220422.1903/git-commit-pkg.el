(define-package "git-commit" "20220422.1903" "Edit Git commit messages."
  '((emacs "25.1")
    (compat "28.1.0.4")
    (transient "20210920")
    (with-editor "20211001"))
  :commit "61450cf56bf5a63f354540f510569c26762cd1c0" :authors
  '(("Jonas Bernoulli" . "jonas@bernoul.li")
    ("Sebastian Wiesner" . "lunaryorn@gmail.com")
    ("Florian Ragwitz" . "rafl@debian.org")
    ("Marius Vollmer" . "marius.vollmer@gmail.com"))
  :maintainer
  '("Jonas Bernoulli" . "jonas@bernoul.li")
  :keywords
  '("git" "tools" "vc")
  :url "https://github.com/magit/magit")
;; Local Variables:
;; no-byte-compile: t
;; End: