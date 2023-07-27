(defmodule text_editorQuin
    (export (main 0))
)

(defun input ()
    (let (((tuple 'ok (list guessednum)) (io:fread "" "~s")))
        guessednum))

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
     (io:format (lists:concat message))    
    )
    (input)
)