(defmodule text_editorQuin
    (export (main 0))
)

(defun load-file (filename)
  (let ((result (file:read-text-file filename)))
    (case result
      ((ok contents) contents)
      (error (io:format "File ~s not found. Starting with an empty buffer.~n" `(,filename)) ""))))


(defun save-file (filename contents)
  (file:write-text-file filename contents)
  (io:format "File ~s saved successfully.~n" `(,filename)))

(defun start-text-editor ()
  (let ((filename (io:get_line "Enter filename (or leave empty for a new buffer): ")))
    (if (string:blank? filename)
        (editor-loop "Untitled" "")
        (editor-loop filename (load-file filename)))))

(defun editor-loop (filename text)
  (io:format "Text Editor - File: ~s~n" `(,filename))
  (print-text text)
  (io:format "~nCommands:~n")
  (io:format "  q - Quit~n")
  (io:format "  s - Save and Quit~n")
  (io:format "  e - Edit~n")
  (case (io:get_line "Enter command: ")
    ("q" (exit "Goodbye."))
    ("s" (save-file filename text) (exit "File saved. Goodbye."))
    ("e" (editor-loop filename (edit-text text)))
    (else (editor-loop filename text))))

(defun print-text (text)
  (io:format "~s~n" `(,text)))

(defun edit-text (text)
  (io:format "Type your changes. Press Ctrl+D (Unix) or Ctrl+Z (Windows) on a new line to save and exit.~n")
  (let ((lines (string:tokens text #\newline))
        (num-lines (length lines))
        (cursor-row 1)
        (cursor-col 1))
    (editor-loop filename lines num-lines cursor-row cursor-col)))

(defun move-cursor-down (num-lines cursor-row)
  (if (< cursor-row num-lines)
      (list (+ cursor-row 1) cursor-col)
      (list cursor-row cursor-col)))

(defun move-cursor-up (cursor-row)
  (if (> cursor-row 1)
      (list (- cursor-row 1) cursor-col)
      (list cursor-row cursor-col)))

(defun move-cursor-left (cursor-col)
  (if (> cursor-col 1)
      (list (- cursor-col 1))
      (list cursor-col)))

(defun move-cursor-right (cursor-col)
  (list (+ cursor-col 1)))

(defun insert-line-above (cursor-row lines)
  (let ((new-line (io:get_line "New line: ")))
    (lists:sublist lines 0 (- cursor-row 1))
    ++ (list new-line)
    ++ (lists:sublist lines cursor-row)))

(defun insert-line-below (cursor-row lines)
  (let ((new-line (io:get_line "New line: ")))
    (lists:sublist lines 0 cursor-row)
    ++ (list new-line)
    ++ (lists:sublist lines cursor-row)))

(defun main ()
  (start-text-editor))

;; Usage:
;; (main)
; (let ((x (5))) x) 
; (5)