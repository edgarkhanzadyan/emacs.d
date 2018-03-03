
;; hints:
;; to view pdf files run "M-x pdf-tools-install"

;; packages that i'm using:
;; paradox
;; magit
;; rjsx-mode
;; dimmer
;; multiple-cursors
;; company-tern
;; multi-term
;; smartparens

;; nord-theme;; TODO: implement magit

;; DON'T PUSH THIS TO REPO
;; set key for paradox
(setq paradox-github-token "")
;; DON'T PUSH THIS TO REPO

;;
;;
;; NO-PACKAGE SETUP
;;
;;

;; rebind changing window key from C-x o to M-o
(global-set-key (kbd "M-o") 'other-window)

;; set C-h and M-h to backward deletes
(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-[") 'backward-paragraph)
(global-set-key (kbd "M-]") 'forward-paragraph)
;; no ring bell (ANNOYING)
(setq ring-bell-function 'ignore)

;; set default tab char's display width to 4 spaces
(setq-default tab-width 2)

;; add autocompletion on tab
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

;; show line number in the left margin
(add-hook 'find-file-hook 'linum-mode)

;; minor mode what treats CamelCase as distinct words
(global-subword-mode)

;; toggle fullscreen on M-RET
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
	 nil 'fullscreen
	 (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
(global-set-key (kbd "M-RET") 'toggle-fullscreen)

;;
;;
;; PROGRAMMING PACKAGE SETUP
;;
;;

;; setup gnu and melpa package-archives
(setq package-archives
			'(("gnu" . "http://elpa.gnu.org/packages/")
				;;   ("marmalade" . "http://marmalade-repo.org/packages/")
				("melpa" . "http://melpa.milkbox.net/packages/")))

;; initialize packages
(package-initialize)
(require 'paradox)
(paradox-enable)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; add smartParens and add it to everything in emacs
(require 'smartparens-config)
(add-hook 'find-file-hook 'smartparens-mode)

;; use dimmer which indicates which buffer is currently
;; active by dimming the faces in the other buffers. 
(require 'dimmer)
(dimmer-mode)

;; set zsh for multi-term
(setq multi-term-program "/bin/zsh")

;; use js2-jsx-mode as a major mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'interpreter-mode-alist '("node" . rjsx-mode))

;; add company and company-tern for autocompletion in js
(require 'company)
(require 'company-tern)
(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-jsx-mode-hook (lambda ()
															 (tern-mode)
															 (company-mode)))
;; turn off company-tern circle marker
(setq company-tern-property-marker nil)

;; setup multiple-cursors
(require 'multiple-cursors)
;; some keys for multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/unmark-next-like-this)
(global-set-key (kbd "C-<") 'mc/unmark-previous-like-this)
(global-set-key (kbd "C-c C-.") 'mc/mark-all-like-this)
;; try this one day mc-hide-unmatched-lines-mode

;;
;;
;; THEME & FONT SETUP
;;
;;

;; customize nord-theme
(setq nord-comment-brightness 15)
(setq nord-region-highlight "frost")

;; add FiraCode
(when (window-system)
  (set-frame-font "Fira Code"))
(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
	 ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (nord)))
 '(custom-safe-themes
	 (quote
		("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "c620ce43a0b430dcc1b06850e0a84df4ae5141d698d71e17de85e7494377fd81" "e4859645a914c748b966a1fe53244ff9e043e00f21c5989c4a664d649838f6a3" "7527f3308a83721f9b6d50a36698baaedc79ded9f6d5bd4e9a28a22ab13b3cb1" "4486ade2acbf630e78658cd6235a5c6801090c2694469a2a2b4b0e12227a64b9" default)))
 '(dimmer-fraction 0.2)
 '(fci-rule-color "#3E4451")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
	 (--map
		(solarized-color-blend it "#002b36" 0.25)
		(quote
		 ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
	 (quote
		(("#073642" . 0)
		 ("#546E00" . 20)
		 ("#00736F" . 30)
		 ("#00629D" . 50)
		 ("#7B6000" . 60)
		 ("#8B2C02" . 70)
		 ("#93115C" . 85)
		 ("#073642" . 100))))
 '(hl-bg-colors
	 (quote
		("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
	 (quote
		("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
	 (quote
		("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
	 (quote
		(rjsx-mode magit solarized-theme dimmer smartparens markdown-mode company-tern pdf-tools paradox try multi-term json-mode auto-complete xref-js2 js2-refactor js2-mode atom-one-dark-theme nord-theme oceanic-theme peacock-theme)))
 '(paradox-automatically-star nil)
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
	 (quote
		((20 . "#dc322f")
		 (40 . "#c85d17")
		 (60 . "#be730b")
		 (80 . "#b58900")
		 (100 . "#a58e00")
		 (120 . "#9d9100")
		 (140 . "#959300")
		 (160 . "#8d9600")
		 (180 . "#859900")
		 (200 . "#669b32")
		 (220 . "#579d4c")
		 (240 . "#489e65")
		 (260 . "#399f7e")
		 (280 . "#2aa198")
		 (300 . "#2898af")
		 (320 . "#2793ba")
		 (340 . "#268fc6")
		 (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
	 (quote
		(unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
	 ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
	 ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
