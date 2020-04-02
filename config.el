;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ferhat Erata"
      user-mail-address "ferhat.erata@yale.edu")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Source Code Pro" :size 28))
;;(setq doom-font (font-spec :family "SF Mono" :size 26))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-tomorrow-night)
;; default is doom-atom
(setq doom-themes-treemacs-theme "doom-colors") ;use the colorful treemacs theme

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(after! centaur-tabs
  (setq centaur-tabs-height 60
        centaur-tabs-set-bar 'under
        x-underline-at-descent-line t)
  (centaur-tabs-mode t)
)

(setq fancy-splash-image "~/.doom.d/banners/default.svg")
;(setq +doom-dashboard-banner-padding '(4 . 10))

;;(after! doom-modeline
;;  (setq doom-modeline-major-mode-color-icon t))

(setq expand-region-contract-fast-key "C-v")
(use-package! expand-region
  :commands (er/contract-region er/mark-symbol er/mark-word)
  :init
  (map! :nv "C-v" #'er/contract-region
        :nv "SPC v" #'er/expand-region
        :v  "v"  (general-predicate-dispatch 'er/expand-region
                 (eq (evil-visual-type) 'line)
                 'evil-visual-char)
        )

  :config
  (defadvice! doom--quit-expand-region-a ()
    "Properly abort an expand-region."
    :before '(evil-escape doom/escape)
    (when (memq last-command '(er/expand-region er/contract-region))
      (er/contract-region 0)))
  )

(map! "C-s" #'save-buffer)
(map! "C-q" (lambda! () (interactive) (kill-this-buffer))) ;; Kill buffer

(map! :n [C-tab] (lambda () (interactive) (centaur-tabs-forward)))
(global-set-key
 (if (featurep 'xemacs) (kbd "<C-iso-left-tab>") (kbd "<C-S-iso-lefttab>"))
    'centaur-tabs-backward)

;; -----------------------------------------------------------------------------
;; doom-modeline
(after! doom-modeline
  (display-battery-mode +1)
  (setq display-time-24hr-format t)
  (setq display-time-default-load-average nil)
  (display-time-mode +1))

;; -----------------------------------------------------------------------------
;; Defaults
;; (setq-default delete-by-moving-to-trash t) ; Delete files to trash
;; (blink-cursor-mode t)
(delete-selection-mode 1) ; Replace selection when inserting text
(global-subword-mode 1)   ; Iterate through CamelCase words

;; -----------------------------------------------------------------------------
;; custom-mode
(use-package! alloy-mode)
(use-package! smtlib-mode)

;; -----------------------------------------------------------------------------
(setq +pretty-code-enabled-modes
      (if IS-LINUX '(emacs-lisp-mode haskell-mode python-mode) nil))
;; -----------------------------------------------------------------------------
;; company-mode
(after! company
  (setq company-show-numbers t)
  (add-to-list 'company-backends 'company-tabnine))

;; -----------------------------------------------------------------------------
;; https://github.com/hlissner/doom-emacs/issues/1269
;; -----------------------------------------------------------------------------
(set-company-backend! '(smtlib-mode alloy-mode)
  '(company-tabnine company-yasnippet company-dabbrev)
  'company-capf
  '(company-yasnippet company-dict))

;; -----------------------------------------------------------------------------
;; spelling
(set-company-backend! '(text-mode markdown-mode gfm-mode)
  '(:seperate company-ispell company-files company-yasnippet))

(setq company-ispell-dictionary (file-truename "~/Dropbox/KDE/english-words.txt"))

;;(setq company-box-doc-enable nil)
;; -----------------------------------------------------------------------------
(load! "+bindings")
;; -----------------------------------------------------------------------------
;; add to ~/.doom.d/config.el
(when-let (dims (doom-cache-get 'last-frame-size))
  (cl-destructuring-bind ((left . top) width height fullscreen) dims
    (setq initial-frame-alist
          (append initial-frame-alist
                  `((left . ,left)
                    (top . ,top)
                    (width . ,width)
                    (height . ,height)
                    (fullscreen . ,fullscreen))))))

(defun save-frame-dimensions ()
  (doom-cache-set 'last-frame-size
                  (list (frame-position)
                        (frame-width)
                        (frame-height)
                        (frame-parameter nil 'fullscreen))))

(add-hook 'kill-emacs-hook #'save-frame-dimensions)

;; -----------------------------------------------------------------------------
;; At one point, typing became noticably laggy, Profiling revealed flyspell-post
;; -command-hook was responsible for 47% of CPU cycles by itself! So I’m going
;; to make use of flyspell-lazy
;;(after! flyspell (require 'flyspell-lazy) (flyspell-lazy-mode 1))

;; -----------------------------------------------------------------------------
;; Proof General
;;(setq  pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
;; okular's defaults: light color: #600000 light color: #f0f0f0
(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode) ;; me
;; https://github.com/hlissner/doom-emacs/blob/develop/modules/lang/latex/README.org#changing-the-pdfs-viewer
(setq +latex-viewers '(pdf-tools))

;; https://www.fbxiang.com/blog/2017/11/01/write_papers_with_org_mode_and_spacemacs.html
(setq org-latex-pdf-process
  '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))

(use-package! org-ref
  :after org
  :init
  :config
)
;; -----------------------------------------------------------------------------
