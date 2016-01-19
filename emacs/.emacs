(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "#000000" :foreground "#41FF00" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "adobe" :family "Source Code Pro")))))

(setq inhibit-startup-message t)

(global-unset-key "\M-g")
(global-set-key "\M-g" 'goto-line)

(global-set-key "\C-xaa" 'save-buffers-kill-emacs)
(global-unset-key "\C-x\C-c")

(global-unset-key "\C-x\C-z")  ;; was suspend-or-iconify-emacs

;; for screen/tmux
(define-key input-decode-map "\M-[1;5A" [(control up)])
(define-key input-decode-map "\M-[1;5B" [(control down)])
(define-key input-decode-map "\M-[1;5C" [(control right)])
(define-key input-decode-map "\M-[1;5D" [(control left)])

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/my-lisp"))

(require 'whitespace)

(setq-default whitespace-style '(face trailing newline indentation space-after-tab space-before-tab))
(global-whitespace-mode)

(require 'ws-trim)

(global-ws-trim-mode t)
(setq-default ws-trim-level 1)

(fset 'xml-mode 'nxml-mode)
(setq-default nxml-child-indent 4)

(show-paren-mode 1)

(setq-default indent-tabs-mode nil)

(require 'auto-complete-config)
(ac-config-default)

;;;;;;;; C ;;;;;;;;

(setq-default c-basic-offset 4)

(global-font-lock-mode 1)

(global-set-key "\C-c2" (lambda () (interactive)
                          (setq c-basic-offset 2)
                          (setq indent-tabs-mode nil)))
(global-set-key "\C-c4" (lambda () (interactive)
                          (setq c-basic-offset 4)
                          (setq indent-tabs-mode nil)))
(global-set-key "\C-c8" (lambda () (interactive)
                          (setq c-basic-offset 8)
                          (setq indent-tabs-mode t)))

(defun my-c-mode-hook ()
  ;;(c-set-style "my-c-style")
  ;;(c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
  (c-set-offset 'statement-cont 4)
  ;;(c-set-offset 'inline-open '+)
  ;;(c-set-offset 'block-open '+)
  ;;(c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  ;;(c-set-offset 'case-label '+)       ; indent case labels by c-indent-level, too
)
(add-hook 'c-mode-hook 'my-c-mode-hook)

;;;;;;;;

;;;;;;;; Python ;;;;;;;;

;; see /usr/share/emacs/23.1.50/lisp/newcomment.elc (or source)

(add-hook 'python-mode-hook
          (lambda ()
            (setq python-indent 4)
            (setq comment-start "#")
            (setq comment-padding "")

            (define-key python-mode-map "\M-3"
              (lambda ()
                (interactive)
                (save-excursion
                  (if (< (mark) (point))
                      (exchange-point-and-mark))
                  (beginning-of-line)
                  (comment-region (point) (mark) 2)
                  )
                )
              )

            (define-key python-mode-map "\M-4"
              (lambda ()
                (interactive)
                (save-excursion
                  (if (< (mark) (point))
                      (exchange-point-and-mark))
                  (beginning-of-line)
                  (comment-region (point) (mark) -2)
                  )
                )
              )
            )
          )

;;;;;;;;

(load "my-git-grep.el")

;;;;;;;;;;;;;;;;;;;;;;;;;

(load "my-ido.el")
(load "my-package.el")
(load "my-magit.el")

(load "my-czech-chars.el")

;;;;;;;;;;;;;;;;;;;;;;;;;

(global-auto-revert-mode t)

(message "in init.el")
