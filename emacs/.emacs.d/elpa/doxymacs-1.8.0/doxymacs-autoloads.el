;;; doxymacs-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "../../../profile/emacs/.emacs.d/elpa/doxymacs-1.8.0/doxymacs"
;;;;;;  "doxymacs.el" "e41c6f859ba5fa187259f599257727e8")
;;; Generated autoloads from doxymacs.el

(or (assoc 'doxymacs-mode minor-mode-alist) (setq minor-mode-alist (cons '(doxymacs-mode " doxy") minor-mode-alist)))

;;;***

;;;### (autoloads nil "../../../profile/emacs/.emacs.d/elpa/doxymacs-1.8.0/xml-parse"
;;;;;;  "xml-parse.el" "80976a3e41773df651631b24227ac30e")
;;; Generated autoloads from xml-parse.el

(autoload 'read-xml "../../../profile/emacs/.emacs.d/elpa/doxymacs-1.8.0/xml-parse" "\
Parse XML data at point into a Lisp structure.
See `insert-xml' for a description of the format of this structure.
Point is left at the end of the XML structure read.

\(fn &optional PROGRESS-CALLBACK)" nil nil)

(autoload 'insert-xml "../../../profile/emacs/.emacs.d/elpa/doxymacs-1.8.0/xml-parse" "\
Insert DATA, a recursive Lisp structure, at point as XML.
DATA has the form:

  ENTRY       ::=  (TAG CHILD*)
  CHILD       ::=  STRING | ENTRY
  TAG         ::=  TAG_NAME | (TAG_NAME ATTR+)
  ATTR        ::=  (ATTR_NAME . ATTR_VALUE)
  TAG_NAME    ::=  STRING
  ATTR_NAME   ::=  STRING
  ATTR_VALUE  ::=  STRING

If ADD-NEWLINES is non-nil, newlines and indentation will be added to
make the data user-friendly.

If PUBLIC and SYSTEM are non-nil, a !DOCTYPE tag will be added at the
top of the document to identify it as an XML document.

DEPTH is normally for internal use only, and controls the depth of the
indentation.

\(fn DATA &optional ADD-NEWLINES PUBLIC SYSTEM DEPTH RET-DEPTH)" nil nil)

(autoload 'xml-reformat-tags "../../../profile/emacs/.emacs.d/elpa/doxymacs-1.8.0/xml-parse" "\
If point is on the open bracket of an XML tag, reformat that tree.
Note that this only works if the opening tag starts at column 0.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "doxymacs" "../../../../../.emacs.d/elpa/doxymacs-1.8.0/doxymacs.el"
;;;;;;  "e41c6f859ba5fa187259f599257727e8")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/doxymacs-1.8.0/doxymacs.el

(or (assoc 'doxymacs-mode minor-mode-alist) (setq minor-mode-alist (cons '(doxymacs-mode " doxy") minor-mode-alist)))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/doxymacs-1.8.0/doxymacs-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/doxymacs-1.8.0/doxymacs-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/doxymacs-1.8.0/doxymacs.el"
;;;;;;  "../../../../../.emacs.d/elpa/doxymacs-1.8.0/xml-parse.el"
;;;;;;  "doxymacs.el" "xml-parse.el") (23202 34192 962180 668000))

;;;***

;;;### (autoloads nil "xml-parse" "../../../../../.emacs.d/elpa/doxymacs-1.8.0/xml-parse.el"
;;;;;;  "80976a3e41773df651631b24227ac30e")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/doxymacs-1.8.0/xml-parse.el

(autoload 'read-xml "xml-parse" "\
Parse XML data at point into a Lisp structure.
See `insert-xml' for a description of the format of this structure.
Point is left at the end of the XML structure read.

\(fn &optional PROGRESS-CALLBACK)" nil nil)

(autoload 'insert-xml "xml-parse" "\
Insert DATA, a recursive Lisp structure, at point as XML.
DATA has the form:

  ENTRY       ::=  (TAG CHILD*)
  CHILD       ::=  STRING | ENTRY
  TAG         ::=  TAG_NAME | (TAG_NAME ATTR+)
  ATTR        ::=  (ATTR_NAME . ATTR_VALUE)
  TAG_NAME    ::=  STRING
  ATTR_NAME   ::=  STRING
  ATTR_VALUE  ::=  STRING

If ADD-NEWLINES is non-nil, newlines and indentation will be added to
make the data user-friendly.

If PUBLIC and SYSTEM are non-nil, a !DOCTYPE tag will be added at the
top of the document to identify it as an XML document.

DEPTH is normally for internal use only, and controls the depth of the
indentation.

\(fn DATA &optional ADD-NEWLINES PUBLIC SYSTEM DEPTH RET-DEPTH)" nil nil)

(autoload 'xml-reformat-tags "xml-parse" "\
If point is on the open bracket of an XML tag, reformat that tree.
Note that this only works if the opening tag starts at column 0.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/doxymacs-1.8.0/doxymacs-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/doxymacs-1.8.0/doxymacs-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/doxymacs-1.8.0/doxymacs.el"
;;;;;;  "../../../../../.emacs.d/elpa/doxymacs-1.8.0/xml-parse.el"
;;;;;;  "../../../../../.emacs.d/elpa/doxymacs-1.8.0/xml-parse.el"
;;;;;;  "doxymacs.el" "xml-parse.el" "xml-parse.el") (23202 34334
;;;;;;  956232 749000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; doxymacs-autoloads.el ends here
