;; ───────────────────────────── Package setup ───────────────────────────── ;;
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; ────────────────────────────── Use-package ────────────────────────────── ;;
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; ────────────────────────── Basic configuration ────────────────────────── ;;
(setq custom-file  (expand-file-name "custom.el" user-emacs-directory))
(load-file custom-file)
(setq frame-title-format "Emacs")
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(electric-pair-mode 1)
(setq byte-compile-warnings '(cl-functions))
(setq x-select-enable-clipboard t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default shell-file-name "/bin/bash")
(setq-default explicit-shell-file-name "/bin/bash")
(prefer-coding-system 'utf-8)
(setq org-blank-before-new-entry t)
(setq scroll-conservatively 100)
(setq make-backup-files nil)
(setq auto-save-default nil)
(global-display-line-numbers-mode)
(global-hl-line-mode t)
(global-subword-mode 1)
(setq-default c-basic-offset 4)
(setq org-image-actual-width nil)
(setq display-line-numbers-type 'relative)
;; Transparency
;; (set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;; (set-frame-parameter (selected-frame) 'alpha <both>)
;; (set-frame-parameter (selected-frame) 'alpha 60)
;; (add-to-list 'default-frame-alist '(alpha 60))
;; (set-frame-parameter nil 'alpha-background 60)
;; (add-to-list 'default-frame-alist '(alpha-background . 60))
(setq package-install-upgrade-built-in t)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; ──────────────────────────── Manual Packages ──────────────────────────── ;;
(use-package ef-themes
  :load-path "~/.emacs.d/manual-packages/ef-themes")

(use-package doric-themes
  :load-path "~/.emacs.d/manual-packages/doric-themes")

(use-package r-mode
  :load-path "~/.emacs.d/manual-packages/r-mode")


(use-package typst-mode
  :load-path "~/.emacs.d/manual-packages/typst/"
 )

;;(use-package ESS
;;  :load-path "~/.emacs.d/manual-packages/ESS")

;; (use-package magit-section

;;   :load-path "~/.emacs.d/manual-packages/magit-section")

;; (use-package magit)
;;   :load-path "~/.emacs.d/manual-packages/magit")

;; (use-package lsp-biome
;;   :load-path "~/.emacs.d/manual-packages/lsp-biome")

;; (use-package biomejs-format
;;   :load-path "~/.emacs.d/manual-packages/biomejs-format")

;; (use-package indent-bars
;;   :load-path "~/.emacs.d/manual-packages/indent-bars"
;;   :hook ((python-mode web-mode typescript-mode) . indent-bars-mode))

(use-package savehist
  ;; :load-path "~/.emacs.d/manual-packages/savehist"
  :init (savehist-mode))

;; (use-package odin-mode
;;   :load-path "~/.emacs.d/manual-packages/odin-mode"
;;   :mode ("\\.odin\\'"))

;; ──────────────────────────── Prettify Symbols ──────────────────────────── ;;
(global-prettify-symbols-mode t)
(use-package pretty-mode
  :config
  (global-pretty-mode t)
  (pretty-deactivate-groups
   '(:equality :ordering :ordering-double :ordering-triple
               :arrows :arrows-twoheaded :punctuation
               :logic :sets))
  (pretty-activate-groups
   '(:sub-and-superscripts :greek :arithmetic-nary)))

(defun prettify-typescript-symbols ()
  (mapc (lambda (pair) (push pair prettify-symbols-alist))
        '(;; Syntax
          ("function" .      #x03BB)
          ;; ("() =>" .      #x0192)
          ("&&" .      #x2227)
          ("||" .      #x2228)
          ("some" .      #x2203)
          ("async" .      #x2732)
          ;; ("===" .      #x2261)
          ;; ("!==" .      #x2262)
          ;; ("in" .       #x2208)
          ("() =>" .   #x27f4)
          ("()=>" .   #x27f4)
          ("return" .   #x27fc)
          ("yield" .    #x27fb)
          ("forEach" .      #x2200)
          ;; Base Types
          ("int" .      #x2124)
          ("number" .    #x014a)
          ("string" .      #x054f)
          ("boolean" .      #x0181)
          ("true" .     #x1d54b)
          ("false" .    #x1d53d)
          ;; Mypy
          ;; ("Dict" .     #x1d507)
          ;; ("Array" .     #x2112)
          ("Array" .     #x24B6)
          ;; ("Tuple" .    #x2a02)
          ("Set" .      #x2126)
          ;; ("Iterable" . #x1d50a)
          ;; ("Any" .      #x2754)
          ;; ("Union" .    #x22c3)
          )))

;; (defun prettify-some-symbols ()
;;   (mapc (lambda (pair) (push pair prettify-symbols-alist))
;;         '(;; Syntax
;;           ;; ("/mnt/projects/scheduler-web" . #x1F5C0)
;;           ("scheduler-web" . #x2126)
;;           )))

;; (defun prettify-rescript-symbols ()
;;   (mapc (lambda (pair) (push pair prettify-symbols-alist))
;;         '(;; Syntax
;;           ("->" .      #x2192)
;;           )))
;; (add-hook 'rescript-mode-hook 'prettify-rescript-symbols)
(add-hook 'typescript-mode-hook 'prettify-typescript-symbols)
(add-hook 'tide-mode-hook 'prettify-typescript-symbols)
(add-hook 'rjsx-mode-hook 'prettify-typescript-symbols)

(add-hook
 'python-mode-hook
 (lambda ()
   (mapc (lambda (pair) (push pair prettify-symbols-alist))
         '(;; Syntax
           ;; ("def" .      #x0192)
           ("def" .      #x03BB)
           ;; ("not" .      #x2757)
           ("in" .       #x2208)
           ("not in" .   #x2209)
           ("return" .   #x27fc)
           ("yield" .    #x27fb)
           ("for" .      #x2200)
           ;; Base Types
           ("int" .      #x2124)
           ("float" .    #x211d)
           ("str" .      #x1d54a)
           ("True" .     #x1d54b)
           ("False" .    #x1d53d)
           ("some" .      #x2203)
           ;; Mypy
           ("Dict" .     #x1d507)
           ("List" .     #x2112)
           ("Tuple" .    #x2a02)
           ("Set" .      #x2126)
           ("Iterable" . #x1d50a)
           ("Any" .      #x2754)
           ("Union" .    #x22c3)))))

;; ───────────────────────────── Theme Settings ───────────────────────────── ;;
(mapc #'disable-theme custom-enabled-themes)

;; (use-package stimmung-themes
;;   :config
;;   (setq stimmung-themes-comment 'foreground)
;;   (stimmung-themes-load-dark)
;;   )

;; (global-set-key (kbd "C-c s") 'ef-themes-toggle)

(use-package modus-themes
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)
  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        '(
          (bg-mode-line-active bg-magenta-intense)
          (fringe unspecified)
          (fg-mode-line-active fg-main)
          (bg-region bg-lavender) ; try to replace `bg-ochre' with `bg-lavender', `bg-sage'
          (fg-region unspecified)
          (fg-line-number-inactive "gray50")
          (fg-line-number-active fg-main)
          (bg-line-number-inactive unspecified)
          (bg-line-number-active unspecified)
          (border-mode-line-active unspecified)
          (border-mode-line-inactive unspecified)))
  :bind
  ("<f5>" . modus-themes-toggle))
;; Load the theme of your choice.
(load-theme 'modus-vivendi t)
;; (load-theme 'ef-trio-dark t)

;; Abbreviation
;; (abbrev-table-put typescript-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
;; (abbrev-table-put web-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
;; (add-hook 'prog-mode-hook 'abbrev-mode)
;; (abbrev-table-put global-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")

;; (abbrev-table-put global-abbrev-table :case-fixed t)
;; (dolist (table abbrev-table-name-list)
;;     (abbrev-table-put (symbol-value table) :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)"))
;; (dolist (table abbrev-table-name-list)
;;   (abbrev-table-put (symbol-value table) :case-fixed t))
;; (setq-default abbrev-mode t)

;; ──────────────────────────── Org Mode ──────────────────────────── ;;
;; Load org-faces to make sure we can set appropriate faces
(require 'org-faces)

;; Hide emphasis markers on formatted text
(setq org-hide-emphasis-markers t)

;; Resize Org headings
(dolist (face '((org-level-1 . 1.4)
                (org-level-2 . 1.2)
                (org-level-3 . 1.1)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Aporetic Serif" :weight 'medium :height (cdr face)))

;; Make the document title a bit bigger
(set-face-attribute 'org-document-title nil :font "Aporetic Serif" :weight 'bold :height 3.0)

;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;; ───────────────────────────── Basic Packages ───────────────────────────── ;;
;; Substitute
(use-package substitute
  :config
  (define-key global-map (kbd "C-c s") #'substitute-prefix-map))

;; Diminish
(use-package diminish
  :init
  (diminish 'which-key-mode)
  (diminish 'projectile-mode)
  (diminish 'eldoc-mode)
  (diminish 'subword-mode)
  (diminish 'helm-mode)
  (diminish 'yas-minor-mode)
  (diminish 'hungry-delete-mode)
  )
;; Rg
(use-package rg)

;; ;; Beacon
;; (use-package beacon
;;   :init
;;   (beacon-mode 1))

(use-package pulsar
  :config
  (setq pulsar-pulse-functions
        ;; NOTE 2022-04-09: The commented out functions are from before
        ;; the introduction of `pulsar-pulse-on-window-change'.  Try that
        ;; instead.
        '(recenter-top-bottom
          move-to-window-line-top-bottom
          reposition-window
          beginning-of-buffer
          end-of-buffer
          ;; bookmark-jump
          other-window
          ;; delete-window
          ;; delete-other-windows
          forward-page
          backward-page
          scroll-up-command
          scroll-down-command
          ;; windmove-right
          ;; windmove-left
          ;; windmove-up
          ;; windmove-down
          ;; windmove-swap-states-right
          ;; windmove-swap-states-left
          ;; windmove-swap-states-up
          ;; windmove-swap-states-down
          ;; tab-new
          ;; tab-close
          ;; tab-next
          org-next-visible-heading
          org-previous-visible-heading
          org-forward-heading-same-level
          org-backward-heading-same-level
          outline-backward-same-level
          outline-forward-same-level
          outline-next-visible-heading
          outline-previous-visible-heading
          outline-up-heading))

  (setq pulsar-pulse-on-window-change t)
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.055)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'pulsar-green)
  (setq pulsar-highlight-face 'pulsar-yellow)
  :init
  (pulsar-global-mode 1))

;; Hungry delete
(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

;; mood modeline
(use-package mood-line
  :config
  (mood-line-mode)
  (setq mood-line-glyph-alist mood-line-glyphs-fira-code))

(use-package embrace)
(use-package expand-region)
(use-package all-the-icons)
(use-package transient)

;; Treemacs
(use-package treemacs
  :bind
  (:map global-map ("C-c \\" . treemacs))
  :config
  (setq treemacs-project-follow-mode t)
  ;; (treemacs-load-all-the-icons-with-workaround-font "Victor Mono")
  )

(use-package treemacs-projectile
  :after (treemacs projectile))

;; Ligatures
(use-package ligature
  :config
  (ligature-set-ligatures '(web-mode)
                          '("<!--" "-->" "</>" "</" "/>" "!==" "===" "=>" ">=" "<="))
  (ligature-set-ligatures '(typescript-mode) '("!==" "===" "=>" ">=" "<="))
  (global-ligature-mode t))

;; (use-package treemacs-all-the-icons
;;   :init
;;   (treemacs-load-theme "all-the-icons"))

;; Dired
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; Denote
(use-package denote
  :config
  (setq denote-directory (expand-file-name "/mnt/projects/Notes"))
  :bind ("C-c n" . denote-open-or-create))

;; Rainbow braces
(use-package rainbow-mode
  :bind ("M-p" . rainbow-mode))

(use-package rainbow-delimiters
  :init (rainbow-delimiters-mode 1)
  :hook (prog-mode . rainbow-delimiters-mode))

;; Projectile
(use-package projectile
  :init
  (projectile-mode 1)
  :config
  (setq projectile-indexing-method 'hybrid)
  (setq projectile-sort-order 'access-time)
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map))

;; Dashboard
(use-package dashboard
  :load-path "~/.emacs.d/manual-packages/dashboard"
  :config
  (dashboard-setup-startup-hook)
  ;; (setq dashboard-startup-banner 'logo)
  ;; (setq dashboard-startup-banner "/home/vortex/.emacs.d/logos/black_hole.png")
  (setq dashboard-startup-banner "/home/vortex/.emacs.d/logos/kawaii-sm.png")
  ;; (setq dashboard-startup-banner "/home/vortex/.emacs.d/logos/xemacs.png")
  ;; (setq dashboard-startup-banner "/home/vortex/.emacs.d/logos/butterfly-sm.png")
  ;; (setq dashboard-startup-banner "/home/vortex/.emacs.d/logos/orig_gnu.png")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents . 4)
                          (projects . 9)))
  :init
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))

;; Goto last change
(use-package goto-chg)

;; Avy
(use-package avy
  :config
  (setq avy-keys '(?c ?i ?e ?a ?, ?. ?h ?t ?s))
  (setq avy-background t))

;; Swiper
(use-package swiper
  :bind ("M-s" . swiper))

;; Which-key
(use-package which-key
  :init
  (which-key-mode))

;; Multiple-cursors
(use-package multiple-cursors
  :bind ("C-;" . 'mc/mark-next-like-this))

;; Origami
(use-package origami
  :config (global-origami-mode 1)
  :bind ("C-c v" . origami-toggle-node))

;; ─────────────────── Vertico + Consult + Company Setup ─────────────────── ;;
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  :config
  (setq completion-styles '(basic substring partial-completion flex))
  (setq read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        completion-ignore-case t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
;; (use-package savehist
;;   :init
;;   (savehist-mode))

(use-package consult
  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   ;; consult--source-bookmark consult--source-file-register
   ;; consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root)))
  :bind
  ("C-x C-b" . 'consult-buffer)
  ;; ("M-s" . 'consult-line)
  )

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package company
  :init
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  :config
  (global-company-mode t)
  :bind
  ("C-<tab>" . dabbrev-expand)
  :diminish company-mode)

;; ───────────────────────────── Language Modes ───────────────────────────── ;;
(use-package lua-mode)
;; (use-package crystal-mode)

(use-package eldoc)

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci"))
                  ("Ruby" "/home/vortex/.local/share/gem/ruby/3.4.0/bin/rufo"))))

(defun insert-rescript-pipe ()
  (interactive)
  (insert "->"))

(use-package eglot)

(defun setup-rescript-mode ()
  (format-all-ensure-formatter)
  (diminish 'rescript-mode)
  (diminish 'eglot-mode)
  (define-key rescript-mode-map (kbd "C-'") 'insert-rescript-pipe)
  (abbrev-table-put rescript-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
  (abbrev-mode)
  (electric-indent-local-mode -1)
  (company-mode +1))

(use-package rescript-mode
  :hook ((rescript-mode . setup-rescript-mode))
  :config
  (add-to-list 'eglot-server-programs
               '(rescript-mode . ("rescript-language-server" "--stdio"))))

;; Elm
;; (use-package elm-mode
;;   :config
;;   (setq elm-mode-hook '(elm-indent-simple-mode))
;;   (add-hook 'elm-mode-hook 'elm-format-on-save-mode))

;; Rust
(use-package rust-mode
  :init
  (setq rust-format-on-save t))

;; ;; Ocaml
;; (use-package caml
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.ml[iylp]?$" . caml-mode))
;;   (autoload 'caml-mode "caml" "Major mode for editing OCaml code." t)
;;   (autoload 'run-caml "inf-caml" "Run an inferior OCaml process." t)
;;   (autoload 'camldebug "camldebug" "Run ocamldebug on program." t)
;;   (add-to-list 'interpreter-mode-alist '("ocamlrun" . caml-mode))
;;   (add-to-list 'interpreter-mode-alist '("ocaml" . caml-mode))
;;   (if window-system (require 'caml-font))
;;   )

;; Haskell
;; (use-package haskell-mode)

;; Fish shell
(use-package fish-mode)

;; Org
(setq org-src-preserve-indentation t)

;; Org Bullets
(use-package org-bullets
  :hook
  (org-mode . org-bullets-mode))

;; ;; python
;; (use-package py-autopep8
;;   :hook (python-mode . py-autopep8-enable-on-save))

;; Helm
;; (use-package helm
;;   :bind
;;   ("C-x C-b" . 'helm-buffers-list)
;;   ;; ("C-c f" . 'helm-find-files)  
;;   :config
;;   (add-to-list 'display-buffer-alist
;;                '("*Help*" display-buffer-same-window))
;;   (helm-mode 1))

;;  R lang
(use-package ess
  :ensure t)
;; ───────────────────────────── Snippet setup ───────────────────────────── ;;
;; yasnippets
(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

;; auto-yasnippets
(use-package auto-yasnippet
  :bind
  ("C-c C-y w" . #'aya-create)
  ("C-c C-y TAB" . #'aya-expand)
  ("C-c C-y SPC" . #'aya-expand-from-history)
  ("C-c C-y d" . #'aya-delete-from-history)
  ("C-c C-y c" . #'aya-clear-history)
  ("C-c C-y n" . #'aya-next-in-history)
  ("C-c C-y p" . #'aya-previous-in-history)
  ("C-c C-y s" . #'aya-persist-snippet)
  ("C-c C-y o" . #'aya-open-line))

;; ──────────────────────────── Web development ──────────────────────────── ;;
;; emmet
(use-package emmet-mode
  ;; :load-path "~/.emacs.d/manual-packages/emmet-mode"
  :config
  (emmet-mode 1)
  :bind ("C-j" . emmet-expand-line))

;; Svelte
(use-package svelte-mode)
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))
(setq web-mode-engines-alist
      '(("svelte" . "\\.svelte\\'")))

;; Add jsx tag when pressing `<` in jsx/tsx modes
(defun tsx-electric-lt (n)
  (interactive "p")
  (if (/= n 1)
      (insert (make-string n ?<))
    (if (save-excursion
          (forward-comment most-negative-fixnum)
          (skip-chars-backward "\n\r")
          (or (= (point) (point-min))
              (memq (char-before) (append "=(?:>}&|{," nil))
              (let ((start (- (point) 6)))
                (and (>= start (point-min))
                     (string= (buffer-substring start (point)) "return")))))
        (progn (insert "</>")
               (backward-char 2))
      (insert "<"))))

;; (defun tsx-comment-region (func)
;;   (unless (use-region-p)
;;     (error "need an active region"))
;; (let ((res (funcall func (buffer-substring (mark) (point)))))
;;   (delete-region (region-beginning) (region-end))     (insert res)))

;; (defun tsx-comment (text)
;;   (concat "{/*" text "*/}")
;;   )

;; Tide (typescript ide)
(use-package tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (diminish 'tide-mode)
  (define-key tide-mode-map (kbd "M-,") 'tide-references)
  (company-mode +1))

;; Lsp , tree sitter, tsx
;; (use-package lsp-mode
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   ;; (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          ;; if you want which-key integration
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :config
;;   (setq lsp-headerline-breadcrumb-enable nil)
;;   :commands lsp)

;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :config
;;   (lsp-enable-which-key-integration t)
;;   (setq lsp-headerline-breadcrumb-enable nil))

;; (use-package lsp-ui)

;; (use-package tree-sitter
;;   :diminish tree-sitter-mode
;;   :config
;;   ;; activate tree-sitter on any buffer containing code for which it has a parser available
;;   (global-tree-sitter-mode)
;;   ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
;;   ;; by switching on and off
;;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; (use-package tree-sitter-langs
;;   :after tree-sitter)

(use-package typescript-mode
  ;; :after tree-sitter
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :hook ((typescript-mode . setup-tide-mode)
         ;; (typescript-mode . biome-js-format-mode)
         ;; (typescript-mode . lsp-mode)
         )
  :init
  (add-hook 'typescript-mode-hook
            (lambda ()
              (abbrev-table-put typescript-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
              (abbrev-mode)
              )))


;; (use-package typescript-mode
;;   ;; :after tree-sitter
;;   :hook ((typescript-mode . prettier-js-mode)
;;          (typescript-mode . setup-tide-mode))
;;   :config
;;   ;; we choose this instead of tsx-mode so that eglot can automatically figure out language for server
;;   ;; see https://github.com/joaotavora/eglot/issues/624 and https://github.com/joaotavora/eglot#handling-quirky-servers
;;   (define-derived-mode typescriptreact-mode typescript-mode
;;     "TypeScript TSX")

;;   ;; use our derived mode for tsx files
;;   (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
;;   ;; by default, typescript-mode is mapped to the treesitter typescript parser
;;   ;; use our derived mode to map both .tsx AND .ts -> typescriptreact-mode -> treesitter tsx
;;   (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx))
;;   (add-to-list 'tree-sitter-major-mode-language-alist '(web-mode . tsx))
;;     :init
;; (add-hook 'typescriptreact-mode-hook (lambda ()
;;                                        (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;                                          (web-mode +1)
;;                                          ;; (setq-local comment-use-syntax nil)
;;                                          ;; (setq-local comment-start-skip "[[:space:]]*\\(//+\\|{?/\\*+\\)")
;;                                          ;; (setq-local comment-end-skip "\\(\\*+/}?[[:space:]]*\\)\n?\\|\n")
;;                                          ;; (setq-local comment-start "{/\*")
;;                                          ;; (setq-local comment-end   "\*/}")
;;                                          (define-key typescript-mode-map "<" 'tsx-electric-lt))))
;;     )

;; ;; Web mode
(use-package web-mode
  ;; :hook (web-mode . prettier-js-mode)
  :mode (("\\.html?\\'" . web-mode)
         ("\\.tsx\\'" . web-mode))
  :init
  (add-hook 'web-mode-hook (lambda ()
                             (when (string-equal "tsx" (file-name-extension buffer-file-name))
                               (setup-tide-mode)
                               (abbrev-table-put web-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
                               (abbrev-mode)
                               ;; (lsp-mode)
                               ;; (biome-js-format-mode)
                               (define-key web-mode-map "<" 'tsx-electric-lt))))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2
        web-mode-enable-auto-closing t 
        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
    	web-mode-enable-auto-indentation nil
    	web-mode-enable-auto-quoting nil
        web-mode-content-types-alist
        '(("jsx" . "\\.tsx\\'")))
  ;; enable typescript-tslint checker
  ;; (flycheck-add-mode 'typescript-tslint 'web-mode)  
  )


;; rjsx
(use-package rjsx-mode
  :init
  (setq create-lockfiles nil)
  :diminish rjsx-mode
  :mode "\\.jsx\\'")

;; prettier-js
(use-package prettier-js
  :hook ((rjsx-mode . prettier-js-mode)
	     (js-mode . prettier-js-mode)
	     (tide-mode . prettier-js-mode)
	     (scss-mode . prettier-js-mode)
	     (css-mode . prettier-js-mode)
	     (web-mode . prettier-js-mode)
	     (svelte-mode . prettier-js-mode)
         ;; (typescript-mode . prettier-js-mode)
         )
  :config
  (setq prettier-js-args '(
  "--trailing-comma" "es5"
));; (add-hook 'rjsx-mode-hook (lambda()
  ;;                             (flycheck-add-mode 'javascript-eslint 'rjsx-mode)))
  :diminish prettier-js-mode)

;; Auto-start on any markup modes
(add-hook 'sgml-mode-hook 'emmet-mode)

;; enable Emmet's css abbreviation.
(add-hook 'css-mode-hook  'emmet-mode)

;; ──────────────────────────── Custom Functions ──────────────────────────── ;;
(defun copy-whole-buffer-to-clipboard ()
  "Copy the entire buffer to the system clipboard."
  (interactive)
  (let ((current-buffer (current-buffer)))
    (save-excursion
      (goto-char (point-min))
      (let ((text (buffer-string)))  ; Get the entire buffer content as a string
        (with-temp-buffer
          (insert text)
          (clipboard-kill-region (point-min) (point-max)))))  ; Copy to system clipboard
    (message "Whole buffer copied to system clipboard.")))

(defun copy-to-end-of-line ()
  "Copy text from the cursor to the end of the current line."
  (interactive)
  (let ((start (point))  ; Save the current cursor position
        (end (line-end-position)))  ; Get the end of the current line
    (clipboard-kill-ring-save start end)  ; Copy the region to the kill ring
    (message "Copied from cursor to end of line.")))

(defun switch-to-scratch-buffer ()
  (interactive)
  (switch-to-buffer "*scratch*"))

(defun package-upgrade-all ()
  "Upgrade all packages automatically without showing *Packages* buffer."
  (interactive)
  (package-refresh-contents)
  (let (upgrades)
    (cl-flet ((get-version (name where)
                (let ((pkg (cadr (assq name where))))
                  (when pkg
                    (package-desc-version pkg)))))
      (dolist (package (mapcar #'car package-alist))
        (let ((in-archive (get-version package package-archive-contents)))
          (when (and in-archive
                     (version-list-< (get-version package package-alist)
                                     in-archive))
            (push (cadr (assq package package-archive-contents))
                  upgrades)))))
    (if upgrades
        (when (yes-or-no-p
               (message "Upgrade %d package%s (%s)? "
                        (length upgrades)
                        (if (= (length upgrades) 1) "" "s")
                        (mapconcat #'package-desc-full-name upgrades ", ")))
          (save-window-excursion
            (dolist (package-desc upgrades)
              (let ((old-package (cadr (assq (package-desc-name package-desc)
                                             package-alist))))
                (package-install package-desc)
                (package-delete  old-package)))))
      (message "All packages are up to date"))))

(defun capitalize-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string nil 1))
          (rest-str   (substring string 1)))
      (concat (capitalize first-char) rest-str))))

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-c d") 'kill-current-buffer)

;; move-region-up-down
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(defun split-right-and-move ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun split-below-and-move ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun replace-char ()
  (interactive)
  (let ((mychar (read-char "replace with:")))
    (if (= ?\C-\[ mychar)
        (message "Cancelled replace")
      (delete-char 1)
      (insert mychar))))

(defun replace-char-or-meow-replace ()
  (interactive)
  (if (use-region-p)
      (meow-replace)
    (replace-char)))

(defun meow-yank-with-char (char &optional both-sides?)
  (insert char)
  (meow-yank)
  (if both-sides?
      (insert char)))

(defun yank-with-space ()
  (interactive)
  (meow-yank-with-char " "))
(defun yank-with-space2 ()
  (interactive)
  (meow-yank-with-char " " t))
(defun yank-with-dot ()
  (interactive)
  (meow-yank-with-char "."))
(defun yank-with-end-comma ()
  (interactive)
  (meow-yank)
  (insert ","))


(defun surround-region (start-str end-str)
  "Surround the current region with START-STR and END-STR.
If no region is active, prompt for strings to use."
  (interactive 
   (if (use-region-p)
       (list 
        (read-string "Start string: " nil nil "")
        (read-string "End string: " nil nil ""))
     (list 
      (read-string "Start string: ")
      (read-string "End string: "))))
  
  (let ((start (region-beginning))
        (end (region-end)))
    (save-excursion
      (goto-char end)
      (insert end-str)
      (goto-char start)
      (insert start-str))))
    
(defun surround-with (char-start char-end)
    (interactive)
  (if (use-region-p)
      (let ((regionp (buffer-substring (region-beginning) (region-end))))
        (kill-region (region-beginning) (region-end))
        (insert (concat char-start regionp char-end)))))

(defun rescript-react-string ()
  (interactive)
    (surround-with "{\"" "\"->React.string}"))

(defun surround-with-curly ()
  (interactive)
    (surround-with "{" "}"))
(defun surround-with-round ()
  (interactive)
    (surround-with "(" ")"))
(defun surround-with-square ()
  (interactive)
    (surround-with "[" "]"))
(defun surround-with-angle ()
  (interactive)
    (surround-with "<" ">"))
(defun surround-with-quotes ()
  (interactive)
    (surround-with "\"" "\""))
(defun surround-with-single-quotes ()
  (interactive)
    (surround-with "'" "'"))
(defun surround-with-backtick ()
  (interactive)
    (surround-with "`" "`"))
(defun surround-with-rescript-string ()
  (interactive)
    (surround-with "String(" ")"))
(defun surround-with-rescript-number ()
  (interactive)
    (surround-with "Number(" ".)"))
(defun surround-with-rescript-private ()
  (interactive)
    (surround-with "%%private(\n" "\n)"))
(defun surround-with-rescript-array ()
  (interactive)
    (surround-with "array<" ">"))
(defun surround-with-rescript-option ()
  (interactive)
    (surround-with "option<" ">"))

(defun projectile-find-file-in-current-directory ()
  (interactive)
  (projectile-find-file-in-directory (file-name-directory buffer-file-name)))

(defun divide-comment (start end len)
  (let ((content (s-trim (thing-at-point 'line t))))
    (let ((sep (concat " " (make-string (/ (- len (length content)) 2) 9472) " ")))
      (kill-whole-line)
      (insert (concat start sep content sep end))
      (newline))))

(defun surround-with-array ()
  (interactive)
  (surround-with "Array<" ">"))

(defun surround-with-maybe ()
  (interactive)
  (surround-with "Maybe<" ">"))

(defun sort-imports-of-buffer ()
  (interactive)
  (shell-command-on-region (point-min) (point-max) "/mnt/projects/Perl/muy-importante/main.pl" nil t))

(defun ts-enum-to-res-type ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "/mnt/projects/Perl/react/ts_enum_to_res_type.pl" nil t))

(defun union-to-res-type ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "/mnt/projects/Perl/react/union_to_res_type.pl" nil t))

(defun rescript-use-state ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "/mnt/projects/Perl/react/use_state.pl" nil t))

(defun rescript-to-icon ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "/mnt/projects/Perl/react/to_res_icon.pl" nil t))

(defun ts-toggle-env ()
  (interactive)
  (shell-command-on-region (point-min) (point-max) "/mnt/projects/Perl/react/toggle_env.pl" nil t))

(defun perl-on-region ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "/mnt/projects/Perl/react/fix_api_fn.pl" nil t))

(defun ts-divide-comment ()
  (interactive)
  (divide-comment "/*" "*/" 66))

(defun elisp-divide-comment ()
  (interactive)
  (divide-comment ";;" ";;" 72))

;; (defun wrap-in-hooks (beg end hook)
;;   (interactive "r")
;;   (save-excursion
;;     (narrow-to-region beg end)
;;     (set-mark nil)
;;     (goto-char (point-min))
;;     (insert "use" hook "(\n\t() => ")
;;     (goto-char (point-max))
;;     (insert ",\n\t[]\n)")
;;     (widen)))

;; ────────────────────────────── Saved Macros ────────────────────────────── ;;
(defalias 'export-js
  (kmacro "C-a i e x p o r t SPC <escape>"))

(defalias 'end-delete
  (kmacro "C-e C-d"))

(defalias 'text-children
  (kmacro "j m g C-SPC C-e s k x h a SPC c h i l d r e n = \" <escape> p l a SPC / <escape> j x x s k x g"))

(defalias 'remove-useless-braces
  (kmacro "C-s { \" <return> <left> <backspace> C-s \" } <return> <backspace>"))

(defalias 'snake-upcase
  (kmacro ", g SPC y SPC <return> _ <return> ! , g C-x C-u"))

(defalias 'remove-curly-braces
  (kmacro "C-s { <return> h < d {"))

(defalias 'embrace-quote-to-backtick
  (kmacro "SPC ; c \" `"))

(defalias 'select-block
   (kmacro "o C-e q C-a"))

;; ───────────────────────────────── Hydra ───────────────────────────────── ;;
(use-package hydra
  :config
  (defhydra hydra-zoom (global-map "<f2>")
    "zoom"
    ("j" text-scale-increase "in")
    ("k" text-scale-decrease "out"))

  (defhydra hydra-bookmarked-files (:color blue)
    "Bookmarked files"
    ("a" (ido-find-file-in-dir (expand-file-name "~/.config/awesome")) "Awesome")
    ("c" (ido-find-file-in-dir (expand-file-name "~/.config")) "Config")
    ("e" (find-file (expand-file-name "~/.emacs.d/init.el")) "Emacs")
    ("g" (ido-find-file-in-dir "/mnt/projects/Git") "Git")
    ("h" (ido-find-file-in-dir "/mnt/projects/Haskell") "Haskell")
    ("l" (ido-find-file-in-dir "/mnt/projects/Perl") "Perl")
    ("m" (ido-find-file-in-dir (expand-file-name "~/.config/myshell")) "Myshell")
    ("p" (ido-find-file-in-dir "/mnt/projects") "Projects")
    ("r" (ido-find-file-in-dir "/mnt/projects/Rust") "Rust")
    ("R" (ido-find-file-in-dir "/mnt/projects/React") "React")
    ("s" (ido-find-file-in-dir "/mnt/projects/Rescript") "Rescript")
    ("S" (ido-find-file-in-dir "/mnt/projects/Svelte") "Svelte")
    ("t" (ido-find-file-in-dir "/mnt/projects/Typescript") "Typescript")
    ("y" (ido-find-file-in-dir "/mnt/projects/Python") "Python"))
  (global-set-key (kbd "C-c q") 'hydra-bookmarked-files/body)

  (defhydra hydra-utils (:color blue)
    "general helpers"
    ("b" ibuffer "ibuffer")
    ("c" copy-to-end-of-line "Copy-To-End-Of-Line")
    ("d" dashboard-refresh-buffer "Dashboard")
    ("f" consult-focus-lines "Consult-Focus-Lines")
    ("i" insert-register "Insert-Register")
    ("l" duplicate-line "Duplicate line")
    ("t" switch-to-scratch-buffer "Switch to scratch")
    ("s" ef-themes-select "Ef-Themes-Select")
    ("w" copy-whole-buffer-to-clipboard "Copy-Whole-Buffer-To-Clipboard"))
  (global-set-key (kbd "C-c u") 'hydra-utils/body)
  
  (defhydra hydra-ts-react (:color blue)
    "TS/React helpers"
    ("a" surround-with-array "surround-with-array")
    ("b" remove-curly-braces "Remove-Curly-Braces")
    ("c" ts-divide-comment "[ts] Divide comment")
    ("l" perl-on-region "Perl-On-Region")
    ("i" sort-imports-of-buffer "Sort Imports")
    ("m" surround-with-maybe "surround-with-maybe")
    ("r" remove-useless-braces "Remove-Useless-Braces")
    ("s" select-block "Select-Block"))
  (global-set-key (kbd "C-c t") 'hydra-ts-react/body)

  (defhydra hydra-avy (:color blue)
    "Avy copy/move"
    ("l" avy-copy-line "Copy line")
    ("r" avy-copy-region "Copy region")
    ("m" avy-move-line "Move line")
    ("w" avy-move-region "Move region"))
  (global-set-key (kbd "C-c a") 'hydra-avy/body)

  ;;   (defhydra hydra-surround (:color blue)
  ;;   "Embrace add stuff"
  ;;   ("a" surround-with-angle "add < >")
  ;;   ("b" surround-with-backtick "quote to backtick")
  ;;   ("t" embrace-quote-to-backtick "quote to backtick")
  ;;   ("c" surround-with-curly "add { }")
  ;;   ("v" surround-with-quotes "add \"")
  ;;   ("'" surround-with-single-quotes "add \"")
  ;;   ("r" surround-with-round "add ( )")
  ;;   ("s" surround-with-square "add [ ]"))
  ;; (global-set-key (kbd "C-c v") 'hydra-surround/body)

  (defhydra hydra-yank (:color blue)
    "yank with"
    ("p" yank-with-space "Yank-With-Space")
    ("d" yank-with-space2 "Yank-With-Space2")
    ("." yank-with-dot "Yank-With-Dot")
    ("," yank-with-end-comma "Yank-With-End-Comma"))
  (global-set-key (kbd "C-c p") 'hydra-yank/body)

  (defhydra hydra-rescript (:color blue)
    "Rescript utils"
    ("a" surround-with-rescript-array "Array")
    ("b" rescript-use-state "Rescript-Use-State")
    ("c" text-children "Text-Children")
    ("e" ts-enum-to-res-type "TS enum to Res type")
    ("i" rescript-to-icon "Rescript-To-Icon")
    ("n" surround-with-rescript-number "Number")
    ("o" surround-with-rescript-option "Option")
    ("p" surround-with-rescript-private "private")
    ("r" rescript-react-string "rescript-react-string")
    ("s" surround-with-rescript-string "String")
    ("u" union-to-res-type "union to Res type"))
  (global-set-key (kbd "C-c r") 'hydra-rescript/body))

;; (defhydra hydra-embrace (:color blue)
;;   "Embrace"
;;   ("a" embrace-add "Add")
;;   ("c" embrace-change "Change")
;;   ("d" embrace-delete "Delete"))
;; (global-set-key (kbd "C-c l") 'hydra-embrace/body)

;; ──────────────────────────── Custom shortcuts ──────────────────────────── ;;
(global-set-key (kbd "C-,") 'move-text-up)
(global-set-key (kbd "C-.") 'move-text-down)

(global-set-key (kbd "C-c b") 'beginning-of-buffer)
(global-set-key (kbd "C-c e") 'end-of-buffer)
(global-set-key (kbd "C-c /") 'comment-line)
;; (global-set-key (kbd "C-c p") 'point-to-register)
;; (global-set-key (kbd "C-c v") 'jump-to-register)
(global-set-key (kbd "C-c '") 'projectile-find-file)
(global-set-key (kbd "C-c i") 'projectile-find-file-in-current-directory)
(global-set-key (kbd "C-c l") 'consult-ripgrep)
(global-set-key (kbd "C-c ;") 'embrace-commander)
(global-set-key (kbd "C-c =") 'ffap)
;; kill region (cut)
(global-set-key (kbd "M-k") 'kill-region)

(global-set-key (kbd "C-c ,") 'split-below-and-move)
(global-set-key (kbd "C-c .") 'split-right-and-move)
(global-set-key (kbd "C-c o") 'other-window)

;; save-buffer
;; (global-set-key (kbd "C-c t") 'save-buffer)
(global-set-key (kbd "C-c y") 'query-replace)
;; org-mode-src
;; (global-set-key (kbd "C-c s r") (kbd "C-c C-, s"))

;; yas-expand
(global-set-key (kbd "C-o") 'yas-expand)

;; ─────────────────────────────── Meow mode ─────────────────────────────── ;;
(defun meow-setup ()
  (setq meow-keypad-self-insert-undefined t)
  ;; (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   '("\"" . surround-with-quotes)
   ;; '("'" . surround-with-single-quotes)
   '("`" . surround-with-backtick)
   '("[" . surround-with-square)
   '("{" . surround-with-curly)
   '("(" . surround-with-round)
   '("z" . embrace-quote-to-backtick)   
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . save-buffer)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-reverse)
   '("Q" . meow-goto-line)
   '("r" . replace-char-or-meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("T" . avy-goto-char)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   ;; '("v" . meow-visit)
   ;; '("v" . goto-char-2-right)
   '("v" . avy-goto-word-0)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("'" . goto-last-change)
   '("z" . er/expand-region)
   ;; '("`" . goto-char-2-right)
   ;; my shortcuts
   '("\\" . comment-line)
   '("/" . "M-s")
   '("=" . end-delete)
   '("<" . embrace-commander)
   ;; my shortcuts ends
   '("<escape>" . mode-line-other-buffer))
  (meow-thing-register 'angle '(regexp "<" ">") '(regexp "<" ">"))
  (meow-thing-register 'tag '(regexp ">" "<") '(regexp ">" "<"))
  (add-to-list 'meow-char-thing-table '(?t . tag))
  (add-to-list 'meow-char-thing-table '(?a . angle)))

;; (use-package meow
;;   :config
;;   (meow-setup)
;;   (meow-global-mode 1))

;; Live down
;; (custom-set-variables
;;  '(livedown-autostart nil) ; automatically open preview when opening markdown files
;;  '(livedown-open t)        ; automatically open the browser window
;;  '(livedown-port 1337)     ; port for livedown server
;;  '(livedown-browser nil))  ; browser to use

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))
;; (require 'livedown)

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/highlight-indent-guides-master"))
;; (require 'highlight-indent-guides)
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/tsi.el-main"))
;; (require 'tsi-typescript)
;; (tsi-typescript-mode t)


;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/tsx-mode.el-master"))
;; (require 'tsx-mode)
;; (tsx-mode t)
;; init.el

;; for terminals
;; (set-face-background 'default "undefined")
