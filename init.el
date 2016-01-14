(require 'cl)

(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-archive-enable-alist '(("melpa" deft magit)))

(defvar mplamann/packages '(ace-jump-mode
			    auctex
			    evil
			    evil-escape
			    evil-leader
			    evil-surround
			    haskell-mode
			    magit 
			    paredit
			    use-package
			    zenburn-theme))

(defun mplamann/packages-installed-p ()
  (loop for pkg in mplamann/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (mplamann/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg mplamann/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(require 'use-package)

(load-theme 'zenburn t)

(use-package
 evil
 :config
 (evil-mode 1))

(use-package
  evil-escape
  :config
  (evil-escape-mode 1))

(use-package
  evil-surround
  :config
  (global-evil-surround-mode 1)
  (evil-define-key 'visual
    evil-surround-mode-map "s" 'evil-surround-region)
  (evil-define-key 'visual
    evil-surround-mode-map "S" 'evil-substitute))

(use-package
  evil-leader
  :config
  (setq evil-leader/leader "SPC")
  (global-evil-leader-mode)
  (evil-leader/set-key
    ;; c- compilation
    "c" 'compile
    ;; f- file operations
    "fs" 'save-buffer
    ;; g- version control
    "gs" 'magit-status
    ;; p- processes
    "ps" 'shell
    ;; t- text manipulation
    "tr" 'indent-region
    ;; b- buffer operations
    "s" 'switch-to-buffer
    "bn" 'switch-to-next-buffer
    "bp" 'switch-to-prev-buffer
    "br" 'revert-buffer))

(use-package
  haskell-mode
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))

(use-package
  ace-jump-mode
  :config
  (evil-leader/set-key
    "SPC" 'ace-jump-char-mode))

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

(setq scroll-step 1
      scroll-conservatively 10000)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq make-backup-files nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(show-paren-mode 1)

;; I bring an end to mouse clicks
(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]  
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
