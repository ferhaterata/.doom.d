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

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

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

(use-package! centaur-tabs
  :config
  (setq centaur-tabs-height 60
        centaur-tabs-set-bar 'under
        x-underline-at-descent-line t)
  (centaur-tabs-mode t)
)

;;(setq +doom-dashboard-banner-dir
;;      (concat doom-private-dir "banners/"))
;;(setq +doom-dashboard-banner-padding '(4 . 10))

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

;; ----------------------------------------------------------------------------------
;; doom-modeline
(after! doom-modeline
  (display-battery-mode +1)
  (setq display-time-24hr-format t)
  (setq display-time-default-load-average nil)
  (display-time-mode +1))

;; (blink-cursor-mode t)
;; ----------------------------------------------------------------------------------
;; custom-mode
(use-package! alloy-mode)
(use-package! smtlib-mode)

;; ----------------------------------------------------------------------------------
(setq +pretty-code-enabled-modes
      (if IS-LINUX '(emacs-lisp-mode haskell-mode python-mode) nil))

;; ----------------------------------------------------------------------------------
(after! company
  (add-to-list 'company-backends 'company-tabnine))

;; ----------------------------------------------------------------------------------
;; https://github.com/hlissner/doom-emacs/issues/1269
;; ----------------------------------------------------------------------------------
(set-company-backend! '(smtlib-mode alloy-mode)
  '(company-tabnine company-yasnippet company-dabbrev)
  'company-capf
  '(company-yasnippet company-dict))


;; ----------------------------------------------------------------------------------
(load! "+bindings")
;; ----------------------------------------------------------------------------------

(use-package! dired-sidebar
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  (map! :leader (:prefix ("o" . "open") "~" #'dired-sidebar-toggle-sidebar))
  ;;(add-hook 'dired-sidebar-mode-hook (lambda () (all-the-icons-dired-mode -1)))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

;; ----------------------------------------------------------------------------------
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
