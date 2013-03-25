;;
;; Platform Selection
;; -----------------------------------------------------------------------
(defvar running-apple (string-match "apple" system-configuration))

;; -----------------------------------------------------------------------
;; User interface
;; -----------------------------------------------------------------------
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message "mengelhart")
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq visible-bell t)
;;(setq bell-volume 0) ;; turn off annoying bell!!
;; turn off toolbar
(if window-system
    (tool-bar-mode -1))

;; Make all yes-or-no questions as y-or-n
(fset 'yes-or-no-p 'y-or-n-p) 

;; unique the buffer names
;;(require 'uniquify)

;; set default font size
(set-face-attribute 'default nil :height 160)

;; -----------------------------------------------------------------------
;; File navigation tools
;; -----------------------------------------------------------------------

(load-file "~/.emacs.d/vendor/sr-speedbar.el")
(require 'sr-speedbar)


(load-file "~/.emacs.d/vendor/protobuf-mode.el")
(require 'protobuf-mode)
(setq auto-mode-alist (cons '("\\.proto\\'" . protobuf-mode) auto-mode-alist))

(require 'ido)
(ido-mode t)
(ido-everywhere t)

;; setup autocomplete 
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete")
(require 'auto-complete-config)
;; ; Make sure we can find the dictionaries
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/dict")
;; ; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
;; ; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
;; ; case sensitivity is important when finding matches
(setq ac-ignore-case nil)


;; Linum mode
(global-linum-mode 1)
(setq linum-format "%d ")

(setq linum-mode-inhibit-modes-list '(eshell-mode
                                      shell-mode
                                      erc-mode
                                      jabber-roster-mode
                                      jabber-chat-mode
                                      gnus-group-mode
                                      speedbar-mode
                                      gnus-summary-mode
                                      grep-mode
                                      gnus-article-mode))

(defadvice linum-on (around linum-on-inhibit-for-modes)
  "Stop the load of linum-mode for some major modes."
    (unless (member major-mode linum-mode-inhibit-modes-list)
      ad-do-it))

(ad-activate 'linum-on)

;; -----------------------------------------------------------------------
;; Gmail/Gnus/W3m support
;; -----------------------------------------------------------------------

(load-file "~/.emacs.d/vendor/gmail-gnus.el")
;; -----------------------------------------------------------------------
;; Miscellaneous editor settings
;; -----------------------------------------------------------------------


;; sr-speedbar configuration
(define-key osx-key-mode-map (kbd "A-b") 'sr-speedbar-toggle)
;(setq sr-speedbar-refresh-turn-off 1)
(setq speedbar-use-images nil)
(setq sr-speedbar-max-width 120)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width-console 120)
(setq sr-speedbar-auto-refresh nil)
(setq sr-speedbar-skip-other-window-p t)





(setq compile-command "/usr/bin/ruby ")

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2) 

; special stuff for ruby mode
(setq auto-mode-alist (cons '("\\.rake\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rb\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Rakefile$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Gemfile.*$" . ruby-mode) auto-mode-alist))


;; remap some basic keys to use Apple HUI guidelines but emacs functionality
(define-key osx-key-mode-map (kbd "A-o") 'ido-find-file)
;; isearch-forward is already bound to (kbd "A-f") internally
(define-key osx-key-mode-map (kbd "A-r") 'isearch-backward)

;; cycle buffers via Ctrl-TAB
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-S-tab>") 'previous-buffer)

;; 
;; invoke M-x by pressing C-x C-x to save wrists
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


;; have dired only use a single buffer
(put 'dired-find-alternate-file 'disabled nil)


;;
;;  Hippie Expand
;;
(defun hippie-expand-case-sensitive (arg)
  "Do case sensitive searching so we deal with gtk_xxx and GTK_YYY."
  (interactive "P")
  (let ((case-fold-search nil))
    (hippie-expand arg)))

(global-set-key "\M-/" 'hippie-expand-case-sensitive)
(global-set-key (kbd "M-SPC") 'hippie-expand-case-sensitive)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))


;; -------------------------------------------------------- [ backup-dir ]
;; Store backup files in the the Trash
(if (file-accessible-directory-p (expand-file-name "~/Library/Application Support"))
    (add-to-list 'backup-directory-alist
                 (cons "." (expand-file-name "~/Library/Application Support/EmacsBackups/"))))


(setq default-directory "~/")
;; -------------------------------------------------------------------------
;; Miscellaneous minor mode support
;; -------------------------------------------------------------------------

;; HAML and SASS 
(load-file "~/.emacs.d/vendor/haml-mode.el")
(require 'haml-mode)
(load-file "~/.emacs.d/vendor/sass-mode.el")
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))


;; YAML mode
(load-file "~/.emacs.d/vendor/yaml-mode.el")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
;; YAsnippet
(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet/snippets")



;; twilight color theme
(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/themes/color-theme-twilight.el")
(color-theme-twilight)

;; adjust the linenum line number color
(global-hl-line-mode 1)
(set-face-background 'hl-line "#223545")

;; Ruby compile syntax checker
;;(load-file "~/.emacs.d/vendor/flymake-ruby.el")
;;(require 'flymake-ruby)
;;(add-hook 'ruby-mode-hook 'flymake-ruby-load)


;; ----------------------------------------------------------------------
;; SLIME configuration
;; ----------------------------------------------------------------------
(setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
     (add-to-list 'load-path "~/.emacs.d/vendor/slime/")  ; your SLIME directory
     (require 'slime)
     (slime-setup)


;; turn off tabs in aquamacs
(tabbar-mode -1)

;; text mate minor mode 
(load-file "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)


;; ----------------------------------------------------------------------
;; Custom functions
;; ----------------------------------------------------------------------
(defun dont-kill-emacs ()
  (interactive)
  (error (substitute-command-keys "To exit emacs: \\[kill-emacs]")))
  
(global-set-key "\C-x\C-c" 'dont-kill-emacs)
;;(eval-after-load 'textmate
;;  '(define-key *textmate-mode-map* (kbd "A-t") 'forward-char))
