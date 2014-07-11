(if (file-directory-p "~/emacs/backup")
    (setq backup-directory-alist '(("." . "~/emacs/backup")))
  (message "Directory does not exist: ~/emacs/backup"))

(defun ome-exec-path-from-shell-setup()
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(ome-install 'exec-path-from-shell)

(when (eq system-type 'darwin)
  (unless (display-graphic-p)
    (defun copy-from-osx ()
      "Copies the current clipboard content using the `pbcopy` command"
      (shell-command-to-string "pbpaste"))

    (defun paste-to-osx (text &optional push)
      "Copies the top of the kill ring stack to the OSX clipboard"
      (let ((process-connection-type nil))
        (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
          (process-send-string proc text)
          (process-send-eof proc))))

    ;; Override defaults to use the mac copy and paste
    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx)))

(setq inferior-julia-program-name "/Users/jarutis/dev/julia/usr/bin/julia-basic")
(setq inferior-R-program-name "/usr/local/bin/R")
