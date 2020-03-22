;;; ~/.doom.d/autoload/ferhaterata.el -*- lexical-binding: t; -*-

;;;###autoload
(defhydra resize-window-hydra (:hint nil)
  "
         _k_
      _h_     _l_
         _j_
"
  ("h" evil-window-decrease-width)
  ("j" evil-window-decrease-height)
  ("k" evil-window-increase-height)
  ("l" evil-window-increase-width))

;;;###autoload
(defhydra hydra-dired (:hint nil :color amaranth)
  "
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
_R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
_r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
_z_ compress-file  _A_ find regexp
_Z_ compress       _Q_ repl regexp

T - tag prefix
"
  ("\\" dired-do-ispell)
  ("(" dired-hide-details-mode)
  (")" dired-omit-mode)
  ("+" dired-create-directory)
  ("=" diredp-ediff)         ;; smart diff
  ("?" dired-summary)
  ("$" diredp-hide-subdir-nomove)
  ("A" dired-do-find-regexp)
  ("C" dired-do-copy)        ;; Copy all marked files
  ("D" dired-do-delete)
  ("E" dired-mark-extension)
  ("e" dired-ediff-files)
  ("F" dired-do-find-marked-files)
  ("G" dired-do-chgrp)
  ("g" revert-buffer)        ;; read all directories again (refresh)
  ("i" dired-maybe-insert-subdir)
  ("l" dired-do-redisplay)   ;; relist the marked or singel directory
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("O" dired-display-file)
  ("o" dired-find-file-other-window)
  ("Q" dired-do-find-regexp-and-replace)
  ("R" dired-do-rename)
  ("r" dired-do-rsynch)
  ("S" dired-do-symlink)
  ("s" dired-sort-toggle-or-edit)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
  ("w" dired-kill-subdir)
  ("Y" dired-do-relsymlink)
  ("z" diredp-compress-this-file)
  ("Z" dired-do-compress)
  ("q" nil)
  ("." nil :color blue))

;;;###autoload
(defhydra hydra-pdftools (:color blue :hint nil)
        "
                                                                        ╭───────────┐
      Move  History   Scale/Fit     Annotations   Search/Link    Do    │ PDF Tools │
  ╭────────────────────────────────────────────────────────────────────┴───────────╯
       ^^_gg_^^      _B_    ^↧^    _+_    ^ ^     [_al_] list      [_s_] search    [_u_] revert buffer
        ^^^↑^^^      ^↑^    _H_    ^↑^  ↦ _W_ ↤   [_am_] markup    [_o_] outline   [_i_] info
        ^^_k_^^      ^ ^    ^↥^    _0_    ^ ^     [_at_] text      [_F_] link      [_d_] dark mode
        ^^^↑^^^      ^↓^  ╭─^─^─┐  ^↓^  ╭─^ ^─┐   [_ah_] highlight [_f_] search l. [_n_] night mode
   _h_ ←pag_e_→ _l_  _N_  │ _P_ │  _-_    _b_     [_au_] underline [_y_] yank
        ^^^↓^^^      ^ ^  ╰─^─^─╯  ^ ^  ╰─^ ^─╯   [_as_] squiggly  [_<ESC>_] quit
        ^^_j_^^      ^ ^  _m_ouse slice       [_ad_] delete
        ^^^↓^^^      ^ ^  _r_eset slice box   [_aa_] dired
        ^^_G_^^
  --------------------------------------------------------------------------------
        "
        ("j" evil-collection-pdf-view-next-line-or-next-page :color red)
        ("k" evil-collection-pdf-view-previous-line-or-previous-page :color red)
        ("l" image-forward-hscroll :color red)
        ("h" image-backward-hscroll :color red)
        ("gg" evil-collection-pdf-view-goto-first-page)
        ("G" evil-collection-pdf-view-goto-page)
        ("H" pdf-view-fit-height-to-window)
        ("W" pdf-view-fit-width-to-window)
        ("P" pdf-view-fit-page-to-window)
        ("+" pdf-view-enlarge :color red)
        ("-" pdf-view-shrink :color red)
        ("0" pdf-view-scale-reset)
        ("e" pdf-view-goto-page)
        ("d" pdf-view-dark-minor-mode)
        ("n" pdf-view-midnight-minor-mode)
        ("o" pdf-outline)
        ("b" pdf-view-set-slice-from-bounding-box)
        ("r" pdf-view-reset-slice)
        ("m" pdf-view-set-slice-using-mouse)
        ("B" pdf-history-backward :color red)
        ("N" pdf-history-forward :color red)
        ("al" pdf-annot-list-annotations)
        ("ad" pdf-annot-delete)
        ("aa" pdf-annot-attachment-dired)
        ("am" pdf-annot-add-markup-annotation)
        ("at" pdf-annot-add-text-annotation)
        ("au" pdf-annot-add-underline-markup-annotation)
        ("ao" pdf-annot-add-strikeout-markup-annotation)
        ("ah" pdf-annot-add-highlight-markup-annotation)
        ("as" pdf-annot-add-squiggly-markup-annotation)
        ("y"  pdf-view-kill-ring-save)
        ("<ESC>" "quit")
        ("s" pdf-occur)
        ("i" pdf-misc-display-metadata)
        ("u" pdf-view-revert-buffer)
        ("F" pdf-links-action-perfom)
        ("f" pdf-links-isearch-link))


;;;###autoload
(defhydra hydra-window (:color blue :hint nil)
            "
                                                                       ╭─────────┐
     Move to      Size    Scroll        Split                    Do    │ Windows │
  ╭────────────────────────────────────────────────────────────────────┴─────────╯
        ^_k_^           ^_K_^       ^_p_^    ╭─┬─┐^ ^        ╭─┬─┐^ ^         ↺ [_u_] undo layout
        ^^↑^^           ^^↑^^       ^^↑^^    │ │ │_v_ertical ├─┼─┤_b_alance   ↻ [_r_] restore layout
    _h_ ←   → _l_   _H_ ←   → _L_   ^^ ^^    ╰─┴─╯^ ^        ╰─┴─╯^ ^         ✗ [_d_] close window
        ^^↓^^           ^^↓^^       ^^↓^^    ╭───┐^ ^        ╭───┐^ ^         ⇋ [_w_] cycle window
        ^_j_^           ^_J_^       ^_n_^    ├───┤_s_tack    │   │_z_oom
        ^^ ^^           ^^ ^^       ^^ ^^    ╰───╯^ ^        ╰───╯^ ^
  --------------------------------------------------------------------------------
            "
            ("<tab>" hydra-master/body "back")
            ("<ESC>" nil "quit")
            ("n" joe-scroll-other-window :color red)
            ("p" joe-scroll-other-window-down :color red)
            ("b" balance-windows)
            ("d" delete-window)
            ("H" shrink-window-horizontally :color red)
            ("h" windmove-left :color red)
            ("J" shrink-window :color red)
            ("j" windmove-down :color red)
            ("K" enlarge-window :color red)
            ("k" windmove-up :color red)
            ("L" enlarge-window-horizontally :color red)
            ("l" windmove-right :color red)
            ("r" winner-redo :color red)
            ("s" split-window-vertically :color red)
            ("u" winner-undo :color red)
            ("v" split-window-horizontally :color red)
            ("w" other-window)
            ("z" delete-other-windows))
