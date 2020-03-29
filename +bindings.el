;;; ~/.doom.d/+bindings.el -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; You can also find out what's bound to a key sequence with
;; SPC h k <keysequence> or C-h k <keysequence>.
;; https://github.com/hlissner/doom-emacs/issues/1801
;; https://github.com/hlissner/doom-emacs/blob/develop/modules/config/default/+evil-bindings.el
;;
(map! :after dired ; binds these after the dired package has loaded
  (:map dired-mode-map :desc "Dired Hydra" :n "." #'hydra-dired/body))

(map!
 (:map dired-mode-map
   :desc "Dired Hydra" :localleader "h" #'hydra-dired/body))

(map!
 (:map pdf-view-mode-map :desc "PDF Tools Hydra"
     :localleader "h" #'hydra-pdftools/body))

(map! :leader (:prefix ("w" . "window") "~" #'resize-window-hydra/body))
(map! :leader (:prefix ("m" . "localleader") "w" #'hydra-window/body))
(map! :desc "Avy Hydra"
      :leader (:prefix ("m" . "localleader") "a" #'my/hydra-avy/body))

(map!
 (:map pdf-view-mode-map :localleader
   "a l" #'pdf-annot-list-annotations
   "a d" #'pdf-annot-delete
   "a a" #'pdf-annot-attachment-dired
   "a m" #'pdf-annot-add-markup-annotation
   "a t" #'pdf-annot-add-text-annotation
   "a h" #'pdf-annot-add-highlight-markup-annotation
   "a o" #'pdf-annot-add-strikeout-markup-annotation
   "a s" #'pdf-annot-add-squiggly-markup-annotation
   "a u" #'pdf-annot-add-underline-markup-annotation
   "n" #'pdf-view-midnight-minor-mode
   "s" #'pdf-view-set-slice-using-mouse
   "b" #'pdf-view-set-slice-from-bounding-box
   "r" #'pdf-view-reset-slice))

(map!
 (:map sml-mode-map
   :desc "SML Mode" :localleader "'"  #'run-sml
   :prefix ("s" . "sml") (
   :desc "Run buffer"                  "b" #'sml-prog-proc-send-buffer
   :desc "Run buffer and Focus"        "B" #'my/sml-prog-proc-send-buffer-and-focus
   :desc "Run the paragraph"           "f" #'sml-send-function
   :desc "Run the paragraph and focus" "F" #'my/sml-send-function-and-focus
   :desc "Run sml"                     "i" #'run-sml
   :desc "Run region"                  "r" #'sml-prog-proc-send-region
   :desc "Run region and focus"        "R" #'my/sml-prog-proc-send-region-and-focus
   :desc "Run buffer"                  "s" #'run-sml)))
