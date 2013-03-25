;; (setq gnus-nntp-server "news.gmane.org"
;;       gnus-read-active-file nil
;;       gnus-save-newsrc-file nil
;;       gnus-read-newsrc-file nil
;;       gnus-check-new-newsgroups nil)

(require 'nnir)

(setq gnus-select-method '(nnimap "gmail"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)))

(setq nnimap-authinfo-file "~/.authinfo-imap")
;; choose text/plain instead of HTML if available
(setq mm-discouraged-alternatives '("text/html" "text/richtext"))


(setq gnus-home-directory "~/Library/Gnus")
;; make sure gnus doesn't ignore the [Gmail] prefix
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq message-directory "~/Library/Gnus/Mail/")
(setq gnus-directory "~/Library/Gnus/News/")
(setq nnfolder-directory "~/Library/Gnus/Mail/archive")

(setq starttls-use-gnutls t
      starttls-gnutls-program "/usr/local/bin/gnutls-cli"
      starttls-extra-arguments '("--x509cafile=/usr/local/Cellar/gnutls/3.1.9/certs/Equifax_Secure_Certificate_Authority.pem.txt"))

(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo-smtp")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(require 'smtpmail)

;; allow for HTML rendering in Gnus
(add-to-list 'load-path "~/Library/Application Support/Aquamacs Emacs/share/emacs/site-lisp/w3m")
(if window-system
   (require 'w3m-load))
