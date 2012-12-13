;; Setting By Hua Liang [ [ Stupid ET ] Cedric Porter ]
;; Mail:    et@everet.org
;; website: http://EverET.org

;;Personal information
(setq user-full-name "Hua Liang")
(setq user-mail-address "et@everet.org") 

(set-frame-font "Ubuntu Mono-12")


;; Add plugins to load-path.
;; We will put some tiny plugins in it
(add-to-list 'load-path "~/.emacs.d/plugins/") 
(add-to-list 'load-path "~/.emacs.d/plugins/configs") 

(defun open-setting-file()
  (interactive)
  (find-file "~/.emacs"))

;; ====================      line number      ====================
;; 调用linum.el(line number)来显示行号：
(require 'linum)
(global-linum-mode t)
;;(require 'hlinum)
;; --------------------      End         --------------------

;;======================    time setting        =====================
;;启用时间显示设置，在minibuffer上面的那个杠上（忘了叫什么来着）
(display-time-mode 1)
 
;;时间使用24小时制
(setq display-time-24hr-format t)
 
;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)
 
;;时间栏旁边启用邮件设置
;(setq display-time-use-mail-icon t)
 
;;时间的变化频率
(setq display-time-interval 10)
 
;;显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t) 
;;----------------------    END    time setting    ---------------------

;; ==================== recent-jump ====================
;; set recent-jump
(setq recent-jump-threshold 4)
(setq recent-jump-ring-length 10)
(global-set-key (kbd "C-o") 'recent-jump-jump-backward)
(global-set-key (kbd "M-o") 'recent-jump-jump-forward)
(require 'recent-jump)
;; -------------------- end of recent-jump --------------------

;; ==================== UI setting ====================
;; 实现全屏效果，快捷键为f11
(global-set-key [(control f11)] 'my-fullscreen) 
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  )
;; 最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  )
;; 启动emacs时窗口最大化
(my-maximized)

(setq-default fill-column 81)
(setq default-fill-column 80)

;; 启动窗口大小
(setq default-frame-alist
      '((height . 35) (width . 125) (menu-bar-lines . 20) (tool-bar-lines . 0)))
;; -------------------- UI setting --------------------


;; 在Emacs23里，可以用命令M-x quick-calc或快捷键C-x * q来启动Quick Calculator模式。
;; 这是一个非常小巧的工具，启动后会在minibuffer里提示输入数学计算式，回车就显示结果。
;; 这个模式能非常方便地用来做一些基本的数学运算，比用系统自带的计算器来得方便、快捷一些。


;; ==================== Common Setting ====================

;;;_ xterm & console
(when (eq system-type 'gnu/linux)
  (if (not window-system)
      (xterm-mouse-mode t))
  ;;(gpm-mouse-mode t) ;;for Linux console

  (load-library "help-mode")  ;; to avoid the error message "Symbol's value as variable is void: help-xref-following"
  )

;(setq tramp-default-method "ssh")
 
;;; shift the meaning of C-s and C-M-s
(global-set-key [(control s)] 'isearch-forward-regexp)
(global-set-key [(control meta s)] 'isearch-forward)
(global-set-key [(control r)] 'isearch-backward-regexp)
(global-set-key [(control meta r)] 'isearch-backward)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Mark Set
(global-unset-key (kbd "C-SPC"))  
(global-set-key (kbd "M-SPC") 'set-mark-command)

;; moinmoin-mode
(require 'screen-lines)
(require 'moinmoin-mode)

;; nginx-mode
(require 'nginx-mode)

;(require 'ibus) 
;(add-hook 'after-init-hook 'ibus-mode-on) 

;;去掉菜单栏，将F10绑定为显示菜单栏，需要菜单栏了可以摁F10调出，再摁F10就去掉菜单
;; 如果总是不显示工具栏，将下面代码加到.emacs中
;; 参考： http://www.emacswiki.org/emacs/ToolBar
;; 注意：在menu-bar不显示的情况下，按ctrl+鼠标右键还是能调出菜单选项的 
(tool-bar-mode -1)
;; 如果总是不显示菜单，将下面代码加到.emacs中
;;参考： http://www.emacswiki.org/emacs/MenuBar
(menu-bar-mode -1)

;; eliminate long "yes" or "no" prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; 方便的在 kill-ring 里寻找需要的东西。
(require 'browse-kill-ring)
(require 'second-sel)
(require 'browse-kill-ring+)
(browse-kill-ring-default-keybindings)
(global-set-key "\C-c\C-k" 'browse-kill-ring)

;; 防止页面滚动时跳动，可以很好的看到上下文。
(setq scroll-margin 3
      scroll-conservatively 10000)

;; 改造你的C-w和M-w键
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
	 (list (line-beginning-position)
		   (line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
	 (list (line-beginning-position)
		   (line-beginning-position 2)))))

;; 4.1 在单元格之间移动
;; table-forward-cell<==>tab
;; table-backward-cell<==>shift+tab
;; 
;; 4.2 合并单元格
;; table-span-cell
;; 
;; 4.3 拆分单元格
;; +---------------------------------------+---------------+
;; |table-split-cell-horizontally          |C-c C-c -      |
;; +---------------------------------------+---------------+
;; |table-split-cell-vertically            |C-c C-c |      |
;; +---------------------------------------+---------------+
;; 
;; 4.4 扩大或缩小单元格的宽度、高度
;; +--------------------------------------+----------+
;; |垂直扩大：table-highten-cell          |C-c C-c } |
;; |                                      |          |
;; +--------------------------------------+----------+
;; |垂直缩小：table-shorten-cell          |C-c C-c { |
;; |                                      |          |
;; +--------------------------------------+----------+
;; |水平扩大: table-widen-cell            |C-c C-c > |
;; |                                      |          |
;; +--------------------------------------+----------+
;; |水平缩小：table-narrow-cell           |C-c C-c < |
;; |                                      |          |
;; +--------------------------------------+----------+
;; 
;; 5、单元格对齐方式
;; +---------------------------------------+-----------+
;; |命令：table-justify                    |C-c C-c :  |
;; +---------------------------------------+-----------+

;; 可以“所见即所得”的编辑一个文本模式的 表格。
(autoload 'table-insert "table" "WYGIWYS table editor")

;; 解决汉字表格对齐问题，也就是设置等宽汉字
(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (set-fontset-font "fontset-default"
                                    'chinese-gbk "WenQuanYi Micro Hei Mono 12"))))
  (set-fontset-font "fontset-default" 'chinese-gbk "WenQuanYi Micro Hei Mono 12"))

;;设置句尾
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

;;直接打开图片
(auto-image-file-mode)

;; take the place of C-x C-f
;; 当你输入了一些字符后，系统会自动帮你补全；
;; C-s(next)或是C-r(previous)用来在列表中循环；
;; 按[Tab]键会自动列出可能的补全方法；
;; 用C-x C-d直接打开当前目录的Dired浏览模式；
(require 'ido)
(ido-mode t)
;(ffap-bindings)
;(global-set-key "\C-x\C-f" 'ido-dired)
(global-set-key "\C-c\C-f" 'find-file-at-point)


;; 去掉滚动栏
(scroll-bar-mode -1)

;; 一打开就起用 text 模式。  
(setq default-major-mode 'text-mode)

;; 语法高亮
(global-font-lock-mode t)
	 
;;use meta and direction key to go to the window
(windmove-default-keybindings 'meta)

;; session
(require 'session) 
(add-hook 'after-init-hook 'session-initialize) 
(load "desktop") 
(desktop-save-mode) 

;; back to last position when we close the file
(require 'saveplace)
(setq-default save-place t)

;;tabbar
(require 'tabbar)  
(tabbar-mode 1)  
(global-set-key [(meta j)] 'tabbar-backward)  
(global-set-key [(meta k)] 'tabbar-forward)
(global-set-key [(control meta j)] 'tabbar-backward-group)
(global-set-key [(control meta k)] 'tabbar-forward-group)
;;set group strategy
(defun tabbar-buffer-groups ()  
  "tabbar group"  
  (list  
   (cond  
    ((memq major-mode '(shell-mode dired-mode))  
     "shell"  
     )  
    ((memq major-mode '(c-mode c++-mode))  
     "cc"  
     )  
    ((eq major-mode 'python-mode)  
     "python"  
     )  
    ((memq major-mode
	   '(php-mode nxml-mode nxhtml-mode))
     "WebDev"
     )
    ((eq major-mode 'emacs-lisp-mode)
      "Emacs-lisp"
      )
    ((memq major-mode
	   '(tex-mode latex-mode text-mode snippet-mode))
     "Text"
     )
    ((string-equal "*" (substring (buffer-name) 0 1))  
     "emacs"  
     )  
    (t  
     "other"  
     )  
    )))  
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups) 

;;;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
                    :family "Vera Sans YuanTi Mono"
                    :background "gray80"
                    :foreground "gray10"
                    :height 1.0
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "gray30")
                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "DarkGreen"
                    :background "LightGoldenrod"
                    :box '(:line-width 2 :color "DarkGoldenrod")
                    ;; :overline "black"
                    ;; :underline "black"
                    :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "gray70")
                    )
;; cancel grouping
;;(setq tabbar-buffer-groups-function
;;    (lambda (b) (list “All Buffers”)))
;;(setq tabbar-buffer-list-function
;;    (lambda ()
;;        (remove-if
;;          (lambda(buffer)
;;             (find (aref (buffer-name buffer) 0) ” *”))
;;          (buffer-list))))

;;禁用启动信息
;(setq inhibit-startup-message t) 

;; 回车缩进
;; (global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)

;; 显示括号匹配 
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(require 'highlight-parentheses)
(highlight-parentheses-mode 1)

;; 显示ascii表
;(require 'ascii)

;; Key binding
;;(require 'misc)

(global-set-key "\M-f" 'forward-same-syntax) ; Make it behave like vim
(global-set-key "\M-b" (lambda () (interactive) (forward-same-syntax -1)))

(defun kill-syntax (&optional arg)
  "Kill ARG sets of syntax characters after point."
  (interactive "p")
  (let ((opoint (point)))
	(forward-same-syntax arg)
	(kill-region opoint (point))) )
(global-set-key "\M-d" 'kill-syntax)
(global-set-key [(meta backspace)] (lambda() (interactive) (kill-syntax -1) ) )


;;用一个很大的 kill ring. 这样防止我不小心删掉重要的东西。
(setq kill-ring-max 200)

;;高亮显示选中的区域
(transient-mark-mode t) 

;;支持emacs和外部程序的拷贝粘贴
(setq x-select-enable-clipboard t) 
 
;;在标题栏提示当前位置
(setq frame-title-format "ET@%b")

;;使用C-k删掉指针到改行末的所有东西
(setq-default kill-whole-line t)

;;==================== 注释 ====================
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c b") 'comment-box)
(global-set-key (kbd "C-c k") 'comment-kill)
;;-------------------- end --------------------

;(require 'doxygen-config.el)

;;==================== color theme ====================
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0/") 
(require 'color-theme) 
(load-file "~/.emacs.d/plugins/color-theme-6.6.0/themes/color-theme-library.el")
;;(require 'color-theme-library)
;;(color-theme-charcoal-black)
;;(color-theme-taylor)
(color-theme-taylor-et)
;;(color-theme-infodoc)
;;-------------------- color theme --------------------


;; ==================== ace-jump ====================
;; "C-c SPC" ==> ace-jump-word-mode : enter first character of a word, select the highlighted key to move to it.
;; "C-u C-c SPC" ==> ace-jump-char-mode : enter a character for query, select the highlighted key to move to it.
;; "C-u C-u C-c SPC" ==> ace-jump-line-mode : each non-empty line will be marked, select the highlighted key to move to it.
(autoload 'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(setq ace-jump-mode-scope 'window)      ; limit scope to current buffer(window)
(setq ace-jump-mode-submode-list
      '(ace-jump-word-mode              ; C-;
        ace-jump-line-mode              ; C-u C-;
        ace-jump-char-mode))            ; C-u C-u C-;
;; you can select the key you prefer to
(define-key global-map (kbd "C-;") 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-char-mode)
;; -------------------- ace-jump --------------------


;; ;;==================== evil ====================
;; ;;vi emulator
;; (setq evil-want-C-i-jump t)
;; (setq evil-want-C-u-scroll t)
;; 
;; (add-to-list 'load-path "~/.emacs.d/plugins/evil")
;; (require 'evil)  
;; (evil-mode 1)
;; (require 'surround)
;; (global-surround-mode 1)
;; 
;; ;;(global-set-key [(kdb "C-u")] 'evil-scroll-up)
;; 
;; (define-key evil-normal-state-map ",i" 'ibuffer)
;; (define-key evil-normal-state-map ",bs" 'ido-switch-buffer)
;; (define-key evil-normal-state-map ",bd" 'kill-this-buffer)
;; ;(define-key evil-normal-state-map ",m" 'magit-status)
;; (define-key evil-normal-state-map ",w" 'save-buffer)
;; (define-key evil-normal-state-map ",ee" 'open-setting-file)
;; (define-key evil-normal-state-map "ZZ" (kbd "C-c C-c"))
;; 
;; ;; org-mode relaterat
;; (define-key evil-normal-state-map ",a" 'org-agenda)
;; 
;; ;; lisp-relaterat som annars inte verkar fungera
;; (define-key evil-normal-state-map ",hv" 'describe-variable)
;; (define-key evil-normal-state-map ",hk" 'describe-key)
;; (define-key evil-normal-state-map ",hf" 'describe-function)
;; (define-key evil-normal-state-map ",hm" 'describe-mode)
;; 
;; ;; window
;; (define-key evil-normal-state-map ",0" 'delete-window)         ;delete this window, same as C-x 0 
;; (define-key evil-normal-state-map ",1" 'delete-other-windows)  ;delete other windows
;; (define-key evil-normal-state-map ",2" 'split-window-up-down)  ;split the window to up and down windows, which the upper one is bigger
;; (define-key evil-normal-state-map ",3" 'split-window-3)        ;split the window to 3 window, left big
;; (define-key evil-normal-state-map ",4" 'split-window-4)        ;split the window into 4 equal size window
;; (define-key evil-normal-state-map ",q" 'winner-undo)	       ;undo, in other word, restore to previous window style
;; (define-key evil-normal-state-map ",Q" 'winner-redo)	       ;redo window style change
;; 
;; ;; End of evil config copied from monotux@reddit
;; ;;-------------------- evil --------------------


;;==================== undo tree ====================
(require 'undo-tree)
;;-------------------- undo tree --------------------


(require 'window-setting)


;; ==================== htmlize ====================
;; 1) M-x htmlize-buffer
;; 把当前的buffer转为一个html文件，并保留当前你Emacs的色彩定义。运行这个命令后，Emacs会跳转到一个新的buffer里，你把这个buffer保存下来即可。
;;  
;; 2) M-x htmlize-file
;; 这个命令会在mini-buffer里提示输入你需要转换的文件，自动帮你转换好，并保存为.html。
;;  
;; 3) M-x htmlize-many-files
;; 这个命令和2)差不多的功能，不过可以让你同时转一批文件。
;;  
;; 4) M-x htmlize-many-files-dired
;; 这个命令可以把你标记好的目录下的所以文件都转成html。
(require 'htmlize)
;; -------------------- htmlize -----------------------------


;;==================== yasnippt ====================
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
;;-------------------- yasnippt --------------------


;;==================== auto complete ====================
;; auto complete with clang
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict/")  
;(require 'auto-complete-clang)

(setq ac-auto-start t)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
(define-key ac-mode-map [(control tab)] 'auto-complete)

;; (defun my-ac-config ()
;;   (setq ac-clang-flags (split-string "-I../include -I../Include -I../ -I../inc -I../Inc -I../common -I../Common -I../lib -I../Lib"))
;;   (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
;;   (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
;;   ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;   (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
;;   (add-hook 'css-mode-hook 'ac-css-mode-setup)
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;   (global-auto-complete-mode t))
;; (defun my-ac-cc-mode-setup ()
;;   (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
;; (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ;; ac-source-gtags
;; (my-ac-config)
;; -------------------- end of auto complete --------------------

;; cua-mode: I want the rectangle C-return
(setq cua-enable-cua-keys nil)
(cua-mode t) 
   
;; ==================== new python ====================
(add-to-list 'load-path "~/.emacs.d/plugins/python-mode.el-6.1.0")

(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
 
(add-to-list 'load-path "~/.emacs.d/plugins/pymacs")
 
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(require 'pycomplete)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))

(defun ac-pycomplete-candidates ()
  ;(message "Start ac-pycomplete-candidates: %s %s %s"   ; for debug
  ; 		   (py-symbol-near-point)
  ; 		   (py-find-global-imports)
  ; 		     (pycomplete--get-all-completions (py-symbol-near-point) (py-find-global-imports)))
  (pycomplete--get-all-completions (py-symbol-near-point) (py-find-global-imports)))


(defface ac-pycomplete-candidate-face
  '((t (:background "burlywood1" :foreground "navy")))
  "Face for clang candidate"
  :group 'auto-complete)

(defface ac-pycomplete-selection-face
  '((t (:background "navy" :foreground "white")))
  "Face for the clang selected candidate."
  :group 'auto-complete)

(ac-define-source pycomplete
  '((candidates . ac-pycomplete-candidates)
	(candidate-face . ac-pycomplete-candidate-face)
	(selection-face . ac-pycomplete-selection-face)
	)
  )

(defun ac-python-mode-setup ()
  (setq ac-sources (append '(ac-source-pycomplete)
			   ac-sources)))
(add-hook 'python-mode-hook 'ac-python-mode-setup)

;; flymake
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init)))
(load-library "flymake-cursor")
;(global-set-key [f10] 'flymake-goto-prev-error)
;(global-set-key [f11] 'flymake-goto-next-error)

;; -------------------- new python --------------------


;; ;; ;;==================== python ====================
;; (require 'python)
;;  
;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (add-to-list 'load-path "~/.emacs.d/plugins/pymacs")
;;  
;; (require 'pymacs)
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")
;; ;;(eval-after-load "pymacs"
;; ;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
;;  
;; ;;; Initialize Rope
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t) ;; Too slow when I am saving
;;  
;; (ac-ropemacs-initialize)
;; (add-hook 'python-mode-hook
;;  	  (lambda ()
;;  	    (add-to-list 'ac-sources 'ac-source-ropemacs)))
;;  
;; ;;load pydb
;; (require 'pydb)
;; (autoload 'pydb "pydb" "Python Debugger mode via GUD and pydb" t)
;; ;;-------------------- python --------------------

;; ;;==================== cedet ====================
;; (add-to-list 'load-path "~/.emacs.d/plugins/cedet-1.1/common/")
;; (load-file "~/.emacs.d/plugins/cedet-1.1/common/cedet.elc")
;; (require 'semantic-ia)
;; (require 'semantic-gcc)
;;  
;; (semantic-add-system-include ".." 'c++-mode)
;;  
;; ;; Enable EDE (Project Management) features
;; (global-ede-mode t)
;;  
;; ;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)
;;  
;; ;; ;; (setq semanticdb-project-roots (list (expand-file-name "/")))
;; ;; (defconst cedet-user-include-dirs
;; ;;   (list ".." "../include" "../Include" "../inc" "../common" "../public" "../lib"
;; ;;         "../.." "../../include" "../../inc" "../../common" "../../public" "../../.." "../../../include" "../../../Include"))
;; ;; (defconst cedet-win32-include-dirs
;; ;;   (list "C:/MinGW/include"
;; ;;         "C:/MinGW/include/c++/3.4.5"
;; ;;         "C:/MinGW/include/c++/3.4.5/mingw32"
;; ;;         "C:/MinGW/include/c++/3.4.5/backward"
;; ;;         "C:/MinGW/lib/gcc/mingw32/3.4.5/include"
;; ;;         "C:/Program Files/Microsoft Visual Studio/VC98/MFC/Include"))
;;  
;; ;; (require 'semantic-c nil 'noerror)
;; ;; (let ((include-dirs cedet-user-include-dirs))
;; ;;   ;(when (eq system-type 'windows-nt)
;; ;;   ;  (setq include-dirs (append include-dirs cedet-win32-include-dirs)))
;; ;;   (mapc (lambda (dir)
;; ;;           (semantic-add-system-include dir 'c++-mode)
;; ;;           (semantic-add-system-include dir 'c-mode))
;; ;;         include-dirs))
;; ;;-------------------- cedet --------------------
;;  
;;  
;; ;; ==================== semantic ====================
;; ;; (semantic-load-enable-minimum-features)
;; (semantic-load-enable-code-helpers)
;; ;; (semantic-load-enable-guady-code-helpers)
;; ;; (semantic-load-enable-excessive-code-helpers)
;; (semantic-load-enable-semantic-debugging-helpers)
;;  
;; ;; (semantic-decoration-mode 1)
;;  
;; ;; jump to definition
;; (global-set-key [f12] 'semantic-ia-fast-jump)
;;  
;; ;; go back
;; (global-set-key [S-f12]
;;         	(lambda ()
;;         	  (interactive)
;;         	  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
;;         	      (error "Semantic Bookmark ring is currently empty"))
;;         	  (let* ((ring (oref semantic-mru-bookmark-ring ring))
;;         		 (alist (semantic-mrub-ring-to-assoc-list ring))
;;         		 (first (cdr (car alist))))
;;         	    (if (semantic-equivalent-tag-p (oref first tag)
;;         					   (semantic-current-tag))
;;         		(setq first (cdr (car (cdr alist)))))
;;         	    (semantic-mrub-switch-tags first))))
;;  
;; ;;(define-key c-mode-base-map (kbd "M-n") 'semantic-ia-complete-symbol)
;; ;; -------------------- semantic --------------------

;; ==================== bzr cedet ====================
(load-file "~/.emacs.d/plugins/cedet-bzr/cedet-devel-load.el")
(semantic-mode 1)

(require 'semantic/ia)
(require 'semantic/bovine/c)
(require 'semantic/bovine/clang)
;; (require 'semantic/bovine/gcc)

;; loading contrib...
(require 'eassist)

;; customisation of modes
(defun alexott/cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-comsemantic-ia-complete-symbolplete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;;  (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
  ;;  (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)

  (add-to-list 'ac-sources 'ac-source-semantic)
  )

(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-hook 'alexott/cedet-hook)
(add-hook 'lisp-mode-hook 'alexott/cedet-hook)
(add-hook 'scheme-mode-hook 'alexott/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'alexott/cedet-hook)
(add-hook 'erlang-mode-hook 'alexott/cedet-hook)

(defun alexott/c-mode-cedet-hook ()
 ;; (local-set-key "." 'semantic-complete-self-insert)
 ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)

  (add-to-list 'ac-sources 'ac-source-gtags)
  )
(add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)

(when (cedet-gnu-global-version-check t)
  (semanticdb-enable-gnu-global-databases 'c-mode t)
  (semanticdb-enable-gnu-global-databases 'c++-mode t))

(when (cedet-ectag-version-check t)
  (semantic-load-enable-primary-ectags-support))

;; SRecode
(global-srecode-minor-mode 1)

;; EDE
(global-ede-mode 1)
(ede-enable-generic-projects)

;; helper for boost setup...
(defun recur-list-files (dir re)
  "Returns list of files in directory matching to given regex"
  (when (file-accessible-directory-p dir)
    (let ((files (directory-files dir t))
          matched)
      (dolist (file files matched)
        (let ((fname (file-name-nondirectory file)))
          (cond
           ((or (string= fname ".")
                (string= fname "..")) nil)
           ((and (file-regular-p file)
                 (string-match re fname))
            (setq matched (cons file matched)))
           ((file-directory-p file)
            (let ((tfiles (recur-list-files file re)))
              (when tfiles (setq matched (append matched tfiles)))))))))))

(defun c++-setup-boost (boost-root)
  (when (file-accessible-directory-p boost-root)
    (let ((cfiles (recur-list-files boost-root "\\(config\\|user\\)\\.hpp")))
      (dolist (file cfiles)
        (add-to-list 'semantic-lex-c-preprocessor-symbol-file file)))))

;; my functions for EDE
(defun alexott/ede-get-local-var (fname var)
  "fetch given variable var from :local-variables of project of file fname"
  (let* ((current-dir (file-name-directory fname))
         (prj (ede-current-project current-dir)))
    (when prj
      (let* ((ov (oref prj local-variables))
            (lst (assoc var ov)))
        (when lst
          (cdr lst))))))

;; setup compile package
(require 'compile)
(setq compilation-disable-input nil)
(setq compilation-scroll-output t)
(setq mode-compile-always-save-buffer-p t)

(defun alexott/compile ()
  "Saves all unsaved buffers, and runs 'compile'."
  (interactive)
  (save-some-buffers t)
  (let* ((r (alexott/ede-get-local-var
             (or (buffer-file-name (current-buffer)) default-directory)
             'compile-command))
         (cmd (if (functionp r) (funcall r) r)))
    (set (make-local-variable 'compile-command) (or cmd compile-command))
    (compile compile-command)))

(global-set-key [f7] 'alexott/compile)
;; -------------------- bzr cedet --------------------



;; ==================== gud ====================

(gud-tooltip-mode 1)
(add-hook 'gdb-mode-hook '(lambda ()
                            (define-key c-mode-base-map [(f11)] 'gud-step) ; step in
                            (define-key c-mode-base-map [(f10)] 'gud-next) ; step out
                            (define-key c-mode-base-map [(f5)] 'gud-go)
                            (define-key c-mode-base-map [(shift f5)] 'gud-cont)
                            (define-key c-mode-base-map [(control f5)] 'gud-until) ; run to here
                            (define-key c-mode-base-map [(f9)] 'gud-break) ; set break point
                            (define-key c-mode-base-map [(control f9)] 'gud-remove) ; remove break point
                            (define-key c-mode-base-map [(shitf f11)] 'gud-finish) ; jump out of the function
	  )) 

(global-set-key [f10] 'gud-next)

;; -------------------- gud --------------------


;; ==================== ecb ====================
(add-to-list 'load-path "~/.emacs.d/plugins/ecb-2.40")
(require 'ecb)
(setq-default ecb-tip-of-the-day nil)

(ecb-layout-define "my-cscope-layout" left nil
                   (ecb-set-methods-buffer)
                   (ecb-split-ver 0.5 t)
                   (other-window 1)
                   (ecb-set-sources-buffer) ; (ecb-set-history-buffer)
                   (ecb-split-ver 0.25 t)
                   (other-window 1)
                   (ecb-set-cscope-buffer))

(defecb-window-dedicator-to-ecb-buffer ecb-set-cscope-buffer
    " *ECB cscope-buf*" nil
  "docstring of cscope buffer"
  (switch-to-buffer "*cscope*"))

(setq ecb-layout-name "my-cscope-layout")

(setq ecb-history-make-buckets 'never)
  
;; --------------------  ecb --------------------


;; ;; compile
;; (setq compilation-read-command nil)	;don't prompt to press ENTER
;; (global-set-key [(f7)] (lambda()
;;         		 (interactive)
;;         		 (save-some-buffers t)	   ;save all buffers
;;         		 (compile compile-command) ;compile
;;         		 ))

(global-set-key [f4] 'eshell)
(global-set-key [(shift f4)] 'shell)

;;自定义的代码风格
(defconst my-c-style
  '("stroustrup" ;;基于现有的代码风格进行修改。
    (c-offsets-alist . (;(access-label . -)
			(inclass . ++)
			(inline-open . 0)
			;(case-label . +)
			(statement-case-intro . +))))
  "My Programming Style")
;; 将自定义的代码风格加入到列表中
(c-add-style "my" my-c-style)

;; microsoft style
(c-add-style "microsoft"
              '("stroustrup"
                (c-offsets-alist
                 (innamespace . -)
                 (inline-open . 0)
                 (inher-cont . c-lineup-multi-inher)
                 (arglist-cont-nonempty . +)
                 (template-args-cont . +))))
;(setq c-default-style "microsoft")

;定制C/C++缩进风格
(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "k&r")
	     (setq c-basic-offset 4)
	     (setq tab-width 4)
	     (setq-default indent-tabs-mode nil)
	     ;(setq indent-tabs-mode nil)
	     ))
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "microsoft")
;	     (set (make-local-variable 'ac-auto-start) nil) ;; shut down ac-auto-start in c++-mode
	     ))



(setq tab-width 4)
;; 设置缩进字符数
(setq c-basic-offset 4)
;(setq-default indent-tabs-mode nil)

(global-set-key [(f5)] 'speedbar)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; ;;; Auto-completion                                                                                            
;; ;;;  Integrates:                                                                                               
;; ;;;   1) Rope                                                                                                  
;; ;;;   2) Yasnippet                                                                                             
;; ;;;   all with AutoComplete.el                                                                                 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; (defun prefix-list-elements (list prefix)
;;   (let (value)
;;     (nreverse
;;      (dolist (element list value)
;;       (setq value (cons (format "%s%s" prefix element) value))))))
;; (defvar ac-source-rope
;;   '((candidates
;;      . (lambda ()
;;          (prefix-list-elements (rope-completions) ac-target))))
;;   "Source for Rope")
;; (defun ac-python-find ()
;;   "Python `ac-find-function'."
;;   (require 'thingatpt)
;;   (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
;;     (if (null symbol)
;;         (if (string= "." (buffer-substring (- (point) 1) (point)))
;;             (point)
;;           nil)
;;       symbol)))
;; (defun ac-python-candidate ()
;;   "Python `ac-candidates-function'"
;;   (let (candidates)
;;     (dolist (source ac-sources)
;;       (if (symbolp source)
;;           (setq source (symbol-value source)))
;;       (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
;;              (requires (cdr-safe (assq 'requires source)))
;;              cand)
;;         (if (or (null requires)
;;                 (>= (length ac-target) requires))
;;             (setq cand
;;                   (delq nil
;;                         (mapcar (lambda (candidate)
;;                                   (propertize candidate 'source source))
;;                                 (funcall (cdr (assq 'candidates source)))))))
;;         (if (and (> ac-limit 1)
;;                  (> (length cand) ac-limit))
;;             (setcdr (nthcdr (1- ac-limit) cand) nil))
;;         (setq candidates (append candidates cand))))
;;     (delete-dups candidates)))
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;                  (auto-complete-mode 1)
;;                  (set (make-local-variable 'ac-sources)
;;                       (append ac-sources '(ac-source-rope) '(ac-source-yasnippet)))
;;                  (set (make-local-variable 'ac-find-function) 'ac-python-find)
;;                  (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
;;                  (set (make-local-variable 'ac-auto-start) nil)))
;; 
;; ;;Ryan's python specific tab completion                                                                        
;; (defun ryan-python-tab ()
;;   ; Try the following:                                                                                         
;;   ; 1) Do a yasnippet expansion                                                                                
;;   ; 2) Do a Rope code completion                                                                               
;;   ; 3) Do an indent                                                                                            
;;   (interactive)
;;   (if (eql (ac-start) 0)
;;       (indent-for-tab-command)))
;; 
;; (defadvice ac-start (before advice-turn-on-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) t))
;; (defadvice ac-cleanup (after advice-turn-off-auto-start activate)
;;   (set (make-local-variable 'ac-auto-start) nil))
;; 
;; (define-key python-mode-map "\t" 'ryan-python-tab)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; ;;; End Auto Completion                                                                                        
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; git emacs
(add-to-list 'load-path "~/.emacs.d/plugins/git-emacs/")
(require 'git-emacs)


;;==================== w3m ====================
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-w3m-1.4.4")
;(require 'w3m-load)
(require 'w3m-e21)
(provide 'w3m-e23)
;;-------------------- w3m --------------------


;;==================== doxymacs ====================
(add-to-list 'load-path "~/.emacs.d/plugins/doxymacs-1.8.0")
(add-to-list 'load-path "~/.emacs.d/plugins/doxymacs")
(require 'doxymacs)

;; +---------+----------------------------------------------------------------------+
;; |C-c d ?  |从符号表中查找当前光标所在内容的文档（需要指定doxymacs-doxygen-dirs） |
;; +---------+----------------------------------------------------------------------+
;; |C-c d r  |重新扫描 Doxygen 的 tags 文件                                         |
;; +---------+----------------------------------------------------------------------+
;; |C-c d f  |为所在位置之后的那个函数插入注释（注意是在当前光标处插入，最好在函数  |
;; |         |上方的空行处使用，插入前先对好齐）                                    |
;; |         |                                                                      |
;; +---------+----------------------------------------------------------------------+
;; |C-c d i  |为当前文件插入注释（内容包括文件名、作者、日期和简介）                |
;; |         |                                                                      |
;; +---------+----------------------------------------------------------------------+
;; |C-c d ;  |为当前行的成员变量插入注释（类似M-;，但是格式不同）                   |
;; +---------+----------------------------------------------------------------------+
;; |C-c d m  |插入空白的多行注释，这个就在单纯是想要注释的时候用了                  |
;; +---------+----------------------------------------------------------------------+
;; |C-c d s  |插入空白的单行注释，和上面那个差不多                                  |
;; +---------+----------------------------------------------------------------------+
;; |C-c d @  |插入分组注释。所谓分组注释就是将某个范围内的代码看作一组，生成文档时  |
;; |         |会单独归在一个组下。使用时要先选中想分组的那部分代码                  |
;; +---------+----------------------------------------------------------------------+

;;注释高亮，针对C和C++程序
(add-hook 'c-mode-common-hook 'doxymacs-mode)

;;-------------------- doxymacs --------------------


;; ==================== cscope ====================
;; +----------+--------------------------------------------------+
;; |C-c s a   |设定初始化的目录，一般是你代码的根目录            |
;; +----------+--------------------------------------------------+
;; |C-s s I   |对目录中的相关文件建立列表并进行索引              |
;; +----------+--------------------------------------------------+
;; |C-c s s   |序找符号                                          |
;; +----------+--------------------------------------------------+
;; |C-c s g   |寻找全局的定义                                    |
;; +----------+--------------------------------------------------+
;; |C-c s c   |看看指定函数被哪些函数所调用                      |
;; +----------+--------------------------------------------------+
;; |C-c s C   |看看指定函数调用了哪些函数                        |
;; +----------+--------------------------------------------------+
;; |C-c s e   |寻找正则表达式                                    |
;; +----------+--------------------------------------------------+
;; |C-c s f   |寻找文件                                          |
;; +----------+--------------------------------------------------+
;; |C-c s i   |看看指定的文件被哪些文件include                   |
;; +----------+--------------------------------------------------+

(add-to-list 'load-path "~/.emacs.d/plugins/cscope-15.8a/contrib/xcscope/")
(add-hook 'c-mode-common-hook
          '(lambda ()
             (require 'xcscope)))
;; -------------------- cscope --------------------


;; ==================== lisp ====================
(require 'slime)
(slime-setup '(slime-fancy))

;; From http://d.hatena.ne.jp/tsz/20091222/1261492959
(defvar ac-slime-modes
  '(lisp-mode))

(defun ac-slime-candidates ()
  "Complete candidates of the symbol at point."
  (if (memq major-mode ac-slime-modes)
      (let* ((end (point))
			 (beg (slime-symbol-start-pos))
			 (prefix (buffer-substring-no-properties beg end))
			 (result (slime-simple-completions prefix)))
		(destructuring-bind (completions partial) result
		  completions))))

(defvar ac-source-slime
  '((candidates . ac-slime-candidates)
    (requires-num . 3)))

(add-hook 'lisp-mode-hook (lambda ()
							(slime-mode t)
							(push 'ac-source-slime ac-sources)
							(auto-complete-mode)))
;; -------------------- lisp --------------------



(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-tag-header-face ((((class color) (background dark)) (:background "SeaGreen4"))))
 '(highlight ((t (:background "black" :foreground "LightGoldenrod"))))
 '(moinmoin-anchor-ref-id ((t (:foreground "LightBlue2" :underline t :height 0.8))))
 '(moinmoin-anchor-ref-title ((t (:foreground "LightBlue4" :underline t))))
 '(moinmoin-code ((t (:foreground "purple"))))
 '(moinmoin-email ((t (:foreground "LightBlue2"))))
 '(moinmoin-inter-wiki-link ((t (:foreground "LightBlue3" :weight bold))))
 '(moinmoin-url ((t (:foreground "LightBlue2" :height 0.8))))
 '(moinmoin-url-title ((t (:foreground "LightBlue4" :underline t))))
 '(moinmoin-wiki-link ((t (:foreground "LightBlue4" :weight bold))))
 '(which-func ((((class color) (min-colors 88) (background dark)) (:foreground "LightBlue1"))))
 '(xref-keyword-face ((t (:foreground "LightBlue"))))
 '(xref-list-pilot-face ((t (:foreground "blue violet"))))
 '(xref-list-symbol-face ((t (:foreground "light sky blue")))))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(session-use-package t nil (session)))
