(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))


; list the packages you want
(setq package-list '(ac-octave auto-complete popup auctex auto-complete-auctex auto-complete popup yasnippet chess common-lisp-snippets yasnippet dired+ ess julia-mode fireplace flyspell-correct hc-zenburn-theme helm-core async highlight-numbers parent-mode julia-mode latex-preview-pane matlab-mode multi paredit parent-mode popup slime w3 w3m yasnippet))


; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
(package-initialize)
(setq inferior-lisp-program "sbcl")
(setq slime-auto-connect t)

(defvar my--slime-setup-done nil)
(defun my-slime-setup-once ()
  (unless my--slime-setup-done
    (my-slime-setup)
    (setq my--slime-setup-done t)))
(defadvice lisp-mode (before my-slime-setup-once activate)
  (my-slime-setup-once))


;;Melpa interaction
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-electric-math (quote ("$...$")))
 '(TeX-master t)
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-view-program-list
   (quote
    (("Sumatra PDF"
      ("\"C:/Program Files (x86)/SumatraPDF/SumatraPDF.exe\" -reuse-instance"
       (mode-io-correlate " -forward-search %b %n")
       " %o")
      nil))))
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and start")
     (output-dvi "Yap")
     (output-pdf "Sumatra PDF")
     (output-html "start"))))
 '(ansi-color-names-vector
   ["#313131" "#D9A0A0" "#8CAC8C" "#FDECBC" "#99DDE0" "#E090C7" "#A0EDF0" "#DCDCCC"])
 '(browse-url-browser-function (quote browse-url-default-windows-browser))
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "6b0d1d4f1f7720dcdf1b07d3926572f9d475e3cd4e90d82f2fdfb6bd4d99979b" "bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "108b3724e0d684027c713703f663358779cc6544075bc8fd16ae71470497304f" default)))
 '(fci-rule-color "#5E5E5E")
 '(latex-run-command "latex-file-line-error")
 '(matlab-mode-hook (quote (highlight-numbers-mode)))
 '(matlab-show-periodic-code-details-flag nil)
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (magit elpy helm-core jedi epc rainbow-delimiters powerline spaceline zenburn-theme auctex ## ranger w3m w3 slime paredit multi matlab-mode latex-preview-pane highlight-numbers hc-zenburn-theme flyspell-correct fireplace ess dired+ common-lisp-snippets chess auto-complete-auctex ac-octave)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(preview-default-preamble
   (quote
    ("\\RequirePackage["
     ("," . preview-default-option-list)
     "]{preview}[2004/11/05]")))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#202020")
 '(vc-annotate-color-map
   (quote
    ((20 . "#C99090")
     (40 . "#D9A0A0")
     (60 . "#ECBC9C")
     (80 . "#DDCC9C")
     (100 . "#EDDCAC")
     (120 . "#FDECBC")
     (140 . "#6C8C6C")
     (160 . "#8CAC8C")
     (180 . "#9CBF9C")
     (200 . "#ACD2AC")
     (220 . "#BCE5BC")
     (240 . "#CCF8CC")
     (260 . "#A0EDF0")
     (280 . "#79ADB0")
     (300 . "#89C5C8")
     (320 . "#99DDE0")
     (340 . "#9CC7FB")
     (360 . "#E090C7"))))
 '(vc-annotate-very-old-color "#E090C7"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(my-outermost-paren-face ((t (:weight extra-bold)))))

;;Hyperspec lookup
(defun my-hyperspec-setup ()
  (let ((dir (locate-dominating-file invocation-directory "HyperSpec/")))
    (if dir
        (progn
          (setq common-lisp-hyperspec-root (expand-file-name "HyperSpec/" dir)))
      (warn "No HyperSpec directory found"))))
(defun my-slime-setup ()
  (my-hyperspec-setup)
  (require 'slime-autoloads)
  (slime-setup '(slime-scratch slime-editing-commands slime-repl)))
(add-hook 'lisp-mode-hook 'electric-pair-mode)
(add-hook 'lisp-mode-hook 'highlight-numbers-mode)


;;;LaTeX

(load "auctex.el" nil t t)
(require 'tex-mik)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)
(setq TeX-save-query nil)
(setq-default TeX-master t)
(setq TeX-electric-math (cons "$" "$"))
(setq LaTeX-electric-left-right-brace t)
;(setq debug-on-error t)
;(eval-after-load "preview"
;  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
					; )
; --doesn't work on windows
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;;Transparency
 ;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
 (set-frame-parameter (selected-frame) 'alpha '(95 95))
 (add-to-list 'default-frame-alist '(alpha 95 95))

;;Yasnippet clisp plugin
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(put 'downcase-region 'disabled nil)

(require 'desktop)
(desktop-save-mode 1)
(defun my-desktop-save ()
  (interactive)
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save emacs_sessions)))
(add-hook 'auto-save-hook 'my-desktop-save)

(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
 (add-to-list
  'auto-mode-alist
  '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-toggle-highlight-cross-function-variables t)
(setq matlab-return-add-semicolon t)

(require 'auto-complete)
(global-auto-complete-mode t)
;(add-to-list 'auto-mode-alist '("\\.m\\'" . auto-complete-mode))
;(add-hook 'matlab-mode #'highlight-numbers-mode)
(add-to-list 'ac-modes 'matlab-mode)
;(add-to-list 'auto-mode-alist '("\\.m\\'" . highlight-numbers-mode))
;(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))
(add-to-list 'ac-modes 'r-mode)
(add-to-list 'ac-modes 'latex-mode)
;(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(set-default 'preview-scale-function 0.75)

(add-hook 'matlab-mode-hook '(lambda () (linum-mode t)))
(add-hook 'ess-mode-hook 'linum-mode)
(add-hook 'lisp-mode-hook 'linum-mode)
;(require 'hlinum)
;(hlinum-activate)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'matlab-mode-hook 'rainbow-delimiters-mode)
(defface my-outermost-paren-face
  '((t (:weight bold)))
  "Face used for outermost parens.")
;;;modeline

(add-to-list 'load-path "~/bin/powerline")
(require 'powerline)
;;(powerline-vim-theme) ;;plain line
;;(powerline-nano-theme)
(powerline-center-theme)
(setq powerline-default-separator 'brace)


;;;Python
(add-hook 'python-mode-hook 'jedi-mode)
;(setq jedi:setup-keys t)                      ; optional
;(setq jedi:complete-on-dot t)
(elpy-enable)
(add-hook 'python-mode-hook 'linum-mode)
		     
;;;Magit

(global-set-key (kbd "C-x g") 'magit-status)
