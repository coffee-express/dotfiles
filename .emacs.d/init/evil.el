(setq evil-want-C-u-scroll t
      evil-want-fine-undo t
      evil-search-module 'evil-search
      evil-ex-search-vim-style-regexp t)

(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

(use-package evil
  :ensure t
  :config
  ;; global
  (define-key evil-normal-state-map (kbd "C-l") 'evil-ex-nohighlight)
  (define-key evil-normal-state-map (kbd "/") 'swiper)
  (define-key evil-insert-state-map (kbd "C-k") 'company-yasnippet)
  ;; direx
  (evil-define-key 'normal direx:direx-mode-map
    (kbd "q") 'evil-window-delete
    (kbd "D") 'direx:do-delete-files
    (kbd "r") 'direx:refresh-whole-tree
    (kbd "R") 'direx:do-rename-file
    (kbd "c") 'direx:do-copy-files
    (kbd "j") 'direx:next-item
    (kbd "k") 'direx:previous-item
    (kbd "C-j") 'direx:next-sibling-item
    (kbd "C-k") 'direx:previous-sibling-item
    (kbd "SPC") 'direx:toggle-item
    (kbd "o") 'direx:maybe-find-item
    (kbd "RET") 'direx:find-item
    (kbd "P") 'direx-project:jump-to-project-root)
  ;; quickrun
  (evil-define-key 'normal quickrun--mode-map
    (kbd "q") 'evil-window-delete)
  ;; python
  (evil-define-key 'normal python-mode-map
    (kbd "gd") 'jedi:goto-definition
    (kbd "K") 'jedi:show-doc)
  ;; markdown
  (evil-define-key 'normal markdown-mode-map
    (kbd ",1") 'markdown-insert-header-setext-1
    (kbd ",2") 'markdown-insert-header-setext-2
    (kbd ",3") 'markdown-insert-header-atx-3
    (kbd ",4") 'markdown-insert-header-atx-4
    (kbd ",5") 'markdown-insert-header-atx-5
    (kbd ",-") 'markdown-insert-hr
    (kbd ",c") 'markdown-insert-code
    (kbd ",C") 'markdown-insert-gfm-code-block
  ))

(use-package evil-leader
  :ensure t
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "ag" 'counsel-ag
    "bc" 'elscreen-create
    "bk" 'elscreen-kill
    "bn" 'elscreen-next
    "bp" 'elscreen-previous
    "bs" 'elscreen-start
    "df" 'counsel-describe-function
    "dv" 'counsel-describe-variable
    "el" 'flycheck-list-errors
    "fb" 'ivy-switch-buffer
    "fc" 'org-capture
    "fd" 'direx:jump-to-directory-other-window
    "ff" 'counsel-find-file
    "fj" 'my/open-junk-file
    "fr" 'counsel-recentf
    "gf" 'counsel-git
    "gg" 'counsel-git-grep
    "gp" 'counsel-ghq
    "gs" 'magit-status
    "ll" 'counsel-load-library
    "lo" 'counsel-locate
    "ls" 'counsel-info-lookup-symbol
    "r" 'quickrun
    "th" 'twit
    "tu" 'twittering-update-status-interactive
    "us" 'counsel-unicode-char
    "ze" 'eval-buffer
    "zi" 'find-user-init-file
    "zr" 'restart-emacs
    )
  ;; Note: You should enable global-evil-leader-mode before you enable evil-mode
  (global-evil-leader-mode)
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-magit :ensure t)

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode 1))

;; (use-package somelauw/evil-org)

(use-package evil-lion
  :ensure t
  :config
  (evil-lion-mode))

(use-package evil-escape :ensure t)