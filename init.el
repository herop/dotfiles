;; Make sure `use-package' is available.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Configure `use-package' prior to loading it.
(eval-and-compile
  (setq use-package-always-ensure nil)
  (setq use-package-always-defer nil)
  (setq use-package-always-demand nil)
  (setq use-package-expand-minimally nil)
  (setq use-package-enable-imenu-support t)
  (setq use-package-compute-statistics t)
  ;; The following is VERY IMPORTANT.  Write hooks using their real name
  ;; instead of a shorter version: after-init ==> `after-init-hook'.
  ;;
  ;; This is to empower help commands with their contextual awareness,
  ;; such as `describe-symbol'.
  (setq use-package-hook-name-suffix nil))

(eval-when-compile
  (require 'use-package))

;; END

;;; Dired all-the-icons need to go here
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)


;;; This fixed garbage collection, makes emacs start up faster ;;;;;;;
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))

(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
	gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; This is all kinds of necessary
(require 'package)
(setq package-enable-at-startup nil)

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

;;; remove SC if you are not using sunrise commander and org if you like outdated packages
(setq package-archives '(("ELPA"  . "http://tromey.com/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Bootstrapping use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; This is the actual config file. It is omitted if it doesn't exist so emacs won't refuse to launch.
(when (file-readable-p "~/.emacs.d/config.org")
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(buffer-expose-auto-init-aw t)
 '(buffer-expose-mode t)
 '(calendar-mark-diary-entries-flag t)
 '(calendar-view-diary-initially-flag t)
 '(current-language-environment "UTF-8")
 ;;; Like the DOOM Dracula better - for now
 ;;'(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
 '(deft-default-extension "org" t)
 '(deft-directory "~/org/" t)
 '(deft-recursive t t)
 '(deft-use-filter-string-for-filename t t)
 '(delete-by-moving-to-trash nil)
 '(dired-listing-switches "-lFaGh1v")
 '(elfeed-feeds nil)
 '(image-load-path '("~/org/images/" data-directory load-path))
 '(ls-lisp-emulation 'MS-Windows)
 '(org-agenda-files "~/.agenda_files")
 '(org-agenda-loop-over-headlines-in-active-region nil)
 '(org-agenda-show-inherited-tags t)
 '(org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled t)
 '(org-agenda-skip-scheduled-if-deadline-is-shown t t)
 '(org-agenda-sorting-strategy
   '((agenda deadline-up priority-down)
     (todo priority-down category-keep)
     (tags priority-down category-keep)
     (search category-keep)) t)
 '(org-agenda-span 'fortnight t)
 '(org-agenda-sticky nil)
 '(org-blank-before-new-entry '((heading) (plain-list-item)))
 '(org-download-image-dir "~/org/files/" t)
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-hide-leading-stars t)
 '(org-journal-date-format "%A, %d %B %Y")
 '(org-journal-date-prefix "#+TITLE: ")
 '(org-journal-dir "~/org/")
 '(org-journal-file-format "%Y-%m-%d.org")
 '(org-link-search-must-match-exact-headline nil)
 '(org-log-done 'time)
 '(org-pretty-entities t)
 '(org-protocol-project-alist
   '(("https://orgmode.org/worg/" :base-url "https://orgmode.org/worg/" :working-directory "c:/Users/JochenBurkhard/iCloudDrive/iCloud~com~appsonthemove~beorg/org/" :online-suffix ".html" :working-suffix ".org")))
 '(org-roam-directory "~/org/" nil nil "Customized with use-package org-roam")
 '(org-roam-graph-executable "C:/Program Files (x86)/Graphviz2.38/bin/dot.exe")
 '(org-roam-index-file "~/org/index.org")
 '(org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "PROJECT(p)" "ONIT(o)" "WAIT(w@/!)" "MEETING(m@)" "|" "DONE(d!)" "CANCELLED(c@)")))
 '(quelpa-upgrade-p t)
 '(super-save-mode t)
 '(trash-directory nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-hide ((t (:foreground "gray17")))))
