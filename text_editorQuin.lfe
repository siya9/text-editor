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
        (++ (string:tokens line "\n"))
        (++ (lists:map
          (lambda (word)
            (let ((word-chunks (split-long-word word max-line-length)))
              (++
                (lists:map
                  (lambda (chunk)
                    (let ((line-length (length (++ line chunk))))
                      (if (> line-length max-line-length)
                        (++ "" chunk)
                        chunk)))
                  word-chunks))))
          (string:tokens line " "))))
      (string:tokens text "\n"))))

; (defun input () ; old
;     (let (((tuple 'ok (list guessednum)) (io:fread "" "~s")))
;         guessednum))

(defun update-formatted-prompt (input-line)
  (let ((formatted-input-line (wrap-text input-line max-line-length)))
    (handle-input input-line formatted-input-line)))

(defun handle-input (input-line formatted-input-line)
  (lfe_io:format (lists:concat ">>> " formatted-input-line)) ; Print the prompt and current input line
  (case (lfe_io:getch 'noecho)
    ((newline)
     (lfe_io:format "~n")   ; Move to the next line
     (handle-input "" ""))  ; Clear the input line and formatted input
    ((escape)
     input-line)            ; Return the input when the user presses Escape
    ((8) ; ASCII code for backspace
     (if (not (== "" input-line))
       (handle-input (string:sub_string input-line 1 (- (length input-line) 1)) formatted-input-line) ; Remove the last character
       (handle-input "" formatted-input-line))) ; Continue reading input
    (c
     (handle-input (lists:concat input-line (string c)) formatted-input-line) ; Add the character to the input line
     )))

(defun input ()
  (letrec ((max-line-length 120)) ; Set the maximum line length
    (update-formatted-prompt ""))) ; Start handling user input

; (defun readanddisplayfile ()
;   (io:format "Enter the filename: ")
;   (let* ((filename (io:get_line 'prompt))
;          (filename (string:trim filename))
;          (result (file:read_file filename)))
;     (case result
;       ((tuple ok content)
;        (io:format "File Contents:~n~s~n" (binary_to_list content)))
;       ((tuple error reason)
;        (io:format "Error: ~s~n" reason))
;     )
;     )
; )

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
    ; (readanddisplayfile)
)
; (defun input ()
;     (let (((tuple 'ok (list guessednum)) (io:fread "" "~s")))
;         guessednum))
; (wrap-text "helooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo" 120)
; (wrap-text "heloooooooooooooooooooooooooooooooooooooooooo oooooooooooooo oooooooooooooooooooooooooooo ooooooo ooooooooooooooooooooooooo" 120)