;;; init.el --- Emacs configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Save the contents of this file to ~/.config/emacs/init.el and
;; you're ready to boot up Emacs.

;; Hack this file! One of the best ways to get started with Emacs is
;; to look at other peoples' configurations and extract the pieces
;; that work for you. That's where this configuration started. I
;; encourage you to read through the code in this file and explore the
;; functions and variables using the built-in help system (details
;; below). Happy hacking!

;; "C-<chr>  means hold the CONTROL key while typing the character <chr>.
;; Thus, C-f would be: hold the CONTROL key and type f." (Emacs tutorial)
;;
;; - C-h t: Start the Emacs tutorial
;; - C-h o some-symbol: Describe symbol
;; - C-h C-q: Pull up the quick-help cheatsheet

;;; Code:

;; Performance tweaks for modern machines
(setq gc-cons-threshold 100000000) ; 100 mb
(setq read-process-output-max (* 1024 1024)) ; 1mb

;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Set the font. Note: height = px * 100
(set-face-attribute 'default nil :font "JetBrainsMono" :height 120)

;; Make it a bit transparent
(set-frame-parameter nil 'alpha-background 70)
(add-to-list 'default-frame-alist '(alpha-background . 70))

;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
(require 'uniquify)

;; Automatically insert closing parens
(electric-pair-mode t)

;; Visualize matching parens
(show-paren-mode 1)

;; Prefer spaces to tabs
(setq-default indent-tabs-mode nil)

;; Automatically save your place in files
(save-place-mode t)

;; Save history in minibuffer to keep recent commands easily accessible
(savehist-mode t)

;; Keep track of open files
(recentf-mode t)

;; Keep files up-to-date when they change outside Emacs
(global-auto-revert-mode t)

;; Display line numbers only when in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; The `setq' special form is used for setting variables. Remember
;; that you can look up these variables with "C-h v variable-name".
(setq uniquify-buffer-name-style 'forward
      window-resize-pixelwise t
      frame-resize-pixelwise t
      load-prefer-newer t
      backup-by-copying t
      ;; Backups are placed into your Emacs directory, e.g. ~/.config/emacs/backups
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      ;; I'll add an extra note here since user customizations are important.
      ;; Emacs actually offers a UI-based customization menu, "M-x customize".
      ;; You can use this menu to change variable values across Emacs. By default,
      ;; changing a variable will write to your init.el automatically, mixing
      ;; your hand-written Emacs Lisp with automatically-generated Lisp from the
      ;; customize menu. The following setting instead writes customizations to a
      ;; separate file, custom.el, to keep your init.el clean.
      custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Bring in package utilities so we can install packages from the web.
(require 'package)

;; Add MELPA, an unofficial (but well-curated) package registry to the
;; list of accepted package registries. By default Emacs only uses GNU
;; ELPA and NonGNU ELPA, https://elpa.gnu.org/ and
;; https://elpa.nongnu.org/ respectively.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Unless we've already fetched (and cached) the package archives,
;; refresh them.
;;(unless package-archive-contents
;;  (package-refresh-contents))

;; Add the :vc keyword to use-package, making it easy to install
;; packages directly from git repositories.
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)

;; A quick primer on the `use-package' function (refer to
;; "C-h f use-package" for the full details).
;;
;; (use-package my-package-name
;;   :ensure t    ; Ensure my-package is installed
;;   :after foo   ; Load my-package after foo is loaded (seldom used)
;;   :init        ; Run this code before my-package is loaded
;;   :bind        ; Bind these keys to these functions
;;   :custom      ; Set these variables
;;   :config      ; Run this code after my-package is loaded

;; A package with a great selection of themes:
;; https://protesilaos.com/emacs/ef-themes
(use-package ef-themes
  :ensure t
  :config
  (ef-themes-select 'ef-autumn))

;; Minibuffer completion is essential to your Emacs workflow and
;; Vertico is currently one of the best out there. There's a lot to
;; dive in here so I recommend checking out the documentation for more
;; details: https://elpa.gnu.org/packages/vertico.html. The short and
;; sweet of it is that you search for commands with "M-x do-thing" and
;; the minibuffer will show you a filterable list of matches.
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(basic substring partial-completion flex))
  :init
  (vertico-mode))

;; Improve the accessibility of Emacs documentation by placing
;; descriptions directly in your minibuffer. Give it a try:
;; "M-x find-file".
(use-package marginalia
  :after vertico
  :ensure t
  :init
  (marginalia-mode))

;; Adds intellisense-style code completion at point that works great
;; with LSP via Eglot. You'll likely want to configure this one to
;; match your editing preferences, there's no one-size-fits-all
;; solution.
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  ;; You may want to play with delay/prefix/styles to suit your preferences.
  (corfu-auto-delay 0)
  (corfu-auto-prefix 0)
  (completion-styles '(basic)))

;; Add extra context to Emacs documentation to help make it easier to
;; search and understand. This configuration uses the keybindings 
;; recommended by the package author.
(use-package helpful
  :ensure t
  :bind (("C-h f" . #'helpful-callable)
         ("C-h v" . #'helpful-variable)
         ("C-h k" . #'helpful-key)
         ("C-c C-d" . #'helpful-at-point)
         ("C-h F" . #'helpful-function)
         ("C-h C" . #'helpful-command)))

;; Adds vim emulation. Activate `evil-mode' to swap your default Emacs
;; keybindings with the modal editor of great infamy. There's a ton of
;; keybindings that Evil needs to modify, so this configuration also
;; includes `evil-collection' to fill in the gaps.
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; `org-mode' is great but Denote makes it even better by adding
;; features that you'd find in something like Obsidian (like
;; backlinks!). You can write your notes in org, markdown, or plain
;; text, though I recommend giving `org-mode' a try if you've never
;; used it before. The Denote manual is also excellent:
;; https://protesilaos.com/emacs/denote
(use-package denote
  :ensure t
  :custom
  (denote-known-keywords '("emacs" "journal"))
  ;; This is the directory where your notes live.
  (denote-directory (expand-file-name "~/denote/"))
  :bind
  (("C-c n n" . denote)
   ("C-c n f" . denote-open-or-create)
   ("C-c n i" . denote-link)))

;; Status line
(use-package lambda-line
  :vc (:fetcher github :repo Lambda-Emacs/lambda-line)
  :custom
  (lambda-line-icon-time t) ;; requires ClockFace font (see below)
  (lambda-line-clockface-update-fontset "JetBrainsMono") ;; set clock icon
  (lambda-line-position 'top) ;; Set position of status-line 
  (lambda-line-abbrev t) ;; abbreviate major modes
  (lambda-line-hspace "  ")  ;; add some cushion
  (lambda-line-prefix t) ;; use a prefix symbol
  (lambda-line-prefix-padding nil) ;; no extra space for prefix 
  (lambda-line-status-invert nil)  ;; no invert colors
  ;(lambda-line-gui-ro-symbol  " ⨂") ;; symbols
  ;(lambda-line-gui-mod-symbol " ⬤") 
  ;(lambda-line-gui-rw-symbol  " ◯") 
  (lambda-line-space-top +.50)  ;; padding on top and bottom of line
  (lambda-line-space-bottom -.50)
  (lambda-line-symbol-position 0.1) ;; adjust the vertical placement of symbol
  (lambda-line-position "header")
  :config
  ;; activate lambda-line 
  (lambda-line-mode)
  ;; set divider line in footer
  (when (eq lambda-line-position 'top)
    (setq-default mode-line-format (list "%_"))
    (setq mode-line-format (list "%_"))))

;; LSP for Nim and C
(package-install 'nim-mode)
(package-install 'flymake)
(package-install 'lsp-mode)

(require 'lsp-mode)
(require 'nim-mode)

(setq nimsuggest-path "nimsuggest")
(add-hook 'nim-mode-hook #'lsp)

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-inlay-hint-enable t)

  ;; Nim
  (lsp-nim-auto-check-file t)
  (lsp-nim-langserver "nimlsp")

  ;; C/C++
  (lsp-clangd-binary-path "clangd")
  (lsp-clients-clangd-executable "clangd")

  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-update-mode t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-side 'left)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t))

(defun my--init-nim-mode ()
  "Local init function for `nim-mode'."

  (local-set-key (kbd "M->") 'nim-indent-shift-right)
  (local-set-key (kbd "M-<") 'nim-indent-shift-left)

  (auto-fill-mode 0)
  (electric-indent-local-mode 0)
)

(add-hook 'nim-mode-hook 'my--init-nim-mode)

;; An extremely feature-rich git client. Activate it with "C-c g".
(use-package magit
  :ensure t
  :bind (("C-c g" . magit-status)))

;; Nord theme
(package-install 'nord-theme)
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
(load-theme 'nord t)

;; Fuzzy finder
(package-install 'orderless)
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

(use-package affe
  :config
  ;; Manual preview key for `affe-grep'
  (consult-customize affe-grep :preview-key "C-c f"))

(global-set-key (kbd "C-c f") 'affe-grep)

; (setq affe-regexp-compiler #'affe-orderless-regexp-compiler)

;; Email client
(package-install 'notmuch)
(use-package helm
  :vc (:fetcher github :repo emacs-helm/helm)
  )

(package-install 'helm-notmuch)
(require 'helm)
(require 'helm-notmuch)
(require 'notmuch)

;; Dashboard
(defun db/random-quote ()
  "Generate a random quote for dashboard"
  (interactive)
  (let ((ops '(
    "Those who can, do. Those who cannot, complain."
    "Any sufficiently advanced technology is indistinguishable from magic."
    "The only way of discovering the limits of the possible is to venture a little way past them into the impossible."
    "Premature optimization is the root of all evil."))) (nth (random (length ops)) ops)))

(use-package dashboard
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (setq dashboard-banner-logo-title (db/random-quote))
  (setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 5)
                        (registers . 5)))
  
  (setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
  (dashboard-setup-startup-hook))
