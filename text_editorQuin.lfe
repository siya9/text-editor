(defmodule text_editorQuin
    (export (main 0))
)

(defun split-long-word (word sizeofword)
  (if (>= (length word) sizeofword)
    (cons (string:sub_string word 1 sizeofword) (split-long-word (string:sub_string word sizeofword) sizeofword))
    (list word)))
    
; Function to wrap text to a maximum line-length of `max-line-length`
(defun wrap-text (text max-line-length)
  (++
    (lists:map
      (lambda (line)
        (++ (string:tokens line "~n"))
        (++ (lists:map
          (lambda (word)
            (let ((word-chunks (split-long-word word max-line-length)))
              (++
                (lists:map
                  (lambda (chunk)
                    (let ((line-length (length (++ line chunk))))
                      (if (> line-length max-line-length)
                        (++ "~n" chunk)
                        chunk)))
                  word-chunks))))
          (string:tokens line " "))))
      (string:tokens text "~n"))))

(defun input ()
    (let (((tuple 'ok (list guessednum)) (io:fread "" "~s")))
        guessednum))

(defun readanddisplayfile ()
  (io:format "Enter the filename: ")
  (let* ((filename (io:get_line 'prompt))
         (filename (string:trim filename))
         (result (file:read_file filename)))
    (case result
      ((tuple ok content)
       (io:format "File Contents:~n~s~n" (binary_to_list content)))
      ((tuple error reason)
       (io:format "Error: ~s~n" reason))
    )
    )
)

; first place that gets called 
(defun main ()
    (let ((message '("Welcome to this text-editor!~n"
                     "If you would like to load a file press 'Ctrl+o'~n"
                     "If you would like to save your file press 'Ctrl+s'~n"
                     "The text has a fixed-width with a maximum line-length of 120 characters~n"
                     "Press a to move the cursor forward~n"
                     "Press b to move the cursor backwards~n"
                     "Press c to move the cursor up~n"
                     "Press d to move the cursor down~n"
                     "You can select text by holding down Shift and using arrow keys~n"
                     "Go ahead and type away :)~n"
                     )
            )
         )
        (io:format (lists:concat message)) ; what it was before :) 
    )
    (input)
    (readanddisplayfile)
)
; (defun input ()
;     (let (((tuple 'ok (list guessednum)) (io:fread "" "~s")))
;         guessednum))
; (wrap-text "helooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo" 120)