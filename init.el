;; -*- coding: utf-8 -*-
;(defvar best-gc-cons-threshold gc-cons-threshold "Best default gc threshold value. Should't be too big.")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Inherited from the source: https://github.com/redguardtoo/emacs.d
;; Author: ikol172q
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-visual-line-mode 1) ; 1 for on, 0 for off

(package-initialize)

(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)

(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (and (not (featurep 'xemacs)) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

(setq *emacs24old*  (or (and (= emacs-major-version 24) (= emacs-minor-version 3))
                        (not *emacs24*)))

;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
      (read-only-mode -1)))

;; @see https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; Normally file-name-handler-alist is set to
;; (("\\`/[^/]*\\'" . tramp-completion-file-name-handler)
;; ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler)
;; ("\\`/:" . file-name-non-special))
;; Which means on every .el and .elc file loaded during start up, it has to runs those regexps against the filename.
(let ((file-name-handler-alist nil))
  (require 'init-autoload)
  (require 'init-modeline)
  (require 'cl-lib)
  (require 'init-compat)
  (require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
  (require 'init-utils)

  ;; Windows configuration, assuming that cygwin is installed at "c:/cygwin"
  ;; (condition-case nil
  ;;     (when *win64*
  ;;       ;; (setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
  ;;       (setq cygwin-mount-cygwin-bin-directory "c:/cygwin64/bin")
  ;;       (require 'setup-cygwin)
  ;;       ;; better to set HOME env in GUI
  ;;       ;; (setenv "HOME" "c:/cygwin/home/someuser")
  ;;       )
  ;;   (error
  ;;    (message "setup-cygwin failed, continue anyway")
  ;;    ))

  (require 'idle-require)
  (require 'init-elpa)
  (require 'init-exec-path) ;; Set up $PATH
  ;; any file use flyspell should be initialized after init-spelling.el
  ;; actually, I don't know which major-mode use flyspell.
  (require 'init-spelling)
  (require 'init-gui-frames)
  (require 'init-ido)
  (require 'init-dired)
  (require 'init-uniquify)
  (require 'init-ibuffer)
  (require 'init-ivy)
  (require 'init-hippie-expand)
  (require 'init-windows)
  (require 'init-sessions)
  (require 'init-git)
  (require 'init-crontab)
  (require 'init-markdown)
  (require 'init-erlang)
  (require 'init-javascript)
  (require 'init-org)
  (require 'init-css)
  (require 'init-python-mode)
  (require 'init-haskell)
  (require 'init-ruby-mode)
  (require 'init-lisp)
  (require 'init-elisp)
  (require 'init-yasnippet)
  ;; Use bookmark instead
  (require 'init-cc-mode)
  (require 'init-gud)
  (require 'init-linum-mode)
  ;; (require 'init-gist)
  (require 'init-moz)
  (require 'init-gtags)
  ;; init-evil dependent on init-clipboard
  (require 'init-clipboard)
  ;; use evil mode (vi key binding)
  (require 'init-multiple-cursors)
  (require 'init-sh)
  (require 'init-ctags)
  (require 'init-bbdb)
  (require 'init-gnus)
  (require 'init-lua-mode)
  (require 'init-workgroups2)
  (require 'init-term-mode)
  (require 'init-web-mode)
  (require 'init-slime)
  (require 'init-company)
  (require 'init-chinese-pyim) ;; cannot be idle-required
  ;; need statistics of keyfreq asap
  (require 'init-keyfreq)
  (require 'fill-column-indicator)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;---------------------------Additional packages------------------------------
  (require 'init-httpd)
  ;;(require 'init-evil)
  ;;(require 'speedbar-extension)
  (require 'dired+)
  (require 'ansi-color)
  ;;(require 'init-color-theme)
  ;;(require 'rainbow-mode)
  (require 'ein)
  (require 'auto-complete)
  (require 'cc-mode)
  ;;(require 'livedown)
  ;;(require 'dash)
  ;;(require 's)
  ;;(require 'f)
  (require 'ob-ipython)

  ;; projectile costs 7% startup time

  ;; misc has some crucial tools I need immediately
  (require 'init-misc)

  ;; comment below line if you want to setup color theme in your own way
  (if (or (display-graphic-p) (string-match-p "256color"(getenv "TERM"))) (require 'init-color-theme))

  (require 'init-emacs-w3m)
  (require 'init-hydra)

  ;; {{ idle require other stuff
  (setq idle-require-idle-delay 2)
  (setq idle-require-symbols '(init-perforce
                               init-misc-lazy
                               init-which-func
                               init-fonts
                               init-hs-minor-mode
                               init-writting
                               init-pomodoro
                               init-artbollocks-mode
                               init-semantic))
  (idle-require-mode 1) ;; starts loading
  ;; }}

  (when (require 'time-date nil t)
    (message "Emacs startup time: %d seconds."
             (time-to-seconds (time-since emacs-load-start-time))))

  ;; my personal setup, other major-mode specific setup need it.
  ;; It's dependent on init-site-lisp.el
  (if (file-exists-p "~/.custom.el") (load-file "~/.custom.el")))

;; @see https://www.reddit.com/r/emacs/comments/4q4ixw/how_to_forbid_emacs_to_touch_configuration_files/
(setq custom-file (concat user-emacs-directory "custom-set-variables.el"))
(load custom-file 'noerror)

(setq gc-cons-threshold best-gc-cons-threshold)
;;; Local Variables:
;;; no-byte-compile: t
;;; End:
(put 'erase-buffer 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Additional packages and plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when window-system (set-frame-size (selected-frame) 121 48)) ;; Resize the window
(tool-bar-mode nil)
(menu-bar-mode nil)
(toggle-scroll-bar nil)
(scroll-bar-mode nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default fill-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "gray")
(add-hook 'after-change-major-mode-hook 'fci-mode)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; resource: http://codingpy.com/article/emacs-the-best-python-editor/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8))

;; PYTHON CONFIGURATION
;; --------------------------------------
;; https://tkf.github.io/emacs-ipython-notebook/
(elpy-enable)
(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sppedbar setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq speedbar-show-unknown-files t) ;; show all files
(setq speedbar-use-images nil) ;; use text for buttons
(setq sr-speedbar-right-side nil) ;; put on left side
(setq sr-speedbar-auto-refresh nil) ;; turn on auto-refresh
(setq sr-speedbar-width 33)

(add-hook 'emacs-startup-hook (lambda ()
(sr-speedbar-open)
))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Projectile setting
;; Projectile source: http://batsov.com/projectile/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(projectile-global-mode)
;;(setq projectile-require-project-root nil)
;;(setq projectile-indexing-method 'native)
;;(setq projectile-enable-caching t)

;;(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

;;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq ein:use-auto-complete t)
;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Livedown setting: https://github.com/shime/emacs-livedown
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
'(livedown-autostart nil) ; automatically open preview when opening markdown files
'(livedown-open t)        ; automatically open the browser window
'(livedown-port 1337)     ; port for livedown server
'(livedown-browser nil))  ; browser to use

(setq py-split-windows-on-execute-p t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-Babel for ipython
;; source: https://github.com/gregsexton/ob-ipython
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ipython . t)
   ;; other languages..
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tabbar model setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (require 'tabbar nil t)
  (tabbar-mode 1))

(setq tabbar-use-images nil)

(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
    
(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
  `(defun ,name (arg)
     (interactive "P"), do-always
     (if (equal nil arg), on-no-prefix, on-prefix)))

(defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))

(defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Resource: https://zhangda.wordpress.com/2012/09/21/tabbar-mode-rocks-with-customization/
(defun tabbar-buffer-groups-by-dir ()
  "Put all files in the same directory into the same tab bar"
  (with-current-buffer (current-buffer)
    (let ((dir (expand-file-name default-directory)))
      (cond ;; assign group name until one clause succeeds, so the order is important
       ((eq major-mode 'dired-mode)
        (list "Dired"))
       ((memq major-mode
              '(help-mode apropos-mode Info-mode Man-mode))
        (list "Help"))
       ((string-match-p "\*.*\*" (buffer-name))
        (list "Misc"))
       (t (list dir))))))

(defun tabbar-switch-grouping-method (&optional arg)
  "Changes grouping method of tabbar to grouping by dir. With a prefix arg, changes to grouping by major mode."
  (interactive "P")
  (ignore-errors
    (if arg
      (setq tabbar-buffer-groups-function 'tabbar-buffer-groups) ;; the default setting
      (setq tabbar-buffer-groups-function 'tabbar-buffer-groups-by-dir))))

(global-set-key [(control tab)] 'shk-tabbar-next)
(global-set-key [(control shift tab)] 'shk-tabbar-prev)

(setq tabbar-background-color "#959A79") ;; the color of the tabbar background
(custom-set-faces
 '(tabbar-default ((t (:inherit variable-pitch :background "#959A79" :foreground "black" :weight bold))))
 '(tabbar-button ((t (:inherit tabbar-default :foreground "dark red"))))
 '(tabbar-button-highlight ((t (:inherit tabbar-default))))
 '(tabbar-highlight ((t (:underline t))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#95CA59")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cursor setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default cursor-type 'bar) ; change the cursor shape
(set-cursor-color "#ffffff") ; change the cursor color

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(add-hook 'text-mode-hook 'turn-on-visual-line-mode)


;;------------------------------------------------------------
;; * 
;;------------------------------------------------------------
