(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; (package-install 'use-package)


;; Coding
(prefer-coding-system 'utf-8)

;; japanese font
;; (set-fontset-font t 'japanese-jisx0208 (font-spec :family "IPAexGothic"))
;; (add-to-list 'face-font-rescale-alist '(".*IPAex.*" . 0.85))

;; 行番号の表示
(global-linum-mode t)
(setq linum-format "%3d ")

;; C-k １回で行全体を削除する
(setq kill-whole-line t)

;;通常のウィンドウ用の設定, テキストの折り返し
(setq-default truncate-lines t
          truncate-partial-width-windows t)


;; active でない window の空 cursor を出さない
(setq cursor-in-non-selected-windows nil)

;; bufferの先頭でカーソルを戻そうとしても音をならなくする
(defun previous-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move (- arg))
    (beginning-of-buffer)))

;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
      (end-of-buffer)))

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; メニューバー，ツールバーの非表示
(menu-bar-mode 0)
(tool-bar-mode 0)

;; 起動画面の設定
(setq inhibit-startup-message t)

;; バックアップファイルを作らないようにする
(setq make-backup-files nil
      auto-save-default nil)

;; 括弧の対応関係をハイライト表示
(show-paren-mode nil)
(electric-pair-mode 1)


;; mouse in terminal emacs
(xterm-mouse-mode t)
(mouse-wheel-mode t)
(global-set-key   [mouse-4] '(lambda () (interactive) (scroll-down 1))) ;; scroll
(global-set-key   [mouse-5] '(lambda () (interactive) (scroll-up   1)))


;; 大文字 <-> 小文字の補完について
(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [f1] 'other-window)
(global-set-key [f2] 'neotree-toggle)
(global-set-key [f3] 'delete-trailing-whitespace)
;;(global-set-key [f4] (lambda () (interactive)(ansi-term "bash")))
(global-set-key [f4] 'kill-this-buffer)
(global-set-key [f5] 'compile)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<down>") 'windmove-down)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-z") 'suspend-emacs)
(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)
(global-set-key (kbd "C-:") 'hs-toggle-hiding)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-r") 'swiper)
(defvar swiper-include-line-number-in-search t)
(setq compilation-scroll-output t)

;; undefine C-z
(global-set-key "\C-z" nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Auto Complete
(use-package auto-complete
  :init (global-auto-complete-mode t)
  :ensure t)

;;
;; python
;;
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python3" . python-mode)
  :config
  (add-hook 'python-mode-hook
        (lambda()
          (hs-minor-mode t))))

;; -------------------------------------------------------------
;; ivy
;; -------------------------------------------------------------
(use-package ivy
  :init (ivy-mode t)
  :ensure t)


;; -------------------------------------------------------------
;; counsel
;; -------------------------------------------------------------
(use-package counsel
  :config (setq counsel-find-file-ignore-regexp
        (concat
         ;; File names beginning with # or .
         "\\(?:\\`[#.]\\)"
         ;; File names ending with # or ~
         "\\|\\(?:\\`.+?[#~]\\'\\)"))
  :ensure t)



;;
;; powerline
;;
(use-package powerline
  :ensure t)
;; (powerline-default-theme)

;; -------------------------------------------------------------
;; swiper
;; -------------------------------------------------------------
(use-package swiper
  :ensure t)

;;
;; all the icons
;;
(use-package all-the-icons
  :ensure t)
;; note: M-x all-the-icons-install-fonts

;; -------------------------------------------------------------
;; neotree
;; -------------------------------------------------------------
(use-package neotree
  :ensure t
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))


;; -------------------------------------------------------------
;; undo-tree
;; -------------------------------------------------------------
(use-package undo-tree
  :defer t
  :init (global-undo-tree-mode t)
  :bind (("C-z" . undo-tree-undo)
     ("C-/" . undo-tree-undo)
     ("M-/" . undo-tree-redo)
     ("C-S-z" . undo-tree-redo)
     ("C-x u" . undo-tree-visualize))
  :ensure t)


;; -------------------------------------------------------------
;; dashboard
;; -------------------------------------------------------------
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 15)))
 :ensure t)


;;
;; yasnippet
;;
(use-package yasnippet
  :ensure t
  :init (yas-global-mode t)
  :diminish yas-minor-mode
  :config
  (define-key yas-minor-mode-map (kbd "TAB") nil))
;; yasnippet-snippets mo install


;;
;; mozc and mozc-popup
;;
(use-package mozc
  :ensure t)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")
(prefer-coding-system 'utf-8)
(use-package mozc-popup
  :ensure t)
(setq mozc-candidate-style 'echo-area)


;; -------------------------------------------------------------
;; compile
;; -------------------------------------------------------------
(use-package compile
  :config
  (bury-successful-compilation t)
  :ensure t)

(defvar yel-compile-auto-close nil)
(defadvice compile (after compile-aftercheck
                          activate compile)
  "Adds a funcion of windows auto-close."
  (let ((proc (get-buffer-process "*compilation*")))
    (if (and proc yel-compile-auto-close)
        (set-process-sentinel proc 'yel-compile-teardown))))
(defun yel-compile-teardown (proc status)
  "Closes window automatically, if compile succeed."
  (let ((ps (process-status proc)))
    (if (eq ps 'exit)
        (if (eq 0 (process-exit-status proc))
            (progn
              (delete-other-windows)
              (kill-buffer "*compilation*")
              (message "---- Compile Success ----")
              )
          (message "Compile Failer")))
    (if (eq ps 'signal)
        (message "Compile Abnormal end"))))


;; C mode
(use-package cc-mode
;; c-mode-common-hook は C/C++ の設定
  :config
  (add-hook 'cc-mode-hook
        (lambda()
          (setq c-default-style "k&r"
            c-basic-offset)
          (hs-minor-mode t))))

;; custom set, dont touch
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(adwaita))
 '(package-selected-packages
   '(nim-mode all-the-icons-ivy all-the-icons-gnus markdown-mode yasnippet-snippets dockerfile-mode yaml-mode page-break-lines powerline)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
