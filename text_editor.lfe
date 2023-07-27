(defmodule text-editor
  (export (main 1)))

(defun main (Filepath)
  (case (file:read_text Filepath)
    ((ok Content) (process-content Filepath Content))
    (error (io:format "Error: ~p~n" (list error)))))

(defun process-content (Filepath Content)
  (io:format "Text Editor - ~s~n" (list Filepath))
  (io:format "----------------------------------~n")
  (io:format "~s~n" (list Content))
  (io:format "----------------------------------~n")
  (io:format "Enter new content (terminate with '.' on a new line):~n")
  (receive-new-content Filepath (string:join "" (read-content []))))

(defun read-content (Acc)
  (case (io:get_line "")
    ((eof) (lists:reverse Acc))
    (Line (read-content (cons Line Acc)))))

(defun receive-new-content (Filepath Content)
  (case (io:get_line "")
    ((eof) (save-file Filepath Content))
    (Line (receive-new-content Filepath (string:join Content Line)))))

(defun save-file (Filepath Content)
  (case (file:write_text Filepath Content)
    (ok (io:format "File saved successfully.~n"))
    (error (io:format "Error saving the file: ~p~n" (list error)))))
