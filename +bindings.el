;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

;; https://noelwelsh.com/posts/2019-01-10-doom-emacs.html
;; -----------------------------------------------------------------------------
;; You can also find out what's bound to a key sequence with
;; SPC h k <keysequence> or C-h k <keysequence>.
;; https://github.com/hlissner/doom-emacs/issues/1801
;; https://github.com/hlissner/doom-emacs/blob/develop/modules/config/default/+evil-bindings.el
;;
(map! :after dired ; binds these after the dired package has loaded
  (:map dired-mode-map :desc "Dired Hydra" :n "." #'hydra-dired/body)
  (:map dired-mode-map :n "l" #'dired-find-file)
  (:map dired-mode-map :n "h" #'dired-up-directory))

(map!
 (:map dired-mode-map
   :desc "Dired Hydra" :localleader "h" #'hydra-dired/body))

(map!
 (:map pdf-view-mode-map :desc "PDF Tools Hydra"
     :localleader "h" #'hydra-pdftools/body))

(map! :leader (:prefix ("w" . "window") "~" #'resize-window-hydra/body))
(map! :leader (:prefix ("m" . "localleader") "w" #'hydra-window/body))
(map! :desc "Avy Hydra"
      :leader (:prefix ("m" . "localleader") "y" #'my/hydra-avy/body))

(map!
 (:map pdf-view-mode-map :localleader
   (:prefix ("a" . "annotation")
        "l" #'pdf-annot-list-annotations
        "d" #'pdf-annot-delete
        "a" #'pdf-annot-attachment-dired
        "m" #'pdf-annot-add-markup-annotation
        "t" #'pdf-annot-add-text-annotation
        "h" #'pdf-annot-add-highlight-markup-annotation
        "o" #'pdf-annot-add-strikeout-markup-annotation
        "s" #'pdf-annot-add-squiggly-markup-annotation
        "u" #'pdf-annot-add-underline-markup-annotation)
   (:prefix ("f" . "fit")
        "w" #'pdf-view-fit-width-to-window
        "p" #'pdf-view-fit-page-to-window)
   "n" #'pdf-view-midnight-minor-mode
   "s" #'pdf-view-set-slice-using-mouse
   "b" #'pdf-view-set-slice-from-bounding-box
   "r" #'pdf-view-reset-slice))
;; -----------------------------------------------------------------------------
;; (map!
;;  (:map sml-mode-map
;;    :desc "SML Mode" :localleader "'"  #'run-sml
;;    :prefix ("s" . "sml") (
;;    :desc "Run buffer"                  "b" #'sml-prog-proc-send-buffer
;;    :desc "Run buffer and Focus"        "B" #'my/sml-prog-proc-send-buffer-and-focus
;;    :desc "Run the paragraph"           "f" #'sml-send-function
;;    :desc "Run the paragraph and focus" "F" #'my/sml-send-function-and-focus
;;    :desc "Run sml"                     "i" #'run-sml
;;    :desc "Run region"                  "r" #'sml-prog-proc-send-region
;;    :desc "Run region and focus"        "R" #'my/sml-prog-proc-send-region-and-focus
;;    :desc "Run buffer"                  "s" #'run-sml)))
;; -----------------------------------------------------------------------------
(defun +my-treemacs-sidebar ()
  "Hacky; Found myself selecting window after changing project and needing to
  close and reopen for treemacs to update to the next project's directory"
  (interactive)
  (treemacs-select-window)
  (+treemacs/toggle)
  (+treemacs/toggle))
;; -----------------------------------------------------------------------------
(map!
 (:leader
    (:prefix "o"
      :desc "Undo tree visualize" :n "u"      #'undo-tree-visualize)
    (:prefix ("b" . "buffer")
      :desc "ibuffer (other window)" "I"      #'ibuffer-other-window)
    (:when (featurep! :ui treemacs)
      :desc "Project sidebar"        "0"      #'+my-treemacs-sidebar)
    (:when (featurep! :ui tabs)
      :prefix "TAB"
      :desc "Group tabs by project"  "t"      #'centaur-tabs-group-by-projectile-project)
    (:when (featurep! :ui tabs)
      :prefix ("b" . "buffer")
      :desc "Group tabs by buffer"   "t"      #'centaur-tabs-group-buffer-groups)
 )
)

