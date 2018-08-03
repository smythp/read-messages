(defun empty-string-p (string)
  "Return t if a STRING is empty."
  (string= "" string))


(defun remove-empty-string (list)
  "Remove empty strings from LIST."
  (seq-remove 'empty-string-p list))


(defun update-messages ()
  (interactive)
  (let* ((all-messages (with-current-buffer "*Messages*" (buffer-string)))
	 (messages-list-reversed (reverse (split-string all-messages "\n"))))
    (progn
      (setq messages-list messages-list-reversed)
      (setq messages-list (remove-empty-string messages-list))
      (setq messages-list-loc 0)
      (read-message-aloud 0))))


(defun read-current-message-aloud ()
  (interactive)
  (read-message-aloud 0))

(defun read-previous-message-aloud ()
  (interactive)
  (progn 
    (read-message-aloud 1)))


(defun read-next-message-aloud ()
  (interactive)
  (read-message-aloud -1))

(defun read-message-aloud (num)
  (progn
    (setq messages-list-loc (+ num messages-list-loc))
    (if (< messages-list-loc 0)
	(setq messages-list-loc 0))
    (eloud-speak (nth messages-list-loc messages-list))))


(global-set-key (kbd "<M-left>") 'update-messages)
(global-set-key (kbd "<M-up>") 'read-previous-message-aloud)
(global-set-key (kbd "<M-down>") 'read-next-message-aloud)
(global-set-key (kbd "<M-right>") 'read-current-message-aloud)
